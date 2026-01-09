function gadget:GetInfo()
	return {
		name      = "WM Squad Commander AI (Custom DB Edition)",
		desc      = "AI con database unità personalizzato e targeting selettivo",
		author    = "molix",
		date      = "2025",
		license   = "GPL",
		layer     = 100,
		enabled   = true
	}
end
-- 08/01/2025 = creata l'AI WMRTS_AI per missioni
-- 09/01/2025 = implementato il comando attack al gruppo di bombardieri. Prima l'AI gestiva solamente il comando FIGHT ma i bombardieri non bombardano automaticamente, bisogna indicargli il punto da bombardare con il comando Attack.

-- to do LIST ################################
-- implementare SUB


if (not gadgetHandler:IsSyncedCode()) then
	return false
end

--------------------------------------------------------------------------------
-- 1) DATABASE UNITÀ -- caricato dal file WMRTS_AI_mission_db.lua
--------------------------------------------------------------------------------
-- Qui puoi aggiungere campi extra in futuro (es. priority, armor_type, ecc.)
-- La tipologia di ogni singola unità è necessaria affinchè la AI gestisca le squadre/gruppi (punto 2) contro le singole unità.
-- Ad esempio le tipologie di unità "ground" definite nel database verranno bersagliate dai gruppi tipo "ground" e "air_toground" definiti nel punto 2. 
-- Questa logica di "chi attacca cosa" è definita poi nel punto "4) LOGICA DI TARGETING BASATA SU DATABASE"
-- definizione delle tipologie:
--			type = ground 				-> unità mobile di terra (veicoli e Kbot)
--			type = air 					-> unità mobile aerea
--			type = hovercraft 			-> unità mobile di terra che può andare sul mare
--			type = naval 				-> unità mobile navale (di superficie, no SUB)
--			type = building 			-> unità fissa di superficie su terra (di difesa/produzione/energia)
--			type = navalbuilding 		-> unità fissa di superficie su mare (di difesa/produzione/energia)
--			type = strategicbuilding 	-> unità fissa di superficie strategica ( Es factory 3 livello, silos, antipalline )

local dbPath = "LuaRules/Configs/WMRTS_AI_mission_db.lua"
local UNIT_DB = VFS.Include(dbPath)

-- Debug in caso di mancanza del database
if not UNIT_DB then
    Spring.Echo("WARNING: WM AI units database not found in: " .. dbPath)
    UNIT_DB = {}
end

--------------------------------------------------------------------------------
-- 2a) CONFIGURAZIONE SQUADRE / GRUPPI (LISTE DI COSTRUZIONE) e tipologia
--------------------------------------------------------------------------------

-- Il nome dello "squad_template" identifica solamente il nome del gruppo da creare. Es. ["light_patrol_1"], verrà poi impiegato nel punto 2b per dire alla fabbrica: costruisci le unità di questo gruppo e forma il gruppo
-- units = l'elenco delle unità che comporranno il gruppo (ad esempio il gruppo "light_patrol_1"
-- type = tipologia di squadra, la tipologia verrà impiegata nella logica di targeting (punto 4) per dire quali unità devono attaccare. In generale descrizioni a seguito:
-- 					type = "ground" -> attacca unità tipo "ground", "unknown" e "hover" se y di quest'ultima > -1 (vedere punto 4)
--					type = "air_toair" -> tutti gli aerei destinati ad attaccare solo aerei
--					type = "air_toground" -> tutti gli aerei destinati ad attaccare tutto (ground, hovercraft e naval). Attenzione: non mettere bombardieri in quanto sorvolerebbero solamente la zona. Per loro ci vuole una logica di attacco diretto sull'unità, per questo usare i gruppi specifici per bombardieri
--					type = "air_bomber" -> tutti gli aerei da bombardamento. Hanno una logica per un bombardamento diretto sull'unità

