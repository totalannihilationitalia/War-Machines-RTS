--------------------------------------------------------------------------------
-- War Machines RTS - AI Gadget (WMRTSAI - Sviluppo da Zero)
-- Fase 2: Comandante e Tech 0 (Costruzione base, passaggio a Tech 1)
-- AGGIORNATO CON LOG DI DEBUG DETTAGLIATI
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "WMRTS AI_LAND",
    desc      = "WMRTS AI_LAND - AI dedicata per War Machines RTS. Sviluppo da Zero.",
    author    = "TuoNome & MolixAIHelper",
    date      = "Giorno/Mese/Anno",
    license   = "Free to use",
    layer     = 90,
    enabled   = true
  }
end

-- Variabili globali del gadget
local teamData = {}
local WMRTSAI_Debug_Mode = 1 -- 0 = No Debug, 1 = Debug Attivo

--------------------------------------------------------------------------------
-- SYNCED CODE - Logica di gioco principale
--------------------------------------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then

  -- Speedups e locali
  local Spring        = Spring
  local Game          = Game
  local UnitDefs      = UnitDefs
  local UnitDefNames  = UnitDefNames

  local LOG_SECTION = "WMRTSAI"

  -- Funzione helper per il logging debug
  local function Log(teamID, message)
    if WMRTSAI_Debug_Mode > 0 then
      local teamPrefix = teamID and ("WMRTSAI Team[" .. teamID .. "] ") or (LOG_SECTION .. ": ")
      Spring.Echo(teamPrefix .. message)
    end
  end

  -- === 1. DEFINIZIONE FAZIONI E UNITÀ ===
  local factionUnits = {
      ICU = {
          commander = "icucom",
          _unitDefIDs = {},
          T1 = {
              extractor = {
                  name = "icumetex", moveType="BUILDING", role="T1_Extractor",
                  footX = 3, footZ = 3, interceptradius = 250,
                  metalCost = 75, energyCost = 0, buildTime = 25
              },
              powerPlant = {
                  {
                      name = "armsolar", moveType="BUILDING", role="T1_Power",
                      footX = 5, footZ = 5, interceptradius = 250,
                      metalCost = 90, energyCost = 0, buildTime = 20, providesEnergy = 20
                  },
                  {
                      name = "icuwind", moveType="BUILDING", role="T1_Power",
                      footX = 5, footZ = 5, interceptradius = 250,
                      metalCost = 120, energyCost = 0, buildTime = 30, providesEnergy = 30
                  },
              },
              factory = {
                  {
                      name = "armlab",   moveType = "BUILDING", role="T1_Factory_Kbot",
                      footX = 9, footZ = 9, interceptradius = 450,
                      metalCost = 450, energyCost = 450, buildTime = 150
                  },
                  {
                      name = "armvp",   moveType = "BUILDING", role="T1_Factory_Vehicle",
                      footX = 9, footZ = 9, interceptradius = 450,
                      metalCost = 500, energyCost = 500, buildTime = 160
                  },
                  {
                      name = "armap",   moveType = "BUILDING", role="T1_Factory_Air",
                      footX = 9, footZ = 9, interceptradius = 450,
                      metalCost = 550, energyCost = 550, buildTime = 180
                  },
              },
              estorage = {
                  name = "icuestor", moveType = "BUILDING", role="T1_Estorage",
                  footX = 3, footZ = 3, interceptradius = 450,
                  metalCost = 80, energyCost = 80, buildTime = 30, storesEnergy = 500
              },
              mstorage = {
                  name = "armmstor", moveType = "BUILDING", role="T1_Mstorage",
                  footX = 4, footZ = 4, interceptradius = 450,
                  metalCost = 80, energyCost = 80, buildTime = 30, storesMetal = 500
              },
              radar = {
                  name = "armrad", moveType = "BUILDING", role="T1_Radar",
                  footX = 3, footZ = 3, interceptradius = 850,
                  metalCost = 60, energyCost = 100, buildTime = 40
              },
              jammer = {
                  name = "armjamt", moveType = "BUILDING", role="T1_Jammer",
                  footX = 3, footZ = 3, interceptradius = 850,
                  metalCost = 70, energyCost = 150, buildTime = 50
              },
              constructor = {
                  {
                      name = "icuck", moveType = "LAND", role="T1_Constructor",
                      interceptradius = 350,
                      metalCost = 120, energyCost = 200, buildTime = 60
                  }
              },
              attackers = {
                  {
                      name = "icupatroller", moveType = "LAND", role="T1_Land_Scout",
                      interceptradius = 450, isantiair = 0, isunderwater = 0, islandattacker = 1, isscout = 1, candefend = 1, islongrange = 0,
                      metalCost = 40, energyCost = 60, buildTime = 15
                  },
                  {
                      name = "armstorm", moveType = "LAND", role="T1_Land_Artillery",
                      interceptradius = 450, isantiair = 0, isunderwater = 0, islandattacker = 1, isscout = 0, candefend = 1, islongrange = 1,
                      metalCost = 70, energyCost = 130, buildTime = 25
                  },
                  {
                      name = "icuinv", moveType = "LAND", role="T1_Land_Assault",
                      interceptradius = 450, isantiair = 0, isunderwater = 0, islandattacker = 1, isscout = 0, candefend = 1, islongrange = 0,
                      metalCost = 60, energyCost = 90, buildTime = 20
                  },
                  {
                      name = "armwar", moveType = "LAND", role="T1_Land_Tank",
                      interceptradius = 450, isantiair = 0, isunderwater = 0, islandattacker = 1, isscout = 0, candefend = 1, islongrange = 0,
                      metalCost = 80, energyCost = 100, buildTime = 22
                  },
                  {
                      name = "icuaa", moveType = "LAND", role="T1_Land_AntiAir",
                      interceptradius = 550, isantiair = 1, isunderwater = 0, islandattacker = 0, isscout = 0, candefend = 1, islongrange = 0,
                      metalCost = 50, energyCost = 75, buildTime = 18
                  }
              },
              defenses = {
                  {
                      name = "iculighlturr", moveType = "BUILDING", role="T1_LaserTurret",
                      interceptradius = 850, isantiair = 0, islongrange = 0,
                      metalCost = 150, energyCost = 200, buildTime = 50
                  },
                  {
                      name = "armrl", moveType = "BUILDING", role="T1_MissileTurret",
                      interceptradius = 850, isantiair = 1, islongrange = 0,
                      metalCost = 180, energyCost = 150, buildTime = 60
                  },
                  {
                      name = "packo", moveType = "BUILDING", role="T1_FlakTurret",
                      interceptradius = 850, isantiair = 1, islongrange = 1,
                      metalCost = 220, energyCost = 250, buildTime = 70
                  },
                  {
                      name = "tawf001", moveType = "BUILDING", role="T1_LightLaserTurret",
                      interceptradius = 850, isantiair = 0, islongrange = 0,
                      metalCost = 120, energyCost = 180, buildTime = 45
                  },
                  {
                      name = "armhlt", moveType = "BUILDING", role="T1_HeavyLaserTurret",
                      interceptradius = 850, isantiair = 0, islongrange = 0,
                      metalCost = 250, energyCost = 300, buildTime = 75
                  },
                  {
                      name = "armguard", moveType = "BUILDING", role="T1_PlasmaTurret",
                      interceptradius = 850, isantiair = 0, islongrange = 1,
                      metalCost = 300, energyCost = 400, buildTime = 80
                  },
              }
          },
          T2 = {}, T3 = {},
      },
      NFA = { commander = "nfacom", _unitDefIDs = {}, T1 = {}, T2 = {}, T3 = {} },
      EUF = { commander = "eufcd",  _unitDefIDs = {}, T1 = {}, T2 = {}, T3 = {} },
      AND = { commander = "andcom", _unitDefIDs = {}, T1 = {}, T2 = {}, T3 = {} }
  }

  -- Mappa Comandante (nome UnitDef) -> Chiave Fazione (usata in factionUnits)
  local commanderFactionMap = {
      icucom = "ICU",
      nfacom = "NFA",
      eufcd  = "EUF",
      andcom = "AND"
  }

  -- === DEFINIZIONE LIVELLI TECNOLOGICI ===
  local techLevels = {
      [0] = {
          levelName = "Initial Setup (Tech 0)",
          sequentialBuildOrder = {
              { role = "T1_Power", type = "powerPlant" },
              { role = "T1_Extractor", type = "extractor" },
              { role = "T1_Power", type = "powerPlant" },
              { role = "T1_Extractor", type = "extractor" },
              { role = "T1_Factory_Kbot", type = "factory" },
              { role = "T1_Power", type = "powerPlant" },
              { role = "T1_Extractor", type = "extractor" },
          },
          requirementsToAdvance = {
              { role = "T1_Power", type = "powerPlant", targetCount = 3 },
              { role = "T1_Extractor", type = "extractor", targetCount = 3 },
              { roleMatch = "T1_Factory", type = "factory", targetCount = 1 },
          },
          commanderbehaviour = "comm_builder",
          buildInIslandOverride = {
              ["T1_Extractor"] = false,
              ["T1_Factory_Kbot"] = false,
              ["T1_Factory_Vehicle"] = false,
              ["T1_Factory_Air"] = false,
          },
          militaryconstruction = nil,
      },
      [1] = {
          levelName = "Basic Economy and Scouting (Tech 1)",
          requirementsToAdvance = {
              { role = "T1_Power", type = "powerPlant", targetCount = 5 },
              { role = "T1_Extractor", type = "extractor", targetCount = 5 },
              { roleMatch = "T1_Factory", type = "factory", targetCount = 2 },
              { role = "T1_Estorage", type = "estorage", targetCount = 1 },
              { role = "T1_Mstorage", type = "mstorage", targetCount = 1 },
              { role = "T1_Radar", type = "radar", targetCount = 1 },
          },
          commanderbehaviour = "comm_patrolbase",
          T1_builder_target_count = 1,
          militaryconstruction = {} -- Placeholder
      }
  }

  -- Funzione ricorsiva per popolare factionUnits[FAZIONE]._unitDefIDs
  local function PopulateFactionUnitIDs(factionKey, sourceFactionData, idTargetTable)
      Log(nil, "PopulateFactionUnitIDs: Starting for faction: " .. factionKey)
      if type(sourceFactionData) ~= "table" then Log(nil, "ERROR PFU: sourceFactionData for " .. factionKey .. " not table."); return end
      if type(idTargetTable) ~= "table" then Log(nil, "ERROR PFU: idTargetTable for " .. factionKey .. " not table."); return end

      if type(sourceFactionData.commander) == "string" then
          local commanderUnitDef = UnitDefNames[sourceFactionData.commander]
          if commanderUnitDef then
              idTargetTable.commander = {
                  name = sourceFactionData.commander, id = commanderUnitDef.id, role = "Commander",
                  moveType = UnitDefs[commanderUnitDef.id].movedata and UnitDefs[commanderUnitDef.id].movedata.moveType or "LAND"
              }
              Log(nil, "PFU: Populated commander '" .. sourceFactionData.commander .. "' ID: " .. commanderUnitDef.id)
          else Log(nil, "ERROR PFU: Commander UD '" .. sourceFactionData.commander .. "' not found for " .. factionKey) end
      end

      for tierKey, tierData in pairs(sourceFactionData) do
          if tierKey == "T1" or tierKey == "T2" or tierKey == "T3" then
              if type(tierData) == "table" then
                  -- Log(nil, "PFU: Processing " .. tierKey .. " for " .. factionKey) -- Log troppo verboso, rimosso
                  if not idTargetTable[tierKey] then idTargetTable[tierKey] = {} end
                  for unitCategory, categoryData in pairs(tierData) do
                      if type(categoryData) == "table" then
                          if categoryData.name then -- Singola definizione
                              local unitDef = UnitDefNames[categoryData.name]
                              if unitDef then
                                  idTargetTable[tierKey][unitCategory] = {}
                                  for k, v in pairs(categoryData) do idTargetTable[tierKey][unitCategory][k] = v end
                                  idTargetTable[tierKey][unitCategory].id = unitDef.id
                                  -- Log(nil, "  - PFU Populated " .. tierKey .. "/" .. unitCategory .. " (" .. categoryData.name .. "): ID " .. unitDef.id) -- Log verboso
                              else Log(nil, "  - ERROR PFU: UD '" .. categoryData.name .. "' for " .. tierKey .. "/" .. unitCategory .. " not found.") end
                          else -- Lista di unità
                              idTargetTable[tierKey][unitCategory] = {}
                              for i, unitEntry in ipairs(categoryData) do
                                  if type(unitEntry) == "table" and unitEntry.name then
                                      local unitDef = UnitDefNames[unitEntry.name]
                                      if unitDef then
                                          local newEntry = {}
                                          for k, v in pairs(unitEntry) do newEntry[k] = v end
                                          newEntry.id = unitDef.id
                                          table.insert(idTargetTable[tierKey][unitCategory], newEntry)
                                          -- Log(nil, "  - PFU Populated " .. tierKey .. "/" .. unitCategory .. "[" .. i .. "] (" .. unitEntry.name .. "): ID " .. unitDef.id) -- Log verboso
                                      else Log(nil, "  - ERROR PFU: UD '" .. unitEntry.name .. "' for " .. tierKey .. "/" .. unitCategory .. "[" .. i .. "] not found.") end
                                  else Log(nil, "  - WARN PFU: Invalid entry in " .. tierKey .. "/" .. unitCategory .. " at index " .. i) end
                              end
                          end
                      end
                  end
              end
          end
      end
      -- Log(nil, "PopulateFactionUnitIDs: Finished for faction: " .. factionKey) -- Log verboso
  end

  -- Funzione helper per ottenere i dati di un'unità da factionUnits._unitDefIDs
  local function GetUnitDataByFactionTierRole(factionKey, tierKey, roleName, typeHint)
      if not factionUnits[factionKey] or not factionUnits[factionKey]._unitDefIDs or
         not factionUnits[factionKey]._unitDefIDs[tierKey] then
        -- Log(nil, "GetUnitData: Faction " .. factionKey .. " or Tier " .. tierKey .. " not found in _unitDefIDs.") -- Potrebbe essere normale se il tier non è ancora definito
        return nil
      end
      local tierUnits = factionUnits[factionKey]._unitDefIDs[tierKey]

      if not typeHint then
          if roleName:find("Extractor") then typeHint = "extractor"
          elseif roleName:find("Power") then typeHint = "powerPlant"
          elseif roleName:find("Factory") then typeHint = "factory"
          elseif roleName:find("Estorage") then typeHint = "estorage"
          elseif roleName:find("Mstorage") then typeHint = "mstorage"
          elseif roleName:find("Radar") then typeHint = "radar"
          elseif roleName:find("Jammer") then typeHint = "jammer"
          elseif roleName:find("Constructor") then typeHint = "constructor"
          end
      end
      
      if not typeHint then
          Log(nil, "GetUnitData: typeHint for role '"..roleName.."' could not be deduced and was not provided.")
          return nil
      end

      local categoryData = tierUnits[typeHint]
      if not categoryData then
        -- Log(nil, "GetUnitData: Category '" .. typeHint .. "' not found in " .. factionKey .. "/" .. tierKey) -- Potrebbe essere normale
        return nil
      end

      if categoryData.name and categoryData.role == roleName then
          return categoryData
      elseif type(categoryData) == "table" then
          for _, unitData in ipairs(categoryData) do
              if unitData.role == roleName then
                  return unitData
              end
          end
          if #categoryData > 0 and (roleName == tierKey.."_"..typeHint or roleName == tierKey.."_".. (typeHint:gsub("s$", ""))) then
             -- Log(nil, "GetUnitData: Role '"..roleName.."' not specifically matched in list for type '"..typeHint.."', returning first entry as fallback.") -- Log verboso
             return categoryData[1]
          end
      end
      -- Log(nil, "GetUnitData: Role '" .. roleName .. "' (TypeHint: "..typeHint..") not found in " .. factionKey .. "/" .. tierKey .. "/" .. typeHint) -- Log verboso
      return nil
  end

  -- Funzione per trovare una posizione di costruzione semplice
  local function FindSimpleBuildSpot(teamID, builderID, unitToBuildDefID, isExtractor)
      local data = teamData[teamID]
      local bx, by, bz = Spring.GetUnitPosition(builderID)
      if not bx then Log(teamID, "FindSimpleBuildSpot: Builder " .. builderID .. " position not found."); return nil end

      if isExtractor then
          Log(teamID, "FindSimpleBuildSpot: Attempting to find metal spot for builder " .. builderID)
          local mexCount = Spring.GetGameRulesParam("mex_count")
          if mexCount and mexCount > 0 then
              for i = 1, mexCount do
                  local spotX = Spring.GetGameRulesParam("mex_x" .. i)
                  local spotY = Spring.GetGameRulesParam("mex_y" .. i)
                  local spotZ = Spring.GetGameRulesParam("mex_z" .. i)
                  if spotX and spotZ then
                      spotY = spotY or Spring.GetGroundHeight(spotX, spotZ)
                      if spotY then
                          local unitsNear = Spring.GetUnitsInRectangle(spotX - 5, spotZ - 5, spotX + 5, spotZ + 5)
                          local occupied = false
                          if unitsNear then
                              for _, nearID in ipairs(unitsNear) do
                                  local nearDef = UnitDefs[Spring.GetUnitDefID(nearID)]
                                  if nearDef and nearDef.extractsMetal and nearDef.extractsMetal > 0 then occupied = true; break end
                              end
                          end
                          if not occupied then
                              local buildTestResult = Spring.TestBuildOrder(unitToBuildDefID, spotX, spotY, spotZ, 1)
                              if buildTestResult == 0 or buildTestResult == 2 then
                                  Log(teamID, "FindSimpleBuildSpot: Found metal spot at " .. spotX .. "," .. spotZ .. " (Test: "..buildTestResult..")")
                                  return { x = spotX, y = spotY, z = spotZ }
                              end
                          end
                      end
                  end
              end
          end
          Log(teamID, "FindSimpleBuildSpot: No suitable free metal spot found for extractor.")
          return nil
      else
          for attempt = 1, 20 do
              local angle = math.random() * 2 * math.pi
              local dist = 60 + math.random(80)
              local testX = bx + math.cos(angle) * dist
              local testZ = bz + math.sin(angle) * dist
              local testY = Spring.GetGroundHeight(testX, testZ)
              if testY then
                  local onMetalSpot = false
                  local mexCount = Spring.GetGameRulesParam("mex_count")
                  if mexCount and mexCount > 0 then
                      for i = 1, mexCount do
                          local spotX = Spring.GetGameRulesParam("mex_x" .. i)
                          local spotZ = Spring.GetGameRulesParam("mex_z" .. i)
                          if spotX and spotZ then
                              local dx, dz = testX - spotX, testZ - spotZ
                              if (dx*dx + dz*dz) < (16*16) then onMetalSpot = true; break end
                          end
                      end
                  end
                  if not onMetalSpot then
                      local buildTestResult = Spring.TestBuildOrder(unitToBuildDefID, testX, testY, testZ, 1)
                      if buildTestResult == 0 or buildTestResult == 2 then
                          Log(teamID, "FindSimpleBuildSpot: Found general spot at " .. testX .. "," .. testZ .. " (Test: "..buildTestResult..")")
                          return { x = testX, y = testY, z = testZ }
                      end
                  end
              end
          end
          Log(teamID, "FindSimpleBuildSpot: No suitable general spot found near builder.")
          return nil
      end
  end

  -- Funzione per controllare se i requisiti per avanzare di tech level sono soddisfatti
    local function CheckTechRequirements(teamID)
      local data = teamData[teamID]
      local currentTechConfig = techLevels[data.currentTechLevel]

      local factionAllUnitsData = factionUnits[data.factionKey]._unitDefIDs

      if not factionAllUnitsData then
          Log(teamID, "CheckTechReq: CRITICAL ERROR - _unitDefIDs not found for faction " .. data.factionKey .. ". Cannot check requirements.")
          return false
      end

      if not currentTechConfig then
          Log(teamID, "CheckTechReq: ERROR - No techLevel config found for current level: " .. data.currentTechLevel)
          return false
      end
      if not currentTechConfig.requirementsToAdvance then
          Log(teamID, "CheckTechReq: No requirementsToAdvance defined for Tech Level " .. data.currentTechLevel .. ". Assuming requirements met (or error in config).")
          return true
      end

      Log(teamID, "CheckTechReq: STARTING CHECK for Tech Level " .. data.currentTechLevel .. ". Num requirements: " .. #currentTechConfig.requirementsToAdvance)

      for i, req in ipairs(currentTechConfig.requirementsToAdvance) do
          local currentCount = 0
          local reqNameForLog = req.role or req.roleMatch or "UNKNOWN_REQ_NAME"
          local reqTypeForLog = req.type or "N/A"

          Log(teamID, "CheckTechReq: Evaluating requirement [" .. i .. "]: Name='" .. reqNameForLog .. "', Type='" .. reqTypeForLog .. "', TargetCount=" .. req.targetCount)

          if req.role then
              local factionTierData = factionAllUnitsData.T1
              if not factionTierData then
                  Log(teamID, "CheckTechReq: ERROR - T1 unit definitions not found in _unitDefIDs for faction " .. data.factionKey)
                  return false
              end
              local categoryData = factionTierData[req.type]
              if not categoryData then
                  Log(teamID, "CheckTechReq: ERROR - Category '" .. reqTypeForLog .. "' for role '" .. req.role .. "' not found in T1 definitions for faction " .. data.factionKey)
                  return false
              end
              if categoryData.name and type(categoryData.name) == "string" then
                  if categoryData.role == req.role and categoryData.id then
                      local units = Spring.GetTeamUnitsByDefs(teamID, categoryData.id)
                      currentCount = units and #units or 0
                      Log(teamID, "CheckTechReq: Role '" .. req.role .. "' (single def: "..categoryData.name..") - Found UnitDefID: " .. categoryData.id .. ", Current Count: " .. currentCount)
                  else
                      Log(teamID, "CheckTechReq: ERROR - Single definition for type '" .. reqTypeForLog .. "' does not match role '" .. req.role .. "' or has no ID.")
                      return false
                  end
              elseif type(categoryData) == "table" and #categoryData >= 0 then
                  Log(teamID, "CheckTechReq: Role '" .. req.role .. "' (list type: "..reqTypeForLog..") - Counting units for each matching entry in list...")
                  currentCount = 0
                  if #categoryData == 0 then
                      Log(teamID, "CheckTechReq: WARN - The list for type '"..reqTypeForLog.."' is empty in factionUnits. Cannot satisfy requirement for role '"..req.role.."'")
                  end
                  for _, unitDefEntryInList in ipairs(categoryData) do
                      if unitDefEntryInList.role == req.role and unitDefEntryInList.id then
                          local unitsOfThisType = Spring.GetTeamUnitsByDefs(teamID, unitDefEntryInList.id)
                          local countOfThisType = unitsOfThisType and #unitsOfThisType or 0
                          Log(teamID, "CheckTechReq:  - List Entry '"..unitDefEntryInList.name.."' (Role: "..unitDefEntryInList.role..", ID: "..unitDefEntryInList.id..") Specific Count: "..countOfThisType)
                          currentCount = currentCount + countOfThisType
                      end
                  end
                  Log(teamID, "CheckTechReq: Role '" .. req.role .. "' (list summary) - Total Count from list: " .. currentCount)
              else
                   Log(teamID, "CheckTechReq: ERROR - No valid categoryData (neither single obj nor list) for role '" .. req.role .. "' (type: " .. reqTypeForLog .. ")")
                   return false
              end

          elseif req.roleMatch then
              local teamInstanceIDsList = Spring.GetTeamUnits(teamID)

              Log(teamID, "CheckTechReq: Evaluating roleMatch '" .. req.roleMatch .. "' for type '" .. reqTypeForLog .. "'")

              Log(teamID, "CheckTechReq: Inspecting factionAllUnitsData.T1.factory for roleMatch:")
              if factionAllUnitsData.T1 and factionAllUnitsData.T1.factory then
                  for idx, fDef in ipairs(factionAllUnitsData.T1.factory) do
                      Log(teamID, "  - Known FactoryDef ["..idx.."]: Name="..(fDef.name or "N/A")..", ID="..(fDef.id or "N/A")..", Role="..(fDef.role or "N/A"))
                  end
              else
                  Log(teamID, "  - factionAllUnitsData.T1.factory is nil or not T1 (cannot show known factory defs)")
              end

              if not teamInstanceIDsList then
                  Log(teamID, "CheckTechReq: ERROR - Spring.GetTeamUnits(teamID) returned nil. Cannot count for roleMatch.")
                  return false
              end
              
              Log(teamID, "CheckTechReq: For roleMatch, teamInstanceIDsList has " .. #teamInstanceIDsList .. " unit instances. Looking for KBot Lab (example DefID 149).")
              local kbotLabFoundInList_debug = false
              local kbotLabUnitInstanceID_debug = nil
              for _, unitInstanceID_in_list_debug in ipairs(teamInstanceIDsList) do
                  if Spring.GetUnitDefID(unitInstanceID_in_list_debug) == 149 then
                      kbotLabFoundInList_debug = true
                      kbotLabUnitInstanceID_debug = unitInstanceID_in_list_debug
                      Log(teamID, "   YES! KBot Lab (UnitInstanceID " .. kbotLabUnitInstanceID_debug .. ", DefID 149) IS in teamInstanceIDsList.")
                      break
                  end
              end
              if not kbotLabFoundInList_debug then
                  Log(teamID, "   NO! KBot Lab (DefID 149) IS NOT in teamInstanceIDsList at this point (this means it's not built or not detected by Spring.GetTeamUnits).")
              end

              if req.type == "factory" then
                  if factionAllUnitsData.T1 and factionAllUnitsData.T1.factory and #factionAllUnitsData.T1.factory > 0 then
                      local countedFactoryInstanceIDs = {} 

                      for _, unitInstanceID_from_team in ipairs(teamInstanceIDsList) do 
                          if not countedFactoryInstanceIDs[unitInstanceID_from_team] then
                              local actualUnitDefID_of_instance = Spring.GetUnitDefID(unitInstanceID_from_team) 
                              if actualUnitDefID_of_instance then
                                  for _, factoryDefFromList in ipairs(factionAllUnitsData.T1.factory) do 
                                      if factoryDefFromList.id == actualUnitDefID_of_instance then 
                                          Log(teamID, "CheckTechReq: >> MATCHED DefID! Team unit instance " .. unitInstanceID_from_team .. " (DefID: " .. actualUnitDefID_of_instance .. ") is known factory def: " .. factoryDefFromList.name)
                                          if factoryDefFromList.role:find(req.roleMatch) then
                                              currentCount = currentCount + 1
                                              countedFactoryInstanceIDs[unitInstanceID_from_team] = true
                                              Log(teamID, "CheckTechReq: >>>> ROLE MATCH SUCCESS! Factory '" .. factoryDefFromList.name .. "' (Role: '" .. factoryDefFromList.role .. "') contains '" .. req.roleMatch .. "'. New factory count: " .. currentCount)
                                          else
                                              Log(teamID, "CheckTechReq: >>>> ROLE MATCH FAIL! Factory '" .. factoryDefFromList.name .. "' (Role: '" .. factoryDefFromList.role .. "') does NOT contain '" .. req.roleMatch .. "'.")
                                          end
                                          break 
                                      end
                                  end
                              else
                                  -- Log(teamID, "CheckTechReq: WARN - Could not get DefID for unit instance " .. unitInstanceID_from_team .. ". Skipping it for factory check.") -- Potrebbe essere verboso
                              end
                          end
                      end
                  else
                      Log(teamID, "CheckTechReq: ERROR - No T1 factory definitions found in _unitDefIDs for faction " .. data.factionKey .. " (for roleMatch '"..req.roleMatch.."').")
                      return false
                  end
              else
                  Log(teamID, "CheckTechReq: ERROR - roleMatch currently only implemented for req.type 'factory'. Cannot check for type '" .. reqTypeForLog .. "'.")
                  return false
              end
          end

          if currentCount < req.targetCount then
              Log(teamID, "CheckTechReq: REQUIREMENT [" .. i .. "] NOT MET for '" .. reqNameForLog .. "'. Have " .. currentCount .. ", Need " .. req.targetCount .. ". Aborting further checks.")
              return false
          else
              Log(teamID, "CheckTechReq: Requirement [" .. i .. "] MET for '" .. reqNameForLog .. "'. Have " .. currentCount .. ", Need " .. req.targetCount)
          end
      end
      Log(teamID, "CheckTechReq: ALL REQUIREMENTS MET for Tech Level " .. data.currentTechLevel .. ". Returning true.")
      return true
  end

  --------------------------------------------------------------------------------
  -- GADGET EVENT HANDLERS (SYNCED)
  --------------------------------------------------------------------------------
  function gadget:Initialize()
      Log(nil, gadget:GetInfo().name .. " Initializing...")
      if not UnitDefNames then Log(nil, "CRITICAL ERROR - Init: UnitDefNames missing!"); return end
      if not UnitDefs then Log(nil, "CRITICAL ERROR - Init: UnitDefs missing!"); return end
      for factionKey, data in pairs(factionUnits) do
          if type(data) == "table" then PopulateFactionUnitIDs(factionKey, data, data._unitDefIDs) end
      end
      Log(nil, gadget:GetInfo().name .. " Initialization complete.")
  end

  function gadget:GameStart()
      Log(nil, gadget:GetInfo().name .. " Game Starting...") -- Questo log lo vedi
      local allTeams = Spring.GetTeamList()
      local gadgetAIName = gadget:GetInfo().name -- Nome dell'IA definito in GetInfo()

      if not allTeams or #allTeams == 0 then
          Log(nil, "GameStart CRITICAL: Spring.GetTeamList() returned nil or an empty list of teams!")
          return -- Non c'è nulla da fare se non ci sono team
      end
      Log(nil, "GameStart: Found " .. #allTeams .. " team(s) in the game.")

      for i, currentTeamID in ipairs(allTeams) do
          local teamLuaAI = Spring.GetTeamLuaAI(currentTeamID)
          local processThisTeam = false -- Flag per decidere se processare il team

          -- Log dettagliato per ogni team controllato
          Log(nil, "GameStart Check [" .. i .. "/" .. #allTeams .. "]: TeamID=" .. currentTeamID ..
                     ", Assigned LuaAI='" .. tostring(teamLuaAI) ..
                     "'. Expected AI Name='" .. gadgetAIName .. "'.")

          if teamLuaAI == gadgetAIName then
              Log(currentTeamID, "GameStart: SUCCESS - Team MATCHES Expected AI Name. Proceeding with initialization for this team.")
              processThisTeam = true
          else
              Log(nil, "GameStart Check: TeamID=" .. currentTeamID ..
                         " (Assigned LuaAI='" .. tostring(teamLuaAI) ..
                         "') does NOT match Expected AI Name ('" .. gadgetAIName .. "'). Skipping this team.")
              processThisTeam = false
          end

          if processThisTeam then
              local startX, startY, startZ = Spring.GetTeamStartPosition(currentTeamID)
              if not startX then
                  Log(currentTeamID, "GameStart ERROR: Could not get start position for TeamID " .. currentTeamID .. "! Aborting initialization for this team.")
                  -- Non impostare teamData[currentTeamID] e il ciclo continuerà con il prossimo team
              else
                  teamData[currentTeamID] = {
                      teamID = currentTeamID, initialized = true, factionKey = nil,
                      commanderUnitID = nil, commanderDefID = nil, commanderData = nil,
                      startPos = { x = startX, y = startY, z = startZ },
                      currentTechLevel = 0, warAIState = "scout",
                      resourceInfo = { metal = 0, energy = 0, metalIncome = 0, energyIncome = 0, lastUpdateFrame = -100}, -- Usiamo -100 per sicurezza
                      buildings = {}, constructors = {}, factories = {}, mobileUnits = {},
                      attackingGroups = {}, scoutingGroups = {}, defendingGroups = {}, nextGroupID = 1,
                      currentSequentialBuildIndex = 1,
                      hotspots_attack = {}, hotspots_defense = {},
                  }
                  Log(currentTeamID, "GameStart: Base teamData structure initialized for TeamID " .. currentTeamID .. ".")

                  local teamUnits = Spring.GetTeamUnits(currentTeamID)
                  if teamUnits and #teamUnits > 0 then
                      Log(currentTeamID, "GameStart: Found " .. #teamUnits .. " initial units for TeamID " .. currentTeamID .. ". Searching for commander...")
                      local commanderFoundForThisTeam = false
                      for _, unitID in ipairs(teamUnits) do
                          local unitDefID = Spring.GetUnitDefID(unitID)
                          if unitDefID then
                              local uDef = UnitDefs[unitDefID]
                              if uDef then
                                  local unitDefNameLower = uDef.name:lower()
                                  if commanderFactionMap[unitDefNameLower] then
                                      local faction = commanderFactionMap[unitDefNameLower]
                                      teamData[currentTeamID].factionKey = faction
                                      teamData[currentTeamID].commanderUnitID = unitID
                                      teamData[currentTeamID].commanderDefID = unitDefID
                                      commanderFoundForThisTeam = true

                                      if factionUnits[faction] and factionUnits[faction]._unitDefIDs and factionUnits[faction]._unitDefIDs.commander then
                                          teamData[currentTeamID].commanderData = factionUnits[faction]._unitDefIDs.commander
                                          Log(currentTeamID, "GameStart: Commander successfully found for TeamID " .. currentTeamID .. ": " .. uDef.name .. " (UnitID: " .. unitID .. "). Faction set to: " .. faction .. ". CommanderData loaded.")
                                      else
                                          Log(currentTeamID, "GameStart: Commander successfully found for TeamID " .. currentTeamID .. ": " .. uDef.name .. " (UnitID: " .. unitID .. "). Faction set to: " .. faction .. ". WARNING: CommanderData NOT found in factionUnits._unitDefIDs.")
                                      end
                                      
                                      teamData[currentTeamID].constructors[unitID] = {
                                          isCommander = true, techLevel = 0, state = "idle", currentTask = nil,
                                          moveType = teamData[currentTeamID].commanderData and teamData[currentTeamID].commanderData.moveType or "LAND"
                                      }
                                      Log(currentTeamID, "GameStart: Commander " ..unitID.. " added to constructors list for TeamID " .. currentTeamID .. ".")
                                      break 
                                  end
                              else Log(currentTeamID, "GameStart WARN: UnitDef for unitID " .. unitID .. " (DefID: "..unitDefID..") is nil on TeamID " .. currentTeamID .. ".") end
                          else Log(currentTeamID, "GameStart WARN: UnitDefID for unitID " .. unitID .. " is nil on TeamID " .. currentTeamID .. ".") end
                      end -- fine ciclo teamUnits

                      if not commanderFoundForThisTeam then
                          Log(currentTeamID, "GameStart CRITICAL ERROR: No commander unit found for TeamID " .. currentTeamID .. " among its " .. #teamUnits .. " initial units! AI cannot function correctly.")
                          if teamData[currentTeamID] then teamData[currentTeamID].initialized = false end
                      end

                  else -- teamUnits è nil o vuoto
                      Log(currentTeamID, "GameStart CRITICAL ERROR: No initial units found for TeamID " .. currentTeamID .. " (Spring.GetTeamUnits returned nil or empty)! AI cannot find commander.")
                      if teamData[currentTeamID] then teamData[currentTeamID].initialized = false end
                  end

                  -- Verifica finale dopo aver tentato di trovare il comandante
                  if teamData[currentTeamID] and not teamData[currentTeamID].factionKey and teamData[currentTeamID].initialized then
                      Log(currentTeamID, "GameStart CRITICAL ERROR: FactionKey is still nil for TeamID " .. currentTeamID .. " even after processing units. AI cannot function.")
                      teamData[currentTeamID].initialized = false
                  elseif teamData[currentTeamID] and teamData[currentTeamID].initialized then
                      Log(currentTeamID, "GameStart: TeamID " .. currentTeamID .. " setup appears complete. Faction: " .. teamData[currentTeamID].factionKey .. ", Tech: " .. teamData[currentTeamID].currentTechLevel .. ", State: " .. teamData[currentTeamID].warAIState)
                  end
              end -- fine if startX (posizione valida)
          end -- fine if processThisTeam
      end -- fine ciclo allTeams

      local finalTeamDataCount = 0
      if teamData then for _ in pairs(teamData) do finalTeamDataCount = finalTeamDataCount + 1 end end
      Log(nil, gadget:GetInfo().name .. " Game Start processing complete. Final teamData entries: " .. finalTeamDataCount) -- Questo log lo vedi
  end


  function gadget:GameFrame(frame)
      -- DEBUG LOG: ALL'INIZIO ASSOLUTO DI GAMEFRAME
 --   if frame % 60 == 0 then -- Logga ogni 2 secondi
 --       Spring.Echo("WMRTSAI: GameFrame CALLED. Frame: " .. frame .. ", Paused: " .. tostring(Game.gamePaused) .. ", GameOver: " .. tostring(Game.gameOver))
 --   end
    if Game.gamePaused or Game.gameOver then return end

    -- DEBUG LOG: Controlla se teamData è vuoto
 --   if frame % 60 == 5 then
 --       local teamCount = 0
 --       if teamData then for _ in pairs(teamData) do teamCount = teamCount + 1 end end
 --       Spring.Echo("WMRTSAI: GameFrame - teamData has " .. teamCount .. " entries. DebugMode: " .. tostring(WMRTSAI_Debug_Mode))
 --   end

    for teamID, data in pairs(teamData) do
      -- DEBUG LOG: Controlla se il team viene processato
   --   if frame % 120 == (teamID * 2 + 1) then -- Logga ogni 4 secondi circa, sfalsato
    --      if data.initialized and data.factionKey then
     --         Log(teamID, "GF Debug: Processing team. Tech: " .. data.currentTechLevel .. ", Faction: " .. data.factionKey)
     --     else
   --           Log(teamID, "GF Debug: SKIPPING team. Initialized: " .. tostring(data.initialized) .. ", FactionKey: " .. tostring(data.factionKey))
     --     end
     -- end

      if data.initialized and data.factionKey then
        if frame % 31 == 0 then -- Ogni ~1 secondo (31 è un primo per desincronizzare aggiornamenti)
            local metal, energy = Spring.GetTeamResources(teamID, "metal", "energy")
            if metal and energy then
                data.resourceInfo.metal = metal
                data.resourceInfo.energy = energy
            end
        end

        if data.currentTechLevel == 0 then
            local tech0Config = techLevels[0]
            
            -- DEBUG LOG: Controlla lo stato del comandante e il tech config
            if frame % 120 == (teamID * 2 + 5) and tech0Config then
                Log(teamID, "GF T0 Debug: CommanderID = " .. tostring(data.commanderUnitID) .. ", Behavior = " .. tostring(tech0Config.commanderbehaviour))
                if data.commanderUnitID and data.constructors[data.commanderUnitID] then
                    Log(teamID, "GF T0 Debug: Commander constructor data exists. State: " .. data.constructors[data.commanderUnitID].state)
                elseif data.commanderUnitID then
                    Log(teamID, "GF T0 Debug: ERROR - Commander constructor data MISSING for ID: " .. data.commanderUnitID)
                else
                    Log(teamID, "GF T0 Debug: ERROR - CommanderID is nil.")
                end
            end

            if tech0Config and tech0Config.commanderbehaviour == "comm_builder" then
                local commanderID = data.commanderUnitID
                if commanderID and data.constructors[commanderID] then -- Assicurati che il comandante esista e sia nei costruttori
                    local commanderState = data.constructors[commanderID].state

                    if commanderState == "idle" then
                        local buildQueue = tech0Config.sequentialBuildOrder
                        
                        -- DEBUG LOG: Controlla la build queue e l'indice
                        if frame % 120 == (teamID * 2 + 10) then
                            Log(teamID, "GF T0 IdleCom Debug: BuildIndex = " .. data.currentSequentialBuildIndex .. ", QueueLength = " .. #buildQueue)
                        end

                        if data.currentSequentialBuildIndex <= #buildQueue then
                            local itemToBuild = buildQueue[data.currentSequentialBuildIndex]
                            local unitDataToBuild = GetUnitDataByFactionTierRole(data.factionKey, "T1", itemToBuild.role, itemToBuild.type)

                            if unitDataToBuild and unitDataToBuild.id then
                                if (data.resourceInfo.metal >= (unitDataToBuild.metalCost or 0)) and
                                   (data.resourceInfo.energy >= (unitDataToBuild.energyCost or 0)) then
                                    local isExtractor = (itemToBuild.type == "extractor")
                                    local buildPos = FindSimpleBuildSpot(teamID, commanderID, unitDataToBuild.id, isExtractor)
                                    if buildPos then
                                        Log(teamID, "Tech 0 ORDER: Commander " .. commanderID .. " to build " .. unitDataToBuild.name .. " (Role: " .. itemToBuild.role .. ") at " .. string.format("%.0f,%.0f", buildPos.x, buildPos.z) )
                                        Spring.GiveOrderToUnit(commanderID, -unitDataToBuild.id, {buildPos.x, buildPos.y, buildPos.z}, {})
                                        data.constructors[commanderID].state = "busy_building"
                                        data.constructors[commanderID].currentTask = { buildingDefID = unitDataToBuild.id, role = itemToBuild.role }
                                    else
                                        if frame % 180 == (teamID *2 + 15) then -- Log non troppo frequente
                                           Log(teamID, "Tech 0 INFO: Commander " .. commanderID .. " wants to build " .. unitDataToBuild.name .. " but no suitable build spot found.")
                                        end
                                    end
                                else
                                     if frame % 180 == (teamID *2 + 20) then -- Log non troppo frequente
                                        Log(teamID, "Tech 0 INFO: Commander " .. commanderID .. " wants to build " .. unitDataToBuild.name .. " but cannot afford. M: " .. data.resourceInfo.metal .. "/" .. (unitDataToBuild.metalCost or 0) .. ", E: " .. data.resourceInfo.energy .. "/" .. (unitDataToBuild.energyCost or 0))
                                     end
                                end
                            else
                                Log(teamID, "Tech 0 ERROR: Could not find UnitData for role: " .. itemToBuild.role .. " (type: "..(itemToBuild.type or "N/A")..") in seqBuildOrder index " .. data.currentSequentialBuildIndex)
                                data.currentSequentialBuildIndex = data.currentSequentialBuildIndex + 1 -- Avanza per non bloccarsi
                            end
                        else
                            -- Log(teamID, "Tech 0 INFO: Commander idle, sequential build order complete. Waiting for tech req check.") -- Log verboso
                        end
                    end
                end
            end
        end

        if frame % 301 == (teamID * 7 + 50) % 301 then
             Log(teamID, "Heartbeat - Tech: " .. data.currentTechLevel .. ", State: " .. data.warAIState .. ", M: " .. string.format("%.0f", data.resourceInfo.metal or 0) .. ", E: " .. string.format("%.0f", data.resourceInfo.energy or 0) .. ", BuildIdx: " .. (data.currentSequentialBuildIndex or "N/A"))
             if data.currentTechLevel == 0 and data.commanderUnitID and data.constructors[data.commanderUnitID] then
                Log(teamID, " Commander State: " .. data.constructors[data.commanderUnitID].state)
             end
        end
      end
    end
  end

  function gadget:UnitFinished(unitID, unitDefID, unitTeam)
    if teamData[unitTeam] and teamData[unitTeam].initialized and teamData[unitTeam].factionKey then
        local data = teamData[unitTeam]
        local uDef = UnitDefs[unitDefID]
        Log(unitTeam, "UnitFinished: " .. unitID .. " (" .. (uDef and uDef.humanName or "Unknown") .. " - DefID: "..unitDefID..")")

        if data.currentTechLevel == 0 and data.commanderUnitID and data.constructors[data.commanderUnitID] and data.constructors[data.commanderUnitID].state == "busy_building" then
            local task = data.constructors[data.commanderUnitID].currentTask
            if task and task.buildingDefID == unitDefID then
                Log(unitTeam, "Tech 0: Commander finished building " .. (uDef and uDef.humanName or "Unknown") .. " (Role: "..(task.role or "N/A")..")")
                data.constructors[data.commanderUnitID].state = "idle"
                data.constructors[data.commanderUnitID].currentTask = nil
                local tech0Config = techLevels[0]
                local buildQueue = tech0Config.sequentialBuildOrder
                if data.currentSequentialBuildIndex <= #buildQueue then
                    local expectedItem = buildQueue[data.currentSequentialBuildIndex]
                    if expectedItem.role == task.role then
                        data.currentSequentialBuildIndex = data.currentSequentialBuildIndex + 1
                        Log(unitTeam, "Tech 0: Advanced sequential build index to: " .. data.currentSequentialBuildIndex)
                    else
                        Log(unitTeam, "Tech 0 WARN: Commander built "..task.role..", but expected "..expectedItem.role..". Not advancing index.")
                    end
                end
                if CheckTechRequirements(unitTeam) then
                    data.currentTechLevel = 1
                    data.currentSequentialBuildIndex = 1 
                    Log(unitTeam, "----------------------------------------------------")
                    Log(unitTeam, "TECH LEVEL UP! Advanced to Tech Level 1.")
                    Log(unitTeam, "----------------------------------------------------")
                else
                    Log(unitTeam, "Tech 0: Requirements to advance NOT YET met after building " .. (uDef and uDef.humanName or "Unknown") .. ".")
                end
            end
        end
    end
  end

  function gadget:UnitIdle(unitID, unitDefID, unitTeam)
      if teamData[unitTeam] and teamData[unitTeam].initialized and teamData[unitTeam].factionKey then
          local data = teamData[unitTeam]
          if data.commanderUnitID and unitID == data.commanderUnitID and data.constructors[unitID] and data.constructors[unitID].state ~= "idle" then
              Log(unitTeam, "Commander " .. unitID .. " became IDLE. Previous state: " .. data.constructors[unitID].state .. ". Resetting to idle.")
              data.constructors[unitID].state = "idle"
              data.constructors[unitID].currentTask = nil
          end
      end
  end

  function gadget:UnitDestroyed(unitID, unitDefID, unitTeam, attackerUnitID, attackerUnitDefID, attackerTeamID)
      if teamData[unitTeam] and teamData[unitTeam].initialized then
          local data = teamData[unitTeam]
          local uDef = UnitDefs[unitDefID]
          Log(unitTeam, "UnitDestroyed: " .. unitID .. " (" .. (uDef and uDef.humanName or "Unknown") .. ")")
          if data.constructors and data.constructors[unitID] then data.constructors[unitID] = nil; Log(unitTeam, " Removed from constructors.") end
          -- ...
      end
  end

  function gadget:Shutdown()
    Log(nil, gadget:GetInfo().name .. " Shutting down.")
    teamData = {}
  end

end -- SYNCED CODE END

--------------------------------------------------------------------------------
-- UNSYNCED CODE - Debug Visivo e Comandi Console
--------------------------------------------------------------------------------
if (not gadgetHandler:IsSyncedCode()) then
    local SYNCED = SYNCED
    local Spring = Spring
    local gl = gl

    local function DrawTeamInfo(teamID, data)
      if not data or not data.startPos or not data.factionKey then return end
      local x, y, z = data.startPos.x, data.startPos.y, data.startPos.z
      if x then
         gl.Text(data.factionKey .. " (T" .. data.currentTechLevel .. ") St: " .. data.warAIState, x, y + 70, 15, "co")
         if data.commanderUnitID then
            local cmdUID = data.commanderUnitID -- Per evitare di accedere a data.commanderUnitID se nil
            if cmdUID and Spring.ValidUnitID(cmdUID) then -- Controlla se l'ID è valido prima di GetUnitPosition
                local cx, cy, cz = Spring.GetUnitPosition(cmdUID)
                if cx then
                    local comState = "N/A"
                    if data.constructors and data.constructors[cmdUID] then
                        comState = data.constructors[cmdUID].state or "N/A"
                    end
                    gl.Text("Com: " .. cmdUID .. " St: " .. comState, cx, cy + 30, 12, "co")
                end
            end
         end
      end
    end

    function gadget:DrawWorld()
      if SYNCED and SYNCED.WMRTSAI_Debug_Mode and SYNCED.WMRTSAI_Debug_Mode > 0 and type(SYNCED.teamData) == "table" then
        for teamID, data in pairs(SYNCED.teamData) do
           if data and data.initialized then
              DrawTeamInfo(teamID, data)
           end
        end
        gl.Color(1,1,1,1)
      end
    end

    local function ToggleWMRTSAIDebug(cmd, line, words, playerID)
        if SYNCED then
            local currentMode = SYNCED.WMRTSAI_Debug_Mode or 0
            SYNCED.WMRTSAI_Debug_Mode = (currentMode == 0) and 1 or 0
            Spring.Echo("WMRTSAI Debug Mode (synced var) set to: " .. SYNCED.WMRTSAI_Debug_Mode)
        else
            Spring.Echo("WMRTSAI: SYNCED context not available to set debug mode.")
        end
        return true
    end

    function gadget:Initialize()
       gadgetHandler:AddChatAction("wmrtsai_debug_toggle", ToggleWMRTSAIDebug, "Toggle WMRTSAI debug mode (synced var)")
    end
end -- UNSYNCED CODE END