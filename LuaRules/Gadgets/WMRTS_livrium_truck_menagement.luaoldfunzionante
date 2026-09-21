function gadget:GetInfo()
  return {
    name      = "WMRTS Livrium Truck Logistics",
    desc      = "Gestisce il trasporto automatico di Livrium dalle Harvester Factory alle Raffinerie tramite camion",
    author    = "molix",
    date      = "2026",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true
  }
end

if not gadgetHandler:IsSyncedCode() then 
    return 
end

-- =============================================================================
-- CONFIGURAZIONE
-- =============================================================================

local CHECK_INTERVAL   = 30   -- Frequenza del ciclo logico (30 frame = 1 secondo)
local DOCK_DISTANCE_refineries  = 235  	-- Distanza minima dalla raffineria per impartire il comando LOAD_UNITS
local DOCK_DISTANCE_factory		= 350		-- Distanza minima dalla harvester factory per impartire il comando load/unload
local DEFAULT_LOAD_TIME = 300 -- Frame di sosta dentro la struttura (150 frame = 5 secondi)

local TRUCK_TYPES = {
    ruspa_camion = {
        capacity    = 200,							-- meglio mantenere multipli di 200 per la logica WMRTS
        factories   = {"euf_harvester_factory"},
        refineries  = {"eufrafinery", "eufrafineryenergy"},
        loadTime    = 300
    },
    and_camion = {
        capacity    = 200,							-- meglio mantenere multipli di 200 per la logica WMRTS
        factories   = {"and_harvester_factory"},
        refineries  = {"and_refinery"},
        loadTime    = 300
    }
}

-- =============================================================================
-- VARIABILI DI STATO (SYNCED)
-- =============================================================================

local trucks = {}
local processingBuildings = {}

-- Tabelle di cache per gli ID numerici
local truckDefs = {}
local factoryDefs = {}
local refineryDefs = {}

-- =============================================================================
-- FUNZIONI DI UTILITÀ
-- =============================================================================

local function GetDistance(x1, z1, x2, z2)
    return math.sqrt((x1 - x2)^2 + (z1 - z2)^2)
end

-- Trova la Harvester Factory alleata più vicina
local function GetNearestFactory(unitID)
    local x, _, z = Spring.GetUnitPosition(unitID)
    local teamID = Spring.GetUnitTeam(unitID)
    local units = Spring.GetTeamUnits(teamID)
    local bestFactory = nil
    local minDist = math.huge

    for i = 1, #units do
        local uID = units[i]
        local uDefID = Spring.GetUnitDefID(uID)
        
        if factoryDefs[uDefID] then
            local _, _, _, _, buildProgress = Spring.GetUnitHealth(uID)
            if buildProgress and buildProgress >= 1.0 then
                local fx, _, fz = Spring.GetUnitPosition(uID)
                local d = GetDistance(x, z, fx, fz)
                if d < minDist then
                    minDist = d
                    bestFactory = uID
                end
            end
        end
    end
    return bestFactory
end

-- Trova una raffineria alleata che ha spazio per ricevere Livrium
local function FindRefineryNeedingLivrium(truckID, truckData)
    local teamID = truckData.teamID
    local x, _, z = Spring.GetUnitPosition(truckID)
    local units = Spring.GetTeamUnits(teamID)

    local bestRefinery = nil
    local minDist = math.huge

    for i = 1, #units do
        local rID = units[i]
        local uDefID = Spring.GetUnitDefID(rID)

        if refineryDefs[uDefID] then
            local _, _, _, _, buildProgress = Spring.GetUnitHealth(rID)
            if buildProgress and buildProgress >= 1.0 then
                local curLiv = Spring.GetUnitRulesParam(rID, "livrium_storage") or 0
                local maxLiv = Spring.GetUnitRulesParam(rID, "livrium_storage_max") or 500
                
                -- Se la raffineria non è piena
                if curLiv < maxLiv then
                    -- Controlla che nessun altro camion sia già assegnato a questa raffineria
                    local alreadyAssigned = false
                    for otherID, otherData in pairs(trucks) do
                        if otherID ~= truckID and otherData.targetRefinery == rID then
                            alreadyAssigned = true
                            break
                        end
                    end

                    if not alreadyAssigned then
                        local rx, _, rz = Spring.GetUnitPosition(rID)
                        local d = GetDistance(x, z, rx, rz)
                        if d < minDist then
                            minDist = d
                            bestRefinery = rID
                        end
                    end
                end
            end
        end
    end
    return bestRefinery
end

-- =============================================================================
-- CALLBACK DI SPRING
-- =============================================================================

