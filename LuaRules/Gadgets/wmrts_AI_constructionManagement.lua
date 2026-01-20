function gadget:GetInfo()
	return {
		name      = "WMRTS Construction Manager",
		desc      = "Gestore costruzioni V1.2 - War Machines RTS",
		author    = "molix & AI",
		date      = "2025",
		license   = "GPL",
		layer     = 90,
		enabled   = true
	}
end

if (not gadgetHandler:IsSyncedCode()) then return end

--------------------------------------------------------------------------------
-- DATABASE CATEGORIE
--------------------------------------------------------------------------------

local CATEGORY_TO_UNIT = {
    ["ICU"] = {
        ["CAT_ENERGY_T1"]      = { "armsolar" },
        ["CAT_CONSTRUCTOR_T1"] = { "icucom", "icuck", "icucv" }, 
        ["CAT_FACTORY_T1"]     = { "armlab", "armvp" },
        ["CAT_LASER_T1"]       = { "iculighlturr" },
        ["CAT_AA_T1"]          = { "armrl" },
        ["CAT_MEX"]            = { "icumetex" },
    },
    ["AND"] = {
        ["CAT_ENERGY_T1"]      = { "andsolar" },
        ["CAT_CONSTRUCTOR_T1"] = { "andcom", "andcon" },
        ["CAT_FACTORY_T1"]     = { "andlab" },
        ["CAT_LASER_T1"]       = { "andlaser" },
        ["CAT_AA_T1"]          = { "andaa" },
        ["CAT_MEX"]            = { "andmex" }, -- mettere nil se la fazione non ha questa categoria di unità
    }
}

local AI_BUILD_LEVELS = {
    [0] = {
        simultanea = 1,
        requisiti = {
            {cat = "CAT_CONSTRUCTOR_T1", count = 1}, 
            {cat = "CAT_MEX",            count = 1}, -- Priorità assoluta
            {cat = "CAT_ENERGY_T1",      count = 1},
            {cat = "CAT_FACTORY_T1",     count = 1},
            {cat = "CAT_MEX",            count = 2}, 
            {cat = "CAT_ENERGY_T1",      count = 2},
            {cat = "CAT_LASER_T1",       count = 2},
        }
    }
}

--------------------------------------------------------------------------------
-- FUNZIONI DI SUPPORTO
--------------------------------------------------------------------------------

local function IsTerrainFlat(x, z)
    local nx, ny, nz = Spring.GetGroundNormal(x, z)
    return ny > 0.9 
end

-- RICERCA METALLO OTTIMIZZATA PER SPRING 100
local function GetClosestMetalSpot(cx, cz, mexDefID)
    local bestX, bestZ
    local maxM = 0
    local radius = 2000 -- Raggio aumentato
    local step = 16    -- Risoluzione nativa della metal map

    for i = -radius, radius, step do
        for j = -radius, radius, step do
            local tx, tz = cx + i, cz + j
            local m = Spring.GetMetalAmount(tx, tz)
            
            if m > maxM then
                -- Se troviamo un punto con più metallo, testiamo se è costruibile
                local ty = Spring.GetGroundHeight(tx, tz)
                local test = Spring.TestBuildOrder(mexDefID, tx, ty, tz, 0)
                
                if test == 2 then
                    -- Verifichiamo che non ci sia già un mex
                    local units = Spring.GetUnitsInSphere(tx, ty, tz, 64)
                    local occupied = false
                    for _, uID in ipairs(units) do
                        local name = UnitDefs[Spring.GetUnitDefID(uID)].name
                        if string.find(name, "mex") or string.find(name, "moho") then
                            occupied = true; break
                        end
                    end
                    
                    if not occupied then
                        maxM = m
                        bestX, bestZ = tx, tz
                    end
                end
            end
        end
    end
    
    if bestX then 
        Spring.Echo("WMRTS AI DEBUG: Metallo trovato a " .. bestX .. "," .. bestZ .. " (Valore: " .. maxM .. ")")
        return bestX, Spring.GetGroundHeight(bestX, bestZ), bestZ 
    end
    
    Spring.Echo("WMRTS AI DEBUG: Nessun giacimento di metallo libero trovato nel raggio di " .. radius)
    return nil
end

