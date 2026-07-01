function gadget:GetInfo()
  return {
    name      = "WMRTS Harvester Logic",
    desc      = "Gestisce la raccolta di Livrium per War Machines RTS",
    author    = "molix",
    date      = "29/06/2026",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true -- caricato di default
  }
end

-- 29/06/2026 = realizzata rev 0
-- 01/07/2026 = rev 1 -> integrato con il WMRTS_livrium_menagement.lua. Ora il "livrium" raccolto è una risorsa vera e propria, che verrà trasformato in metal solo dalle apposite raffinerie.
-- todo
-- fare in modo che al loading dell'unità, vengano memorizzate le posizioni x,y,z cosi da utilizzarle per scaricare l'unità. Obiettivo: l'unità deve essere scaricata nell'esatto punto in cui l'ho prelevata
if not gadgetHandler:IsSyncedCode() then return end

-- =============================================================================
-- CONFIGURAZIONE E COSTANTI
-- =============================================================================

local MAX_LIVRIUM = 3000
local HARVEST_SPEED = 100 
local CHECK_INTERVAL = 30 
local UNLOAD_DISTANCE = 350
local LOAD_TIME = 150 

local livriumFields = {
    ["Zoty Outpost"] = {
        {x = 364, z = 1550, radius = 400},
    },
}

local currentMap = Game.mapName
local fields = livriumFields[currentMap] or {}

local harvesters = {} 
local factories = {}  

-- =============================================================================
-- FUNZIONI DI SUPPORTO
-- =============================================================================

local function GetDistance(x1, z1, x2, z2)
    return math.sqrt((x1-x2)^2 + (z1-z2)^2)
end

local function GetNearestField(x, z)
    local bestField = nil
    local minDist = math.huge
    for _, field in ipairs(fields) do
        local d = GetDistance(x, z, field.x, field.z)
        if d < minDist then
            minDist = d
            bestField = field
        end
    end
    return bestField
end

local function GetNearestFactory(unitID)
    local x, y, z = Spring.GetUnitPosition(unitID)
    local teamID = Spring.GetUnitTeam(unitID)
    local units = Spring.GetTeamUnits(teamID)
    local bestFact = nil
    local minDist = math.huge
    
    for _, fID in ipairs(units) do
        local unitDefID = Spring.GetUnitDefID(fID)
        if unitDefID and UnitDefNames["euf_harvester_factory"] and unitDefID == UnitDefNames["euf_harvester_factory"].id then
            local fx, fy, fz = Spring.GetUnitPosition(fID)
            local d = GetDistance(x, z, fx, fz)
            if d < minDist then
                minDist = d
                bestFact = fID
            end
        end
    end
    return bestFact
end

-- =============================================================================
-- CALLBACK DI SPRING
-- =============================================================================

function gadget:UnitCreated(unitID, unitDefID, unitTeam)
    local uDef = UnitDefs[unitDefID]
    if uDef.name == "euf_harvester" then
        Spring.SetUnitRulesParam(unitID, "stato_raccolta", 1)
        Spring.SetUnitRulesParam(unitID, "quantita_raccolta", 0)
        harvesters[unitID] = {timer = 0}
    elseif uDef.name == "euf_harvester_factory" then
        factories[unitID] = {isProcessing = false, timer = 0, processingUnit = nil}
    end
end

function gadget:UnitLoaded(unitID, unitDefID, unitTeam, transportID, transportTeam)
    if UnitDefs[unitDefID].name == "euf_harvester" then
        if factories[transportID] then
            factories[transportID].isProcessing = true
            factories[transportID].timer = LOAD_TIME
            factories[transportID].processingUnit = unitID
            Spring.SetUnitRulesParam(unitID, "stato_raccolta", 4)
        end
    end
end

function gadget:UnitDestroyed(unitID)
    harvesters[unitID] = nil
    factories[unitID] = nil
end

