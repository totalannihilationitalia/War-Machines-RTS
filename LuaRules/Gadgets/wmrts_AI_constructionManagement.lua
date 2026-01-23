function gadget:GetInfo()
	return {
		name      = "WMRTS Construction Manager",
		desc      = "Gestore costruzioni V2.6 - War Machines RTS",
		author    = "molix & AI",
		date      = "2025",
		license   = "GPL",
		layer     = 90,
		enabled   = true
	}
end

if (not gadgetHandler:IsSyncedCode()) then return end

--------------------------------------------------------------------------------
-- 1) DATABASE E CONFIGURAZIONE
--------------------------------------------------------------------------------

local MAP_PROFILES = {
    ["Default"]      = { land = true, air = true, sea = false },		-- configurazione di default per le mappe senza profili mappa
    ["Zoty Outpost"] = { land = true, air = true, sea = false },
}

-- categorizzazione delle unità
local CATEGORY_TO_UNIT = {
--	Puoi randomizzare le costruzioni scrivendo più unità per categoria es.: ["CAT_LASER_T1"] = { "armrl", "armllt", "armteeth" },
--  Se vuoi che un'unità sia costruita più spesso di un'altra, puoi ripetere il nome nella lista es.: ["CAT_MEX"] = { "mex_normale", "mex_normale", "mex_corazzato" } Qui l'AI avrà il 66% di probabilità di fare quello normale e il 33% di fare quello corazzato.
--	Aggiungi la categoria che vuoi ["CAT_esempio_robotT3"] = = { "icuraz" }, -- Meglio se la categoria "CAT_esempio_robotT3" sia presente in tutte le fazioni. Usa poi la categoria nella "AI_BUILD_LEVELS"
----------------------------
-- ICU
----------------------------
    ["ICU"] = {
        ["CAT_MEX"]            = { "icumetex" },			
        ["CAT_ENERGY_T1"]      = { "armsolar" },
        ["CAT_LASER_T1"]       = { "iculighlturr" },
        ["CAT_AA_T1"]          = { "armrl" },
        ["CAT_FACTORY_T1"] = {
            land = { "armlab", "armvp" },
            air  = { "armap" },
            sea  = { "armsy" },
        },
        ["CAT_FACTORY_T2"] = {
            land = { "armalab", "armavp" },
            air  = { "armaap" },
            sea  = { "armasy" },
        },		
        ["CAT_ALL_CONSTRUCTORS"] = { "icucom", "icuck", "icucv", "armca", "armcs" }, -- inserire tutti i costruttori della fazione gestiti dalla AI
    },
----------------------------
-- AND
----------------------------
    ["AND"] = {
        ["CAT_MEX"]            = { "andmex" },
        ["CAT_ENERGY_T1"]      = { "andsolar" },
        ["CAT_LASER_T1"]       = { "andlaser" },
        ["CAT_AA_T1"]          = { "andaa" },
        ["CAT_FACTORY_T1"] = {
            land = { "andlab", "andhp" },
            air  = { "andplat" },
            sea  = { "andsy" },
        },
        ["CAT_ALL_CONSTRUCTORS"] = { "andcom", "andcon", "andcv", "andca", "andcs" },
    }
}

local AI_BUILD_LEVELS = {
    [0] = {
        simultanea = 1,
        requisiti = {
            {cat = "CAT_ALL_CONSTRUCTORS", 	count = 1}, 
            {cat = "CAT_MEX",               count = 2}, 
            {cat = "CAT_ENERGY_T1",         count = 2},
            {cat = "CAT_FACTORY_T1",        count = 1}, 
            {cat = "CAT_MEX",               count = 3}, 
        }
    },
    [1] = {
        simultanea = 2,
        requisiti = {
            {cat = "CAT_ALL_CONSTRUCTORS", count = 2},
            {cat = "CAT_MEX",               count = 5},
            {cat = "CAT_ENERGY_T1",         count = 6},
        }
    }
}

