function gadget:GetInfo()
	return {
		name      = "WMRTS Construction Manager",
		desc      = "Gestore costruzioni e livelli per War Machines RTS",
		author    = "molix",
		date      = "2025",
		license   = "GPL",
		layer     = 90, -- Carica prima dell'AI di combattimento così i livelli sono pronti
		enabled   = true
	}
end

-- to do LIST ################################
-- 1) ***implementare le funzioni nella "CATEGORY_TO_UNIT" per far scegliere alla AI le unità in funzione del tipo di mappa (ad esempio se una certa mappa è ventosa -> icuwing invece di icusolar. cose cosi

if (not gadgetHandler:IsSyncedCode()) then return end

--------------------------------------------------------------------------------
-- CONFIGURAZIONE CATEGORIE 
--------------------------------------------------------------------------------

local CATEGORY_TO_UNIT = {
    ["ICU"] = {
		["CAT_ENERGY_T1"]	   = "armsolar",
        ["CAT_CONSTRUCTOR_T1"] = "icucon",
        ["CAT_FACTORY_T1"]     = "armlab", -- *** Qui potremmo mettere una funzione per variare
        ["CAT_LASER_T1"]       = "armrl",
        ["CAT_AA_T1"]          = "armlightad",
        ["CAT_MEX"]            = "armmex",
        ["CAT_FACTORY_T2"]     = "armalab",
        ["CAT_CONSTRUCTOR_T2"] = "icucon2",
        ["CAT_AA_T2"]          = "armflak",
    },
    ["AND"] = {
		["CAT_ENERGY_T1"]	   = "andsolar",	
        ["CAT_CONSTRUCTOR_T1"] = "andcon",
        ["CAT_FACTORY_T1"]     = "andlab",
        ["CAT_LASER_T1"]       = "andlaser",
        ["CAT_AA_T1"]          = nil, -- Esempio: AND non ha AA dedicata a lvl 1, si potrebbe anche non specificare la categoria in AND, in questo caso varrebbe sempre NIL
        ["CAT_MEX"]            = "andmex",
        ["CAT_FACTORY_T2"]     = "andalab",
        ["CAT_CONSTRUCTOR_T2"] = "andcon2",
        ["CAT_AA_T2"]          = "andaa2",
    }
}

--------------------------------------------------------------------------------
-- CONFIGURAZIONE LIVELLI 
--------------------------------------------------------------------------------
-- Per ogni livello si stabiliscono i requisiti per mantenerlo.
local AI_BUILD_LEVELS = {
    [0] = {
        simultanea = 1,
        requisiti = {
            {cat = "CAT_CONSTRUCTOR_T1", count = 1},
            {cat = "CAT_MEX",            count = 2},
            {cat = "CAT_FACTORY_T1",     count = 1},
            {cat = "CAT_LASER_T1",       count = 2},
            {cat = "CAT_AA_T1",          count = 1},
        }
    },
    [1] = {
        simultanea = 1,
        requisiti = {
            {cat = "CAT_CONSTRUCTOR_T1", count = 2},
            {cat = "CAT_MEX",            count = 4},
            {cat = "CAT_FACTORY_T1",     count = 2},
            {cat = "CAT_LASER_T1",       count = 4},
            {cat = "CAT_AA_T1",          count = 2},
            {cat = "CAT_FACTORY_T2",     count = 1},
        }
    },
    -- ... aggiungi altri livelli qui ...
}

--------------------------------------------------------------------------------
-- VARIABILI DI STATO
--------------------------------------------------------------------------------

local aiTeamIDs = {}
local teamLevels = {}       -- [teamID] = livello attuale
local teamFactions = {}     -- [teamID] = "ICU" o "AND"
local teamBasePos = {}      -- [teamID] = {x, y, z} (centro base)
local teamConstructionSlots = {} -- [teamID] = numero di progetti attivi

local BUILD_RADIUS = 1000
local CHECK_INTERVAL = 150 -- Ogni 5 secondi (30fps * 5)

--------------------------------------------------------------------------------
-- FUNZIONI DI SUPPORTO
--------------------------------------------------------------------------------

-- Determina la fazione del team (molto semplificato)
local function GetTeamFaction(teamID)
    local side = select(5, Spring.GetTeamInfo(teamID))
    if side and string.find(string.lower(side), "and") then return "AND" end
    return "ICU"
end

-- Conta quante unità di una certa categoria possiede il team
local function CountUnitsInCategory(teamID, category)
    local faction = teamFactions[teamID]
    local unitName = CATEGORY_TO_UNIT[faction][category]
    if not unitName then return 999 end -- Se non esiste, requisito "saltato"
    
    local uDefID = UnitDefNames[unitName].id
    return Spring.GetTeamUnitDefCount(teamID, uDefID)
end

--------------------------------------------------------------------------------
-- LOGICA CORE
--------------------------------------------------------------------------------

function gadget:Initialize()
    local teamList = Spring.GetTeamList()
    for _, teamID in ipairs(teamList) do
        local assignedAI = Spring.GetTeamLuaAI(teamID)
        if assignedAI and string.find(string.lower(assignedAI), "wmrts") then
            aiTeamIDs[teamID] = true
            teamLevels[teamID] = 0
            teamFactions[teamID] = GetTeamFaction(teamID)
            
            -- Inizializziamo il livello globale per gli altri gadget
            if not GG.WMRTS_Levels then GG.WMRTS_Levels = {} end
            GG.WMRTS_Levels[teamID] = 0
        end
    end
end

function gadget:GameFrame(n)
    if (n % CHECK_INTERVAL ~= 0) then return end

    for teamID, _ in pairs(aiTeamIDs) do
        local currentLevel = teamLevels[teamID]
        local faction = teamFactions[teamID]
        local config = AI_BUILD_LEVELS[currentLevel]
        
        if not config then return end -- Livello massimo raggiunto o non definito

        -- 1) DEFINIZIONE CENTRO BASE (Se non esiste)
        if not teamBasePos[teamID] then
            local units = Spring.GetTeamUnits(teamID)
            if units[1] then
                local x, y, z = Spring.GetUnitPosition(units[1])
                teamBasePos[teamID] = {x=x, y=y, z=z}
            end
        end

        -- 2) CHECK INVENTARIO E LIVELLI (Level-Up / Level-Down)
        local allCurrentSatisfied = true
        
        -- Controllo se mancano requisiti dei livelli precedenti (Level-Down)
        for i = 0, currentLevel do
            local reqs = AI_BUILD_LEVELS[i].requisiti
            for _, req in ipairs(reqs) do
                local posseduti = CountUnitsInCategory(teamID, req.cat)
                if posseduti < req.count then
                    if i < currentLevel then
                        teamLevels[teamID] = i -- Retrocedi
                        Spring.Echo("WMRTS Construction: Team " .. teamID .. " declassato al livello " .. i)
                        GG.WMRTS_Levels[teamID] = i
                        return -- Riesegui al prossimo ciclo
                    end
                    allCurrentSatisfied = false
                end
            end
        end

        -- Se tutti i requisiti correnti sono ok, sali di livello
        if allCurrentSatisfied and AI_BUILD_LEVELS[currentLevel + 1] then
            teamLevels[teamID] = currentLevel + 1
            GG.WMRTS_Levels[teamID] = currentLevel + 1
            Spring.Echo("WMRTS Construction: Team " .. teamID .. " avanzato al livello " .. (currentLevel + 1))
            return
        end

        -- 3) LOGICA DI COSTRUZIONE (Slot simultanei)
        local slotsDisponibili = config.simultanea
        local projectsStarted = 0
        
        -- Trova costruttori liberi
        local allUnits = Spring.GetTeamUnits(teamID)
        local builders = {}
        for _, uID in ipairs(allUnits) do
            local uDefID = Spring.GetUnitDefID(uID)
            if UnitDefs[uDefID].isBuilder then
                local qSize = Spring.GetCommandQueue(uID, 0)
                if qSize == 0 then table.insert(builders, uID) end
            end
        end

        -- Assegna ordini per i requisiti mancanti
        for _, req in ipairs(config.requisiti) do
            if projectsStarted >= slotsDisponibili then break end
            
            local posseduti = CountUnitsInCategory(teamID, req.cat)
            if posseduti < req.count then
                local unitName = CATEGORY_TO_UNIT[faction][req.cat]
                if unitName and #builders > 0 then
                    local bID = builders[1] -- Prendi il primo costruttore libero
                    local uDefID = UnitDefNames[unitName].id
                    
                    -- Trova posizione
                    local bx, by, bz
                    if req.cat == "CAT_MEX" then
                        -- Logica speciale per estrattori
                        local spot = Spring.GetClosestMetalSpot(teamBasePos[teamID].x, teamBasePos[teamID].z)
                        if spot then bx, by, bz = spot.x, spot.y, spot.z end
                    else
                        -- Logica casuale per il resto
                        local tx = teamBasePos[teamID].x + math.random(-BUILD_RADIUS, BUILD_RADIUS)
                        local tz = teamBasePos[teamID].z + math.random(-BUILD_RADIUS, BUILD_RADIUS)
                        bx, by, bz = Spring.FindStartBuildSite(uDefID, tx, 0, tz, 500)
                    end

                    if bx then
                        Spring.GiveOrderToUnit(bID, -uDefID, {bx, by, bz, 0}, {})
                        table.remove(builders, 1)
                        projectsStarted = projectsStarted + 1
                    end
                end
            end
        end

        -- 4) ASSISTENZA (Nano-boost)
        -- I costruttori rimasti liberi aiutano i cantieri aperti
        for _, bID in ipairs(builders) do
            local targetUnit = Spring.GetClosestUnitMap(teamBasePos[teamID].x, teamBasePos[teamID].z, 500, teamID)
            if targetUnit then
                local _, _, _, _, buildProgress = Spring.GetUnitHealth(targetUnit)
                if buildProgress and buildProgress < 1 then
                    Spring.GiveOrderToUnit(bID, CMD.REPAIR, {targetUnit}, {})
                end
            end
        end
    end
end