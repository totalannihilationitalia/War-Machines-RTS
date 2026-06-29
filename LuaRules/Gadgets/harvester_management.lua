function gadget:GetInfo()
  return {
    name      = "EUF Harvester Automation (Spring 100 Compatible)",
    desc      = "Gestisce l'euf_harvester in modo compatibile con Spring 100",
    author    = "molix",
    date      = "2026",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true
  }
end

if (not gadgetHandler:IsSyncedCode()) then
  return
end

-- COSTANTI DEL GIOCO
----------------------------------------------------------------------------------------------------
local EUF_HARVESTER_DEFID         = UnitDefNames["euf_harvester"].id
local EUF_HARVESTER_FACTORY_DEFID = UnitDefNames["euf_harvester_factory"].id
local MAX_HARVEST_CAPACITY        = 3000 
local HARVEST_RATE                = 50   
local HARVEST_TICK_INTERVAL_FRAMES = 30  

local HARVEST_SPOT_DURATION_FRAMES = 30 * 20 
local DEPOSIT_DURATION_FRAMES      = 30 * 5  

local FACTORY_DEPOSIT_RADIUS_SQ   = 500 * 500 
local ARRIVED_AT_SPOT_RADIUS_SQ   = 100 * 100 

-- DATI DEI CAMPI LIVRIUM (STRUTTURA MULTI-CAMPO)
----------------------------------------------------------------------------------------------------
local LIVRIUM_FIELDS = {
  ["Zoty Outpost"] = {
    { x = 1000, z = 1000, radius = 400 }, 
    { x = 500, z = 500, radius = 300 }, 
  },
  ["Canyon_Clash"] = {
    { x = 1200, z = 1500, radius = 600 },
    { x = 3800, z = 3200, radius = 500 },
  },
}

-- STATI DELL'HARVESTER
----------------------------------------------------------------------------------------------------
local STATE_IDLE = 0                 
local STATE_MOVING_TO_HARVEST = 1    
local STATE_HARVESTING = 2           
local STATE_MOVING_TO_FACTORY = 3    
local STATE_DEPOSITING = 4           

-- VARIABILI GLOBALI
----------------------------------------------------------------------------------------------------
local activeHarvesters = {} 
local activeFactories = {}  
local currentMapLivriumFields = nil 

-- FUNZIONI DI UTILITÀ
----------------------------------------------------------------------------------------------------

local function DistSq(x1, z1, x2, z2)
    local dx = x1 - x2
    local dz = z1 - z2
    return dx*dx + dz*dz
end

local function GetRandomPointInCircle(centerX, centerZ, radius)
    local angle = math.random() * 2 * math.pi
    local r = math.sqrt(math.random()) * radius
    return centerX + r * math.cos(angle), centerZ + r * math.sin(angle)
end

local function GetClosestField(harvesterX, harvesterZ)
    if not currentMapLivriumFields or #currentMapLivriumFields == 0 then
        return nil
    end
    
    local closestField = nil
    local minDistanceSq = math.huge 
    
    for _, field in ipairs(currentMapLivriumFields) do
        local distSq = DistSq(harvesterX, harvesterZ, field.x, field.z)
        if distSq < minDistanceSq then
            minDistanceSq = distSq
            closestField = field
        end
    end
    
    return closestField
end