function gadget:GameFrame(n)
    if n % CHECK_INTERVAL ~= 0 then return end

    -- Ciclo Harvesters
    for hID, data in pairs(harvesters) do
        local stato = Spring.GetUnitRulesParam(hID, "stato_raccolta")
        local x, y, z = Spring.GetUnitPosition(hID)
        local teamID = Spring.GetUnitTeam(hID)
        
        -- Controlliamo se l'harvester è fermo (coda ordini vuota)
        local qCount = Spring.GetUnitCommands(hID, 0)
        local isIdle = (qCount == 0)

        local hasFactory = false
        for fID, _ in pairs(factories) do
            if Spring.GetUnitTeam(fID) == teamID then hasFactory = true; break end
        end

        if hasFactory and #fields > 0 then
            
            -- STATO 1: VAI A RACCOGLIERE
            if stato == 1 then
                local field = GetNearestField(x, z)
                if field then
                    local distToField = GetDistance(x, z, field.x, field.z)
                    
                    if distToField > field.radius then
                        -- DA RE-IMPARTIRE SOLO SE FERMO
                        if isIdle then
                            Spring.GiveOrderToUnit(hID, CMD.MOVE, {field.x, y, field.z}, {})
                        end
                    else
                        -- Siamo dentro il campo
                        local quantita = Spring.GetUnitRulesParam(hID, "quantita_raccolta") or 0
                        if quantita < MAX_LIVRIUM then
                            Spring.SetUnitRulesParam(hID, "quantita_raccolta", quantita + HARVEST_SPEED)
                            
                            -- Movimento casuale ogni 20 secondi
                            data.timer = data.timer + 1
                            if data.timer >= 20 then
                                local angle = math.random() * math.pi * 2
                                local r = math.random() * field.radius
                                local tx = field.x + math.cos(angle) * r
                                local tz = field.z + math.sin(angle) * r
                                Spring.GiveOrderToUnit(hID, CMD.MOVE, {tx, y, tz}, {})
                                data.timer = 0
                            end
                        else
                            Spring.SetUnitRulesParam(hID, "stato_raccolta", 2)
                        end
                    end
                end

            -- STATO 2: TORNA ALLA FABBRICA
            elseif stato == 2 then
                local factID = GetNearestFactory(hID)
                if factID then
                    local fx, fy, fz = Spring.GetUnitPosition(factID)
                    local distToFact = GetDistance(x, z, fx, fz)
                    
                    if distToFact > UNLOAD_DISTANCE then
                        -- DA RE-IMPARTIRE SOLO SE FERMO
                        if isIdle then
                            Spring.GiveOrderToUnit(hID, CMD.MOVE, {fx, fy, fz}, {})
                        end
                    else
                        Spring.SetUnitRulesParam(hID, "stato_raccolta", 3)
                    end
                end

            -- STATO 3: ATTESA CARICO
            elseif stato == 3 then
                local factID = GetNearestFactory(hID)
                if factID and not factories[factID].isProcessing then
                    -- Controlliamo se la fabbrica ha già l'ordine di caricare questo harvester
                    -- per evitare di spammare CMD.LOAD_UNITS
                    local fQueue = Spring.GetUnitCommands(factID, 1)
                    if #fQueue == 0 then 
                        Spring.GiveOrderToUnit(factID, CMD.LOAD_UNITS, { hID }, {"shift"})
--                        Spring.GiveOrderToUnit(hID, CMD.WAIT, {}, {}) -- L'harvester si mette in pausa
                    end
                end
            end
        end
    end

    -- GESTIONE FABBRICHE (Rimane quasi uguale)
    for fID, data in pairs(factories) do
        if data.isProcessing then
            data.timer = data.timer - CHECK_INTERVAL
            if data.timer <= 0 then
                local hID = data.processingUnit
                if Spring.ValidUnitID(hID) then
                    local teamID = Spring.GetUnitTeam(hID)
                    local guadagno = Spring.GetUnitRulesParam(hID, "quantita_raccolta") or 0
--                    Spring.AddTeamResource(teamID, "metal", guadagno) -- rimosso con rev1
                    -- Aggiunge il livrium accumulato al team usando il gadget di gestione WMRTS_livrium_menagement.lua . Ora il livrium è una risorsa vera e propria che viene gestita dal gadget.
                    if GG.AddTeamLivrium then
                        GG.AddTeamLivrium(teamID, guadagno)
                    else
                        Spring.Echo("WMRTS Harvester Logic Error: Il gadget di gestione Livrium non e attivo!") -- debug in caso di errore!!!!!!!!!!!
                    end                    
                    local fx, fy, fz = Spring.GetUnitPosition(fID)
                    -- Scarica l'unità
                    Spring.GiveOrderToUnit(fID, CMD.UNLOAD_UNITS, {fx + 150, fy, fz + 150, 100}, {})
                    
                    Spring.SetUnitRulesParam(hID, "quantita_raccolta", 0)
                    Spring.SetUnitRulesParam(hID, "stato_raccolta", 1)
                end
                data.isProcessing = false
                data.processingUnit = nil
            end
        end
    end
end