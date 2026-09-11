function gadget:GetInfo()
  return {
    name      = "WMRTS Refinery Logic",
    desc      = "Gestisce la conversione di Livrium in Metallo tramite le raffinerie",
    author    = "molix",
    date      = "2026",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true
  }
end

-- rev0 = generato questo gadget per la conversione Livrium -> metal
-- rev1 = 03/07/2026 aggiungo la variabile "stato_raffineria" che verrà poi utilizzata per mostrare le etichette di stato. molix
-- rev2 = 11/09/2026 aggiungo il magazzino livrium interno. La gestione del livrium sarà più complessa: dovra essere trasportato tramite mezzi dall'harvester factory alla raffineria
--[[
Come modificare i parametro da gadget esterno (Ricerche):
if GG.SetRefineryTeamMultiplier then
    -- Riduce il consumo energetico delle raffinerie del team a 70% (sconto del 30%)
    GG.SetRefineryTeamMultiplier(teamID, "energy", 0.70)
end
Le variabili modificabili sono:
"livrium"	-- livrium consumato per la conversione livrium/metal
"metal"		-- metallo prodotto
"energy"	-- energia consumata per la conversione livrium/metal
]]--
if not gadgetHandler:IsSyncedCode() then 
    return 
end

-- =============================================================================
-- CONFIGURAZIONE
-- =============================================================================

local refineryConfig = {
    eufrafinery = {
        energy_consumption = 1000, 	-- Consumo di energia richiesto per ogni conversione
        livrium_bruciato   = 50,   	-- Unita di Livrium perse ad ogni ciclo
        metal_ottenuto     = 50,   	-- Metallo ottenuto ad ogni ciclo
        frequenza_sec      = 2,     -- Frequenza in secondi del ciclo di conversione
		livrium_storage_max= 500,	-- capienza massima di livrium nel serbatoio interno la raffineria
    }
    -- aggiugnere le varianti ############## AND ###################
}

-- =============================================================================
-- VARIABILI DI STATO (SYNCED)
-- =============================================================================

local activeRefineries = {} -- activeRefineries[unitID] = { teamID, config, timer, livrium_storage }
local refineryConfigs = {}  -- refineryConfigs[unitDefID] = config_elaborata
local teamModifiers = {}    -- teamModifiers[teamID] = { energy = 1.0, livrium = 1.0, metal = 1.0 }

-- =============================================================================
-- INTERFACCIA GLOBALE (GG) PER ALTRI GADGET
-- =============================================================================

-- 1. Chiamato dal gadget RICERCHE per modificare l'efficienza di un Team
-- statName può essere: "energy", "livrium", "metal"
-- mult è il moltiplicatore (es: 0.8 per -20% consumo, 1.2 per +20% produzione)
GG.SetRefineryTeamMultiplier = function(teamID, statName, mult)
    if not teamModifiers[teamID] then
        teamModifiers[teamID] = { energy = 1.0, livrium = 1.0, metal = 1.0 }
    end
    teamModifiers[teamID][statName] = mult
end

-- 2. Chiamato dal gadget dei CAMION per scaricare il Livrium nella raffineria
-- Ritorna la quantità effettivamente scaricata
GG.AddRefineryLivrium = function(unitID, amount)
    local data = activeRefineries[unitID]
    if not data then return 0 end

    local maxCap = data.config.livrium_storage_max
    local spaceAvailable = maxCap - data.livrium_storage
    local amountToAdd = math.min(amount, spaceAvailable)

    if amountToAdd > 0 then
        data.livrium_storage = data.livrium_storage + amountToAdd
        Spring.SetUnitRulesParam(unitID, "livrium_storage", data.livrium_storage)
        return amountToAdd
    end
    return 0
end

-- 3. Chiamato dal gadget dei CAMION per sapere lo stato del serbatoio
GG.GetRefineryLivrium = function(unitID)
    local data = activeRefineries[unitID]
    if not data then return nil, nil end
    return data.livrium_storage, data.config.livrium_storage_max
end

-- =============================================================================
-- LOGICA DI CONVERSIONE
-- =============================================================================

