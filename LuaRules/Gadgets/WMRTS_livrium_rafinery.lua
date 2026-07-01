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

if not gadgetHandler:IsSyncedCode() then 
    return 
end

-- =============================================================================
-- CONFIGURAZIONE
-- =============================================================================

local refineryConfig = {
    euf_rafinery = {
        energy_consumption = 1000, -- Consumo di energia richiesto per ogni conversione
        livrium_bruciato   = 10,   -- Unita di Livrium perse ad ogni ciclo
        metal_ottenuto     = 50,   -- Metallo ottenuto ad ogni ciclo
        frequenza_sec      = 2     -- Frequenza in secondi del ciclo di conversione
    }
    -- aggiugnere le varianti ############## AND ###################
}

-- =============================================================================
-- VARIABILI DI STATO (SYNCED)
-- =============================================================================

local activeRefineries = {} -- activeRefineries[unitID] = { teamID, config, timer }
local refineryConfigs = {}  -- refineryConfigs[unitDefID] = config_elaborata

-- =============================================================================
-- LOGICA DI CONVERSIONE
-- =============================================================================

local function ProcessRefinery(unitID, data)
    -- Controlla se la raffineria e attiva (non e paralizzata, ha energia nativa ed e accesa)
    if not Spring.GetUnitIsActive(unitID) then
        return
    end

    local teamID = data.teamID
    local config = data.config

    -- 1. Controlla se il team ha abbastanza Energia
    local currentEnergy = Spring.GetTeamResources(teamID, "energy")
    if not currentEnergy or currentEnergy < config.energy_consumption then
        return -- Energia insufficiente, la conversione salta per questo ciclo
    end

    -- 2. Controlla se il team ha abbastanza Livrium (tramite il gadget del Punto 1)
    if not GG.GetTeamLivrium then
        return -- Il modulo di gestione Livrium non e caricato
    end
    
    local currentLivrium, _ = GG.GetTeamLivrium(teamID)
    if not currentLivrium or currentLivrium < config.livrium_bruciato then
        return -- Livrium insufficiente, la conversione salta per questo ciclo
    end

    -- 3. Esegui la conversione
    -- Consuma prima il Livrium (se l'operazione va a buon fine, procediamo)
    if GG.UseTeamLivrium(teamID, config.livrium_bruciato) then
        -- Consuma l'energia richiesta
        Spring.UseTeamResource(teamID, "energy", config.energy_consumption)
        
        -- Accredita il metallo ottenuto al team
        -- Nota: il motore Spring gestisce automaticamente lo stoccaggio massimo del metallo,
        -- quindi se il giocatore non ha abbastanza magazzini di metallo, l'eccedenza verra persa.
        Spring.AddTeamResource(teamID, "metal", config.metal_ottenuto)
    end
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
                    teamID = teamID,
                    config = cfg,
                    timer  = 0
                }
            end
        end
    end
end

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
    local cfg = refineryConfigs[unitDefID]
    if cfg then
        activeRefineries[unitID] = {
            teamID = unitTeam,
            config = cfg,
            timer  = 0
        }
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