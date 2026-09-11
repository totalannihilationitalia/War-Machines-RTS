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
local DOCK_DISTANCE    = 320  -- Distanza minima a cui impartire il comando LOAD_UNITS alla struttura
local DEFAULT_LOAD_TIME = 150 -- Frame di sosta dentro la struttura (150 frame = 5 secondi)

local TRUCK_TYPES = {
    ruspa_camion = {
        capacity    = 200,
        factories   = {"euf_harvester_factory"},
        refineries = { "eufrafinery", "eufrafineryenergy" }, -- aggiungere tutte le raffinerie che necessitano il trasporto di livrium
        loadTime    = 150
    },
    and_camion = {				-- ############## da definire
        capacity    = 200,
        factories     = {"and_harvester_factory"}, -- Modificare con il nome esatto dell'unità AND
        refineries   = {"and_refinery"},          -- Modificare con il nome esatto dell'unità AND
        loadTime    = 150
    }
}

-- =============================================================================
-- VARIABILI DI STATO (SYNCED)
-- =============================================================================

-- trucks[unitID] = { teamID, config, state, targetRefinery, livrium_carried, truckDefID }
local trucks = {}

-- processingBuildings[buildingID] = { timer, truckID, actionType ("LOAD" / "UNLOAD") }
local processingBuildings = {}

-- Cache degli ID numerici di Spring
local truckDefs = {}     -- truckDefs[unitDefID] = config
local factoryDefs = {}   -- factoryDefs[unitDefID] = true
local refineryDefs = {}  -- refineryDefs[unitDefID] = true

-- =============================================================================
-- FUNZIONI DI UTILITÀ
-- =============================================================================

local function GetDistance(x1, z1, x2, z2)
    return math.sqrt((x1 - x2)^2 + (z1 - z2)^2)
end

-- Trova la Harvester Factory alleata più vicina tra quelle compatibili
local function GetNearestFactory(unitID, factoryList)
    local x, _, z = Spring.GetUnitPosition(unitID)
    local teamID = Spring.GetUnitTeam(unitID)
    local units = Spring.GetTeamUnits(teamID)
    local bestFactory = nil
    local minDist = math.huge

    -- Crea set rapido delle fabbriche valide
    local validFactories = {}
    for _, fName in ipairs(factoryList) do
        local ud = UnitDefNames[fName]
        if ud then validFactories[ud.id] = true end
    end

    for i = 1, #units do
        local uID = units[i]
        local uDefID = Spring.GetUnitDefID(uID)
        if validFactories[uDefID] then
            local _, _, _, _, buildProgress = Spring.GetUnitHealth(uID)
            if buildProgress and buildProgress >= 1.0 and Spring.GetUnitIsActive(uID) then
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

-- Trova una raffineria alleata che necessita di Livrium
local function FindRefineryNeedingLivrium(truckID, truckData)
    local teamID = truckData.teamID
    local x, _, z = Spring.GetUnitPosition(truckID)
    local units = Spring.GetTeamUnits(teamID)

    local bestRefinery = nil
    local minDist = math.huge

    -- Crea un set rapido delle raffinerie compatibili con questo camion
    local validDefIDs = {}
    for _, refName in ipairs(truckData.config.refineries) do
        local ud = UnitDefNames[refName]
        if ud then validDefIDs[ud.id] = true end
    end

    for i = 1, #units do
        local rID = units[i]
        local uDefID = Spring.GetUnitDefID(rID)

        -- Se questa unità fa parte delle raffinerie valide per questo camion
        if validDefIDs[uDefID] then
            local _, _, _, _, buildProgress = Spring.GetUnitHealth(rID)
            if buildProgress and buildProgress >= 1.0 and Spring.GetUnitIsActive(rID) then
                local curLiv = Spring.GetUnitRulesParam(rID, "livrium_storage") or 0
                
                -- Se ha bisogno di Livrium
                if curLiv < truckData.config.capacity then
                    -- Controlla che nessun altro camion sia già diretto qui
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
                        -- Sceglie la raffineria bisognosa più vicina
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
    -- Conversione nomi unità in ID numerici
    for name, cfg in pairs(TRUCK_TYPES) do
        local ud = UnitDefNames[name]
        if ud then
            truckDefs[ud.id] = cfg
        end
        -- Registra tutte le fabbriche della lista
        for _, fName in ipairs(cfg.factories) do
            local fDef = UnitDefNames[fName]
            if fDef then factoryDefs[fDef.id] = true end
        end

        -- Registra tutte le raffinerie della lista
        for _, rName in ipairs(cfg.refineries) do
            local rDef = UnitDefNames[rName]
            if rDef then refineryDefs[rDef.id] = true end
        end
    end		
		


    -- Registra unità già presenti alla partenza
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
                    state            = 0, -- 0 = IDLE
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
            state           = 0, -- 0 = IDLE
            targetRefinery  = nil,
            livrium_carried = 0
        }
        Spring.SetUnitRulesParam(unitID, "stato_camion", 0)
        Spring.SetUnitRulesParam(unitID, "livrium_trasportato", 0)
        Spring.SetUnitRulesParam(unitID, "livrium_max", cfg.capacity)
    end