local SQUAD_TEMPLATES = {
	["light_patrol_1"] = {
		units = { "icupatroller", "icupatroller", "icurock", "icurock" },
		type = "ground" -- squadtype 
	},
	["heavy_assault_1"] = {
		units = { "mediumtank", "mediumtank", "artillerybot" }, 
		type = "ground"
	},
	["air_raid_1"] = { 			
		units = { "armkam", "armfig", "armfig", "armkam", "armkam" },
		type = "air_toground"
	},
	["antiair_raid_1"] = { 
		units = { "armfig", "armfig", "armfig" },
		type = "air_toair"
	},
	["air_bomber_1"] = { 
		units = { "armthund", "armthund", "armthund", "armthund", "armthund" }, 	-- gruppo da 5 bombardieri
		type = "air_bomber"
	},	
--	["naval_fleet"] = {
--		units = { "corbats", "corbats", "corbats" },
--		type = "naval"
--	}
}


--------------------------------------------------------------------------------
-- 2b) CONFIGURAZIONE FABBRICHE E BUILDLIST
--------------------------------------------------------------------------------

-- CONFIGURAZIONE FABBRICHE, selezionare gli squad_templates (le liste di costruzione)
local FACTORY_CONFIG = {
	["armlab"] = { "light_patrol_1" },
	["armap"]  = { "antiair_raid_1", "air_raid_1" },
--	["armsy"]  = { "naval_fleet" },
}

local TARGET_AI_NAME = "WarMachinesRTSmissionAI" 
local SQUAD_TIMEOUT_SECONDS = 600 -- questo timeout definisce il tempo di attesa per la formazione del gruppo delle unità uscite dalla fabbrica. Oltre questo timeout il gruppo di completa e parte all'attacco o difesa 

--------------------------------------------------------------------------------
-- 3) VARIABILI
--------------------------------------------------------------------------------

local aiTeamIDs = {}      
local factories = {}      
local squads = {}         

--------------------------------------------------------------------------------
-- 4) LOGICA DI TARGETING BASATA SU DATABASE
--------------------------------------------------------------------------------

-- Ottiene la categoria dal NOSTRO database
local function GetUnitCategoryFromDB(unitID)
	local uDefID = Spring.GetUnitDefID(unitID)
	if not uDefID then return "unknown" end
	local unitName = UnitDefs[uDefID].name
	
	if UNIT_DB[unitName] then
		return UNIT_DB[unitName].type
	end
	
	return "unknown" 
end

-- Funzione per trovare il bersaglio 
local function GetSmartEnemyTarget(myTeamID, squadType)
	local allUnits = Spring.GetAllUnits()
	
	for i = 1, #allUnits do
		local uID = allUnits[i]
		local uTeam = Spring.GetUnitTeam(uID)
		
		if uTeam ~= Spring.GetGaiaTeamID() and not Spring.AreTeamsAllied(myTeamID, uTeam) then
			local enemyCat = GetUnitCategoryFromDB(uID)
			local x, y, z = Spring.GetUnitPosition(uID)
			
			if x then
				local directAttack = false 	-- definire directAttack = true solo per gruppi di bombardieri
				-------------
				-- AEREI: 
				-------------				
				-- La tipologia air_toall Attacca tutto, inclusi gli hovercraft sempre. Relativi a tutti gli aerei NON BOMBARDIERI, che attaccano con comandi come "patrol" e "fight"
				if squadType == "air_toall" then
					if enemyCat == "air" or enemyCat == "ground" or enemyCat == "naval" or enemyCat == "hover" then
						return {x=x, y=y, z=z}
					end				
				-- La tipologia air_toground Attacca soltanto le unità in superficie con aerei NON BOMBARDIERI (es. tipo "armfig" o "armkam")
				elseif squadType == "air_toground" then
					if enemyCat == "ground" or enemyCat == "naval" or enemyCat == "hover" then
						return {x=x, y=y, z=z}
					end
				-- La tipologia air_toair Attacca soltanto gli aerei
				elseif squadType == "air_toair" then
					if enemyCat == "air" then
						return {x=x, y=y, z=z}
					end
				-- La tipologia air_bomber manda il gruppo di unità all'attacco direttamente su una singola unità (UTILE PER I BOMBARDIERI)
				elseif squadType == "air_bomber" then
					directAttack = true -- imposto attacco diretto su true cosi le unità attaccheranno direttamente l'unità
					if enemyCat == "ground" then -- ####################################################################################### valutare se bersagliare unità di tipo building o solo building importanti
						return {x=x, y=y, z=z, id=uID} -- restituisco anche l'ID dell'unità che si intende bersagliare
					end					
				-------------
				-- TERRA: Attaccano ground, unknown e hover (solo se su terra)
				-------------				
				elseif squadType == "ground" then
					if enemyCat == "ground" or enemyCat == "unknown" then
						return {x=x, y=y, z=z}
					elseif enemyCat == "hover" and y >= -1 then -- da -1 (spiaggia) a sopra il livello dell'acqua (montagna)
						return {x=x, y=y, z=z}
					end
				-------------					
				-- NAVALI: Attaccano naval e hover (solo se in acqua)
				-------------				
				elseif squadType == "naval" then
					if enemyCat == "naval" then
						return {x=x, y=y, z=z}
					elseif enemyCat == "hover" and y < -1 then -- sotto il livello del mare
						return {x=x, y=y, z=z}
					end
				end
				----------------------------------------------------------------
			end
		end
	end
	
	return { x = Game.mapSizeX/2, y = 0, z = Game.mapSizeZ/2 }