-- LOGICA DEL SINGOLO HARVESTER (Sostituisce l'uso del "goto" con "return")
----------------------------------------------------------------------------------------------------
local function UpdateHarvester(harvesterID, harvesterData, frameNum)
    local harvesterTeam = Spring.GetUnitTeam(harvesterID)
    local harvesterX, harvesterY, harvesterZ = Spring.GetUnitPosition(harvesterID)
    
    -- Se l'unità è stata distrutta ma è ancora in lista, la rimuoviamo e usciamo
    if not harvesterX then
        activeHarvesters[harvesterID] = nil
        return
    end

    local quantitaRaccolta = Spring.GetUnitRulesParam(harvesterID, "quantita_raccolta") or 0
    local statoRaccolta    = Spring.GetUnitRulesParam(harvesterID, "stato_raccolta") or 0

    -- Condizione 3: verifica lo stato di raccolta
    if statoRaccolta ~= 1 then
      harvesterData.state = STATE_IDLE 
      return
    end

    -- Condizione 1: Cerca la fabbrica del team
    local playerFactory = nil
    for fID, fData in pairs(activeFactories) do
      if fData.teamID == harvesterTeam then
        playerFactory = fData
        break 
      end
    end

    if not playerFactory then
        harvesterData.state = STATE_IDLE
        return
    end

    -- Condizione 2: Verifica l'esistenza di campi nella mappa
    if not currentMapLivriumFields or #currentMapLivriumFields == 0 then
        harvesterData.state = STATE_IDLE
        return
    end

    ------------------------------------------------------------------------------------------------
    -- MACCHINA A STATI
    ------------------------------------------------------------------------------------------------
    if quantitaRaccolta < MAX_HARVEST_CAPACITY then -- L'harvester NON è pieno
      
      -- Stato IDLE
      if harvesterData.state == STATE_IDLE then
        local closestField = GetClosestField(harvesterX, harvesterZ)
        
        if closestField then
          local targetX, targetZ = GetRandomPointInCircle(closestField.x, closestField.z, closestField.radius)
          
          Spring.GiveOrderToUnit(harvesterID, CMD.MOVE, {targetX, harvesterY, targetZ}, {})
          harvesterData.targetX = targetX
          harvesterData.targetZ = targetZ
          harvesterData.state = STATE_MOVING_TO_HARVEST
          harvesterData.timer = HARVEST_SPOT_DURATION_FRAMES 
        end

      -- Stato: In Movimento
      elseif harvesterData.state == STATE_MOVING_TO_HARVEST then
        if DistSq(harvesterX, harvesterZ, harvesterData.targetX, harvesterData.targetZ) < ARRIVED_AT_SPOT_RADIUS_SQ then
          harvesterData.state = STATE_HARVESTING
        end

      -- Stato: Raccolta
      elseif harvesterData.state == STATE_HARVESTING then
        harvesterData.timer = harvesterData.timer - 1
        
        if harvesterData.timer <= 0 then
          harvesterData.state = STATE_IDLE 
        end

        if (frameNum % HARVEST_TICK_INTERVAL_FRAMES == 0) then
            local newQuantity = math.min(MAX_HARVEST_CAPACITY, quantitaRaccolta + HARVEST_RATE)
            if newQuantity ~= quantitaRaccolta then
                Spring.SetUnitRulesParam(harvesterID, "quantita_raccolta", newQuantity)
            end
        end
      end

    else -- L'harvester è pieno
      
      -- Stato: In movimento verso la Fabbrica
      if harvesterData.state ~= STATE_MOVING_TO_FACTORY and harvesterData.state ~= STATE_DEPOSITING then
        Spring.GiveOrderToUnit(harvesterID, CMD.MOVE, {playerFactory.x, playerFactory.y, playerFactory.z}, {})
        harvesterData.targetX = playerFactory.x
        harvesterData.targetZ = playerFactory.z
        harvesterData.state = STATE_MOVING_TO_FACTORY
      end

      -- Arrivo alla Fabbrica
      if harvesterData.state == STATE_MOVING_TO_FACTORY then
        if DistSq(harvesterX, harvesterZ, playerFactory.x, playerFactory.z) < FACTORY_DEPOSIT_RADIUS_SQ then
          harvesterData.state = STATE_DEPOSITING
          harvesterData.timer = DEPOSIT_DURATION_FRAMES 
        end
      end

      -- Deposito delle risorse
      if harvesterData.state == STATE_DEPOSITING then
        harvesterData.timer = harvesterData.timer - 1
        if harvesterData.timer <= 0 then
          local currentMetal = Spring.GetTeamResources(harvesterTeam).metal
          Spring.SetTeamResource(harvesterTeam, "metal", currentMetal + quantitaRaccolta)

          Spring.SetUnitRulesParam(harvesterID, "quantita_raccolta", 0)
          harvesterData.state = STATE_IDLE 
        end
      end
    end
end

-- CALL-INs DEL GADGET
----------------------------------------------------------------------------------------------------

function gadget:Initialize()
    local mapName = Spring.GetMapName()
    currentMapLivriumFields = LIVRIUM_FIELDS[mapName]
    
    if not currentMapLivriumFields or #currentMapLivriumFields == 0 then
        Spring.Echo("ATTENZIONE: Nessun campo Livrium definito per la mappa: " .. mapName)
    end

    local allUnits = Spring.GetAllUnits()
    for _, unitID in ipairs(allUnits) do
        local unitDefID = Spring.GetUnitDefID(unitID)
        if unitDefID == EUF_HARVESTER_DEFID or unitDefID == EUF_HARVESTER_FACTORY_DEFID then
            gadget:UnitCreated(unitID, unitDefID, Spring.GetUnitTeam(unitID))
        end
    end
    Spring.Log("EUF Harvester Automation (Spring 100 Compatible) initialized.")
end

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
  if unitDefID == EUF_HARVESTER_DEFID then
    Spring.SetUnitNoSelect(unitID, true)
    
    Spring.SetUnitRulesParam(unitID, "stato_raccolta", 1) 
    Spring.SetUnitRulesParam(unitID, "quantita_raccolta", 0) 

    activeHarvesters[unitID] = {
      state = STATE_IDLE,
      targetX = 0, targetZ = 0, 
      timer = 0,                
    }
  elseif unitDefID == EUF_HARVESTER_FACTORY_DEFID then
    local x, y, z = Spring.GetUnitPosition(unitID)
    activeFactories[unitID] = { x = x, y = y, z = z, teamID = unitTeam }
  end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
  if unitDefID == EUF_HARVESTER_DEFID then
    activeHarvesters[unitID] = nil 
  elseif unitDefID == EUF_HARVESTER_FACTORY_DEFID then
    activeFactories[unitID] = nil 
  end
end

-- Ciclo dei frame principale: chiama la funzione UpdateHarvester per ogni unità
function gadget:GameFrame(frameNum)
  for harvesterID, harvesterData in pairs(activeHarvesters) do
    UpdateHarvester(harvesterID, harvesterData, frameNum)
  end
end