local function CountUnitsInCategory(teamID, category, faction)
    local unitList = CATEGORY_TO_UNIT[faction][category]
    if not unitList then return 999 end
    local total = 0
    for _, unitName in ipairs(unitList) do
        local uDef = UnitDefNames[unitName]
        if uDef then
            total = total + Spring.GetTeamUnitDefCount(teamID, uDef.id)
        end
    end
    return total
end

local function FindGoodBuildSite(unitDefID, cx, cz, currentLevel)
    local baseRadius = 300 + (currentLevel * 100)
    for _ = 1, 40 do 
        local angle = math.random() * math.pi * 2
        local dist = math.random(60, baseRadius)
        local tx = cx + math.cos(angle) * dist
        local tz = cz + math.sin(angle) * dist
        local ty = Spring.GetGroundHeight(tx, tz)
        if IsTerrainFlat(tx, tz) then
            if Spring.TestBuildOrder(unitDefID, tx, ty, tz, 0) == 2 then 
                return tx, ty, tz 
            end
        end
    end
    return nil
end

--------------------------------------------------------------------------------
-- GADGET CORE
--------------------------------------------------------------------------------

local aiTeamIDs = {}
local teamLevels = {}       
local teamFactions = {}     
local teamBasePos = {}      
local CHECK_INTERVAL = 120 

function gadget:GameFrame(n)
    if (n % CHECK_INTERVAL ~= 0) then return end

    local teamList = Spring.GetTeamList()
    for _, teamID in ipairs(teamList) do
        if not aiTeamIDs[teamID] then
            local assignedAI = Spring.GetTeamLuaAI(teamID)
            if assignedAI and (string.find(string.lower(assignedAI), "wmrts") or string.find(string.lower(assignedAI), "ai")) then
                aiTeamIDs[teamID] = true
                teamLevels[teamID] = 0
                local side = select(5, Spring.GetTeamInfo(teamID))
                teamFactions[teamID] = (side and string.find(string.lower(side), "and")) and "AND" or "ICU"
                Spring.Echo("WMRTS AI: Team " .. teamID .. " (" .. teamFactions[teamID] .. ") Online.")
            end
        end
    end

    for teamID, _ in pairs(aiTeamIDs) do
        local currentLevel = teamLevels[teamID]
        local faction = teamFactions[teamID]
        local config = AI_BUILD_LEVELS[currentLevel]
        if not config then return end

        if not teamBasePos[teamID] then
            local units = Spring.GetTeamUnits(teamID)
            if units and units[1] then
                local x, y, z = Spring.GetUnitPosition(units[1])
                teamBasePos[teamID] = {x=x, y=y, z=z}
            else return end
        end

        -- Trova costruttori liberi
        local builders = {}
        local allUnits = Spring.GetTeamUnits(teamID)
        for _, uID in ipairs(allUnits) do
            local uDefID = Spring.GetUnitDefID(uID)
            if uDefID and UnitDefs[uDefID].isBuilder then
                if Spring.GetCommandQueue(uID, 0) == 0 and not Spring.GetUnitIsBuilding(uID) then
                    table.insert(builders, uID)
                end
            end
        end

        local started = 0
        for _, req in ipairs(config.requisiti) do
            if started >= config.simultanea then break end
            
            local posseduti = CountUnitsInCategory(teamID, req.cat, faction)
            if posseduti < req.count then
                local unitName = CATEGORY_TO_UNIT[faction][req.cat][1]
                local uDef = UnitDefNames[unitName]
                
                if uDef and #builders > 0 then
                    local bID = builders[1]
                    local bx, by, bz
                    
                    if req.cat == "CAT_MEX" then
                        -- Passiamo l'ID del MEX per testare la costruzione durante la scansione
                        bx, by, bz = GetClosestMetalSpot(teamBasePos[teamID].x, teamBasePos[teamID].z, uDef.id)
                    else
                        bx, by, bz = FindGoodBuildSite(uDef.id, teamBasePos[teamID].x, teamBasePos[teamID].z, currentLevel)
                    end

                    if bx then
                        Spring.Echo("WMRTS AI: Team " .. teamID .. " ordina " .. unitName)
                        Spring.GiveOrderToUnit(bID, -uDef.id, {bx, by, bz, 0}, {})
                        table.remove(builders, 1)
                        started = started + 1
                        break 
                    end
                end
            end
        end
    end
end