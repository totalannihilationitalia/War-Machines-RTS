function gadget:GetInfo()
	return {
		name      = "WMRTS_Mission_AI",
		desc      = "AI for missions",
		author    = "molix",
		date      = "2025",
		license   = "GPL",
		layer     = 100,
		enabled   = true
	}
end

if (not gadgetHandler:IsSyncedCode()) then
	return false
end

--------------------------------------------------------------------------------
-- CONFIGURAZIONE
--------------------------------------------------------------------------------

local SQUAD_TEMPLATES = {
	["light_patrol"] = {
		units = { "icupatroller", "icupatroller", "icurock", "icurock" },
		type = "ground"
	},
	["heavy_assault"] = {
		units = { "mediumtank", "mediumtank", "artillerybot" }, 
		type = "ground"
	},
	["air_raid"] = {
		units = { "icuinterceptor", "icuinterceptor", "bomber" },
		type = "air"
	}
}

local FACTORY_CONFIG = {
	["armlab"] = { "light_patrol" },
	["icuap"] = { "air_raid", "heavy_assault" },
}

local TARGET_AI_NAME = "WarMachinesRTSmissionAI" 
local SQUAD_TIMEOUT_SECONDS = 30 

--------------------------------------------------------------------------------
-- VARIABILI
--------------------------------------------------------------------------------

local aiTeamIDs = {}      
local factories = {}      
local squads = {}         

--------------------------------------------------------------------------------
-- UTILITY
--------------------------------------------------------------------------------

local function IsNoAI(unitDefID)
	local name = UnitDefs[unitDefID].name
	if string.find(name, "_noai") then return true end
	return false
end

-- Questa funzione ora viene usata per aggiornare i bersagli in tempo reale
local function GetRealEnemyTarget(myTeamID)
	local allUnits = Spring.GetAllUnits()
	for _, uID in ipairs(allUnits) do
		local uTeam = Spring.GetUnitTeam(uID)
		if uTeam ~= Spring.GetGaiaTeamID() and not Spring.AreTeamsAllied(myTeamID, uTeam) then
			local x, y, z = Spring.GetUnitPosition(uID)
			if x then return {x=x, y=y, z=z} end
		end
	end
	-- Se non ci sono nemici, punta al centro mappa
	return { x = Game.mapSizeX/2, y = 0, z = Game.mapSizeZ/2 }
end

local function GiveAttackOrder(unitID, targetPos)
	if not targetPos then return end
	
	-- CMD.STOP rimosso per permettere transizioni più fluide, o mantenuto se vuoi pulizia totale
	Spring.GiveOrderToUnit(unitID, CMD.STOP, {}, {})
	
	local tx = targetPos.x + math.random(-250, 250)
	local tz = targetPos.z + math.random(-250, 250)
	local ty = Spring.GetGroundHeight(tx, tz)
	
	-- FIGHT è perfetto: si muovono e sparano a tutto ciò che vedono
	Spring.GiveOrderToUnit(unitID, CMD.FIGHT, {tx, ty, tz}, {})
end

--------------------------------------------------------------------------------
-- INITIALIZE & UNIT EVENTS
--------------------------------------------------------------------------------

function gadget:Initialize()
	local teamList = Spring.GetTeamList()
	for _, teamID in ipairs(teamList) do
		local assignedAI = Spring.GetTeamLuaAI(teamID)
		if assignedAI and string.find(string.lower(assignedAI), string.lower(TARGET_AI_NAME)) then
			aiTeamIDs[teamID] = true
		end
	end
end

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
	if not aiTeamIDs[unitTeam] then return end
	if IsNoAI(unitDefID) then return end

	local unitName = UnitDefs[unitDefID].name

	if FACTORY_CONFIG[unitName] then
		factories[unitID] = { defName = unitName, squadID = nil, teamID = unitTeam }
		return
	end

	local bestFactoryID = nil
	local nearestDist = 3000
	for fID, fData in pairs(factories) do
		if fData.teamID == unitTeam then
			local dist = Spring.GetUnitSeparation(unitID, fID)
			if dist and dist < nearestDist then
				if fData.squadID and squads[fData.squadID] then
					nearestDist = dist
					bestFactoryID = fID
				end
			end
		end
	end

	if bestFactoryID then
		local fData = factories[bestFactoryID]
		local sID = fData.squadID
		local squad = squads[sID]
		table.insert(squad.units, unitID)
		
		if squad.state == "gathering" then
			local fX, _, fZ = Spring.GetUnitPosition(bestFactoryID)
			Spring.GiveOrderToUnit(unitID, CMD.MOVE, {fX + math.random(-300,300), 0, fZ + math.random(300,500)}, {"shift"})
		elseif squad.state == "attacking_monitor" then
			-- Il ritardatario riceve l'attuale bersaglio della squadra
			GiveAttackOrder(unitID, squad.attackTarget)
		end
	end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
	if factories[unitID] then factories[unitID] = nil end
