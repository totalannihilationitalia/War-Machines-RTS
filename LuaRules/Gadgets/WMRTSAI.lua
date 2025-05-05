--------------------------------------------------------------------------------
-- War Machines RTS - AI Gadget (v0.3 - Configurazione Tech Level)
-- Nome AI: WMRTSAI
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "WMRTSAI", -- Nome usato per assegnare l'IA ai team!
    desc      = "AI implemented for War Machines RTS.",
    author    = "Molix and Gemini", -- Cambia questo!
    date      = "05/05/2025", -- Cambia questo!
    license   = "Free to use", -- Cambia questo!
    layer     = 80,
    enabled   = true
  }
end

-- Variabili globali del gadget
local gameStarted = false
local teamData = {} -- Stato per ogni team AI
local WMRTSAI_Debug_Mode = 1 -- Iniziamo con debug attivo

--------------------------------------------------------------------------------
-- SYNCED CODE - Logica di gioco principale
--------------------------------------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then

  -- Speedups e locali
  local Spring = Spring
  local Game = Game
  local CMD = Command
  local UnitDefs = UnitDefs
  local UnitDefNames = UnitDefNames

  local LOG_SECTION = "WMRTSAI"

  -- Funzione helper per il logging debug
  local function Log(teamID, message)
    if WMRTSAI_Debug_Mode > 0 then
      local teamPrefix = teamID and ("Team[" .. teamID .. "] ") or (LOG_SECTION .. ": ")
      Spring.Echo(teamPrefix .. message)
    end
  end

  -- === 1. DEFINIZIONE FAZIONI E UNITÀ PER TIER ===
  -- !! IMPORTANTE: Sostituisci con i NOMI ESATTI delle tue unitdef e moveType corretti !!
  local factionUnits = {
      ICU = {
          commander = "icucom",
          T1 = {
              factory =     { name = "armlab", moveType = "BUILDING" },
              constructor = { name = "armck", moveType = "LAND" },
              attackers = { { name = "icupatroller", moveType = "LAND" }, },
              defenses = { { name = "iculighlturr", moveType = "BUILDING" }, }
          },
          T2 = {
              factory =     { name = "armalab", moveType = "BUILDING" },
              constructor = { name = "armack", moveType = "LAND" },
              attackers = { { name = "armfboy", moveType = "LAND" }, },
              defenses = { { name = "armhlt", moveType = "BUILDING" } }
          },
          T3 = {
              factory =     { name = "armgant", moveType = "BUILDING" },
              -- constructor = { name = "icu_con_t3", moveType = "LAND" }, -- Temporaneamente rimosso
              attackers = { { name = "armshock", moveType = "LAND" }, }, -- Esempio, usa nome reale
              defenses = { { name = "armemp", moveType = "BUILDING" } } -- Esempio, usa nome reale
          },
          _unitDefIDs = {}
      },
      NFA = { -- !! COMPILA CON I TUOI DATI NFA !!
          commander = "nfacom",
          T1 = { factory = {name="nfa_factory_t1", moveType="BUILDING"}, constructor = {name="nfa_con_t1", moveType="LAND"}, attackers = {{name="nfa_attacker_t1", moveType="LAND"}}, defenses = {{name="nfa_defense_t1", moveType="BUILDING"}} },
          T2 = { factory = {name="nfa_factory_t2", moveType="BUILDING"}, constructor = {name="nfa_con_t2", moveType="LAND"}, attackers = {{name="nfa_attacker_t2", moveType="LAND"}}, defenses = {{name="nfa_defense_t2", moveType="BUILDING"}} },
          T3 = { factory = {name="nfa_factory_t3", moveType="BUILDING"}, constructor = {name="nfa_con_t3", moveType="LAND"}, attackers = {{name="nfa_attacker_t3", moveType="LAND"}}, defenses = {{name="nfa_defense_t3", moveType="BUILDING"}} },
          _unitDefIDs = {}
      },
       AND = { -- !! COMPILA CON I TUOI DATI AND !!
          commander = "andcom",
          T1 = { factory = {name="and_factory_t1", moveType="BUILDING"}, constructor = {name="and_con_t1", moveType="LAND"}, attackers = {{name="and_attacker_t1", moveType="LAND"}}, defenses = {{name="and_defense_t1", moveType="BUILDING"}} },
          T2 = { factory = {name="and_factory_t2", moveType="BUILDING"}, constructor = {name="and_con_t2", moveType="LAND"}, attackers = {{name="and_attacker_t2", moveType="LAND"}}, defenses = {{name="and_defense_t2", moveType="BUILDING"}} },
          T3 = { factory = {name="and_factory_t3", moveType="BUILDING"}, constructor = {name="and_con_t3", moveType="LAND"}, attackers = {{name="and_attacker_t3", moveType="LAND"}}, defenses = {{name="and_defense_t3", moveType="BUILDING"}} },
          _unitDefIDs = {}
      },
      EUF = { -- !! COMPILA CON I TUOI DATI EUF !!
          commander = "eufcd",
          T1 = { factory = {name="euf_factory_t1", moveType="BUILDING"}, constructor = {name="euf_con_t1", moveType="LAND"}, attackers = {{name="euf_attacker_t1", moveType="LAND"}}, defenses = {{name="euf_defense_t1", moveType="BUILDING"}} },
          T2 = { factory = {name="euf_factory_t2", moveType="BUILDING"}, constructor = {name="euf_con_t2", moveType="LAND"}, attackers = {{name="euf_attacker_t2", moveType="LAND"}}, defenses = {{name="euf_defense_t2", moveType="BUILDING"}} },
          T3 = { factory = {name="euf_factory_t3", moveType="BUILDING"}, constructor = {name="euf_con_t3", moveType="LAND"}, attackers = {{name="euf_attacker_t3", moveType="LAND"}}, defenses = {{name="euf_defense_t3", moveType="BUILDING"}} },
          _unitDefIDs = {}
      }
      -- !! AGGIUNGI QUI UNITÀ COMUNI (ESTRATTORE, CENTRALE) !!
      -- common = {
      --    Base_Extractor = { name = "nome_estrattore", moveType="BUILDING" },
      --    Base_PowerPlant = { name = "nome_centrale", moveType="BUILDING" }
      -- }
      -- _commonUnitDefIDs = {}
  }

  -- Mappa Comandante -> Fazione
  local commanderFactionMap = {
      icucom = "ICU",
      nfacom = "NFA",
      andcom = "AND",
      eufcd  = "EUF"
  }

  -- Funzione ricorsiva per popolare gli UnitDefID e moveType
  local function PopulateUnitDefIDs(dataTable, idTable)
      for key, value in pairs(dataTable) do
          if type(value) == "table" then
              if value.name and value.moveType then -- È una definizione di unità {name, moveType}
                  local unitDef = UnitDefNames[value.name]
                  if unitDef then
                      idTable[key] = { id = unitDef.id, moveType = value.moveType, name = value.name }
                  else
                      Log(nil, "ERROR: Unit definition name '" .. value.name .. "' not found for key '" .. key .. "'!")
                      idTable[key] = nil
                  end
              elseif key == "attackers" or key == "defenses" then -- È una lista di unità
                  idTable[key] = {}
                  for i, unitData in ipairs(value) do
                      if unitData.name and unitData.moveType then
                          local unitDef = UnitDefNames[unitData.name]
                          if unitDef then
                              table.insert(idTable[key], { id = unitDef.id, moveType = unitData.moveType, name = unitData.name })
                          else
                              Log(nil, "ERROR: Unit definition name '" .. unitData.name .. "' not found in list '" .. key .. "'!")
                          end
                      end
                  end
              elseif key ~= "_unitDefIDs" then -- Sotto-tabella (T1, T2, T3)
                  if not idTable[key] then idTable[key] = {} end
                  PopulateUnitDefIDs(value, idTable[key])
              end
          end
      end
  end

  -- === 2. DEFINIZIONE CATEGORIE MAPPE ===
  -- !! IMPORTANTE: Compila con i NOMI MAPPA IN MINUSCOLO !!
  local mapCategories = {
      ["zoty outpost"] = "LAND",
      ["altra_mappa_terra"] = "LAND",
      ["mappa_isole_1"] = "NAVAL_ISLANDS",
      ["arcadia bay"] = "NAVAL_ISLANDS",
      ["spazio_profondo_x"] = "SPACE",
      ["oceano_infinito"] = "NAVAL_PURE",
      -- ... aggiungi tutte le tue mappe ...
  }

  -- Variabile globale per la categoria della mappa corrente
  local currentMapCategory = "LAND" -- Default

  -- === 4. CONFIGURAZIONE AI PER TECH LEVEL ===
  -- !! IMPORTANTE: Definisci ruoli, min/max, priorità per il tuo gioco !!
  local aiConfig = {
      [0] = {
          economyTargets = {
              { role = "Base_Extractor", min = 2, max = 3 },
              { role = "Base_PowerPlant", min = 2, max = 4 },
          },
          factoryTargets = {
              minTotal = 1, maxTotal = 1, targetTier = 1,
              allowedTypes = { "T1_Factory_Land", "T1_Factory_Air", "T1_Factory_Naval" }
          },
          productionList = { }, -- Vuoto a T0
          attackGroup = { min = 5, max = 8, target = "PATROL_NEARBY" }
      },
      [1] = {
          economyTargets = {
              { role = "Base_Extractor", min = 4, max = 6 },
              { role = "Base_PowerPlant", min = 5, max = 8 },
          },
          factoryTargets = {
              minTotal = 2, maxTotal = 3, targetTier = 1,
              allowedTypes = { "T1_Factory_Land", "T1_Factory_Air", "T1_Factory_Naval" }
          },
          productionList = {
              { role = "T1_Constructor", priority = 100, max = 3 },
              { role = "T1_Attacker_Basic", priority = 80, max = 0 }, -- Assumi il primo attaccante T1 definito sia "Basic"
              -- { role = "T1_AntiAir", priority = 60, max = 2 }, -- Esempio, richiede ruolo in factionUnits
          },
          attackGroup = { min = 8, max = 12, target = "ATTACK_ENEMY_EXPANSION" }
      },
      [2] = {
          economyTargets = {
              { role = "Base_Extractor", min = 6, max = 10 },
              { role = "Base_PowerPlant", min = 10, max = 15 },
          },
          factoryTargets = {
              minTotal = 3, maxTotal = 5, targetTier = 2,
              allowedTypes = { "T1_Factory_Land", "T1_Factory_Air", "T1_Factory_Naval", "T2_Factory_Land", "T2_Factory_Air", "T2_Factory_Naval" }
          },
          productionList = {
               { role = "T2_Constructor", priority = 100, max = 2 },
               { role = "T2_Attacker_Heavy", priority = 80, max = 0 }, -- Assumi il primo attaccante T2 sia "Heavy"
               { role = "T1_Attacker_Basic", priority = 60, max = 0 },
          },
          attackGroup = { min = 10, max = 15, target = "ATTACK_ENEMY_BASE" }
      },
      [3] = {
          economyTargets = {
              { role = "Base_Extractor", min = 8, max = 14 },
              { role = "Base_PowerPlant", min = 15, max = 25 },
          },
          factoryTargets = { minTotal=4, maxTotal=7, targetTier=3, allowedTypes={...} }, -- Compila allowedTypes
          productionList = {
             -- { role = "T3_Constructor", priority = 100, max = 1 }, -- Se ci fosse
             { role = "T3_Attacker_Experimental", priority = 90, max = 3 }, -- Assumi il primo T3 sia "Experimental"
             { role = "T2_Attacker_Heavy", priority = 70, max = 0 },
             { role = "T1_Attacker_Basic", priority = 50, max = 0 },
          },
          attackGroup = { min = 12, max = 20, target = "ATTACK_ENEMY_BASE_PRIORITY" }
      }
  }

  -- === Funzioni Helper (Includendo Placeholders) ===

  -- Placeholder: GetUnitDataByRole - !! DEVI IMPLEMENTARE QUESTA BENE !!
  function GetUnitDataByRole(faction, tier, role)
      local factionData = factionUnits[faction]
      if not factionData then return nil end
      local fDefs = factionData._unitDefIDs

      -- Gestisci ruoli comuni (richiede definizione in factionUnits.common)
      -- local cDefs = factionUnits._commonUnitDefIDs
      -- if cDefs and cDefs[role] then return cDefs[role] end

      -- Gestisci ruoli specifici T0 (solo comandante per ora)
      if tier == 0 then return nil end -- Il comandante è gestito a parte

      -- Gestisci ruoli T1/T2/T3
      local tierKey = "T" .. tier
      local tDefs = fDefs[tierKey]
      if not tDefs then return nil end

      -- Mappatura Semplice (DA MIGLIORARE CON CAMPO 'role' in factionUnits o nomi più descrittivi)
      if role == tierKey .. "_Constructor" then return tDefs.constructor
      elseif role == tierKey .. "_Factory_Land" then return tDefs.factory -- Assumendo sia Land
      elseif role == tierKey .. "_Attacker_Basic" and tDefs.attackers and #tDefs.attackers > 0 then return tDefs.attackers[1]
      elseif role == tierKey .. "_Attacker_Heavy" and tDefs.attackers and #tDefs.attackers > 0 then return tDefs.attackers[1] -- Esempio, uguale a basic
      elseif role == tierKey .. "_Attacker_Experimental" and tDefs.attackers and #tDefs.attackers > 0 then return tDefs.attackers[1] -- Esempio, uguale a basic
      -- ... aggiungi altri ruoli come "T1_AntiAir", "T2_Defense_Heavy" ecc. ...
      -- Sarà molto più facile se aggiungi un campo `role = "AntiAir"` etc. a ciascuna unità in factionUnits
      end

      Log(faction, "Warning: Role '"..role.."' not found for T"..tier)
      return nil
  end

  -- Trova posizione Metallo - Placeholder
  function FindBestMetalSpotForTeam(teamData, builderID)
      Log(teamData.teamID, "Placeholder: FindBestMetalSpot called for builder "..builderID)
      -- TODO: Implementa ricerca spot metallo più vicino, libero e costruibile
      local bx, _, bz = Spring.GetUnitPosition(builderID)
      if not bx then return nil end
      local spots = Spring.GetMapMetalSpots()
      local bestSpot = nil
      local minDist = math.huge
      if spots then
          for _, spot in ipairs(spots) do
               -- Controlla se libero (nessun estrattore vicino)
               local unitsNear = Spring.GetUnitsInRectangle(spot.x-5, spot.z-5, spot.x+5, spot.z+5) -- Piccolo raggio
               local occupied = false
               if unitsNear then
                   for _, nearID in ipairs(unitsNear) do
                       -- Assumi che estrattori abbiano 'extractsMetal' > 0
                       local nearDef = UnitDefs[Spring.GetUnitDefID(nearID)]
                       if nearDef and nearDef.extractsMetal and nearDef.extractsMetal > 0 then
                           occupied = true; break
                       end
                   end
               end
               if not occupied then
                  local dist = Spring.GetUnitSeparation(builderID, spot.x, nil, spot.z) -- Distanza 2D
                  if dist and dist < minDist then
                       -- TODO: Controlla CanBuildAt/TestBuildOrder qui per l'estrattore
                       minDist = dist
                       bestSpot = {x=spot.x, y=spot.y, z=spot.z}
                  end
               end
          end
      end
      if bestSpot then Log(teamData.teamID,"Found potential metal spot") end
      return bestSpot -- Restituisce {x,y,z} o nil
  end

  -- Trova posizione Energia - Placeholder
  function FindGoodEnergySpotForTeam(teamData, builderID)
      Log(teamData.teamID, "Placeholder: FindGoodEnergySpot called for builder "..builderID)
      -- TODO: Implementa ricerca posizione valida vicino al builder o alla base
      local bx, _, bz = Spring.GetUnitPosition(builderID)
      if not bx then return nil end
      -- Cerca a caso vicino al builder
      for i=1, 10 do
          local angle = math.random() * 2 * math.pi
          local dist = 80 + math.random(80)
          local testX, testZ = bx + math.cos(angle)*dist, bz + math.sin(angle)*dist
          local testY = Spring.GetGroundHeight(testX, testZ)
          -- TODO: Usa TestBuildOrder/CanBuildAt per la centrale
          if testY then -- Se il terreno è valido
              -- Restituisci subito per semplicità, la logica reale sarebbe più complessa
              Log(teamData.teamID,"Found potential energy spot")
              return {x=testX, y=testY, z=testZ}
          end
      end
      return nil
  end

  -- Trova posizione Fabbrica - Placeholder
  function FindGoodFactoryPosForTeam(teamData, builderID)
      Log(teamData.teamID, "Placeholder: FindGoodFactoryPos called for builder "..builderID)
      -- TODO: Implementa ricerca posizione valida, spaziosa, vicino al builder/base
      local bx, _, bz = Spring.GetUnitPosition(builderID)
      if not bx then return nil end
      for i=1, 10 do
          local angle = math.random() * 2 * math.pi
          local dist = 120 + math.random(100)
          local testX, testZ = bx + math.cos(angle)*dist, bz + math.sin(angle)*dist
          local testY = Spring.GetGroundHeight(testX, testZ)
           -- TODO: Usa TestBuildOrder/CanBuildAt per la fabbrica specifica
          if testY then
              Log(teamData.teamID,"Found potential factory spot")
              return {x=testX, y=testY, z=testZ}
          end
      end
      return nil
  end

  -- Funzione per controllare un team e trovare comandante/fazione
  local function CheckTeamCommander(teamID)
      if not teamData[teamID] or teamData[teamID].faction then return end
      local teamUnits = Spring.GetTeamUnits(teamID)
      if not teamUnits then return end
      for _, unitID in ipairs(teamUnits) do
          local unitDefID = Spring.GetUnitDefID(unitID)
          if unitDefID then
              local unitDef = UnitDefs[unitDefID]
              if unitDef then
                  local commanderNameLower = unitDef.name:lower()
                  local faction = commanderFactionMap[commanderNameLower]
                  if faction then
                      local commanderName = unitDef.name:upper()
                      Log(teamID, "Found Commander: " .. commanderName .. " - Faction set to: " .. faction)
                      teamData[teamID].faction = faction
                      teamData[teamID].commanderInfo = { name = commanderName, id = unitID, defID = unitDefID }
                      local comMoveType = UnitDefs[unitDefID].movedata and UnitDefs[unitDefID].movedata.moveType or "UNKNOWN"
                      teamData[teamID].constructors[unitID] = { tier = 0, state = "idle", task = nil, moveType = comMoveType }
                      return
                  end
              end
          end
      end
      if not teamData[teamID].faction and Game.frame > 90 then
          Log(teamID, "WARNING: Could not find starting commander/faction unit after 3 seconds!")
          teamData[teamID].faction = "UNKNOWN"
      end
  end

  -- === 3. LOGICA AVANZAMENTO TECNOLOGICO ===
  local function ManageTechLevel(teamID, frame)
      local data = teamData[teamID]
      if not data or not data.faction or data.faction == "UNKNOWN" or data.techLevel == nil then return end
      local currentLevel = data.techLevel
      local res = data.resourceInfo
      local thresholds = {
          [1] = { metal = 500, energy = 800, prereq = function() return true end },
          [2] = { metal = 2000, energy = 4000, prereq = function() return data:HasFactoryOfTier(1) end },
          [3] = { metal = 8000, energy = 15000, prereq = function() return data:HasFactoryOfTier(2) end }
      }
      local nextLevel = currentLevel + 1
      if thresholds[nextLevel] and currentLevel < 3 then
          local target = thresholds[nextLevel]
          local prereqMet, _ = pcall(target.prereq) -- Usa pcall per sicurezza
          if prereqMet and res.metal >= target.metal and res.energy >= target.energy then
              data.techLevel = nextLevel
              Log(teamID, "Advanced to Tech Level " .. nextLevel .. "!")
          end
      end
  end

  -- Helper per fabbriche
  function TeamHasFactoryOfTier(teamData, tier)
      local faction = teamData.faction
      if not faction or faction == "UNKNOWN" then return false end
      local tierKey = "T" .. tier
      local targetFactoryData = factionUnits[faction]._unitDefIDs[tierKey] and factionUnits[faction]._unitDefIDs[tierKey].factory
      if not targetFactoryData then return false end
      local factories = Spring.GetTeamUnitsByDefs(teamData.teamID, targetFactoryData.id)
      return (factories and #factories > 0)
  end

  -- Funzioni di Gestione Principali
  local function UpdateResourceInfo(teamID, frame)
      local data = teamData[teamID]
      if not data then return end
      if frame - (data.resourceInfo.lastUpdateFrame or -100) > 30 then
          data.resourceInfo.metal, data.resourceInfo.energy = Spring.GetTeamResources(teamID, "metal", "energy")
          local metIncomeOk, metIncome = pcall(Spring.GetTeamResourceIncome, teamID, "metal")
          local metUsageOk, metUsage = pcall(Spring.GetTeamResourceUsage, teamID, "metal")
          local engIncomeOk, engIncome = pcall(Spring.GetTeamResourceIncome, teamID, "energy")
          local engUsageOk, engUsage = pcall(Spring.GetTeamResourceUsage, teamID, "energy")
          data.resourceInfo.metalIncome = (metIncomeOk and metIncome) or 0
          data.resourceInfo.metalUsage = (metUsageOk and metUsage) or 0
          data.resourceInfo.energyIncome = (engIncomeOk and engIncome) or 0
          data.resourceInfo.energyUsage = (engUsageOk and engUsage) or 0
          data.resourceInfo.lastUpdateFrame = frame
      end
  end

  local function ManageEconomy(teamID, frame)
      local data = teamData[teamID]
      if not data or data.techLevel == nil then return end
      local config = aiConfig[data.techLevel]
      if not config or not config.economyTargets then return end
      -- Log(teamID, "ManageEconomy - Tech: " .. data.techLevel)
      for _, target in ipairs(config.economyTargets) do
          -- !! USA NOMI REALI PER GLI ESTRATTORI/CENTRALI IN factionUnits o common !!
          local extractorRole = "Base_Extractor" -- Esempio
          local powerRole = "Base_PowerPlant"     -- Esempio
          local unitData = nil
          if target.role == extractorRole then unitData = GetUnitDataByRole(data.faction, 0, extractorRole) -- Assumi T0 possa costruire
          elseif target.role == powerRole then unitData = GetUnitDataByRole(data.faction, 0, powerRole) -- Assumi T0 possa costruire
          end

          if unitData then
              local unitDefID = unitData.id
              local currentCount = #Spring.GetTeamUnitsByDefs(teamID, unitDefID)
              if currentCount < target.min then
                  if data:CanAfford(unitDefID) then
                      local builderID = data:FindIdleConstructor(0) -- T0 per eco base
                      if builderID then
                          local buildPos = nil
                          if target.role == extractorRole then buildPos = data:FindBestMetalSpot(builderID)
                          elseif target.role == powerRole then buildPos = data:FindGoodEnergySpot(builderID)
                          end
                          if buildPos then
                              Log(teamID, "Ordering builder "..builderID.." to build "..target.role.." (DefID "..unitDefID..") at " .. string.format("%.0f,%.0f", buildPos.x, buildPos.z))
                              Spring.GiveOrderToUnit(builderID, CMD.BUILD_UNIT, { buildPos.x, buildPos.y, buildPos.z, unitDefID }, {})
                              data.constructors[builderID].state = "busy"
                              return -- Fai una cosa alla volta
                          end
                      end
                  end
              end
          else
              -- Log(teamID, "Warning: Could not find unit data for economy role: " .. target.role)
          end
      end
  end

  local function ManageProduction(teamID, frame)
      local data = teamData[teamID]
      if not data or not data.faction or data.faction == "UNKNOWN" or data.techLevel == nil then return end
      local config = aiConfig[data.techLevel]
      if not config then return end
      -- Log(teamID, "ManageProduction - Tech: " .. data.techLevel)

      local faction = data.faction
      local techLevel = data.techLevel
      local allowedMoveTypes = {}
      if currentMapCategory == "LAND" then allowedMoveTypes = { LAND = true, AIR = true, VEHICLE = true, BUILDING = true }
      elseif currentMapCategory == "NAVAL_ISLANDS" then allowedMoveTypes = { NAVAL = true, AIR = true, BUILDING = true }
      elseif currentMapCategory == "SPACE" then allowedMoveTypes = { AIR = true, SPACE = true, BUILDING = true }
      elseif currentMapCategory == "NAVAL_PURE" then allowedMoveTypes = { NAVAL = true, BUILDING = true }
      end

      -- 1. Costruire Fabbriche?
      if config.factoryTargets then
          local totalFactories = 0
          for tier=1, data.techLevel + 1 do
              local facData = GetUnitDataByRole(faction, tier, "T"..tier.."_Factory_Land") or -- Cerca Land
                            GetUnitDataByRole(faction, tier, "T"..tier.."_Factory_Air") or   -- Cerca Air
                            GetUnitDataByRole(faction, tier, "T"..tier.."_Factory_Naval")    -- Cerca Naval
              if facData then totalFactories = totalFactories + #Spring.GetTeamUnitsByDefs(teamID, facData.id) end
          end

          if totalFactories < config.factoryTargets.minTotal then
              local targetTier = config.factoryTargets.targetTier
              local allowedFactoryRoles = {}
              for _, role in ipairs(config.factoryTargets.allowedTypes or {}) do
                  if (role:find("Land") and allowedMoveTypes.LAND) or
                     (role:find("Air") and allowedMoveTypes.AIR) or
                     (role:find("Naval") and allowedMoveTypes.NAVAL) then
                     table.insert(allowedFactoryRoles, role)
                  end
              end

              if #allowedFactoryRoles > 0 then
                  local factoryRoleToBuild = allowedFactoryRoles[math.random(#allowedFactoryRoles)]
                  local factoryData = GetUnitDataByRole(faction, targetTier, factoryRoleToBuild)
                  if factoryData and data:CanAfford(factoryData.id) then
                       local builderID = data:FindIdleConstructor(targetTier - 1)
                       if builderID then
                           local buildPos = data:FindGoodFactoryPos(builderID)
                           if buildPos then
                               Log(teamID, "Ordering T"..(targetTier-1).." builder " .. builderID .. " to build "..factoryRoleToBuild.." (DefID "..factoryData.id..") at " .. string.format("%.0f,%.0f", buildPos.x, buildPos.z))
                               Spring.GiveOrderToUnit(builderID, CMD.BUILD_UNIT, { buildPos.x, buildPos.y, buildPos.z, factoryData.id }, {})
                               data.constructors[builderID].state = "busy"
                               return
                           end
                       end
                  end
              end
          end
      end -- Fine costruzione fabbriche

      -- 2. Produrre Unità dalle Fabbriche Esistenti
      if config.productionList then
          table.sort(config.productionList, function(a,b) return a.priority > b.priority end)
          for factoryTier = 1, data.techLevel do
              local factoryData = GetUnitDataByRole(faction, factoryTier, "T"..factoryTier.."_Factory_Land") or
                                GetUnitDataByRole(faction, factoryTier, "T"..factoryTier.."_Factory_Air") or
                                GetUnitDataByRole(faction, factoryTier, "T"..factoryTier.."_Factory_Naval")
              if factoryData then
                  local factories = Spring.GetTeamUnitsByDefs(teamID, factoryData.id)
                  if factories then
                      for _, factoryID in ipairs(factories) do
                          local queue = Spring.GetFactoryCommands(factoryID)
                          if not queue or #queue < 3 then
                              for _, prodItem in ipairs(config.productionList) do
                                  -- Prova a produrre solo unità del tier della fabbrica o inferiore
                                  local unitTier = tonumber(prodItem.role:match("T(%d+)")) or 0
                                  if unitTier <= factoryTier then
                                      local unitData = GetUnitDataByRole(faction, unitTier, prodItem.role)
                                      if unitData and allowedMoveTypes[unitData.moveType] then
                                          local unitDefID = unitData.id
                                          local currentCount = #Spring.GetTeamUnitsByDefs(teamID, unitDefID)
                                          local maxCount = prodItem.max
                                          local buildThis = false
                                          if prodItem.role:find("Constructor") then
                                               if data:NeedsConstructor(unitTier) then buildThis = true end
                                          elseif maxCount == 0 or currentCount < maxCount then
                                               buildThis = true
                                          end

                                          if buildThis and data:CanAfford(unitDefID) then
                                              Log(teamID, "Ordering T"..factoryTier.." factory " .. factoryID .. " to build "..prodItem.role.." (DefID "..unitDefID..")")
                                              Spring.GiveOrderToUnit(factoryID, -unitDefID, {}, {})
                                              goto next_factory_prod -- Passa alla prossima fabbrica
                                          end
                                      end
                                  end
                              end
                              ::next_factory_prod::
                          end
                      end
                  end
              end
          end -- Fine ciclo tier fabbriche
      end -- Fine produzione unità
  end -- Fine ManageProduction


  local function ManageMilitary(teamID, frame)
      local data = teamData[teamID]
      if not data or data.techLevel == nil then return end
      local config = aiConfig[data.techLevel]
      if not config or not config.attackGroup then return end
      -- Log(teamID, "ManageMilitary - Tech: " .. data.techLevel)

      local allowedMoveTypes = {}
      if currentMapCategory == "LAND" then allowedMoveTypes = { LAND = true, AIR = true, VEHICLE = true }
      elseif currentMapCategory == "NAVAL_ISLANDS" then allowedMoveTypes = { NAVAL = true, AIR = true }
      elseif currentMapCategory == "SPACE" then allowedMoveTypes = { AIR = true, SPACE = true }
      elseif currentMapCategory == "NAVAL_PURE" then allowedMoveTypes = { NAVAL = true }
      end

      local idleCombatUnits = {}
      local idleCount = 0
      for unitID, unitData in pairs(data.combatUnits) do
          if unitData.state == "idle" and allowedMoveTypes[unitData.moveType] then
              local cmds = Spring.GetUnitCommands(unitID)
              if not cmds or #cmds == 0 then
                  table.insert(idleCombatUnits, unitID)
                  idleCount = idleCount + 1
              end
          end
      end

      if idleCount >= config.attackGroup.min then
          local groupSize = math.min(idleCount, config.attackGroup.max)
          local attackGroup = {}
          for i = 1, groupSize do
              local unitID = table.remove(idleCombatUnits, 1) -- Prendi e rimuovi dalla lista idle
              table.insert(attackGroup, unitID)
              data.combatUnits[unitID].state = "attacking"
          end

          local targetPos = nil
          local targetType = config.attackGroup.target or "ATTACK_ENEMY_BASE"
          local enemyTeamID = nil
          local enemyTeams = Spring.GetEnemyTeamIDs(teamID)
          if enemyTeams and #enemyTeams > 0 then enemyTeamID = enemyTeams[math.random(#enemyTeams)] end

          if targetType == "PATROL_NEARBY" then
              local angle = math.random() * 2 * math.pi
              local dist = 1000 + math.random(500)
              targetPos = { data.startPos.x + math.cos(angle)*dist, data.startPos.y, data.startPos.z + math.sin(angle)*dist }
              Log(teamID, "Sending group of " .. groupSize .. " to PATROL NEARBY")
              Spring.GiveOrderToUnitArray(attackGroup, CMD.PATROL, targetPos, {"SHIFT"})
          elseif enemyTeamID then -- Assumi ATTACK per gli altri tipi
              local tx, ty, tz = Spring.GetTeamStartPosition(enemyTeamID)
              if tx then
                  targetPos = { tx, ty, tz }
                  Log(teamID, "Sending group of " .. groupSize .. " to ATTACK ENEMY (" .. enemyTeamID .. ") BASE")
                  Spring.GiveOrderToUnitArray(attackGroup, CMD.ATTACK, targetPos, {"SHIFT"})
              end
          end

          if not targetPos then
              Log(teamID, "Could not find target for attack group, setting back to idle.")
              for _, unitID in ipairs(attackGroup) do if data.combatUnits[unitID] then data.combatUnits[unitID].state = "idle" end end
          end
      end
  end

  -- Helper: Trova costruttore idle di tier minimo
  function FindIdleConstructorForTeam(teamData, minTier)
      minTier = minTier or 0
      local foundBuilderID = nil
      for builderID, builderData in pairs(teamData.constructors) do
          if builderData.tier >= minTier then
              local commands = Spring.GetUnitCommands(builderID)
              if (not commands or #commands == 0) then
                  foundBuilderID = builderID
                  break
              end
          end
      end
      return foundBuilderID
  end

  -- Helper: Controlla se servono costruttori T[N]
  function TeamNeedsConstructor(teamData, tier)
      local count = 0
      for _, builderData in pairs(teamData.constructors) do
          if builderData.tier == tier then count = count + 1 end
      end
      local limit = (tier == 0) and 1 or 2 -- Max 1 com T0, max 2 per T1/T2/T3
      return count < limit
  end

  -- Helper: Controlla se l'AI può permettersi un'unità
  function CanAffordUnit(teamData, unitDefID)
      if not unitDefID then return false end
      local costMetal = UnitDefs[unitDefID] and UnitDefs[unitDefID].metalCost or 0
      local costEnergy = UnitDefs[unitDefID] and UnitDefs[unitDefID].energyCost or 0
      -- Aggiungi un piccolo buffer per evitare di scendere a 0
      local buffer = 50
      return (teamData.resourceInfo.metal >= costMetal + buffer and teamData.resourceInfo.energy >= costEnergy + buffer)
  end

  --------------------------------------------------------------------------------
  -- GADGET EVENT HANDLERS (SYNCED)
  --------------------------------------------------------------------------------

  function gadget:Initialize()
      Log(nil, gadget:GetInfo().name .. " Initializing...")
      for faction, data in pairs(factionUnits) do
          if faction ~= "common" and faction ~= "_commonUnitDefIDs" then
              Log(nil, "Populating UnitDefIDs for faction: " .. faction)
              -- Reset _unitDefIDs prima di popolare
              factionUnits[faction]._unitDefIDs = {}
              PopulateUnitDefIDs(data, factionUnits[faction]._unitDefIDs)
          end
      end
      -- if factionUnits.common then
      --    factionUnits._commonUnitDefIDs = {}
      --    PopulateUnitDefIDs(factionUnits.common, factionUnits._commonUnitDefIDs)
      -- end
      Log(nil, "UnitDefID population complete.")
  end

  function gadget:GameStart()
      Log(nil, gadget:GetInfo().name .. " Game Starting...")
      local mapNameRaw = Game.mapName
      local mapNameLower = mapNameRaw:lower()
      Log(nil, "Detected Map: '" .. mapNameRaw .. "' (Checking as: '" .. mapNameLower .. "')")
      if mapCategories[mapNameLower] then
          currentMapCategory = mapCategories[mapNameLower]
          Log(nil, "Map Category Assigned: '" .. currentMapCategory .. "' (Found in mapCategories table)")
      else
          Log(nil, "Map Category Assigned: '" .. currentMapCategory .. "' (Map not found in list, using default)")
      end
      local teams = Spring.GetTeamList()
      for _, teamID in ipairs(teams) do
          if Spring.GetTeamLuaAI(teamID) == gadget:GetInfo().name then
              Log(teamID, "Team detected for AI control.")
              local startX, startY, startZ = Spring.GetTeamStartPosition(teamID)
              teamData[teamID] = {
                  teamID = teamID, initialized = true, faction = nil, techLevel = 0,
                  commanderInfo = nil, startPos = { x = startX, y = startY, z = startZ },
                  constructors = {}, factories = {}, combatUnits = {}, buildings = {}, missions = {},
                  resourceInfo = { lastUpdateFrame = -100 },
                  HasFactoryOfTier = TeamHasFactoryOfTier,
                  FindIdleConstructor = FindIdleConstructorForTeam,
                  NeedsConstructor = TeamNeedsConstructor,
                  FindGoodFactoryPos = FindGoodFactoryPosForTeam,
                  CanAfford = CanAffordUnit,
                  FindBestMetalSpot = FindBestMetalSpotForTeam,
                  FindGoodEnergySpot = FindGoodEnergySpotForTeam,
                  NeedsBasicEconomy = function(self) -- Controlla se ha pochi estrattori/centrali base
                        local mexCount = 0
                        local powCount = 0
                        local mexData = GetUnitDataByRole(self.faction, 0, "Base_Extractor")
                        local powData = GetUnitDataByRole(self.faction, 0, "Base_PowerPlant")
                        if mexData then mexCount = #Spring.GetTeamUnitsByDefs(self.teamID, mexData.id) end
                        if powData then powCount = #Spring.GetTeamUnitsByDefs(self.teamID, powData.id) end
                        local cfg = aiConfig[self.techLevel]
                        local needsMex = (cfg and cfg.economyTargets[1] and mexCount < cfg.economyTargets[1].min) -- Assumi il primo sia mex
                        local needsPow = (cfg and cfg.economyTargets[2] and powCount < cfg.economyTargets[2].min) -- Assumi il secondo sia pow
                        return needsMex or needsPow
                  end,
              }
              CheckTeamCommander(teamID)
          end
      end
      gameStarted = true
      Log(nil, gadget:GetInfo().name .. " Game Started. Final Map Category: " .. currentMapCategory)
  end

  function gadget:GameFrame(frame)
    if not gameStarted then return end
    for teamID, data in pairs(teamData) do
      if data.initialized and data.faction and data.faction ~= "UNKNOWN" then
        UpdateResourceInfo(teamID, frame)
        if frame % 45 == (teamID * 3) % 45 then ManageTechLevel(teamID, frame) end
        if frame % 61 == (teamID * 5) % 61 then ManageEconomy(teamID, frame) end
        if frame % 91 == (teamID * 7) % 91 then ManageProduction(teamID, frame) end
        if frame % 121 == (teamID * 9) % 121 then ManageMilitary(teamID, frame) end
      elseif data.initialized and not data.faction then
          if frame % 30 == 5 then CheckTeamCommander(teamID) end
      end
    end
  end

  function gadget:UnitFinished(unitID, unitDefID, unitTeam)
    if teamData[unitTeam] then
      local data = teamData[unitTeam]
      if not data.faction then return end
      local unitDef = UnitDefs[unitDefID]
      local faction = data.faction
      local foundType = nil; local unitData = nil;
      for tier = 1, 3 do
          local tierDefs = factionUnits[faction]._unitDefIDs["T"..tier]
          if tierDefs then
              if tierDefs.constructor and unitDefID == tierDefs.constructor.id then unitData=tierDefs.constructor;data.constructors[unitID] = { tier = tier, state = "idle", task = nil, moveType=unitData.moveType }; foundType = "Con T"..tier; break end
              if tierDefs.factory and unitDefID == tierDefs.factory.id then unitData=tierDefs.factory;data.factories[unitID] = { tier = tier, producing = nil, moveType=unitData.moveType }; foundType = "Fac T"..tier; break end
              if tierDefs.attackers then for _, d in ipairs(tierDefs.attackers) do if unitDefID == d.id then unitData=d; data.combatUnits[unitID] = { tier = tier, type = "attacker", group = nil, state = "idle", moveType=unitData.moveType }; foundType = "Atk T"..tier; break end end; if foundType then break end end
              if tierDefs.defenses then for _, d in ipairs(tierDefs.defenses) do if unitDefID == d.id then unitData=d; data.buildings[unitID] = { tier = tier, type = "defense", moveType=unitData.moveType }; foundType = "Def T"..tier; break end end; if foundType then break end end
          end
      end
      -- Controlla unità comuni
      -- local cDefs = factionUnits._commonUnitDefIDs
      -- if not foundType and cDefs then
      --    if cDefs.Base_Extractor and unitDefID == cDefs.Base_Extractor.id then unitData=cDefs.Base_Extractor; data.buildings[unitID]={tier=0, type="extractor", moveType=unitData.moveType}; foundType="Base Extractor"; end
      --    if not foundType and cDefs.Base_PowerPlant and unitDefID == cDefs.Base_PowerPlant.id then unitData=cDefs.Base_PowerPlant; data.buildings[unitID]={tier=0, type="power", moveType=unitData.moveType}; foundType="Base PowerPlant"; end
      -- end

      if foundType then Log(unitTeam, "UnitFinished: " .. unitID .. " (" .. (unitDef and unitDef.humanName or "N/A") .. ") - Categorized as: " .. foundType .." (MoveType: ".. (unitData and unitData.moveType or 'N/A') .. ")")
      else Log(unitTeam, "UnitFinished: " .. unitID .. " (" .. (unitDef and unitDef.humanName or "N/A") .. ") - Not categorized.") end
    end
  end

  function gadget:UnitDestroyed(unitID, unitDefID, unitTeam, ...)
      if teamData[unitTeam] then
          local data = teamData[unitTeam]
          if data.constructors[unitID] then data.constructors[unitID] = nil
          elseif data.factories[unitID] then data.factories[unitID] = nil
          elseif data.combatUnits[unitID] then data.combatUnits[unitID] = nil
          elseif data.buildings[unitID] then data.buildings[unitID] = nil
          end
      end
  end

  function gadget:Shutdown()
    Log(nil, gadget:GetInfo().name .. " Shutting down.")
  end

end -- SYNCED CODE END


-- UNSYNCED CODE (Debug Visivo e Comando Console)
if (not gadgetHandler:IsSyncedCode()) then
    local function DrawFactionAndTech(teamID, data)
      local x, y, z = Spring.GetTeamStartPosition(teamID)
      if x and data.faction then
         gl.Text(data.faction .. " (T" .. data.techLevel .. ")", x, y+60, 15, "co")
      end
    end

    function gadget:DrawWorld()
      if SYNCED and SYNCED.WMRTSAI_Debug_Mode and SYNCED.WMRTSAI_Debug_Mode > 0 and type(SYNCED.teamData) == "table" then
        for teamID, data in pairs(SYNCED.teamData) do
           if data and data.initialized then
              DrawFactionAndTech(teamID, data)
              -- Aggiungi altro disegno qui se necessario
           end
        end
        gl.Color(1,1,1,1)
      end
    end

    function gadget:DrawScreen(vsx, vsy)
       if SYNCED and SYNCED.WMRTSAI_Debug_Mode and SYNCED.WMRTSAI_Debug_Mode > 0 and SYNCED.currentMapCategory then
          gl.Text("Map Category: " .. SYNCED.currentMapCategory, vsx * 0.5, vsy - 30, 15, "co")
       end
    end

    local function ToggleDebug(cmd, line, words, player)
      local currentMode = 0
      if SYNCED and SYNCED.WMRTSAI_Debug_Mode then currentMode = SYNCED.WMRTSAI_Debug_Mode end
      local newMode = (currentMode == 0) and 1 or 0
      Spring.SendLuaRulesMsg("WMRTSAI_SetDebug " .. newMode)
      Spring.Echo("WMRTSAI Debug Mode set to: " .. newMode .. " (Command sent)")
      return true
    end

    function gadget:Initialize()
       gadgetHandler:AddChatAction("wmrtsai_debug", ToggleDebug, "Toggle WMRTSAI debug messages/drawing")
    end

    function gadget:RecvLuaMsg(msg, playerID)
      if msg:find("^WMRTSAI_SetDebug") then
          local _, levelStr = msg:match("([^ ]+)%s+(.*)")
          local level = tonumber(levelStr)
          if level ~= nil then
              if SYNCED then SYNCED.WMRTSAI_Debug_Mode = level end
          end
          return true
      end
      return false
    end
end