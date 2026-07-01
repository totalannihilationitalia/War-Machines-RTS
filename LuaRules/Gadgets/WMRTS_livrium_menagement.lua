function gadget:GetInfo()
  return {
    name      = "Livrium Resource Manager",
    desc      = "Gestisce il Livrium e la relativa capacita di stoccaggio per ciascun team",
    author    = "molix",
    date      = "01/07/2026",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true
  }
end

--[[
-- note
API :
GG.AddTeamLivrium(teamID, amount) per depositare la risorsa.
GG.UseTeamLivrium(teamID, amount) per consumarla.
GG.GetTeamLivrium(teamID) per leggerne i dati. 
GG.SetTeamLivrium(teamID, amount) per settarne la quantità.
-- TODO
 fare widget ampliando il redUI. molix
 le variabili STARTING_CAPACITY e STARTING_LIVRIUM devono essere linkate alla lobby cosi da decidere con quanto livrium si può partire!!
]]--


-- Questo gadget deve girare solo lato Synced (la simulazione di gioco)
if not gadgetHandler:IsSyncedCode() then
    return
end

-- =========================================================================
-- CONFIGURAZIONE
-- =========================================================================

local STARTING_CAPACITY = 0   -- Capacita iniziale di ciascun team (senza magazzini costruiti)
local STARTING_LIVRIUM  = 0   -- Quantita di Livrium iniziale con cui parte ogni team

-- Tabella dei magazzini e relativa capacita di stoccaggio aggiuntiva
local storageUnitNames = {
    uflstore = 1000,
    euf_harvester_factory = 2000,
}

-- =========================================================================
-- VARIABILI DI STATO (SYNCED)
-- =========================================================================

local teamLivrium = {}       -- teamLivrium[teamID] = quantita attuale di livrium
local teamMaxLivrium = {}    -- teamMaxLivrium[teamID] = capacita massima di stoccaggio
local activeStorages = {}    -- activeStorages[unitID] = { teamID = teamID, capacity = capacity }
local storageUnitDefs = {}   -- Tabella convertita UnitDefID -> Capacita (popolata in Initialize)

-- =========================================================================
-- FUNZIONI DI UTILITY INTERNE
-- =========================================================================

-- Inizializza i dati per un team se non sono gia presenti
local function InitTeam(teamID)
    if not teamLivrium[teamID] then
        teamMaxLivrium[teamID] = STARTING_CAPACITY
        teamLivrium[teamID] = math.min(STARTING_LIVRIUM, STARTING_CAPACITY)
    end
end

-- Sincronizza i valori correnti in modo che la GUI (i Widget) possa leggerli
local function UpdateRulesParams(teamID)
    InitTeam(teamID)
    Spring.SetTeamRulesParam(teamID, "livrium_current", teamLivrium[teamID], {public = true})
    Spring.SetTeamRulesParam(teamID, "livrium_max", teamMaxLivrium[teamID], {public = true})
end

-- =========================================================================
-- API PUBBLICA (Accessibile da altri Gadget tramite il tavolo globale "GG")
-- =========================================================================

-- Restituisce la quantita attuale e la capacita massima del team
local function GetTeamLivrium(teamID)
    InitTeam(teamID)
    return teamLivrium[teamID], teamMaxLivrium[teamID]
end

-- Aggiunge livrium al team (fino al limite di stoccaggio) e restituisce il nuovo valore
local function AddTeamLivrium(teamID, amount)
    InitTeam(teamID)
    if amount <= 0 then return teamLivrium[teamID] end
    
    local current = teamLivrium[teamID]
    local maxCap = teamMaxLivrium[teamID]
    local newAmount = math.min(maxCap, current + amount)
    
    teamLivrium[teamID] = newAmount
    UpdateRulesParams(teamID)
    return newAmount
end

-- Sottrae livrium dal team. Ritorna 'true' se l'operazione ha successo, altrimenti 'false' (se non ha abbastanza risorsa)
local function UseTeamLivrium(teamID, amount)
    InitTeam(teamID)
    if amount <= 0 then return true end
    
    local current = teamLivrium[teamID]
    if current >= amount then
        teamLivrium[teamID] = current - amount
        UpdateRulesParams(teamID)
        return true
    else
        return false
    end
end