local function ProcessRefinery(unitID, data)
    -- Controlla se la raffineria è attiva
    if not Spring.GetUnitIsActive(unitID) then
        Spring.SetUnitRulesParam(unitID, "stato_raffineria", 3) -- 3 = Spenta
        return
    end

    local teamID = data.teamID
    local config = data.config

    -- Recupera o crea i moltiplicatori per questo team (default 1.0)
    local mods = teamModifiers[teamID] or { energy = 1.0, livrium = 1.0, metal = 1.0 }

    -- Calcola i valori effettivi per questo ciclo
    local energyReq  = math.floor(config.energy_consumption * (mods.energy or 1.0))
    local livriumReq = math.floor(config.livrium_bruciato * (mods.livrium or 1.0))
    local metalProd  = math.floor(config.metal_ottenuto * (mods.metal or 1.0))

    -- 1. Controlla il serbatoio locale di Livrium
    if data.livrium_storage < livriumReq then
        Spring.SetUnitRulesParam(unitID, "stato_raffineria", 2) -- 2 = No Livrium
        return
    end

    -- 2. Controlla l'Energia del Team
    local currentEnergy = Spring.GetTeamResources(teamID, "energy")
    if not currentEnergy or currentEnergy < energyReq then
        Spring.SetUnitRulesParam(unitID, "stato_raffineria", 1) -- 1 = No Energia
        return
    end

    -- 3. Esegui la conversione
    Spring.SetUnitRulesParam(unitID, "stato_raffineria", 0) -- 0 = OK

    -- Consuma Livrium locale
    data.livrium_storage = data.livrium_storage - livriumReq
    Spring.SetUnitRulesParam(unitID, "livrium_storage", data.livrium_storage)

    -- Consuma Energia globale
    Spring.UseTeamResource(teamID, "energy", energyReq)

    -- Aggiungi Metallo al team
    Spring.AddTeamResource(teamID, "metal", metalProd)
end

-- =============================================================================
-- CALLBACK DI SPRING
-- =============================================================================

function gadget:Initialize()
    -- Converte i nomi delle unita definiti in configurazione nei rispettivi UnitDefID
    for name, cfg in pairs(refineryConfig) do
        local ud = UnitDefNames[name]
        if ud then
            refineryConfigs[ud.id] = {
                energy_consumption = cfg.energy_consumption,
                livrium_bruciato   = cfg.livrium_bruciato,
                metal_ottenuto     = cfg.metal_ottenuto,
				livrium_storage_max = cfg.livrium_storage_max or 500, 
                frequenza_frames   = cfg.frequenza_sec * 30 -- 30 frame di Spring equivalgono a 1 secondo
            }
        else
            Spring.Echo("WMRTS Refinery Logic Warning: L'unita '" .. name .. "' non esiste nei file di gioco.")
        end
    end

    -- Rileva le raffinerie gia esistenti sulla mappa all'avvio della partita
    local allUnits = Spring.GetAllUnits()
    for i = 1, #allUnits do
        local unitID = allUnits[i]
        local unitDefID = Spring.GetUnitDefID(unitID)
        local cfg = refineryConfigs[unitDefID]
        if cfg then
            local _, _, _, _, buildProgress = Spring.GetUnitHealth(unitID)
            if buildProgress and buildProgress >= 1.0 then
                local teamID = Spring.GetUnitTeam(unitID)
				activeRefineries[unitID] = {
					teamID          = teamID,
					config          = cfg,
					timer           = 0,
					livrium_storage = 0 
				}
Spring.SetUnitRulesParam(unitID, "livrium_storage", 0)
Spring.SetUnitRulesParam(unitID, "livrium_storage_max", cfg.livrium_storage_max or 500)
            end
        end
    end
end

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
    local cfg = refineryConfigs[unitDefID]
    if cfg then
		activeRefineries[unitID] = {
			teamID          = unitTeam,
			config          = cfg,
			timer           = 0,
			livrium_storage = 0 
		}
		Spring.SetUnitRulesParam(unitID, "livrium_storage", 0)
		Spring.SetUnitRulesParam(unitID, "livrium_storage_max", cfg.livrium_storage_max or 500)
    end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
    if activeRefineries[unitID] then
        activeRefineries[unitID] = nil
    end
end

function gadget:UnitGiven(unitID, unitDefID, newTeam, oldTeam)
    if activeRefineries[unitID] then
        activeRefineries[unitID].teamID = newTeam
    end
end

function gadget:GameFrame(n)
    -- Controlla e aggiorna i timer di tutte le raffinerie attive ad ogni frame di gioco
    for unitID, data in pairs(activeRefineries) do
        data.timer = data.timer + 1
        if data.timer >= data.config.frequenza_frames then
            data.timer = 0
            ProcessRefinery(unitID, data)
        end
    end
end