function gadget:Initialize()
    for name, cfg in pairs(TRUCK_TYPES) do
        local ud = UnitDefNames[name]
        if ud then
            truckDefs[ud.id] = cfg
        end
        for _, fName in ipairs(cfg.factories) do
            local fDef = UnitDefNames[fName]
            if fDef then factoryDefs[fDef.id] = true end
        end
        for _, rName in ipairs(cfg.refineries) do
            local rDef = UnitDefNames[rName]
            if rDef then refineryDefs[rDef.id] = true end
        end
    end

    local allUnits = Spring.GetAllUnits()
    for i = 1, #allUnits do
        local uID = allUnits[i]
        local uDefID = Spring.GetUnitDefID(uID)
        local cfg = truckDefs[uDefID]
        if cfg then
            local _, _, _, _, buildProgress = Spring.GetUnitHealth(uID)
            if buildProgress and buildProgress >= 1.0 then
                trucks[uID] = {
                    teamID           = Spring.GetUnitTeam(uID),
                    config           = cfg,
                    state            = 0,
                    targetRefinery   = nil,
                    livrium_carried  = 0
                }
                Spring.SetUnitRulesParam(uID, "stato_camion", 0)
                Spring.SetUnitRulesParam(uID, "livrium_trasportato", 0)
                Spring.SetUnitRulesParam(uID, "livrium_max", cfg.capacity)
            end
        end
    end
end

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
    local cfg = truckDefs[unitDefID]
    if cfg then
        trucks[unitID] = {
            teamID          = unitTeam,
            config          = cfg,
            state           = 0,
            targetRefinery  = nil,
            livrium_carried = 0
        }
        Spring.SetUnitRulesParam(unitID, "stato_camion", 0)
        Spring.SetUnitRulesParam(unitID, "livrium_trasportato", 0)
        Spring.SetUnitRulesParam(unitID, "livrium_max", cfg.capacity)
    end
end

function gadget:UnitLoaded(unitID, unitDefID, unitTeam, transportID, transportTeam)
    local tData = trucks[unitID]
    if not tData then return end

    local transDefID = Spring.GetUnitDefID(transportID)

    -- 1. Imbarcato nella Fabbrica (Inizio carico)
    if factoryDefs[transDefID] then
        processingBuildings[transportID] = {
            timer      = tData.config.loadTime or DEFAULT_LOAD_TIME,
            truckID    = unitID,
            actionType = "LOAD"
        }
        tData.state = 2
        Spring.SetUnitRulesParam(unitID, "stato_camion", 2)

    -- 2. Imbarcato nella Raffineria (Inizio scarico)
    elseif refineryDefs[transDefID] then
        processingBuildings[transportID] = {
            timer      = tData.config.loadTime or DEFAULT_LOAD_TIME,
            truckID    = unitID,
            actionType = "UNLOAD"
        }
        tData.state = 4
        Spring.SetUnitRulesParam(unitID, "stato_camion", 4)
    end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
    if trucks[unitID] then
        trucks[unitID] = nil
    end

    if processingBuildings[unitID] then
        processingBuildings[unitID] = nil
    end
end

function gadget:UnitGiven(unitID, unitDefID, newTeam, oldTeam)
    if trucks[unitID] then
        trucks[unitID].teamID = newTeam
        trucks[unitID].targetRefinery = nil
        trucks[unitID].state = 0
        Spring.SetUnitRulesParam(unitID, "stato_camion", 0)
    end
end

-- =============================================================================
-- LOGICA DI GIOCO (GAMEFRAME)
-- =============================================================================