-- inserimento degli spot di metallo per ogni mappa
local MANUAL_MAP_DATA = {
    ["Zoty Outpost"] = { {x = 664, z = 2360}, {x = 2101, z = 2412}, {x = 1320, z = 2312} },
}

--------------------------------------------------------------------------------
-- 2) VARIABILI DI STATO
--------------------------------------------------------------------------------
local aiTeamIDs = {}
local teamLevels = {}       
local teamFactions = {}     
local teamBasePos = {}      
local metalSpots = {}
local scanDone = false

--------------------------------------------------------------------------------
-- 3) FUNZIONI DI SUPPORTO
--------------------------------------------------------------------------------

-- Questa funzione serve a capire dove si trovano le risorse.
--	•	Controlla se esistono coordinate predefinite per la mappa corrente in MANUAL_MAP_DATA.
--	•	Se non ci sono, scansiona l'intera mappa con un salto di 32 pixel cercando punti dove il valore del metallo è superiore a 0.1.
--	•	Salva le coordinate in una tabella metalSpots per usi futuri.
local function AnalyzeMetalMap()
    metalSpots = {}
    local mapName = Game.mapName
    if MANUAL_MAP_DATA[mapName] then
        for _, spot in ipairs(MANUAL_MAP_DATA[mapName]) do table.insert(metalSpots, {x = spot.x, z = spot.z}) end
    else
        local step = 32
        for z = 16, Game.mapSizeZ, step do
            for x = 16, Game.mapSizeX, step do
                if Spring.GetMetalAmount(x, z) > 0.1 then
                    table.insert(metalSpots, {x = x, z = z})
                end
            end
        end
    end
    scanDone = true
    Spring.Echo("WMRTS AI: Metal scan complete (" .. #metalSpots .. " spots)")
end

-- Trova il punto di metallo più vicino alla posizione (cx, cz) (solitamente la base dell'AI).
--	•	Scorre la lista dei punti trovati da AnalyzeMetalMap.
--	•	Per ogni punto, verifica se è già occupato da un altro estrattore usando Spring.GetUnitsInSphere.
--	•	Restituisce le coordinate del punto libero più vicino.
local function GetClosestMetalSpot(cx, cz)
    local bestSpot = nil
    local minDist = 5000 * 5000 
    for i = 1, #metalSpots do
        local spot = metalSpots[i]
        local dx, dz = cx - spot.x, cz - spot.z
        local distSq = dx*dx + dz*dz
        if distSq < minDist then
            local units = Spring.GetUnitsInSphere(spot.x, Spring.GetGroundHeight(spot.x, spot.z), spot.z, 64)
            local occupied = false
            for _, uID in ipairs(units) do
                local ud = UnitDefs[Spring.GetUnitDefID(uID)]
                if ud and ud.isExtractor then occupied = true; break end
            end
            if not occupied then minDist = distSq; bestSpot = spot end
        end
    end
    if bestSpot then return bestSpot.x, Spring.GetGroundHeight(bestSpot.x, bestSpot.z), bestSpot.z end
    return nil
end

-- È il "contabile" dell'AI.
--	•	Riceve la categoria (es. "CAT_MEX") e la fazione.
--	•	Usa Spring.GetTeamUnitDefCount per contare quante unità di quel tipo il team possiede già sulla mappa.
--	•	Gestisce anche le categorie multi-tipo (es. le fabbriche che possono essere Land, Air o Sea).
local function CountUnitsInCategory(teamID, category, faction)
    local entry = CATEGORY_TO_UNIT[faction][category]
    if not entry then return 0 end
    local total = 0
    local function c(list)
        for _, name in ipairs(list) do
            local ud = UnitDefNames[name]
            if ud then total = total + Spring.GetTeamUnitDefCount(teamID, ud.id) end
        end
    end
    if entry.land or entry.air or entry.sea then
        if entry.land then c(entry.land) end
        if entry.air then c(entry.air) end
        if entry.sea then c(entry.sea) end
    else c(entry) end
    return total
end

-- Sceglie quale unità specifica costruire all'interno di una categoria.
--	•	Utilizza i MAP_PROFILES per decidere se la mappa permette unità di terra, aria o mare.
--	•	Restituisce un nome di unità casuale tra quelle valide per quel profilo (es. se la mappa è solo terra, non sceglierà una fabbrica navale).
local function GetRandomUnitFromCat(faction, category)
    local entry = CATEGORY_TO_UNIT[faction][category]
    if not entry then return nil end
    local profile = MAP_PROFILES[Game.mapName] or MAP_PROFILES["Default"]
    local valid = {}
    
    if entry.land or entry.air or entry.sea then
        if profile.land and entry.land then for _,u in ipairs(entry.land) do table.insert(valid,u) end end
        if profile.air and entry.air then for _,u in ipairs(entry.air) do table.insert(valid,u) end end
        if profile.sea and entry.sea then for _,u in ipairs(entry.sea) do table.insert(valid,u) end end
        if #valid > 0 then return valid[math.random(#valid)] end
    else
        return entry[math.random(#entry)]
    end
    return nil
end

-- Funzione per contare quante unità di quella categoria sono "in arrivo" nelle code delle fabbriche 
local function CountUnitsInQueues(teamID, category, faction)
    local entry = CATEGORY_TO_UNIT[faction][category]
    if not entry then return 0 end
    
    -- Trasformiamo i nomi in ID per un confronto veloce
    local validIDs = {}
    local function fillIDs(list)
        for _, name in ipairs(list) do
            local ud = UnitDefNames[name]
            if ud then validIDs[ud.id] = true end
        end
    end

    if entry.land or entry.air or entry.sea then
        if entry.land then fillIDs(entry.land) end
        if entry.air then fillIDs(entry.air) end
        if entry.sea then fillIDs(entry.sea) end
    else fillIDs(entry) end

    local totalInQueue = 0
    local teamUnits = Spring.GetTeamUnits(teamID)
    for _, uID in ipairs(teamUnits) do
        local ud = UnitDefs[Spring.GetUnitDefID(uID)]
        if ud and ud.isFactory then
            local queue = Spring.GetFullBuildQueue(uID)
            if queue then
                for _, buildItem in ipairs(queue) do
                    -- buildItem è { [unitDefID] = count }
                    for uDefID, count in pairs(buildItem) do
                        if validIDs[uDefID] then
                            totalInQueue = totalInQueue + count
                        end
                    end
                end
            end
        end
    end
    return totalInQueue
end

--------------------------------------------------------------------------------
-- 4) GADGET CORE
--------------------------------------------------------------------------------

function gadget:GameFrame(n)
    if n < 35 then return end 
    if not scanDone then AnalyzeMetalMap() end
    if (n % 150 ~= 0) then return end 

    local teamList = Spring.GetTeamList()
    for _, teamID in ipairs(teamList) do
        if not aiTeamIDs[teamID] then
            local aiName = Spring.GetTeamLuaAI(teamID)
            if aiName and aiName ~= "" then
                aiTeamIDs[teamID] = true
                teamLevels[teamID] = 0
                local side = select(5, Spring.GetTeamInfo(teamID))
                teamFactions[teamID] = (side and string.find(string.lower(side), "and")) and "AND" or "ICU"
                Spring.Echo("WMRTS AI: Team " .. teamID .. " detected (" .. teamFactions[teamID] .. ")")
            end
        end
    end

    for teamID, _ in pairs(aiTeamIDs) do
        local faction = teamFactions[teamID]

        if not teamBasePos[teamID] then
            local units = Spring.GetTeamUnits(teamID)
            if units and #units > 0 then
                local x,y,z = Spring.GetUnitPosition(units[1])
                teamBasePos[teamID] = {x=x, y=y, z=z}
            else return end
        end

        local currentLvl = teamLevels[teamID]
        local config = AI_BUILD_LEVELS[currentLvl]
        if not config then return end

        -- Logica Avanzamento Livello
        local levelBroken = false
        for _, req in ipairs(config.requisiti) do
            if CountUnitsInCategory(teamID, req.cat, faction) < req.count then
                levelBroken = true; break
            end
        end
        if not levelBroken and AI_BUILD_LEVELS[currentLvl + 1] then
            teamLevels[teamID] = currentLvl + 1
            if not GG.WMRTS_Levels then GG.WMRTS_Levels = {} end
            GG.WMRTS_Levels[teamID] = teamLevels[teamID]
            Spring.Echo("WMRTS AI: Team " .. teamID .. " Level Up -> " .. teamLevels[teamID])
            return
        end

        -- Identificazione Costruttori e Fabbriche
        local builders = {}
        local factories = {}
        local teamUnits = Spring.GetTeamUnits(teamID)
        for _, uID in ipairs(teamUnits) do
            local ud = UnitDefs[Spring.GetUnitDefID(uID)]
            if ud then
                if ud.canBuild or ud.isBuilder then
                    if Spring.GetCommandQueue(uID, 0) == 0 and not Spring.GetUnitIsBuilding(uID) then
                        table.insert(builders, uID)
                    end
                end
                if ud.isFactory then table.insert(factories, uID) end
            end
        end

        -- Esecuzione Requisiti
        local started = 0
        for _, req in ipairs(config.requisiti) do
            if started >= config.simultanea then break end
            
            local totalPresent = CountUnitsInCategory(teamID, req.cat, faction)
            local totalPending = CountUnitsInQueues(teamID, req.cat, faction)

            if (totalPresent + totalPending) < req.count then
                local unitName = GetRandomUnitFromCat(faction, req.cat)
                local uDef = UnitDefNames[unitName]
                
                if uDef then
                    -- CASO A: È una STRUTTURA (Richiede un Builder)
                    if uDef.isBuilding or uDef.isStructure then
                        if #builders > 0 then
                            local bx, by, bz
                            if req.cat == "CAT_MEX" then
                                bx, by, bz = GetClosestMetalSpot(teamBasePos[teamID].x, teamBasePos[teamID].z)
                            else
                                for _ = 1, 30 do
                                    local angle = math.random() * math.pi * 2
                                    local dist = math.random(100, 500)
                                    local tx = teamBasePos[teamID].x + math.cos(angle) * dist
                                    local tz = teamBasePos[teamID].z + math.sin(angle) * dist
                                    if Spring.TestBuildOrder(uDef.id, tx, 0, tz, 0) == 2 then
                                        bx, by, bz = tx, Spring.GetGroundHeight(tx,tz), tz
                                        break
                                    end
                                end
                            end
                            
                            if bx then
                                Spring.Echo("WMRTS AI: Team " .. teamID .. " builder " .. builders[1] .. " builds " .. unitName)
                                Spring.GiveOrderToUnit(builders[1], -uDef.id, {bx, by, bz, 0}, {})
                                table.remove(builders, 1)
                                started = started + 1
                            end
                        end
                    
                    -- CASO B: È un ROBOT/UNITA' MOBILE (Richiede una Fabbrica)
                    else
                        for _, fID in ipairs(factories) do
                            local fud = UnitDefs[Spring.GetUnitDefID(fID)]
                            local canProduce = false
                            for _, optID in ipairs(fud.buildOptions) do
                                if optID == uDef.id then canProduce = true; break end
                            end
                            
                            if canProduce then
                                -- Evita di spammare se la fabbrica ha già l'unità in coda
                                local alreadyBuilding = false
                                local q = Spring.GetFullBuildQueue(fID)
                                if q then
                                    for _, item in ipairs(q) do
                                        if item[uDef.id] then alreadyBuilding = true; break end
                                    end
                                end

                                if not alreadyBuilding then
                                    Spring.Echo("WMRTS AI: Factory " .. fID .. " priority production: " .. unitName)
                                    Spring.GiveOrderToUnit(fID, -uDef.id, {}, {"alt"})
                                    started = started + 1
                                    break 
                                end
                            end
                        end
                    end -- Fine distinzione edificio/mobile
                end
            end
        end -- Fine ciclo requisiti
    end -- Fine ciclo team
end