end

--------------------------------------------------------------------------------
-- 5) GESTIONE ORDINI E GADGET CORE 
--------------------------------------------------------------------------------

local function GiveAttackOrder(unitID, targetPos)
	if not targetPos then return end
-- ################		if targetData.id and Spring.ValidUnitID(targetData.id) then -- ## valutare se introdurre Spring.ValidUnitID(targetData.id) ########
		if targetData.id then 	-- ORDINE DI ATTACCO DIRETTO ALL'UNITÀ (Cruciale per i bombardieri). Se la logica 4) smuove lo squadtype dedicato ai bombardieri, questi devono attaccare direttamente l'unità bersaglio altrimenti col comando fight o patrol non lo farebbero, "siedendosi" a destinazione
			Spring.GiveOrderToUnit(unitID, CMD.ATTACK, {targetData.id}, {})
		else				  	-- ALTRIMENTI ORDINE DI ATTACCO FIGHT. Per tutte le unità che rispondono a questo comando, attaccando naturalmente le unità lungo il percorso.
			Spring.GiveOrderToUnit(unitID, CMD.STOP, {}, {})
			local tx = targetPos.x + math.random(-250, 250)
			local tz = targetPos.z + math.random(-250, 250)
			local ty = Spring.GetGroundHeight(tx, tz)
			Spring.GiveOrderToUnit(unitID, CMD.FIGHT, {tx, ty, tz}, {})
		end
end

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
			GiveAttackOrder(unitID, squad.attackTarget)
		end
	end
end

function gadget:GameFrame(n)
	if (n % 30 ~= 0) then return end 

	-- GESTIONE FABBRICHE
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
						attackTarget = nil,
						type = template.type 
					}
					fData.squadID = newSquadID
					for _, uName in ipairs(template.units) do
						local uDef = UnitDefNames[uName]
						if uDef then Spring.GiveOrderToUnit(fID, -uDef.id, {}, {}) end
					end
				end
			end
		end
	end

	-- GESTIONE SQUADRE
	for sID, sData in pairs(squads) do
		if sData.state == "gathering" then
			if #sData.units >= sData.targetSize or (Spring.GetGameSeconds() - sData.startTime) > SQUAD_TIMEOUT_SECONDS then
				sData.state = "attacking_monitor"
				sData.attackTarget = GetSmartEnemyTarget(sData.myTeam, sData.type)
				for _, uID in ipairs(sData.units) do
					if Spring.ValidUnitID(uID) then GiveAttackOrder(uID, sData.attackTarget) end
				end
			end
			
		elseif sData.state == "attacking_monitor" then
			if n % 90 == 0 then
				local anyAlive = false
				local anyIdle = false
				for i = #sData.units, 1, -1 do
					local uID = sData.units[i]
					if Spring.ValidUnitID(uID) and not Spring.GetUnitIsDead(uID) then
						anyAlive = true
						if Spring.GetCommandQueue(uID, 0) == 0 then anyIdle = true end
					else
						table.remove(sData.units, i)
					end
				end
				
				if anyAlive and anyIdle then
					sData.attackTarget = GetSmartEnemyTarget(sData.myTeam, sData.type)
					for _, uID in ipairs(sData.units) do
						if Spring.GetCommandQueue(uID, 0) == 0 then
							GiveAttackOrder(uID, sData.attackTarget)
						end
					end
				end
				if not anyAlive then squads[sID] = nil end
			end
		end
	end
end