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
     local function FindSimpleBuildSpot(teamID, builderID, dataForBuilding, isExtractor)
      local data = teamData[teamID]
      local bx, by, bz = Spring.GetUnitPosition(builderID)
      if not bx then Log(teamID, "FindSimpleBuildSpot: Builder " .. builderID .. " position not found."); return nil end

      local unitDefIDToBuild = dataForBuilding.id 
      local buildingNameForLog = dataForBuilding.name or "UnknownBuilding"

      if not unitDefIDToBuild then
          Log(teamID, "FindSimpleBuildSpot: ERROR - dataForBuilding is missing .id field for " .. buildingNameForLog)
          return nil
      end

      if isExtractor then
          Log(teamID, "FindSimpleBuildSpot: Attempting to find BEST metal spot for builder " .. builderID .. " to build " .. buildingNameForLog)
          local mexCount = Spring.GetGameRulesParam("mex_count")
          local suitableSpots = {}

          if mexCount and mexCount > 0 then
              for i = 1, mexCount do
                  local spotX = Spring.GetGameRulesParam("mex_x" .. i)
                  local spotY = Spring.GetGameRulesParam("mex_y" .. i)
                  local spotZ = Spring.GetGameRulesParam("mex_z" .. i)
                  if spotX and spotZ then
                      spotY = spotY or Spring.GetGroundHeight(spotX, spotZ)
                      if spotY then
                          local unitsNear = Spring.GetUnitsInRectangle(spotX - 1, spotZ - 1, spotX + 1, spotZ + 1) 
                          local occupied = false
                          if unitsNear then
                              for _, nearID in ipairs(unitsNear) do
                                  local nearDefID = Spring.GetUnitDefID(nearID)
                                  if nearDefID then
                                      local nearDef = UnitDefs[nearDefID]
                                      if nearDef and nearDef.extractsMetal and nearDef.extractsMetal > 0 then occupied = true; break end
                                  end
                              end
                          end
                          if not occupied then
                              local buildTestResult = Spring.TestBuildOrder(unitDefIDToBuild, spotX, spotY, spotZ, 1) 
                              if buildTestResult == 0 or buildTestResult == 2 then
                                  local dx, dz = spotX - bx, spotZ - bz
                                  local distSq = dx*dx + dz*dz
                                  table.insert(suitableSpots, {x = spotX, y = spotY, z = spotZ, distSq = distSq})
                              end
                          end
                      end
                  end
              end
          end

          if #suitableSpots == 0 then
              Log(teamID, "FindSimpleBuildSpot: No suitable free metal spots found for " .. buildingNameForLog)
              return nil
          end

          table.sort(suitableSpots, function(a,b) return a.distSq < b.distSq end)
          local bestSpot = suitableSpots[1]
          Log(teamID, "FindSimpleBuildSpot: Selected BEST metal spot for " .. buildingNameForLog .. " at " .. string.format("%.0f,%.0f", bestSpot.x, bestSpot.z) .. " (DistSq: "..bestSpot.distSq..")")
          return { x = bestSpot.x, y = bestSpot.y, z = bestSpot.z }

      else -- Per altre strutture (NON ESTRATTORI)
          Log(teamID, "FindSimpleBuildSpot: Attempting to find general spot for " .. buildingNameForLog)
          
          local buildingFootX_tiles = dataForBuilding.footX 
          local buildingFootZ_tiles = dataForBuilding.footZ 

          if not buildingFootX_tiles or not buildingFootZ_tiles then
              Log(teamID, "FindSimpleBuildSpot: ERROR - Missing footX or footZ in dataForBuilding for " .. buildingNameForLog .. ". Using fallback.")
              local springDef = UnitDefs[unitDefIDToBuild] 
              buildingFootX_tiles = springDef and springDef.footprintX or 3 
              buildingFootZ_tiles = springDef and springDef.footprintZ or 3
              Log(teamID, "FindSimpleBuildSpot: Using fallback footprint "..buildingFootX_tiles.."x"..buildingFootZ_tiles.." for "..buildingNameForLog)
          end

          local buildingHalfX_units = (buildingFootX_tiles / 2) * 8
          local buildingHalfZ_units = (buildingFootZ_tiles / 2) * 8
          local buildingClearanceRadius = math.max(buildingHalfX_units, buildingHalfZ_units) + 8 

          for attempt = 1, 30 do 
              local angle = math.random() * 2 * math.pi
              local dist = buildingClearanceRadius + 20 + math.random(100) 
              local testX = bx + math.cos(angle) * dist
              local testZ = bz + math.sin(angle) * dist
              local testY = Spring.GetGroundHeight(testX, testZ)

              if testY then
                  local onMetalSpot = false
                  local metalSpotExclusionRadius = 16 + buildingClearanceRadius 
                  local metalSpotExclusionRadiusSq = metalSpotExclusionRadius * metalSpotExclusionRadius

                  local mexCount_other = Spring.GetGameRulesParam("mex_count")
                  if mexCount_other and mexCount_other > 0 then
                      for i = 1, mexCount_other do
                          local spotX = Spring.GetGameRulesParam("mex_x" .. i)
                          local spotZ = Spring.GetGameRulesParam("mex_z" .. i)
                          if spotX and spotZ then
                              local dx_metal, dz_metal = testX - spotX, testZ - spotZ 
                              if (dx_metal*dx_metal + dz_metal*dz_metal) < metalSpotExclusionRadiusSq then
                                  onMetalSpot = true; break
                              end
                          end
                      end
                  end

                  if not onMetalSpot then
                      local buildTestResult = Spring.TestBuildOrder(unitDefIDToBuild, testX, testY, testZ, 1) 
                      if buildTestResult == 0 or buildTestResult == 2 then
                          Log(teamID, "FindSimpleBuildSpot: Found general spot for " .. buildingNameForLog .. " at " .. string.format("%.0f,%.0f",testX,testZ) .. " (Test: "..buildTestResult..")")
                          return { x = testX, y = testY, z = testZ }
                      end
                  end
              end
          end
          Log(teamID, "FindSimpleBuildSpot: No suitable general spot found near builder for " .. buildingNameForLog)
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
    if frame == 1 or frame % 300 == 7 then 
        Log(nil, "GameFrame DBG: Current Game.gameSpeed = " .. tostring(Game.gameSpeed) .. 
                   ", Game.speedFactor = " .. tostring(Game.speedFactor) .. 
                   ", Game.wantedSpeedFactor = " ..tostring(Game.wantedSpeedFactor))
    end

    if Game.gamePaused or Game.gameOver then return end

    for teamID, data in pairs(teamData) do
      if frame % 120 == (teamID * 2 + 1) then 
          if data.initialized and data.factionKey then
              -- Log(teamID, "GF Debug: Processing team. Tech: " .. data.currentTechLevel .. ", Faction: " .. data.factionKey) 
          else
              Log(teamID, "GF Debug: SKIPPING team. Initialized: " .. tostring(data.initialized) .. ", FactionKey: " .. tostring(data.factionKey))
          end
      end

      if data.initialized and data.factionKey then
        if frame % 31 == 0 then 
            local metal, energy = Spring.GetTeamResources(teamID, "metal", "energy")
            if metal and energy then
                data.resourceInfo.metal = metal
                data.resourceInfo.energy = energy
            end
        end

        if data.currentTechLevel == 0 then
            local tech0Config = techLevels[0]
            
            if tech0Config and tech0Config.commanderbehaviour == "comm_builder" then
                local commanderID = data.commanderUnitID
                if commanderID and data.constructors[commanderID] then 
                    local commanderConstructorData = data.constructors[commanderID]
                    local commanderState = commanderConstructorData.state
                    local performIdleLogic = true 

                    if commanderState == "busy_building" then
                        local task = commanderConstructorData.currentTask
                        if not task or not task.buildingDefID then 
                            Log(teamID, "Tech 0 WARN: Commander is busy_building but currentTask is nil or invalid! Resetting to idle. Frame: " .. frame)
                            Spring.GiveOrderToUnit(commanderID, CMD.STOP, {}, {""})
                            commanderConstructorData.state = "idle"
                            commanderConstructorData.currentTask = nil
                            commanderConstructorData.buildStartTime = nil
                            commanderConstructorData.buildAttempts = 0
                            commanderState = "idle" 
                            performIdleLogic = true 
                        else
                            if not commanderConstructorData.buildStartTime then
                                commanderConstructorData.buildStartTime = frame
                                commanderConstructorData.buildAttempts = (commanderConstructorData.buildAttempts or 0) + 1
                                Log(teamID, "Tech 0: Commander STARTING build (Frame: " .. frame .. ") for task (Role: "..(task.role or "N/A").."), Attempt: " .. commanderConstructorData.buildAttempts .. ", TargetDefID: " .. task.buildingDefID)
                            end

                            local unitDefForTimeout = UnitDefs[task.buildingDefID]
                            local buildTimeSeconds_task = unitDefForTimeout and unitDefForTimeout.buildTime or 90 
                            
                            local speedFactorToUse = Game.speedFactor 
                            if not speedFactorToUse or speedFactorToUse <= 0 then speedFactorToUse = Game.wantedSpeedFactor end
                            if not speedFactorToUse or speedFactorToUse <= 0 then speedFactorToUse = Game.gameSpeed end 
                            if not speedFactorToUse or speedFactorToUse <= 0 then speedFactorToUse = 1.0 end

                            -- LOG SPOSTATO QUI, PRIMA DEI CALCOLI CHE LO USANO
                            if frame == commanderConstructorData.buildStartTime or frame % 150 == (teamID * 5 + 1) % 150 then -- Logga all'inizio del task e poi periodicamente
                                Log(teamID, "DEBUG TIMEOUT CALC (Frame " .. frame .. "): DefID=" .. task.buildingDefID .. 
                                            ", RawUnitDef.buildTime=" .. tostring(unitDefForTimeout and unitDefForTimeout.buildTime) .. 
                                            ", buildTimeSeconds_task=" .. buildTimeSeconds_task .. 
                                            ", Name=" .. (unitDefForTimeout and unitDefForTimeout.humanName or "N/A") .. 
                                            ", SpeedFactorToUse=" .. string.format("%.2f", speedFactorToUse))
                            end
                            
                            local expectedFramesToComplete = (buildTimeSeconds_task * 30) / speedFactorToUse 
                            local timeoutFramesBuffer = 300 
                            local timeoutMultiplier = 2.5 
                            
                            local calculatedTimeoutLimit = math.floor(expectedFramesToComplete * timeoutMultiplier) + timeoutFramesBuffer
                            if calculatedTimeoutLimit < 300 then calculatedTimeoutLimit = 300 end 

                            local framesOnCurrentTask = frame - (commanderConstructorData.buildStartTime or frame)

                            if frame % 150 == (teamID * 5) % 150 then 
                                Log(teamID, "Tech 0 TIMEOUT_CHECK: On task (Role: "..(task.role or "N/A")..") for " .. framesOnCurrentTask .. " frames. Limit: " .. calculatedTimeoutLimit .. ". BuildStartTime: " .. (commanderConstructorData.buildStartTime or "N/A") .. ". SpeedFactorUsed: " .. string.format("%.2f", speedFactorToUse))
                            end

                            if framesOnCurrentTask > calculatedTimeoutLimit then
                                Log(teamID, "Tech 0 TIMEOUT DETECTED: Commander stuck on building (Role: "..(task.role or "N/A")..") for too long (" .. framesOnCurrentTask .. " frames, Limit: " .. calculatedTimeoutLimit .. "). Attempt: " .. commanderConstructorData.buildAttempts)
                                Spring.GiveOrderToUnit(commanderID, CMD.STOP, {}, {""}) 
                                commanderConstructorData.state = "idle"                 
                                commanderConstructorData.currentTask = nil              
                                commanderConstructorData.buildStartTime = nil           
                                local wasSequentialTimeout = task.isSequential          

                                if commanderConstructorData.buildAttempts >= 3 then 
                                    Log(teamID, "Tech 0 TIMEOUT: Too many attempts ("..commanderConstructorData.buildAttempts..") for role "..(task.role or "N/A")..". Advancing sequential index if applicable.")
                                    if wasSequentialTimeout then 
                                       data.currentSequentialBuildIndex = data.currentSequentialBuildIndex + 1
                                       Log(teamID, "Tech 0 TIMEOUT: Sequential index advanced to " .. data.currentSequentialBuildIndex)
                                    end
                                    commanderConstructorData.buildAttempts = 0 
                                else
                                    Log(teamID, "Tech 0 TIMEOUT: Build attempt " .. commanderConstructorData.buildAttempts .. " for this task. Will retry if task is re-selected.")
                                end
                                Log(teamID, "Tech 0 TIMEOUT: Commander has been reset to IDLE state.")
                                commanderState = "idle" 
                                performIdleLogic = true 
                            else
                                performIdleLogic = false 
                            end
                        end
                    elseif commanderState ~= "busy_building" then 
                        commanderConstructorData.buildStartTime = nil
                        commanderConstructorData.buildAttempts = 0
                    end

                    if performIdleLogic and commanderState == "idle" then
                        local buildIndexToUse = data.currentSequentialBuildIndex
                        local isFromSequentialFlag = false 
                        local finalItemToBuildRole = nil
                        local finalItemToBuildType = nil
                        local finalUnitDataToBuild = nil
                        
                        if frame % 15 == (teamID * 1) % 15 or WMRTSAI_Debug_Mode > 1 then 
                           Log(teamID, "---------------- TECH 0 COMMANDER IDLE START (Frame: " .. frame .. ") ----------------")
                           Log(teamID, "ULTRALOG: Commander " .. commanderID .. " is IDLE. Current SeqBuildIdx: " .. data.currentSequentialBuildIndex .. ", SeqQueueLength: " .. #tech0Config.sequentialBuildOrder)
                        end
                        
                        Log(teamID, "ULTRALOG IdleCom: 1. Checking allMainRequirementsMet...")
                        local allMainRequirementsMet = CheckTechRequirements(teamID) 
                        Log(teamID, "ULTRALOG IdleCom: 1. allMainRequirementsMet = " .. tostring(allMainRequirementsMet))
                        
                        if not allMainRequirementsMet then
                            Log(teamID, "ULTRALOG IdleCom: 2. Main requirements NOT met. Iterating requirementsToAdvance...")
                            for reqIdx, req in ipairs(tech0Config.requirementsToAdvance) do
                                local currentCount = 0
                                local reqActualRoleToEvaluate = req.role or req.roleMatch 
                                local reqActualTypeToEvaluate = req.type 
                                if req.role then
                                    local categoryData = factionUnits[data.factionKey]._unitDefIDs.T1[reqActualTypeToEvaluate]
                                    if categoryData then
                                        if categoryData.name then 
                                            if categoryData.role == req.role then
                                                local units = Spring.GetTeamUnitsByDefs(teamID, categoryData.id)
                                                currentCount = units and #units or 0
                                            end
                                        elseif type(categoryData) == "table" then 
                                            for _, entry in ipairs(categoryData) do
                                                if entry.role == req.role then
                                                    local units = Spring.GetTeamUnitsByDefs(teamID, entry.id)
                                                    currentCount = currentCount + (units and #units or 0)
                                                end
                                            end
                                        end
                                    end
                                elseif req.roleMatch and reqActualTypeToEvaluate == "factory" then
                                    local factionT1Factories = factionUnits[data.factionKey]._unitDefIDs.T1.factory
                                    if factionT1Factories then
                                        for _, factoryDef_reqCount in ipairs(factionT1Factories) do 
                                            if factoryDef_reqCount.role:find(req.roleMatch) then
                                                local units = Spring.GetTeamUnitsByDefs(teamID, factoryDef_reqCount.id)
                                                currentCount = currentCount + (units and #units or 0)
                                            end
                                        end
                                    end
                                end

                                if currentCount < req.targetCount then
                                    Log(teamID, "ULTRALOG IdleCom: 2.3. MISSING REQ FOUND! Role: " .. reqActualRoleToEvaluate .. ", Type: " .. reqActualTypeToEvaluate)
                                    finalItemToBuildRole = reqActualRoleToEvaluate 
                                    finalItemToBuildType = reqActualTypeToEvaluate
                                    if req.role then
                                        finalUnitDataToBuild = GetUnitDataByFactionTierRole(data.factionKey, "T1", req.role, req.type)
                                    elseif req.roleMatch and req.type == "factory" then
                                        for _, seqItem_fallback in ipairs(tech0Config.sequentialBuildOrder) do 
                                            if seqItem_fallback.type == "factory" and seqItem_fallback.role:find(req.roleMatch) then
                                                finalUnitDataToBuild = GetUnitDataByFactionTierRole(data.factionKey, "T1", seqItem_fallback.role, seqItem_fallback.type)
                                                finalItemToBuildRole = seqItem_fallback.role 
                                                break
                                            end
                                        end
                                        if not finalUnitDataToBuild and factionUnits[data.factionKey]._unitDefIDs.T1.factory and #factionUnits[data.factionKey]._unitDefIDs.T1.factory > 0 then
                                            finalUnitDataToBuild = factionUnits[data.factionKey]._unitDefIDs.T1.factory[1]
                                            if finalUnitDataToBuild then finalItemToBuildRole = finalUnitDataToBuild.role end
                                        end
                                    end
                                    isFromSequentialFlag = false 
                                    Log(teamID, "ULTRALOG IdleCom: 2.4. Set to build missing req: " .. (finalItemToBuildRole or "RoleNil") .. ", UnitData: " .. (finalUnitDataToBuild and finalUnitDataToBuild.name or "UnitDataNil"))
                                    break 
                                end
                            end 
                        else Log(teamID, "ULTRALOG IdleCom: 2. All main requirements ARE met.") end 
                        
                        if not finalUnitDataToBuild then 
                            if buildIndexToUse <= #tech0Config.sequentialBuildOrder then
                                local currentSeqItem = tech0Config.sequentialBuildOrder[buildIndexToUse]
                                local tempSeqUnitData = GetUnitDataByFactionTierRole(data.factionKey, "T1", currentSeqItem.role, currentSeqItem.type)
                                finalItemToBuildRole = currentSeqItem.role
                                finalItemToBuildType = currentSeqItem.type
                                finalUnitDataToBuild = tempSeqUnitData
                                isFromSequentialFlag = true
                                Log(teamID, "ULTRALOG IdleCom: 3.2. Set to build from sequence: " .. (finalItemToBuildRole or "RoleNil") .. ", UnitData: " .. (finalUnitDataToBuild and finalUnitDataToBuild.name or "UnitDataNil"))
                            end
                        end
                        
                        Log(teamID, "ULTRALOG IdleCom: 4. FINAL DECISION - Role: "..(finalItemToBuildRole or "NONE")..", Type: "..(finalItemToBuildType or "NONE")..", Name: "..(finalUnitDataToBuild and finalUnitDataToBuild.name or "NONE")..", IsSeq: "..tostring(isFromSequentialFlag))
                        
                        if finalUnitDataToBuild and finalUnitDataToBuild.id then
                            if (data.resourceInfo.metal >= (finalUnitDataToBuild.metalCost or 0)) and
                               (data.resourceInfo.energy >= (finalUnitDataToBuild.energyCost or 0)) then
                                local isExtractor = (finalItemToBuildType == "extractor")
                                local buildPos = FindSimpleBuildSpot(teamID, commanderID, finalUnitDataToBuild, isExtractor) 
                                if buildPos then
                                    Log(teamID, "Tech 0 ORDER: Commander " .. commanderID .. " to build " .. finalUnitDataToBuild.name .. " (Role: " .. (finalItemToBuildRole or "N/A") .. ", Seq: "..tostring(isFromSequentialFlag)..") at " .. string.format("%.0f,%.0f", buildPos.x, buildPos.z) )
                                    Spring.GiveOrderToUnit(commanderID, -finalUnitDataToBuild.id, {buildPos.x, buildPos.y, buildPos.z}, {})
                                    commanderConstructorData.state = "busy_building" 
                                    commanderConstructorData.currentTask = { 
                                        buildingDefID = finalUnitDataToBuild.id, 
                                        role = finalItemToBuildRole,
                                        isSequential = isFromSequentialFlag 
                                    }
                                    commanderConstructorData.buildStartTime = nil 
                                    commanderConstructorData.buildAttempts = 0 
                                else
                                    if frame % 181 == (teamID * 3 + 7) % 181 then 
                                       Log(teamID, "Tech 0 INFO (Periodic): Commander " .. commanderID .. " wants to build " .. (finalUnitDataToBuild.name or "UnitDataNil") .. " but no suitable build spot found (attempted for role: "..(finalItemToBuildRole or "N/A")..").")
                                    end
                                end
                            else
                                if frame % 181 == (teamID * 3 + 14) % 181 then 
                                   Log(teamID, "Tech 0 INFO (Periodic): Commander " .. commanderID .. " wants to build " .. (finalUnitDataToBuild.name or "UnitDataNil") .. " but cannot afford. M: " .. data.resourceInfo.metal .. "/" .. (finalUnitDataToBuild.metalCost or 0) .. ", E: " .. data.resourceInfo.energy .. "/" .. (finalUnitDataToBuild.energyCost or 0))
                                end
                            end
                        else
                             if finalItemToBuildRole or (itemToBuildFromSeq and itemToBuildFromSeq.role and not finalUnitDataToBuild) then 
                                Log(teamID, "Tech 0 ERROR (Periodic): Could not get UnitData to build for role: " .. (finalItemToBuildRole or (itemToBuildFromSeq and itemToBuildFromSeq.role) or "UNKNOWN") .. " (type: ".. (finalItemToBuildType or (itemToBuildFromSeq and itemToBuildFromSeq.type) or "N/A")..")")
                                if isFromSequentialFlag and itemToBuildFromSeq then 
                                   Log(teamID, "Tech 0: Advancing sequential build index due to error finding UnitData for current sequential item.")
                                   data.currentSequentialBuildIndex = data.currentSequentialBuildIndex + 1
                                end
                             elseif buildIndexToUse > #tech0Config.sequentialBuildOrder and allMainRequirementsMet then
                                if frame % 301 == (teamID * 7 + 55) % 301 then 
                                   Log(teamID, "Tech 0 IdleCom (Periodic): All sequential items and all requirements appear to be met. Commander remains idle. Waiting for tech up on next UnitFinished or other logic.")
                                end
                             else
                                if frame % 60 == (teamID * 2 + 3) % 60 then 
                                    Log(teamID, "ULTRALOG IdleCom: No specific item identified to build this cycle. Commander remains idle.")
                                end
                             end
                        end 
                        if commanderState == "idle" and (frame % 15 == (teamID * 1) % 15 or WMRTSAI_Debug_Mode > 1) then 
                            if (finalUnitDataToBuild and finalUnitDataToBuild.id) == nil and commanderConstructorData.state == "idle" then 
                               Log(teamID, "---------------- TECH 0 COMMANDER IDLE END (NO ACTION TAKEN THIS CYCLE) (Frame: " .. frame .. ") ----------------")
                            else
                               Log(teamID, "---------------- TECH 0 COMMANDER IDLE END (ACTION ATTEMPTED/GIVEN) (Frame: " .. frame .. ") ----------------")
                            end
                        end
                    end 
                end 
            end 
        end 
        
        if frame % 301 == (teamID * 7 + 50) % 301 then
             Log(teamID, "Heartbeat - Tech: " .. data.currentTechLevel .. ", State: " .. data.warAIState .. ", M: " .. string.format("%.0f", data.resourceInfo.metal or 0) .. ", E: " .. string.format("%.0f", data.resourceInfo.energy or 0) .. ", SeqBuildIdx: " .. (data.currentSequentialBuildIndex or "N/A"))
             if data.currentTechLevel == 0 and data.commanderUnitID and data.constructors[data.commanderUnitID] then
                Log(teamID, " Commander State: " .. data.constructors[data.commanderUnitID].state)
             end
        end
      end
    end
  end
  
   
   
   
  
 
   function gadget:UnitFinished(unitID, unitDefID, unitTeam)
    -- ULTRALOG: All'inizio assoluto di UnitFinished
    if WMRTSAI_Debug_Mode > 0 then -- Controllo manuale perché Log() usa teamID che potremmo non avere subito
        local teamPrefix = unitTeam and ("WMRTSAI Team[" .. unitTeam .. "] ") or ("WMRTSAI UF: ")
        Spring.Echo(teamPrefix .. "UnitFinished CALLED - UnitID: " .. unitID .. ", DefID: " .. unitDefID .. ", Team: " .. unitTeam)
    end

    if teamData[unitTeam] and teamData[unitTeam].initialized and teamData[unitTeam].factionKey then
        local data = teamData[unitTeam]
        local uDef = UnitDefs[unitDefID]
        Log(unitTeam, "UF LOG 1: Processing UnitFinished for " .. unitID .. " (" .. (uDef and uDef.humanName or "Unknown") .. ")")

        if data.currentTechLevel == 0 and data.commanderUnitID and data.constructors[data.commanderUnitID] then
            Log(unitTeam, "UF LOG 2: In Tech 0, commander data exists.")
            local commanderData_UF = data.constructors[data.commanderUnitID] -- Rinomina per evitare conflitto scope

            if commanderData_UF.state == "busy_building" then
                Log(unitTeam, "UF LOG 3: Commander was busy_building.")
                local task = commanderData_UF.currentTask
                if task and task.buildingDefID == unitDefID then
                    Log(unitTeam, "UF LOG 4: Task matched! Commander finished building " .. (uDef and uDef.humanName or "Unknown") .. " (Role: "..(task.role or "N/A").." / Seq: "..tostring(task.isSequential)..")")
                    
                    commanderData_UF.state = "idle"
                    commanderData_UF.currentTask = nil
                    Log(unitTeam, "UF LOG 5: Commander state set to 'idle', task cleared.")

                    if task.isSequential then
                        Log(unitTeam, "UF LOG 6: Task was sequential.")
                        local tech0Config_UF = techLevels[0] -- Rinomina
                        local buildQueue_UF = tech0Config_UF.sequentialBuildOrder -- Rinomina
                        if data.currentSequentialBuildIndex <= #buildQueue_UF then
                            local expectedItem_UF = buildQueue_UF[data.currentSequentialBuildIndex] -- Rinomina
                            Log(unitTeam, "UF LOG 6.1: Current SeqIdx="..data.currentSequentialBuildIndex..", Expected Role="..(expectedItem_UF and expectedItem_UF.role or "N/A"))
                            if expectedItem_UF and expectedItem_UF.role == task.role then
                                data.currentSequentialBuildIndex = data.currentSequentialBuildIndex + 1
                                Log(unitTeam, "UF LOG 6.2: Advanced sequential build index to: " .. data.currentSequentialBuildIndex)
                            else
                                Log(unitTeam, "UF LOG 6.2 WARN: Task role ".. (task.role or "N/A") .." did NOT match expected sequential role "..(expectedItem_UF and expectedItem_UF.role or "N/A")..". SeqIdx not advanced.")
                            end
                        else
                            Log(unitTeam, "UF LOG 6.1: Sequential build index " .. data.currentSequentialBuildIndex .. " is beyond queue length " .. #buildQueue_UF)
                        end
                    else
                        Log(unitTeam, "UF LOG 6: Task was NOT sequential. SeqIdx not advanced.")
                    end

                    Log(unitTeam, "UF LOG 7: Calling CheckTechRequirements...")
                    if CheckTechRequirements(unitTeam) then
                        Log(unitTeam, "UF LOG 8: CheckTechRequirements returned TRUE.")
                        data.currentTechLevel = 1
                        Log(unitTeam, "----------------------------------------------------")
                        Log(unitTeam, "TECH LEVEL UP! Advanced to Tech Level 1.")
                        Log(unitTeam, "----------------------------------------------------")
                    else
                        Log(unitTeam, "UF LOG 8: CheckTechRequirements returned FALSE.")
                        Log(unitTeam, "Tech 0: Requirements to advance to Tech 1 NOT YET met after building " .. (uDef and uDef.humanName or "Unknown") .. ".")
                    end
                else
                    Log(unitTeam, "UF LOG 4: Task did NOT match, or no task. Commander built UnitDefID " .. unitDefID .. ", but expected " .. (task and task.buildingDefID or "NO_TASK_DefID"))
                end
            else
                 Log(unitTeam, "UF LOG 3: Commander was NOT busy_building. Current state: " .. commanderData_UF.state .. ". (Unit finished: "..(uDef and uDef.humanName or "Unknown")..")")
            end
        else
            if not (data.currentTechLevel == 0) then Log(unitTeam, "UF LOG 2: Not in Tech 0. Current Tech: " .. data.currentTechLevel) end
            if not (data.commanderUnitID) then Log(unitTeam, "UF LOG 2: CommanderUnitID is nil.") end
            if data.commanderUnitID and not data.constructors[data.commanderUnitID] then Log(unitTeam, "UF LOG 2: Commander data in constructors is nil for ID: " .. data.commanderUnitID) end
        end
        Log(unitTeam, "UF LOG 9: UnitFinished processing END for " .. unitID)
    else
        if WMRTSAI_Debug_Mode > 0 then
            local reason = ""
            if not teamData[unitTeam] then reason = "teamData[unitTeam] is nil. " end
            if teamData[unitTeam] and not teamData[unitTeam].initialized then reason = reason .. "data not initialized. " end
            if teamData[unitTeam] and teamData[unitTeam].initialized and not teamData[unitTeam].factionKey then reason = reason .. "factionKey is nil." end
            Spring.Echo("WMRTSAI UF: SKIPPING UnitFinished for Team " .. unitTeam .. ". Reason: " .. reason)
        end
    end
  end

   
      function gadget:UnitIdle(unitID, unitDefID, unitTeam)
    local currentFrame_UnitIdle = Game.frame -- Variabile locale con nome univoco

    if currentFrame_UnitIdle == nil then
        if WMRTSAI_Debug_Mode > 0 then
            Spring.Echo("WMRTSAI UnitIdle CRITICAL: Game.frame is nil! Using fallback frame 0.")
        end
        currentFrame_UnitIdle = 0 
    end

    -- Temporaneamente commentato per debug errore 'arithmetic on nil value'
    -- if WMRTSAI_Debug_Mode > 1 then 
    --      Log(unitTeam, "UnitIdle Event: UnitID " .. unitID .. " (DefID: " .. unitDefID .. 
    --                    ") reported IDLE by Spring at frame " .. currentFrame_UnitIdle)
    -- end

    if not teamData[unitTeam] or 
       not teamData[unitTeam].initialized or 
       not teamData[unitTeam].factionKey then
        return 
    end

    local data = teamData[unitTeam]

    if data.commanderUnitID and unitID == data.commanderUnitID and data.constructors[unitID] then
        local commanderConstructorData = data.constructors[unitID]
        
        -- Temporaneamente commentato
        -- if WMRTSAI_Debug_Mode > 1 then
        --      Log(unitTeam, "UnitIdle - Commander specific. AI Task Role: " .. 
        --                    (commanderConstructorData.currentTask and commanderConstructorData.currentTask.role or "NONE") ..
        --                    ", AI State in teamData: " .. commanderConstructorData.state)
        -- end

        if commanderConstructorData.currentTask then
            if commanderConstructorData.state == "busy_building" then
                -- Temporaneamente commentato
                -- if WMRTSAI_Debug_Mode > 0 and (currentFrame_UnitIdle % 150 == (unitTeam * 5) % 150) then 
                --      Log(unitTeam, "UnitIdle WARN: Commander " .. unitID .. " is 'busy_building' in AI state (Task: "..
                --                  (commanderConstructorData.currentTask.role or "N/A")..") but Spring reports unit as idle. Frame: "..currentFrame_UnitIdle..". Waiting for Timeout/UnitFinished.")
                -- end
                if WMRTSAI_Debug_Mode > 0 then -- Log non condizionato da modulo
                     Log(unitTeam, "UnitIdle INFO (Com Tasked & Busy): Commander " .. unitID .. " (Task: ".. (commanderConstructorData.currentTask.role or "N/A") .. ") reported idle by Spring. Frame: "..currentFrame_UnitIdle)
                end
            end
        else 
            if commanderConstructorData.state ~= "idle" then
                Log(unitTeam, "UnitIdle: Commander " .. unitID .. 
                               " became IDLE (no current AI task). Previous state in teamData: " .. 
                               commanderConstructorData.state .. ". Resetting to idle in teamData. Frame: " .. currentFrame_UnitIdle)
                commanderConstructorData.state = "idle"
                commanderConstructorData.buildStartTime = nil 
                commanderConstructorData.buildAttempts = 0
            end
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