function gadget:GameFrame(n)
    if n % CHECK_INTERVAL ~= 0 then return end

    -- -------------------------------------------------------------------------
    -- 1. ELABORAZIONE STRUTTURE (LOAD / UNLOAD)
    -- -------------------------------------------------------------------------
    for bID, bData in pairs(processingBuildings) do
        if not Spring.ValidUnitID(bID) then
            processingBuildings[bID] = nil
        else
            bData.timer = bData.timer - CHECK_INTERVAL
            if bData.timer <= 0 then
                local truckID = bData.truckID
                local bx, by, bz = Spring.GetUnitPosition(bID)

                if Spring.ValidUnitID(truckID) and trucks[truckID] then
                    local tData = trucks[truckID]

                    if bData.actionType == "LOAD" then
                        -- Scala la risorsa dal team globale al momento del carico effettivo
                        local capacity = tData.config.capacity
                        if GG.UseTeamLivrium then
                            GG.UseTeamLivrium(tData.teamID, capacity)
                        end
                        tData.livrium_carried = capacity
                        Spring.SetUnitRulesParam(truckID, "livrium_trasportato", capacity)
                        tData.state = 3 -- Pronto a viaggiare verso la raffineria
                        Spring.SetUnitRulesParam(truckID, "stato_camion", 3)
						Spring.CallCOBScript(truckID, "ChangeStatusFromLUA", 0, 1)	-- imposto il comando in .cob per mostrare il livrium trasportato --> 1 = show livrium object, 0 = hide livrium object. Guarda il modello.s3o e lo script .cob

                    elseif bData.actionType == "UNLOAD" then
                        -- Deposita nel serbatoio interno della raffineria
                        if GG.AddRefineryLivrium then
                            GG.AddRefineryLivrium(bID, tData.livrium_carried)
                        end
                        tData.livrium_carried = 0
                        tData.targetRefinery = nil
                        Spring.SetUnitRulesParam(truckID, "livrium_trasportato", 0)
                        tData.state = 0 -- Torna IDLE
                        Spring.SetUnitRulesParam(truckID, "stato_camion", 0)
						Spring.CallCOBScript(truckID, "ChangeStatusFromLUA", 0, 0)	-- imposto il comando in .cob per mostrare il livrium trasportato --> 1 = show livrium object, 0 = hide livrium object. Guarda il modello.s3o e lo script .cob
                    end

                    -- Scarica il camion fuori dalla struttura
                    Spring.GiveOrderToUnit(bID, CMD.UNLOAD_UNITS, {bx + 160, by, bz + 160, 100}, {})
                end

                processingBuildings[bID] = nil
            end
        end
    end

    -- -------------------------------------------------------------------------
    -- 2. AGGIORNAMENTO STATO E MOVIMENTO CAMION (Logica identica all'Harvester)
    -- -------------------------------------------------------------------------
    for truckID, data in pairs(trucks) do
        local x, y, z = Spring.GetUnitPosition(truckID)
        local qCount = Spring.GetUnitCommands(truckID, 0)
        local isIdle = (qCount == 0)

        -- STATO 0: IDLE (In cerca di carico e destinazione)
        if data.state == 0 then
            Spring.SetUnitRulesParam(truckID, "stato_camion", 0)
            
            local teamLivrium = (GG.GetTeamLivrium and GG.GetTeamLivrium(data.teamID)) or 0
            if teamLivrium >= data.config.capacity then
                local targetRef = FindRefineryNeedingLivrium(truckID, data)
                if targetRef then
                    data.targetRefinery = targetRef
                    data.state = 1 -- Passa a: Vai alla Fabbrica
                end
            end

        -- STATO 1: VAI ALLA HARVESTER FACTORY
        elseif data.state == 1 then
            Spring.SetUnitRulesParam(truckID, "stato_camion", 1)
            
            if not Spring.ValidUnitID(data.targetRefinery) then
                data.targetRefinery = nil
                data.state = 0
            else
                local factID = GetNearestFactory(truckID)
                if factID then
                    local fx, fy, fz = Spring.GetUnitPosition(factID)
                    local dist = GetDistance(x, z, fx, fz)

                    if dist > DOCK_DISTANCE_factory then
                        if isIdle then
                            Spring.GiveOrderToUnit(truckID, CMD.MOVE, {fx, fy, fz}, {})
                        end
                    else
                        local fQueue = Spring.GetUnitCommands(factID, 1)
                        if #fQueue == 0 and not processingBuildings[factID] then
                            Spring.GiveOrderToUnit(factID, CMD.LOAD_UNITS, { truckID }, {})
                        end
                    end
                end
            end

        -- STATO 3: VAI ALLA RAFFINERIA
        elseif data.state == 3 then
            Spring.SetUnitRulesParam(truckID, "stato_camion", 3)
            
            local refID = data.targetRefinery
            if not Spring.ValidUnitID(refID) then
                data.targetRefinery = FindRefineryNeedingLivrium(truckID, data)
            else
                local rx, ry, rz = Spring.GetUnitPosition(refID)
                local dist = GetDistance(x, z, rx, rz)

                if dist > DOCK_DISTANCE_refineries then
                    if isIdle then
                        Spring.GiveOrderToUnit(truckID, CMD.MOVE, {rx, ry, rz}, {})
                    end
                else
                    local rQueue = Spring.GetUnitCommands(refID, 1)
                    if #rQueue == 0 and not processingBuildings[refID] then
                        Spring.GiveOrderToUnit(refID, CMD.LOAD_UNITS, { truckID }, {})
                    end
                end
            end
        end
    end
end