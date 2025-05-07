--------------------------------------------------------------------------------
-- War Machines RTS - AI Gadget (v0.8 - Robust CMDs, No Gotos)
-- Nome AI: WMRTSAI
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "WMRTSAI",
    desc      = "AI con gestione fazioni, tiers, tipi mappa e config per tech (v0.8).",
    author    = "Il Tuo Nome",
    date      = "Data Corrente",
    license   = "La Tua Licenza",
    layer     = 90,
    enabled   = true
  }
end

-- Variabili globali
local gameStarted = false
local teamData = {}
local KPAI_Debug_Mode = 1

--------------------------------------------------------------------------------
-- SYNCED CODE
--------------------------------------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then

  local Spring = Spring
  local Game = Game
  -- CMD globale, potrebbe essere nil all'inizio in v100, quindi la usiamo con cautela
  local CMD = Command
  local UnitDefs = UnitDefs
  local UnitDefNames = UnitDefNames
  local LOG_SECTION = "WMRTSAI"

  local function Log(teamID, message)
    if KPAI_Debug_Mode > 0 then
      local teamPrefix = teamID and ("Team[" .. teamID .. "] ") or (LOG_SECTION .. ": ")
      Spring.Echo(teamPrefix .. message)
    end
  end

  -- === 1. DEFINIZIONE FAZIONI E UNITÀ PER TIER ===
  local factionUnits = {
      ICU = {
          commander = "icucom",
          T1 = {
              extractor =   { name = "icumetex", moveType="BUILDING", role="Extractor_T1"},
              powerPlant =  { name = "armsolar", moveType="BUILDING", role="Power_T1"},
              factory =     { name = "armlab", moveType = "BUILDING", role="Factory_Land_T1"},
              constructor = { name = "icuck", moveType = "LAND", role="Constructor_T1" },
              attackers = { { name = "icupatroller", moveType = "LAND", role="Basic_T1" }, },
              defenses = { { name = "iculighlturr", moveType = "BUILDING", role="Light_T1" }, }
          },
          T2 = {
              extractor =   { name = "armamex", moveType="BUILDING", role="Extractor_T2"},
              powerPlant =  { name = "armfus", moveType="BUILDING", role="Power_T2"},
              factory =     { name = "armalab", moveType = "BUILDING", role="Factory_Land_T2" },
              constructor = { name = "armack", moveType = "LAND", role="Constructor_T2" },
              attackers = { { name = "armfboy", moveType = "LAND", role="Heavy_T2" }, },
              defenses = { { name = "armhlt", moveType = "BUILDING", role="Heavy_T2" } }
          },
          T3 = {
              factory =     { name = "armshltx", moveType = "BUILDING", role="Factory_Land_T3" },
              attackers = { { name = "armshock", moveType = "LAND", role="Experimental_T3" }, },
              defenses = { { name = "armanni", moveType = "BUILDING", role="Experimental_T3" } }
          },
          _unitDefIDs = {}
      },
      NFA = { commander = "nfacom", T1 = { extractor = { name = "nfa_mex_t1", moveType="BUILDING", role="Extractor_T1" }, powerPlant = { name="nfa_pow_t1", moveType="BUILDING", role="Power_T1" }, factory = {name="nfa_factory_t1", moveType="BUILDING", role="Factory_Land_T1"}, constructor = {name="nfa_con_t1", moveType="LAND", role="Constructor_T1"}, attackers = {{name="nfa_attacker_t1", moveType="LAND", role="Basic_T1"}}, defenses = {{name="nfa_defense_t1", moveType="BUILDING", role="Light_T1"}} }, T2 = { extractor = { name = "nfa_mex_t2", moveType="BUILDING", role="Extractor_T2" }, powerPlant = { name="nfa_pow_t2", moveType="BUILDING", role="Power_T2" }, factory = {name="nfa_factory_t2", moveType="BUILDING", role="Factory_Land_T2"}, constructor = {name="nfa_con_t2", moveType="LAND", role="Constructor_T2"}, attackers = {{name="nfa_attacker_t2", moveType="LAND", role="Heavy_T2"}}, defenses = {{name="nfa_defense_t2", moveType="BUILDING", role="Heavy_T2"}} }, T3 = { factory = {name="nfa_factory_t3", moveType="BUILDING", role="Factory_Land_T3"}, constructor = {name="nfa_con_t3", moveType="LAND", role="Constructor_T3"}, attackers = {{name="nfa_attacker_t3", moveType="LAND", role="Experimental_T3"}}, defenses = {{name="nfa_defense_t3", moveType="BUILDING", role="Experimental_T3"}} }, _unitDefIDs = {} },
      AND = { commander = "andcom", T1 = { extractor = { name = "and_mex_t1", moveType="BUILDING", role="Extractor_T1" }, powerPlant = { name="and_pow_t1", moveType="BUILDING", role="Power_T1" }, factory = {name="and_factory_t1", moveType="BUILDING", role="Factory_Land_T1"}, constructor = {name="and_con_t1", moveType="LAND", role="Constructor_T1"}, attackers = {{name="and_attacker_t1", moveType="LAND", role="Basic_T1"}}, defenses = {{name="and_defense_t1", moveType="BUILDING", role="Light_T1"}} }, T2 = { extractor = { name = "and_mex_t2", moveType="BUILDING", role="Extractor_T2" }, powerPlant = { name="and_pow_t2", moveType="BUILDING", role="Power_T2" }, factory = {name="and_factory_t2", moveType="BUILDING", role="Factory_Land_T2"}, constructor = {name="and_con_t2", moveType="LAND", role="Constructor_T2"}, attackers = {{name="and_attacker_t2", moveType="LAND", role="Heavy_T2"}}, defenses = {{name="and_defense_t2", moveType="BUILDING", role="Heavy_T2"}} }, T3 = { factory = {name="and_factory_t3", moveType="BUILDING", role="Factory_Land_T3"}, constructor = {name="and_con_t3", moveType="LAND", role="Constructor_T3"}, attackers = {{name="and_attacker_t3", moveType="LAND", role="Experimental_T3"}}, defenses = {{name="and_defense_t3", moveType="BUILDING", role="Experimental_T3"}} }, _unitDefIDs = {} },
      EUF = { commander = "eufcd", T1 = { extractor = { name = "euf_mex_t1", moveType="BUILDING", role="Extractor_T1" }, powerPlant = { name="euf_pow_t1", moveType="BUILDING", role="Power_T1" }, factory = {name="euf_factory_t1", moveType="BUILDING", role="Factory_Land_T1"}, constructor = {name="euf_con_t1", moveType="LAND", role="Constructor_T1"}, attackers = {{name="euf_attacker_t1", moveType="LAND", role="Basic_T1"}}, defenses = {{name="euf_defense_t1", moveType="BUILDING", role="Light_T1"}} }, T2 = { extractor = { name = "euf_mex_t2", moveType="BUILDING", role="Extractor_T2" }, powerPlant = { name="euf_pow_t2", moveType="BUILDING", role="Power_T2" }, factory = {name="euf_factory_t2", moveType="BUILDING", role="Factory_Land_T2"}, constructor = {name="euf_con_t2", moveType="LAND", role="Constructor_T2"}, attackers = {{name="euf_attacker_t2", moveType="LAND", role="Heavy_T2"}}, defenses = {{name="euf_defense_t2", moveType="BUILDING", role="Heavy_T2"}} }, T3 = { factory = {name="euf_factory_t3", moveType="BUILDING", role="Factory_Land_T3"}, constructor = {name="euf_con_t3", moveType="LAND", role="Constructor_T3"}, attackers = {{name="euf_attacker_t3", moveType="LAND", role="Experimental_T3"}}, defenses = {{name="euf_defense_t3", moveType="BUILDING", role="Experimental_T3"}} }, _unitDefIDs = {} },
  }

  local commanderFactionMap = { icucom = "ICU", nfacom = "NFA", andcom = "AND", eufcd  = "EUF" }

  local function PopulateUnitDefIDs(dataTable, idTable)
      for key, value in pairs(dataTable) do
          if type(value) == "table" then
              if value.name and value.moveType then
                  local unitDef = UnitDefNames[value.name]
                  if unitDef then idTable[key] = {}; for k,v in pairs(value) do idTable[key][k]=v end; idTable[key].id = unitDef.id
                  else Log(nil, "ERROR: UD name '" .. value.name .. "' not found for key '" .. key .. "'!"); idTable[key] = nil end
              elseif key == "attackers" or key == "defenses" then
                  idTable[key] = {}
                  for i, unitData in ipairs(value) do
                      if unitData.name and unitData.moveType then
                          local unitDef = UnitDefNames[unitData.name]
                          if unitDef then local newItem = {}; for k,v in pairs(unitData) do newItem[k]=v end; newItem.id = unitDef.id; table.insert(idTable[key], newItem)
                          else Log(nil, "ERROR: UD name '" .. unitData.name .. "' not found in list '" .. key .. "'!") end
                      end
                  end
              elseif key ~= "_unitDefIDs" then
                  if not idTable[key] then idTable[key] = {} end
                  PopulateUnitDefIDs(value, idTable[key])
              end
          end
      end
  end

  local mapCategories = { ["zoty outpost"] = "LAND", ["another_map"] = "NAVAL_ISLANDS", }
  local currentMapCategory = "LAND"

  local aiConfig = {
      [0] = { economyTargets = {{ role = "T1_Extractor", min = 2, max = 3 },{ role = "T1_PowerPlant", min = 2, max = 4 },}, factoryTargets = { minTotal = 1, maxTotal = 1, targetTier = 1 }, productionList = { }, attackGroup = { min = 8, max = 12, target = "PATROL_NEARBY" }},
      [1] = { economyTargets = {{ role = "T1_Extractor", min = 4, max = 6 },{ role = "T1_PowerPlant", min = 5, max = 8 },}, factoryTargets = { minTotal = 2, maxTotal = 3, targetTier = 1 }, productionList = {{ role = "T1_Constructor", priority = 100, max = 3 },{ role = "T1_Attacker_Basic", priority = 80, max = 0 },}, attackGroup = { min = 8, max = 12, target = "ATTACK_ENEMY_BASE" }},
      [2] = { economyTargets = {{ role = "T1_Extractor", min = 6, max = 8 },{ role = "T1_PowerPlant", min = 8, max = 12 },{ role = "T2_Extractor", min = 3, max = 5 },{ role = "T2_PowerPlant", min = 4, max = 6 },}, factoryTargets = { minTotal = 3, maxTotal = 5, targetTier = 2 }, productionList = {{ role = "T2_Constructor", priority = 100, max = 2 },{ role = "T2_Attacker_Heavy", priority = 80, max = 0 },{ role = "T1_Attacker_Basic", priority = 60, max = 0 },}, attackGroup = { min = 10, max = 15, target = "ATTACK_ENEMY_BASE" }},
      [3] = { economyTargets = {{ role = "T2_Extractor", min = 5, max = 8 },{ role = "T2_PowerPlant", min = 6, max = 10 },}, factoryTargets = { minTotal=4, maxTotal=7, targetTier=3 }, productionList = {{ role = "T3_Attacker_Experimental", priority = 90, max = 3 },{ role = "T2_Attacker_Heavy", priority = 70, max = 0 },}, attackGroup = { min = 12, max = 20, target = "ATTACK_ENEMY_BASE_PRIORITY" }}
  }

  function GetUnitDataByRole(faction, tier, role)
      local factionData = factionUnits[faction]; if not factionData then return nil end
      local fDefs = factionData._unitDefIDs; if not fDefs then return nil end
      local roleTier = tonumber(role:match("^T(%d+)")) or 0; if roleTier == 0 then return nil end
      local tierKey = "T" .. roleTier; local tDefs = fDefs[tierKey]; if not tDefs then return nil end
      if role == tierKey .. "_Constructor" then return tDefs.constructor
      elseif role == tierKey .. "_Factory" then return tDefs.factory
      elseif role == tierKey .. "_Extractor" then return tDefs.extractor
      elseif role == tierKey .. "_PowerPlant" then return tDefs.powerPlant
      elseif role:find(tierKey .. "_Attacker") then
          if not tDefs.attackers or #tDefs.attackers == 0 then return nil end
          if role == tierKey .. "_Attacker_Basic" then return tDefs.attackers[1]
          elseif role == tierKey .. "_Attacker_Heavy" then return tDefs.attackers[1]
          elseif role == tierKey .. "_Attacker_Support" then return #tDefs.attackers >= 2 and tDefs.attackers[2] or nil
          elseif role == tierKey .. "_Attacker_Experimental" then return tDefs.attackers[1]
          else return tDefs.attackers[1] end
      elseif role:find(tierKey .. "_Defense") then
           if not tDefs.defenses or #tDefs.defenses == 0 then return nil end
           if role == tierKey .. "_Defense_Light" then return tDefs.defenses[1]
           elseif role == tierKey .. "_Defense_Heavy" then return #tDefs.defenses >= 2 and tDefs.defenses[2] or nil
           else return tDefs.defenses[1] end
      end
      return nil
  end

  -- Trova posizione Metallo - Usa WG.metalSpots o GameRules
  function FindBestMetalSpotForTeam(teamData, builderID)
      local bx, by, bz = Spring.GetUnitPosition(builderID)
      if not bx then Log(teamData.teamID, "FindBestMetalSpot: Builder position not found."); return nil end

      local bestSpot = nil
      local minDistSq = math.huge
      local mexDefData = GetUnitDataByRole(teamData.faction, 1, "T1_Extractor")
      if not mexDefData then Log(teamData.teamID,"FindBestMetalSpot: Cannot find T1_Extractor definition!"); return nil end
      local mexDefID = mexDefData.id

      local metalSpotsToSearch = {}

      -- Prova prima con WG.metalSpots se disponibile
      if _G["WG"] and _G["WG"].metalSpots then
          -- Log(teamData.teamID, "FindBestMetalSpot: Using WG.metalSpots")
          for _, spot in ipairs(_G["WG"].metalSpots) do
              table.insert(metalSpotsToSearch, {x = spot.x, y = spot.y or Spring.GetGroundHeight(spot.x, spot.z), z = spot.z})
          end
      else -- Altrimenti, leggi dalle GameRules
          -- Log(teamData.teamID, "FindBestMetalSpot: WG.metalSpots not found, trying GameRules.")
          local mexCount = Spring.GetGameRulesParam("mex_count")
          if mexCount and mexCount > 0 then
              for i = 1, mexCount do
                   local spotX = Spring.GetGameRulesParam("mex_x" .. i)
                   local spotY = Spring.GetGameRulesParam("mex_y" .. i)
                   local spotZ = Spring.GetGameRulesParam("mex_z" .. i)
                   if spotX and spotY and spotZ then
                       table.insert(metalSpotsToSearch, {x=spotX, y=spotY, z=spotZ})
                   else
                       Log(teamData.teamID, "FindBestMetalSpot: Warning - Got nil coordinate reading GameRules for mex index " .. i)
                   end
              end
          else
              Log(teamData.teamID, "FindBestMetalSpot: Could not find 'mex_count' or it was 0 in GameRules, and WG.metalSpots not found.")
              return nil -- Nessuna fonte di punti metallo
          end
      end

      -- Log(teamData.teamID, "FindBestMetalSpot: Checking " .. #metalSpotsToSearch .. " potential metal spots.")

      if #metalSpotsToSearch > 0 then
          for _, spot in ipairs(metalSpotsToSearch) do
               local spotX = spot.x
               local spotY = spot.y -- y è già stato calcolato o preso
               local spotZ = spot.z

               local unitsNear = Spring.GetUnitsInRectangle(spotX-10, spotZ-10, spotX+10, spotZ+10)
               local occupied = false
               if unitsNear then
                   for _, nearID in ipairs(unitsNear) do
                       local nearDef = UnitDefs[Spring.GetUnitDefID(nearID)]
                       if nearDef and nearDef.extractsMetal and nearDef.extractsMetal > 0 then
                           occupied = true
                           break
                       end
                   end
               end

               if not occupied then
                  local buildResult = Spring.TestBuildOrder(mexDefID, spotX, spotY, spotZ, 1)
                  if buildResult == 0 or buildResult == 2 then
                      local dx, dz = spotX - bx, spotZ - bz
                      local distSq = dx*dx + dz*dz
                      if distSq < minDistSq then
                          minDistSq = distSq
                          bestSpot = {x=spotX, y=spotY, z=spotZ}
                      end
                  -- else Log(teamData.teamID, "Spot at "..string.format("%.0f,%.0f",spotX,spotZ).." not buildable, code: "..buildResult)
                  end
               -- else Log(teamData.teamID, "Spot at "..string.format("%.0f,%.0f",spotX,spotZ).." occupied.")
               end
          -- NESSUN 'else' QUI CHE RICHIEDEVA UN END, IL CICLO CONTINUA
          end -- <<<<<<<<<<< QUESTO 'end' CHIUDE 'for _, spot in ipairs(metalSpotsToSearch) do'
      end -- <<<<<<<<<<< QUESTO 'end' CHIUDE 'if #metalSpotsToSearch > 0 then'


      if bestSpot then Log(teamData.teamID,"Found best metal spot at " .. string.format("%.0f,%.0f", bestSpot.x, bestSpot.z))
      else Log(teamData.teamID,"FindBestMetalSpot: No suitable metal spot found.") end
      return bestSpot
  end -- <<<<<<<<<<< QUESTO 'end' CHIUDE 'function FindBestMetalSpotForTeam'

  function FindGoodEnergySpotForTeam(teamData, builderID)
      local bx, _, bz = Spring.GetUnitPosition(builderID); if not bx then return nil end
      local powDefData = GetUnitDataByRole(teamData.faction, 1, "T1_PowerPlant"); if not powDefData then Log(teamData.teamID,"FindGoodEnergySpot: Cannot find T1_PowerPlant definition!"); return nil end
      local powDefID = powDefData.id
      local minDistanceToMetalSpotSq = (Game.extractorRadius or 32) * (Game.extractorRadius or 32) * 2.25
      local metalSpots = {}
      local mexCount = Spring.GetGameRulesParam("mex_count")
      if mexCount and mexCount > 0 then for i=1,mexCount do local sx=Spring.GetGameRulesParam("mex_x"..i); local sz=Spring.GetGameRulesParam("mex_z"..i); if sx and sz then table.insert(metalSpots,{x=sx,z=sz})end end end

      for i=1, 30 do
          local a = math.random()*2*math.pi; local d = 80+math.random(150); local tx,tz = bx+math.cos(a)*d, bz+math.sin(a)*d; local ty = Spring.GetGroundHeight(tx,tz)
          if ty then local tooClose=false; for _,ms in ipairs(metalSpots)do local dxm=tx-ms.x; local dzm=tz-ms.z; if(dxm*dxm+dzm*dzm)<minDistanceToMetalSpotSq then tooClose=true;break end end
          if not tooClose then local br = Spring.TestBuildOrder(powDefID, tx,ty,tz, 1); if br == 0 or br == 2 then return {x=tx,y=ty,z=tz} end end end
      end; -- Log(teamData.teamID,"FindGoodEnergySpot: Could not find suitable (non-metal) spot.");
      return nil
  end

  function FindGoodFactoryPosForTeam(teamData, builderID)
      local bx, _, bz = Spring.GetUnitPosition(builderID); if not bx then return nil end
      local tTier = teamData.techLevel + 1; if tTier > 3 then tTier = 3 end
      local facDefData = GetUnitDataByRole(teamData.faction, tTier, "T"..tTier.."_Factory"); if not facDefData then Log(teamData.teamID,"FindGoodFactoryPos: Cannot find Factory T"..tTier.." definition!"); return nil end
      local facDefID = facDefData.id
      local minDistanceToMetalSpotSq = (Game.extractorRadius or 32) * (Game.extractorRadius or 32) * 2.25
      local metalSpots = {}
      local mexCount = Spring.GetGameRulesParam("mex_count")
      if mexCount and mexCount > 0 then for i=1,mexCount do local sx=Spring.GetGameRulesParam("mex_x"..i); local sz=Spring.GetGameRulesParam("mex_z"..i); if sx and sz then table.insert(metalSpots,{x=sx,z=sz})end end end

      for i=1, 30 do
          local a = math.random()*2*math.pi; local d = 150+math.random(150); local tx,tz = bx+math.cos(a)*d, bz+math.sin(a)*d; local ty = Spring.GetGroundHeight(tx,tz)
          if ty then local tooClose=false; for _,ms in ipairs(metalSpots)do local dxm=tx-ms.x; local dzm=tz-ms.z; if(dxm*dxm+dzm*dzm)<minDistanceToMetalSpotSq then tooClose=true;break end end
          if not tooClose then local br = Spring.TestBuildOrder(facDefID, tx,ty,tz, 1); if br == 0 or br == 2 then return {x=tx,y=ty,z=tz} end end end
      end; -- Log(teamData.teamID,"FindGoodFactoryPos: Could not find suitable (non-metal) spot.");
      return nil
  end

  local function CheckTeamCommander(teamID)
      if not teamData[teamID] or teamData[teamID].faction then return end; local teamUnits = Spring.GetTeamUnits(teamID); if not teamUnits then return end
      for _, unitID in ipairs(teamUnits) do local udID = Spring.GetUnitDefID(unitID); if udID then local uDef = UnitDefs[udID]; if uDef then local cnl = uDef.name:lower(); local fac = commanderFactionMap[cnl]
      if fac then Log(teamID,"Found Commander: "..uDef.name:upper().." - Faction: "..fac); teamData[teamID].faction=fac; teamData[teamID].commanderInfo={name=uDef.name:upper(),id=unitID,defID=udID}; local mt=UnitDefs[udID].movedata and UnitDefs[udID].movedata.moveType or "UNKNOWN"; teamData[teamID].constructors[unitID]={tier=0,state="idle",task=nil,moveType=mt}; return end end end end
      if not teamData[teamID].faction and Game.frame>90 then Log(teamID,"WARNING: No commander found after 3s!"); teamData[teamID].faction="UNKNOWN" end
  end

  local function ManageTechLevel(teamID, frame)
      local data=teamData[teamID]; if not data or not data.faction or data.faction=="UNKNOWN" or data.techLevel==nil or not data.resourceInfo then return end
      local cl=data.techLevel; local res=data.resourceInfo
      local thresholds={[1]={metal=500,energy=800,prereq=function() return true end},[2]={metal=2000,energy=4000,prereq=function()return data:HasFactoryOfTier(1)end},[3]={metal=8000,energy=15000,prereq=function()return data:HasFactoryOfTier(2)end}}
      local nl=cl+1; if thresholds[nl] and cl<3 then local tgt=thresholds[nl]; local pMet,_=pcall(tgt.prereq); local rMet=false
      if pMet and _ then if type(res.metal)=="number" and type(res.energy)=="number" and res.metal>=tgt.metal and res.energy>=tgt.energy then rMet=true end end
      if pMet and _ and rMet then data.techLevel=nl; Log(teamID,"Advanced to Tech Level "..nl.."!"); data.economyObjectives={}; Log(teamID,"Economy objectives reset for new tech level.") end end
  end

  function TeamHasFactoryOfTier(teamData, tier)
      local fac=teamData.faction; if not fac or fac=="UNKNOWN" then return false end
      local facData=GetUnitDataByRole(fac,tier,"T"..tier.."_Factory"); if not facData then return false end
      local facs=Spring.GetTeamUnitsByDefs(teamData.teamID,facData.id); return(facs and #facs>0)
  end

  local function UpdateResourceInfo(teamID, frame)
      local data=teamData[teamID]; if not data then return end
      if frame-(data.resourceInfo.lastUpdateFrame or -100)>30 then data.resourceInfo.metal,data.resourceInfo.energy=Spring.GetTeamResources(teamID,"metal","energy")
      local mIOk,mI=pcall(Spring.GetTeamResourceIncome,teamID,"metal"); local mUOk,mU=pcall(Spring.GetTeamResourceUsage,teamID,"metal")
      local eIOk,eI=pcall(Spring.GetTeamResourceIncome,teamID,"energy"); local eUOk,eU=pcall(Spring.GetTeamResourceUsage,teamID,"energy")
      data.resourceInfo.metalIncome=(mIOk and mI)or 0; data.resourceInfo.metalUsage=(mUOk and mU)or 0
      data.resourceInfo.energyIncome=(eIOk and eI)or 0; data.resourceInfo.energyUsage=(eUOk and eU)or 0
      data.resourceInfo.lastUpdateFrame=frame end
  end

  function CanAffordUnit(teamData, unitDefID, frame) -- v8
      if not unitDefID then return false end; local uDef=UnitDefs[unitDefID]; if not uDef then return false end
      if type(frame)~="number" then Log(teamData.teamID or "?","CanAfford ERROR: invalid frame: "..tostring(frame)); return false end
      local cM=uDef.metalCost or 0; local cE=uDef.energyCost or 0; local mE=uDef.energyUpkeep or 0; local mkE=uDef.energyMake or 0
      local res=teamData.resourceInfo; if type(res.metal)~="number" or type(res.energy)~="number" then return false end
      local buf=50; local hS=(res.metal>=cM+buf and res.energy>=cE+buf); if not hS then return false end
      local isT1Eco=false; local t1Ex=GetUnitDataByRole(teamData.faction,1,"T1_Extractor"); local t1Po=GetUnitDataByRole(teamData.faction,1,"T1_PowerPlant")
      if(t1Ex and unitDefID==t1Ex.id)or(t1Po and unitDefID==t1Po.id)then isT1Eco=true end
      if teamData.techLevel==0 and isT1Eco then return true end
      if teamData.techLevel>=1 or not isT1Eco then local cEI=res.energyIncome or 0; local cEU=res.energyUsage or 0; local fEB=cEI-cEU-mE
      if fEB<0 then if mkE>0 then else local iSN=cEI>cEU; local hLES=res.energy>cE*1.5; if not(iSN or hLES)then return false end end end end
      return true
  end

  -- ManageEconomy con logica Priorità Energia e Obiettivi Random (v2)
  local function ManageEconomy(teamID, frame)
      local data = teamData[teamID]
      if not data or data.techLevel == nil then return end
      local config = aiConfig[data.techLevel]
      if not config or not config.economyTargets then return end

      local res = data.resourceInfo
      local currentEnergyIncome = res.energyIncome or 0
      local currentEnergyUsage = res.energyUsage or 0
      local energyBalance = currentEnergyIncome - currentEnergyUsage
      local desiredEnergySurplus = 15
      local prioritizeEnergy = (energyBalance < desiredEnergySurplus)
      local orderGivenThisFrame = false

      if prioritizeEnergy then
          -- Log(teamID, "Prioritizing Energy (Balance: "..string.format("%.1f", energyBalance).." < "..desiredEnergySurplus..", Tech: "..data.techLevel..")")
          local targetPowerRole = (data.techLevel >= 2 and GetUnitDataByRole(data.faction, 2, "T2_PowerPlant") and "T2_PowerPlant") or "T1_PowerPlant"
          -- Log(teamID, "Prioritizing -> Target Power Role: " .. targetPowerRole)
          local powerTargetConfig = nil
          for _, target in ipairs(config.economyTargets) do if target.role == targetPowerRole then powerTargetConfig = target; break end end

          if powerTargetConfig then
              local roleTier = tonumber(targetPowerRole:match("^T(%d+)")) or 1
              local unitData = GetUnitDataByRole(data.faction, roleTier, targetPowerRole)
              if unitData then
                  local unitDefID = unitData.id; local unitDef = UnitDefs[unitDefID]
                  if unitDef then
                      if not data.economyObjectives[targetPowerRole] then data.economyObjectives[targetPowerRole] = { targetCount = math.random(powerTargetConfig.min, powerTargetConfig.max), reached = false }; Log(teamID,"New Eco Obj for "..targetPowerRole..": Build "..data.economyObjectives[targetPowerRole].targetCount) end
                      local currentObjective = data.economyObjectives[targetPowerRole]
                      local currentCount = #Spring.GetTeamUnitsByDefs(teamID, unitDefID)
                      if currentCount < currentObjective.targetCount then
                          if data:CanAfford(unitDefID, frame) then
                              local requiredBuilderTier = math.max(0, roleTier - 1)
                              local builderID = data:FindIdleConstructor(requiredBuilderTier)
                              if builderID then
                                  local buildPos = data:FindGoodEnergySpot(builderID)
                                  if buildPos then Log(teamID, ">>>>>> Ordering T"..requiredBuilderTier.." builder "..builderID.." to build "..targetPowerRole.." #"..(currentCount+1).."/"..currentObjective.targetCount..(prioritizeEnergy and " (PRIORITY)" or "")); Spring.GiveOrderToUnit(builderID, -unitDefID, { buildPos.x, buildPos.y, buildPos.z }, {}); if data.constructors[builderID] then data.constructors[builderID].state = "busy" end; orderGivenThisFrame = true end
                              end
                          end
                      elseif currentCount >= currentObjective.targetCount and not currentObjective.reached then currentObjective.reached = true end
                  end
              end
          end
          if orderGivenThisFrame then return end -- Se ho costruito energia in priorità, esco
      end

      -- Se NON abbiamo dato un ordine per l'energia O l'energia non era prioritaria, controlla ALTRI obiettivi
      if not orderGivenThisFrame then
          for i, targetConfig in ipairs(config.economyTargets) do
              if not targetConfig.role:find("PowerPlant") then -- Salta centrali, già gestite se prioritarie
                  local role = targetConfig.role
                  local minCount = targetConfig.min; local maxCount = targetConfig.max
                  if not data.economyObjectives[role] then local targetNum = math.random(minCount, maxCount); data.economyObjectives[role] = { targetCount = targetNum, reached = false }; Log(teamID, "New Economy Objective for " .. role .. ": Build " .. targetNum) end
                  local currentObjective = data.economyObjectives[role]
                  if not currentObjective.reached then
                      local roleTier = tonumber(role:match("^T(%d+)")) or 1
                      local unitData = GetUnitDataByRole(data.faction, roleTier, role)
                      if unitData then
                          local unitDefID = unitData.id; local unitDef = UnitDefs[unitDefID]
                          if unitDef then
                              local currentCount = #Spring.GetTeamUnitsByDefs(teamID, unitDefID)
                              if currentCount < currentObjective.targetCount then
                                  if data:CanAfford(unitDefID, frame) then
                                      local builderTier = math.max(0, roleTier - 1)
                                      local builderID = data:FindIdleConstructor(builderTier)
                                      if builderID then
                                          local buildPos = nil; if role:find("Extractor") then buildPos = data:FindBestMetalSpot(builderID) end
                                          if buildPos then Log(teamID, ">>>>>> Ordering builder "..builderID.." to build "..role.." #"..(currentCount+1).."/"..currentObjective.targetCount); Spring.GiveOrderToUnit(builderID, -unitDefID, { buildPos.x, buildPos.y, buildPos.z }, {}); if data.constructors[builderID] then data.constructors[builderID].state = "busy" end; return end
                                      end
                                  end
                              elseif currentCount >= currentObjective.targetCount then currentObjective.reached = true end
                          end
                      end
                  end
              end
          end
      end
  end -- Fine ManageEconomy

  -- ManageProduction
  local function ManageProduction(teamID, frame)
      local data=teamData[teamID]; if not data or not data.faction or data.faction=="UNKNOWN" or data.techLevel==nil then return end; local cfg=aiConfig[data.techLevel]; if not cfg then return end
      local fac=data.faction; local tl=data.techLevel; local aMT={}; if currentMapCategory=="LAND"then aMT={LAND=true,AIR=true,VEHICLE=true,BUILDING=true}elseif currentMapCategory=="NAVAL_ISLANDS"then aMT={NAVAL=true,AIR=true,BUILDING=true}elseif currentMapCategory=="SPACE"then aMT={AIR=true,SPACE=true,BUILDING=true}elseif currentMapCategory=="NAVAL_PURE"then aMT={NAVAL=true,BUILDING=true}end
      if cfg.factoryTargets then local tF=0; for tier=1,tl+1 do local fcD=GetUnitDataByRole(fac,tier,"T"..tier.."_Factory"); if fcD then tF=tF+#Spring.GetTeamUnitsByDefs(teamID,fcD.id)end end
      if tF<cfg.factoryTargets.minTotal then local tT=cfg.factoryTargets.targetTier; local fcDt=GetUnitDataByRole(fac,tT,"T"..tT.."_Factory")
      if fcDt and aMT[fcDt.moveType]then if data:CanAfford(fcDt.id,frame)then local bID=data:FindIdleConstructor(tT-1)
      if bID then local bPos=data:FindGoodFactoryPos(bID); if bPos then Log(teamID,"Ordering T"..(tT-1).." builder "..bID.." to build T"..tT.." factory ("..fcDt.name..") at "..string.format("%.0f,%.0f",bPos.x,bPos.z)); Spring.GiveOrderToUnit(bID,-fcDt.id,{bPos.x,bPos.y,bPos.z},{}); if data.constructors[bID]then data.constructors[bID].state="busy"end; return end end end end end end
      if cfg.productionList then local sPL={}; for _,it in ipairs(cfg.productionList)do table.insert(sPL,it)end; table.sort(sPL,function(a,b)return a.priority>b.priority end)
      for ft=1,tl do local fcDt=GetUnitDataByRole(fac,ft,"T"..ft.."_Factory")
      if fcDt then local facs=Spring.GetTeamUnitsByDefs(teamID,fcDt.id)
      if facs then for _,fID in ipairs(facs)do local oGTTF=false; local q=Spring.GetFactoryCommands(fID)
      if not q or #q<3 then for _,pI in ipairs(sPL)do local uT=tonumber(pI.role:match("T(%d+)"))or 0
      if uT<=ft then local uDt=GetUnitDataByRole(fac,uT,pI.role)
      if uDt and aMT[uDt.moveType]then local uDID=uDt.id; local cCt=#Spring.GetTeamUnitsByDefs(teamID,uDID); local mCt=pI.max; local bTh=false
      if pI.role:find("Constructor")then if data:NeedsConstructor(uT)then bTh=true end elseif mCt==0 or cCt<mCt then bTh=true end
      if bTh and data:CanAfford(uDID,frame)then Log(teamID,"Ordering T"..ft.." factory "..fID.." to build "..pI.role.." (DefID "..uDID..")"); Spring.GiveOrderToUnit(fID,-uDID,{},{}); oGTTF=true; break end end end end end end end end end end end
  end

  -- ManageMilitary con correzione CMD
  local function ManageMilitary(teamID, frame)
      local data=teamData[teamID]; if not data or data.techLevel==nil then Log(teamID, "ManageMilitary: Skipping - No data or techLevel"); return end
      Log(teamID,"ManageMilitary: Checking TechLevel = "..tostring(data.techLevel)..", Type: "..type(data.techLevel))
      local cfg=aiConfig[data.techLevel]; if not cfg or not cfg.attackGroup then Log(teamID,"ManageMilitary: Skipping - No config or attackGroup for T"..tostring(data.techLevel)); return end

      local aMT={}; if currentMapCategory=="LAND"then aMT={LAND=true,AIR=true,VEHICLE=true}elseif currentMapCategory=="NAVAL_ISLANDS"then aMT={NAVAL=true,AIR=true}elseif currentMapCategory=="SPACE"then aMT={AIR=true,SPACE=true}elseif currentMapCategory=="NAVAL_PURE"then aMT={NAVAL=true}end
      local iCU={}; local iCnt=0; for uID,uDt in pairs(data.combatUnits)do if Spring.ValidUnitID(uID)and uDt.state=="idle"and aMT[uDt.moveType]then local cmds=Spring.GetUnitCommands(uID); if not cmds or #cmds==0 then table.insert(iCU,uID);iCnt=iCnt+1 end end end
      -- Log(teamID,"ManageMilitary: Found "..iCnt.." idle combat units suitable for map.")
      if iCnt>=cfg.attackGroup.min then -- Log(teamID,"ManageMilitary: Idle count("..iCnt..") >= min("..cfg.attackGroup.min.."). Forming group.");
      local gS=math.min(iCnt,cfg.attackGroup.max); local aG={}; for i=1,gS do local uID=table.remove(iCU,1);table.insert(aG,uID)end
      -- Log(teamID,"ManageMilitary DEBUG: Before accessing target - Type of config: "..type(cfg).." | config.attackGroup exists: "..tostring(cfg.attackGroup~=nil)); if type(cfg)=="table"and cfg.attackGroup then Log(teamID,"ManageMilitary DEBUG: cfg.attackGroup.target value: "..tostring(cfg.attackGroup.target))end
      local tT=cfg.attackGroup.target or"ATTACK_ENEMY_BASE"; local eTID=nil; local gTID=Spring.GetGaiaTeamID(); local aTs=Spring.GetTeamList(); local pE={}; if aTs then for _,oTID in ipairs(aTs)do if oTID~=teamID and oTID~=gTID and not Spring.AreTeamsAllied(teamID,oTID)then if Spring.GetTeamUnitCount(oTID)>0 then table.insert(pE,oTID)end end end end; if #pE>0 then eTID=pE[math.random(#pE)]end
      -- Log(teamID,"ManageMilitary DEBUG: Found enemy target: "..tostring(eTID));
      local tPos=nil; local oIss=false
      if eTID and(tT=="ATTACK_ENEMY_BASE"or tT=="ATTACK_ENEMY_EXPANSION"or tT=="ATTACK_ENEMY_BASE_PRIORITY")then local tx,ty,tz=Spring.GetTeamStartPosition(eTID)
      if tx then tPos={tx,ty,tz}; Log(teamID,"Sending group of "..gS.." to ATTACK ENEMY ("..eTID..") BASE at "..string.format("%.0f,%.0f",tx,tz)); local cTU=(CMD and CMD.ATTACK or 20) -- Usa CMD.ATTACK o 20
      for i,uID in ipairs(aG)do Spring.GiveOrderToUnit(uID,cTU,tPos,{}); if data.combatUnits[uID]then data.combatUnits[uID].state="attacking"end end; oIss=true else Log(teamID,"Could not get start pos for enemy "..eTID);tPos=nil end
      elseif tT=="PATROL_NEARBY"then local ang=math.random()*2*math.pi; local dis=1000+math.random(500); tPos={data.startPos.x+math.cos(ang)*dis,data.startPos.y,data.startPos.z+math.sin(ang)*dis}; Log(teamID,"Sending group of "..gS.." to PATROL NEARBY"); local CMD_P_ID=(CMD and CMD.PATROL or 15); Spring.GiveOrderToUnitArray(aG,CMD_P_ID,tPos,{"SHIFT"})
      for _,uID in ipairs(aG)do if data.combatUnits[uID]then data.combatUnits[uID].state="patrolling"end end; oIss=true end
      if not oIss then Log(teamID,"Could not find target or issue order, setting units back to idle."); for _,uID in ipairs(aG)do if data.combatUnits[uID]then data.combatUnits[uID].state="idle"end end end
      -- else Log(teamID,"ManageMilitary: Idle count("..iCnt..") < min("..cfg.attackGroup.min..")")
      end
  end

  -- Helper: Trova costruttore idle
  function FindIdleConstructorForTeam(teamData, minTier)
      minTier=minTier or 0; local fBID=nil; for bID,bD in pairs(teamData.constructors)do if Spring.ValidUnitID(bID)and bD.tier>=minTier then local cmds=Spring.GetUnitCommands(bID); if(not cmds or #cmds==0)then fBID=bID;break end end end; return fBID
  end

  -- Helper: Controlla se servono costruttori
  function TeamNeedsConstructor(teamData, tier)
      local cnt=0; for uID,bD in pairs(teamData.constructors)do if Spring.ValidUnitID(uID)and bD.tier==tier then cnt=cnt+1 end end; local lim=(tier==0)and 1 or 2; return cnt<lim
  end

  -- GADGET EVENT HANDLERS (SYNCED)
  function gadget:Initialize()
      Log(nil, gadget:GetInfo().name .. " Initializing...")
      for faction, data in pairs(factionUnits) do
          if faction ~= "common" and faction ~= "_commonUnitDefIDs" and faction ~= "_unitDefIDs" then
              Log(nil, "Populating UnitDefIDs for faction: " .. faction)
              factionUnits[faction]._unitDefIDs = {}
              PopulateUnitDefIDs(data, factionUnits[faction]._unitDefIDs)
          end
      end
      Log(nil, "UnitDefID population complete.")
  end

  function gadget:GameStart()
      Log(nil, gadget:GetInfo().name .. " Game Starting...")
      local mapNameRaw = Game.mapName; local mapNameLower = mapNameRaw:lower()
      Log(nil, "Detected Map: '" .. mapNameRaw .. "' (Checking as: '" .. mapNameLower .. "')")
      if mapCategories[mapNameLower] then currentMapCategory = mapCategories[mapNameLower]; Log(nil, "Map Category Assigned: '" .. currentMapCategory .. "' (Found)")
      else Log(nil, "Map Category Assigned: '" .. currentMapCategory .. "' (Default)") end
      local teams = Spring.GetTeamList()
      for _, teamID in ipairs(teams) do
          if Spring.GetTeamLuaAI(teamID) == gadget:GetInfo().name then
              Log(teamID, "Team detected for AI control.")
              local sX,sY,sZ=Spring.GetTeamStartPosition(teamID)
              teamData[teamID] = {teamID=teamID,initialized=true,faction=nil,techLevel=0,commanderInfo=nil,startPos={x=sX,y=sY,z=sZ},constructors={},factories={},combatUnits={},buildings={},missions={},resourceInfo={lastUpdateFrame=-100},economyObjectives={},combatGroups={},patrolPoints={},nextPatrolPointIndex=1,nextGroupID=1,regeneratePatrolPoints=true,
              HasFactoryOfTier=TeamHasFactoryOfTier,FindIdleConstructor=FindIdleConstructorForTeam,NeedsConstructor=TeamNeedsConstructor,FindGoodFactoryPos=FindGoodFactoryPosForTeam,CanAfford=CanAffordUnit,FindBestMetalSpot=FindBestMetalSpotForTeam,FindGoodEnergySpot=FindGoodEnergySpotForTeam,
              NeedsBasicEconomy=function(self)local mC=0;local pC=0;local mD=GetUnitDataByRole(self.faction,1,"T1_Extractor");local pD=GetUnitDataByRole(self.faction,1,"T1_PowerPlant");if mD then mC=#Spring.GetTeamUnitsByDefs(self.teamID,mD.id)end;if pD then pC=#Spring.GetTeamUnitsByDefs(self.teamID,pD.id)end;local cf=aiConfig[self.techLevel];local nM=false;local nP=false;if cf and cf.economyTargets then for _,t in ipairs(cf.economyTargets)do if t.role=="T1_Extractor"then nM=(mC<t.min);break end end;for _,t in ipairs(cf.economyTargets)do if t.role=="T1_PowerPlant"then nP=(pC<t.min);break end end end;return nM or nP end,}
              CheckTeamCommander(teamID); GeneratePatrolPoints(teamID, teamData[teamID])
          end
      end
      gameStarted = true; Log(nil, gadget:GetInfo().name .. " Game Started. Final Map Category: " .. currentMapCategory)
  end

  function gadget:GameFrame(frame)
    if not gameStarted then return end
    for teamID, data in pairs(teamData) do
      if data.initialized and data.faction and data.faction ~= "UNKNOWN" then
        if frame % 150 == (teamID * 15) % 150 then Log(teamID, "Current State - TechLevel: " .. data.techLevel .. " | Map: " .. currentMapCategory .. " | Res M: " .. string.format("%.0f",data.resourceInfo.metal or 0) .. "(" .. string.format("%.1f",data.resourceInfo.metalIncome or 0) .. "/" .. string.format("%.1f",data.resourceInfo.metalUsage or 0) .. ") E: " .. string.format("%.0f",data.resourceInfo.energy or 0) .. "(" .. string.format("%.1f",data.resourceInfo.energyIncome or 0) .. "/" .. string.format("%.1f",data.resourceInfo.energyUsage or 0) .. ")") end
        UpdateResourceInfo(teamID, frame)
        if frame % 45 == (teamID * 3) % 45 then ManageTechLevel(teamID, frame) end
        if frame % 61 == (teamID * 5) % 61 then ManageEconomy(teamID, frame) end
        if frame % 91 == (teamID * 7) % 91 then ManageProduction(teamID, frame) end
        if frame % 121 == (teamID * 9) % 121 then ManageMilitary(teamID, frame) end
      elseif data.initialized and not data.faction then if frame % 30 == 5 then CheckTeamCommander(teamID) end end
    end
  end

  function gadget:UnitFinished(unitID, unitDefID, unitTeam)
    if teamData[unitTeam] then local data=teamData[unitTeam]; if not data.faction then return end; local uDef=UnitDefs[unitDefID]; local fac=data.faction; local fT=nil; local uDt=nil
    for tier=1,3 do local tk="T"..tier; local tDs=factionUnits[fac]._unitDefIDs[tk]; if tDs then
    if tDs.constructor and unitDefID==tDs.constructor.id then uDt=tDs.constructor;data.constructors[unitID]={tier=tier,state="idle",task=nil,moveType=uDt.moveType};fT="Con "..tk;break end
    if tDs.factory and unitDefID==tDs.factory.id then uDt=tDs.factory;data.factories[unitID]={tier=tier,producing=nil,moveType=uDt.moveType};fT="Fac "..tk;break end
    if tDs.extractor and unitDefID==tDs.extractor.id then uDt=tDs.extractor;data.buildings[unitID]={tier=tier,type="extractor",moveType=uDt.moveType};fT="Ext "..tk;break end
    if tDs.powerPlant and unitDefID==tDs.powerPlant.id then uDt=tDs.powerPlant;data.buildings[unitID]={tier=tier,type="power",moveType=uDt.moveType};fT="Pow "..tk;break end
    if tDs.attackers then for _,d in ipairs(tDs.attackers)do if unitDefID==d.id then uDt=d;data.combatUnits[unitID]={tier=tier,type="attacker",group=nil,state="idle",moveType=uDt.moveType};fT="Atk "..tk;break end end;if fT then break end end
    if tDs.defenses then for _,d in ipairs(tDs.defenses)do if unitDefID==d.id then uDt=d;data.buildings[unitID]={tier=tier,type="defense",moveType=uDt.moveType};fT="Def "..tk;break end end;if fT then break end end end end
    if fT then Log(unitTeam,"UnitFinished: "..unitID.." ("..(uDef and uDef.humanName or "N/A")..") - Cat: "..fT.." (MT: ".. (uDt and uDt.moveType or 'N/A') .. ")")
    else Log(unitTeam,"UnitFinished: "..unitID.." ("..(uDef and uDef.humanName or "N/A")..") - Not categorized.") end end
  end

  function gadget:UnitDestroyed(unitID, unitDefID, unitTeam, ...)
      if teamData[unitTeam] then local d=teamData[unitTeam]; if d.constructors[unitID]then d.constructors[unitID]=nil elseif d.factories[unitID]then d.factories[unitID]=nil elseif d.combatUnits[unitID]then d.combatUnits[unitID]=nil elseif d.buildings[unitID]then d.buildings[unitID]=nil end
      -- Rimuovi unità dai gruppi se distrutta
      for groupID, groupData in pairs(d.combatGroups or {}) do local newUnits={}; local found=false; for _,uid_in_group in ipairs(groupData.units)do if uid_in_group~=unitID then table.insert(newUnits,uid_in_group)else found=true end end; if found then groupData.units=newUnits; Log(unitTeam,"Removed unit "..unitID.." from group "..groupID)end end end
  end

  
  
  
  function UpdateCombatGroupStates(teamID, frame, data)
      -- Itera su una COPIA delle chiavi perché potremmo rimuovere elementi da data.combatGroups
      local groupIDsToIterate = {}
      for groupID, _ in pairs(data.combatGroups) do
          table.insert(groupIDsToIterate, groupID)
      end

      for _, groupID in ipairs(groupIDsToIterate) do
          local groupData = data.combatGroups[groupID]

          if groupData then
              local aliveUnits = {}
              for _, unitID in ipairs(groupData.units) do
                  if Spring.ValidUnitID(unitID) and not Spring.GetUnitIsDead(unitID) then
                      table.insert(aliveUnits, unitID)
                  else
                      if data.combatUnits[unitID] then
                          data.combatUnits[unitID].groupID = nil
                          data.combatUnits[unitID].state = "idle"
                      end
                  end
              end
              groupData.units = aliveUnits

              if #groupData.units == 0 then
                  Log(teamID, "Group " .. groupID .. " is now empty, removing.")
                  data.combatGroups[groupID] = nil
              else
                  if groupData.state == "patrolling_area" then
                      local allIdleNearTarget = true
                      if not groupData.targetPoint then
                          allIdleNearTarget = false
                      end

                      if allIdleNearTarget then -- APRE IF 7
                          local groupX, groupZ, unitCountInGroup = 0, 0, 0
                          local allCommandsDoneForGroup = true

                          for _, unitID in ipairs(groupData.units) do
                              local ux, _, uz = Spring.GetUnitPosition(unitID)
                              if ux then
                                  groupX = groupX + ux
                                  groupZ = groupZ + uz
                                  unitCountInGroup = unitCountInGroup + 1
                              end
                              local cmds = Spring.GetUnitCommands(unitID)
                              if cmds and #cmds > 0 then
                                  allCommandsDoneForGroup = false
                                  break
                              end
                          end

                          if unitCountInGroup > 0 and allCommandsDoneForGroup then -- APRE IF 9
                              groupX = groupX / unitCountInGroup
                              groupZ = groupZ / unitCountInGroup
                              local dx = groupX - groupData.targetPoint[1]
                              local dz = groupZ - groupData.targetPoint[3]
                              if (dx*dx + dz*dz) > (200*200) then -- APRE IF 10
                                  allIdleNearTarget = false
                              end -- CHIUDE IF 10
                          elseif unitCountInGroup == 0 then
                              allIdleNearTarget = false
                          elseif not allCommandsDoneForGroup then
                              allIdleNearTarget = false
                          end -- CHIUDE IF 9
                      end -- <<<<<<<<<<< END MANCANTE AGGIUNTO QUI per chiudere IF 7

                      if allIdleNearTarget then
                          Log(teamID, "Group " .. groupID .. " completed patrol at " .. string.format("%.0f,%.0f", groupData.targetPoint[1], groupData.targetPoint[3]))
                          groupData.state = "patrol_complete"
                          groupData.targetPoint = nil
                      end
                  end -- fine if groupData.state == "patrolling_area"
              end -- fine if #groupData.units > 0 / else
          end -- fine if groupData
      end -- fine for groupID
  end -- Fine UpdateCombatGroupStates
  

  function UpdateHotspots(teamID, frame, data)

  end
  
  function DecayOldHotspots(teamID, frame, data) 
  
  end
  
  function FindBestHotspotToAttack(teamID, data, groupData)
	return nil 
  end

  function CreateNewCombatGroup(teamID, data, unitIDs, frame)
      local nGID=data.nextGroupID; data.nextGroupID=data.nextGroupID+1; data.combatGroups[nGID]={units={},state="idle",targetPoint=nil,targetUnit=nil,currentTargetHotspotID=nil,lastOrderFrame=frame}
      for _,uID in ipairs(unitIDs)do if data.combatUnits[uID]then table.insert(data.combatGroups[nGID].units,uID);data.combatUnits[uID].state="assigned_to_group";data.combatUnits[uID].groupID=nGID end end
      Log(teamID,"Created new combat group "..nGID.." with "..#data.combatGroups[nGID].units.." units.")
  end

  function GeneratePatrolPoints(teamID, data)
      if #data.patrolPoints > 0 and not data.regeneratePatrolPoints then return end
      Log(teamID, "Generating patrol points...")
      data.patrolPoints = {}; local mapW, mapH = Game.mapSizeX, Game.mapSizeZ; local sX,sY,sZ = Spring.GetTeamStartPosition(teamID); if not sX then return end
      local bPD = math.min(mapW,mapH)/5; table.insert(data.patrolPoints,{x=sX+bPD,y=0,z=sZ,type="base_perimeter"}); table.insert(data.patrolPoints,{x=sX-bPD,y=0,z=sZ,type="base_perimeter"}); table.insert(data.patrolPoints,{x=sX,y=0,z=sZ+bPD,type="base_perimeter"}); table.insert(data.patrolPoints,{x=sX,y=0,z=sZ-bPD,type="base_perimeter"})
      local aTs=Spring.GetTeamList();if aTs then for _,oTID in ipairs(aTs)do if oTID~=teamID and oTID~=Spring.GetGaiaTeamID()and not Spring.AreTeamsAllied(teamID,oTID)then local ex,ey,ez=Spring.GetTeamStartPosition(oTID);if ex then table.insert(data.patrolPoints,{x=ex,y=ey,z=ez,type="enemy_start"})end end end end
      local mS={}; local mC=Spring.GetGameRulesParam("mex_count"); if mC and mC>0 then for i=1,mC do local sx=Spring.GetGameRulesParam("mex_x"..i);local sz=Spring.GetGameRulesParam("mex_z"..i);if sx and sz then table.insert(mS,{x=sx,z=sz})end end end
      for i,spt in ipairs(mS)do local dx,dz=spt.x-sX,spt.z-sZ;if math.sqrt(dx*dx+dz*dz)>bPD*1.5 then table.insert(data.patrolPoints,{x=spt.x,y=Spring.GetGroundHeight(spt.x,spt.z)or 0,z=spt.z,type="remote_resource"});if #data.patrolPoints>=10 then break end end end
      table.insert(data.patrolPoints,{x=mapW/2,y=0,z=mapH/2,type="center_map"}); local uP={}; local fPP={}; for _,p in ipairs(data.patrolPoints)do local k=string.format("%.0f,%.0f",p.x,p.z);if not uP[k]then if p.x>0 and p.x<mapW and p.z>0 and p.z<mapH then p.y=Spring.GetGroundHeight(p.x,p.z)or 0;table.insert(fPP,p);uP[k]=true end end end; data.patrolPoints=fPP; data.nextPatrolPointIndex=1; data.regeneratePatrolPoints=false; Log(teamID,"Generated "..#data.patrolPoints.." unique patrol points.")
  end

  function gadget:EnemyEnterLOS(enemyUnitID, enemyTeamID, losAllyTeamID)
      if teamData[losAllyTeamID] then local data=teamData[losAllyTeamID]; local ex,ey,ez=Spring.GetUnitPosition(enemyUnitID)
      if ex then Log(losAllyTeamID,"ENEMY SPOTTED by LOS: Unit "..enemyUnitID.." at "..string.format("%.0f,%.0f",ex,ez)); local nHID="hotspot_"..enemyUnitID; data.hotspots[nHID]={x=ex,y=ey,z=ez,strength=1,lastSeenFrame=Game.frame,assignedGroups={}}end end
  end

  function gadget:Shutdown() Log(nil, gadget:GetInfo().name .. " Shutting down.") end

end -- SYNCED CODE END

-- UNSYNCED CODE
if (not gadgetHandler:IsSyncedCode()) then
    local function DrawFactionAndTech(teamID, data) local x,y,z=Spring.GetTeamStartPosition(teamID); if x and data.faction then gl.Text(data.faction .. " (T"..data.techLevel..")",x,y+60,15,"co")end end
    function gadget:DrawWorld() if SYNCED and SYNCED.KPAI_Debug_Mode and SYNCED.KPAI_Debug_Mode>0 and type(SYNCED.teamData)=="table"then for tID,dat in pairs(SYNCED.teamData)do if dat and dat.initialized then DrawFactionAndTech(tID,dat)end end;gl.Color(1,1,1,1)end end
    function gadget:DrawScreen(vsx,vsy) if SYNCED and SYNCED.KPAI_Debug_Mode and SYNCED.KPAI_Debug_Mode>0 and SYNCED.currentMapCategory then gl.Text("Map Category: "..SYNCED.currentMapCategory,vsx*0.5,vsy-30,15,"co")end end
    local function ToggleDebug(cmd,line,words,player) local cM=0; if SYNCED and SYNCED.KPAI_Debug_Mode then cM=SYNCED.KPAI_Debug_Mode end; local nM=(cM==0)and 1 or 0; Spring.SendLuaRulesMsg("WMRTSAI_SetDebug "..nM); Spring.Echo("WMRTSAI Debug: "..nM); return true end
    function gadget:Initialize() gadgetHandler:AddChatAction("wmrtsai_debug",ToggleDebug,"Toggle WMRTSAI debug")end
    function gadget:RecvLuaMsg(msg,pID) if msg:find("^WMRTSAI_SetDebug")then local _,lS=msg:match("([^ ]+)%s+(.*)"); local l=tonumber(lS); if l~=nil then if SYNCED then SYNCED.KPAI_Debug_Mode=l end end; return true end; return false end
end