end

-- Gestione caricamento del camion nella struttura (Factory o Raffineria)
function gadget:UnitLoaded(unitID, unitDefID, unitTeam, transportID, transportTeam)
    local tData = trucks[unitID]
    if not tData then return end

    local transDefID = Spring.GetUnitDefID(transportID)

    -- 1. Camion imbarcato nella Harvester Factory -> Inizio ciclo di caricamento
    if factoryDefs[transDefID] then
        processingBuildings[transportID] = {
            timer      = tData.config.loadTime or DEFAULT_LOAD_TIME,
            truckID    = unitID,
            actionType = "LOAD"
        }
        tData.state = 2 -- STATO 2: Docked in Fabbrica
        Spring.SetUnitRulesParam(unitID, "stato_camion", 2)

    -- 2. Camion imbarcato nella Raffineria -> Inizio ciclo di scarico
    elseif refineryDefs[transDefID] then
        processingBuildings[transportID] = {
            timer      = tData.config.loadTime or DEFAULT_LOAD_TIME,
            truckID    = unitID,
            actionType = "UNLOAD"
        }
        tData.state = 4 -- STATO 4: Docked in Raffineria
        Spring.SetUnitRulesParam(unitID, "stato_camion", 4)
    end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
    -- Se l'unità distrutta è un camion
    if trucks[unitID] then
        local data = trucks[unitID]
        -- Se il camion trasportava Livrium al momento della distruzione,
        -- il Livrium viene perso e decurtato dal totale del team
        if data.livrium_carried > 0 then
            if GG.UseTeamLivrium then
                GG.UseTeamLivrium(data.teamID, data.livrium_carried)
            end
        end
        trucks[unitID] = nil
    end

    -- Se viene distrutta una struttura mentre stava processando un camion
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
    -- Esegue il controllo logico ogni CHECK_INTERVAL frame
    if n % CHECK_INTERVAL ~= 0 then return end

    -- -------------------------------------------------------------------------
    -- 1. AGGIORNAMENTO STRUTTURE IN ELABORAZIONE (LOAD / UNLOAD)
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
                        -- Carico completato presso la Fabbrica
                        tData.livrium_carried = tData.config.capacity
                        Spring.SetUnitRulesParam(truckID, "livrium_trasportato", tData.livrium_carried)
                        tData.state = 3 -- Pronto per viaggiare verso la raffineria
                        Spring.SetUnitRulesParam(truckID, "stato_camion", 3)

                    elseif bData.actionType == "UNLOAD" then
                        -- Scarico completato presso la Raffineria, passa il carico dal camion alla raffineria
                        if GG.AddRefineryLivrium then
                            GG.AddRefineryLivrium(bID, tData.livrium_carried)     -- 'bID' è l'ID della raffineria che contiene il camion e 'tData.livrium_carried' è la quantità a bordo del camion (es. 200)
                        end
                        tData.livrium_carried = 0
                        tData.targetRefinery = nil
                        Spring.SetUnitRulesParam(truckID, "livrium_trasportato", 0)
                        tData.state = 0 -- Torna IDLE
                        Spring.SetUnitRulesParam(truckID, "stato_camion", 0)
                    end

                    -- Scarica fisicamente il camion fuori dalla struttura
                    Spring.GiveOrderToUnit(bID, CMD.UNLOAD_UNITS, {bx + 160, by, bz + 160, 100}, {})
                end

                processingBuildings[bID] = nil
            end
        end
    end

    -- -------------------------------------------------------------------------
    -- 2. AGGIORNAMENTO STATO E MOVIMENTO CAMION
    -- -------------------------------------------------------------------------
    for truckID, data in pairs(trucks) do
        -- Se il camion è spento (OFF) o paralizzato, non esegue ordini logistici
        if not Spring.GetUnitIsActive(truckID) then
            Spring.SetUnitRulesParam(truckID, "stato_camion", 5) -- 5 = Camion spento / OFF
        else
            local x, y, z = Spring.GetUnitPosition(truckID)
            local qCount = Spring.GetUnitCommands(truckID, 0)
            local isIdle = (qCount == 0)

            -- STATO 0: IDLE (In cerca di incarico)
            if data.state == 0 then
                Spring.SetUnitRulesParam(truckID, "stato_camion", 0)
                
                -- Verifica se il team ha Livrium globale disponibile
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
                
                -- Verifica se la raffineria target è ancora valida
                if not Spring.ValidUnitID(data.targetRefinery) then
                    data.targetRefinery = nil
                    data.state = 0
                else
				    -- Passa la lista delle fabbriche compatibili
                    local factID = GetNearestFactory(truckID, data.config.factories)
                    if factID then
                        local fx, fy, fz = Spring.GetUnitPosition(factID)
                        local dist = GetDistance(x, z, fx, fz)

                        if dist > DOCK_DISTANCE then
                            if isIdle then
                                Spring.GiveOrderToUnit(truckID, CMD.MOVE, {fx, fy, fz}, {})
                            end
                        else
                            -- Arrivato: la fabbrica imbarca il camion
                            local fQueue = Spring.GetUnitCommands(factID, 1)
                            if #fQueue == 0 and not processingBuildings[factID] then
                                Spring.GiveOrderToUnit(factID, CMD.LOAD_UNITS, { truckID }, {})
                            end
                        end
                    end
                end

            -- STATO 2: IMBARCATO NELLA FABBRICA (Attende UnitLoaded e timer struttura)

            -- STATO 3: VAI ALLA RAFFINERIA
            elseif data.state == 3 then
                Spring.SetUnitRulesParam(truckID, "stato_camion", 3)
                
                local refID = data.targetRefinery
                if not Spring.ValidUnitID(refID) then
                    -- Se la raffineria è stata distrutta mentre il camion viaggiava verso di lei,
                    -- cercane un'altra
                    data.targetRefinery = FindRefineryNeedingLivrium(truckID, data)
                else
                    local rx, ry, rz = Spring.GetUnitPosition(refID)
                    local dist = GetDistance(x, z, rx, rz)

                    if dist > DOCK_DISTANCE then
                        if isIdle then
                            Spring.GiveOrderToUnit(truckID, CMD.MOVE, {rx, ry, rz}, {})
                        end
                    else
                        -- Arrivato: la raffineria imbarca il camion per scaricarlo
                        local rQueue = Spring.GetUnitCommands(refID, 1)
                        if #rQueue == 0 and not processingBuildings[refID] then
                            Spring.GiveOrderToUnit(refID, CMD.LOAD_UNITS, { truckID }, {})
                        end
                    end
                end

            -- STATO 4: IMBARCATO NELLA RAFFINERIA (Attende UnitLoaded e timer struttura)
            end
        end
    end
end