end

--------------------------------------------------------------------------------
-- GAME FRAME (CORE LOGIC)
--------------------------------------------------------------------------------

function gadget:GameFrame(n)
	if (n % 30 ~= 0) then return end 

	-- 1. GESTIONE FABBRICHE 
	for fID, fData in pairs(factories) do
		local qSize = Spring.GetCommandQueue(fID, 0)
		local isBuilding = Spring.GetUnitIsBuilding(fID)
		local isLocked = false
		
		if fData.squadID and squads[fData.squadID] then
			if (qSize > 0) or isBuilding or (squads[fData.squadID].state == "gathering") then
				isLocked = true
			else
				fData.squadID = nil
			end
		end

		if not isLocked and qSize == 0 and not isBuilding then
			local options = FACTORY_CONFIG[fData.defName]
			if options then
				local template = SQUAD_TEMPLATES[options[math.random(1, #options)]]
				if template then
					local newSquadID = n .. "_" .. fID
					squads[newSquadID] = {
						units = {},
						targetSize = #template.units,
						state = "gathering",
						startTime = Spring.GetGameSeconds(),
						myTeam = fData.teamID,
						attackTarget = nil
					}
					fData.squadID = newSquadID
					for _, uName in ipairs(template.units) do
						local uDef = UnitDefNames[uName]
						if uDef then Spring.GiveOrderToUnit(fID, -uDef.id, {}, {"shift"}) end
					end
				end
			end
		end
	end

	-- 2. GESTIONE SQUADRE (Search & Destroy Continua)
	local currentTime = Spring.GetGameSeconds()
	
	for sID, sData in pairs(squads) do
		
		if sData.state == "gathering" then
			local isFull = #sData.units >= sData.targetSize
			local isTimedOut = (currentTime - sData.startTime) > SQUAD_TIMEOUT_SECONDS
			
			if isFull or isTimedOut then
				sData.state = "attacking_monitor"
				-- Primo bersaglio al lancio
				sData.attackTarget = GetRealEnemyTarget(sData.myTeam)
				for _, uID in ipairs(sData.units) do
					if Spring.ValidUnitID(uID) then
						GiveAttackOrder(uID, sData.attackTarget)
					end
				end
			end
			
		elseif sData.state == "attacking_monitor" then
			-- Monitoraggio ogni 3 secondi (90 frame)
			if n % 90 == 0 then
				local anyAlive = false
				local anyIdle = false
				
				-- Controlliamo lo stato di salute e attività della squadra
				for i = #sData.units, 1, -1 do
					local uID = sData.units[i]
					if Spring.ValidUnitID(uID) and not Spring.GetUnitIsDead(uID) then
						anyAlive = true
						local cmds = Spring.GetCommandQueue(uID, 0)
						if cmds == 0 then
							anyIdle = true
						end
					else
						table.remove(sData.units, i) -- Pulizia unità morte dalla tabella
					end
				end
				
				-- LOGICA SEARCH & DESTROY:
				-- Se la squadra è ancora viva ma qualcuno è fermo, cerchiamo un NUOVO bersaglio
				if anyAlive and anyIdle then
					sData.attackTarget = GetRealEnemyTarget(sData.myTeam)
					Spring.Echo("WM AI: Squadra " .. sID .. " ha completato l'obiettivo. Ricerca nuovo bersaglio...")
					
					for _, uID in ipairs(sData.units) do
						local cmds = Spring.GetCommandQueue(uID, 0)
						if cmds == 0 then
							GiveAttackOrder(uID, sData.attackTarget)
						end
					end
				end
				
				-- PULIZIA MEMORIA: Solo se sono tutti morti
				if not anyAlive then
					Spring.Echo("WM AI: Squadra " .. sID .. " distrutta. Rimozione dalla memoria.")
					squads[sID] = nil 
				end
			end
		end
	end
end