-- Imposta direttamente il valore di livrium (rispettando i limiti min/max)
local function SetTeamLivrium(teamID, amount)
    InitTeam(teamID)
    local maxCap = teamMaxLivrium[teamID]
    teamLivrium[teamID] = math.max(0, math.min(maxCap, amount))
    UpdateRulesParams(teamID)
    return teamLivrium[teamID]
end

-- Registriamo le funzioni in GG per renderle richiamabili dagli altri gadget
GG.GetTeamLivrium = GetTeamLivrium
GG.AddTeamLivrium = AddTeamLivrium
GG.UseTeamLivrium = UseTeamLivrium
GG.SetTeamLivrium = SetTeamLivrium

-- =========================================================================
-- CALLBACKS DEL MOTORE SPRING
-- =========================================================================

function gadget:Initialize()
    -- Converte i nomi testuali delle unita in ID numerici (UnitDefID) per velocizzare i controlli futuri
    for name, capacity in pairs(storageUnitNames) do
        local ud = UnitDefNames[name]
        if ud then
            storageUnitDefs[ud.id] = capacity
        else
            Spring.Echo("Livrium Manager Warning: L'unita '" .. name .. "' non e stata trovata nei file di gioco.")
        end
    end

    -- Inizializza tutti i team presenti a inizio partita
    for _, teamID in ipairs(Spring.GetTeamList()) do
        InitTeam(teamID)
        UpdateRulesParams(teamID)
    end

    -- Gestione delle unita gia presenti sulla mappa al via (es. scenari o posizionamenti pre-partita)
    local allUnits = Spring.GetAllUnits()
    for i = 1, #allUnits do
        local unitID = allUnits[i]
        local unitDefID = Spring.GetUnitDefID(unitID)
        local cap = storageUnitDefs[unitDefID]
        if cap then
            local _, _, _, _, buildProgress = Spring.GetUnitHealth(unitID)
            if buildProgress and buildProgress >= 1.0 then -- Se l'unita e gia completa
                local unitTeam = Spring.GetUnitTeam(unitID)
                activeStorages[unitID] = { teamID = unitTeam, capacity = cap }
                InitTeam(unitTeam)
                teamMaxLivrium[unitTeam] = teamMaxLivrium[unitTeam] + cap
                UpdateRulesParams(unitTeam)
            end
        end
    end
end

-- Chiamato quando un'unita completa la costruzione
function gadget:UnitFinished(unitID, unitDefID, unitTeam)
    local cap = storageUnitDefs[unitDefID]
    if cap then
        activeStorages[unitID] = { teamID = unitTeam, capacity = cap }
        InitTeam(unitTeam)
        teamMaxLivrium[unitTeam] = teamMaxLivrium[unitTeam] + cap
        UpdateRulesParams(unitTeam)
    end
end

-- Chiamato quando un'unita viene distrutta
function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
    local info = activeStorages[unitID]
    if info then
        local tID = info.teamID
        teamMaxLivrium[tID] = math.max(0, teamMaxLivrium[tID] - info.capacity)
        
        -- Se la nuova capacita e inferiore alla risorsa accumulata, l'eccedenza viene persa
        if teamLivrium[tID] > teamMaxLivrium[tID] then
            teamLivrium[tID] = teamMaxLivrium[tID]
        end
        
        activeStorages[unitID] = nil
        UpdateRulesParams(tID)
    end
end

-- Gestisce il passaggio di proprieta di un magazzino (es. cattura o condivisione tra alleati)
function gadget:UnitGiven(unitID, unitDefID, newTeam, oldTeam)
    local info = activeStorages[unitID]
    if info then
        -- Sottrae capacita al vecchio proprietario
        InitTeam(oldTeam)
        teamMaxLivrium[oldTeam] = math.max(0, teamMaxLivrium[oldTeam] - info.capacity)
        if teamLivrium[oldTeam] > teamMaxLivrium[oldTeam] then
            teamLivrium[oldTeam] = teamMaxLivrium[oldTeam]
        end
        UpdateRulesParams(oldTeam)

        -- Aggiunge capacita al nuovo proprietario
        InitTeam(newTeam)
        teamMaxLivrium[newTeam] = teamMaxLivrium[newTeam] + info.capacity
        info.teamID = newTeam
        UpdateRulesParams(newTeam)
    end
end