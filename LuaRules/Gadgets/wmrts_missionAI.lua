function gadget:GetInfo()
	return {
		name      = "WMRTS Squad Commander AI",
		desc      = "AI V0.3 for War Machnines RTS",
		author    = "molix",
		date      = "2025",
		license   = "GPL",
		layer     = 100,
		enabled   = true
	}
end
-- 08/01/2025 = creata l'AI WMRTS_AI per missioni
-- 09/01/2025 = implementato il comando attack al gruppo di bombardieri. Prima l'AI gestiva solamente il comando FIGHT ma i bombardieri non bombardano automaticamente, bisogna indicargli il punto da bombardare con il comando Attack.
-- 09/01/2025 = esternizzata la tabella/db delle unità in WMRTS_AI_mission_db.lua
-- 11/01/2025 = sistemato bug tabelle NIL quando una fabbrica viene distrutta/rimossa
-- 12/01/2025 = agguiunti i livelli di difficoltà della AI. Per ora scattano dopo x minuti di tempo. Prepisposto per una logica migliore di avanzamento

-- to do LIST ################################
-- 1) implementare i SUB
-- 2) REIMPOSTARE L'avanzamento di livello!!!!! vedi 


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

-- Il nome dello "squad_template" identifica solamente il nome del gruppo da creare. Es. ["ICU_armlab_light_patrol_1"], verrà poi impiegato nel punto 2b per dire alla fabbrica: costruisci le unità di questo gruppo e forma il gruppo
-- units = l'elenco delle unità che comporranno il gruppo (ad esempio il gruppo "ICU_armlab_light_patrol_1"
-- type = tipologia di squadra, la tipologia verrà impiegata nella logica di targeting (punto 4) per dire quali unità devono attaccare. In generale descrizioni a seguito:
-- 					type = "ground" 				-> manda all'attacco verso unità tipo "ground", "building", "strategicbuilding", "unknown" e "hover" se y di quest'ultima > -1 (vedere punto 4). Ideale per le truppe di terra o gli aerei.
-- 					type = "ground_hovercraft" 		-> manda all'attacco verso unità tipo "ground", "building", "strategicbuilding", "unknown" e "hover" a prescindere dalla y di quest'ultima (rispetto al gruppo "ground". Ideale per gli hovecraft e per gli aerei
--					type = "air_toair" 				-> tutti gli aerei destinati ad attaccare solo aerei
--					type = "air_toground" 			-> tutti gli aerei destinati ad attaccare tutto (ground, hovercraft e naval). Attenzione: non sono presenti "building" e "strategicbuilding". In questa categoria non mettere bombardieri in quanto sorvolerebbero solamente la zona per poi "sedersi". Per loro ci vuole una logica di attacco diretto sull'unità, per questo usare i gruppi specifici per bombardieri
--					type = "air_bomber" 			-> specifico per tutti gli aerei da bombardamento. Hanno una logica per un bombardamento diretto sull'unità di tipo "building", "strategicbuilding", "ground")
--					type = "air_bomber_strategic" 	-> specifico tutti gli aerei da bombardamento. Hanno una logica per un bombardamento diretto sull'unità di tipo "strategicbuilding" e "building"

local SQUAD_TEMPLATES = {

-- divido qui sotto i template di costruzione in funzione del livello, solo per maggior chiarezza. Quando il livello sale, vado a cambiare i templates di costruzione in 2b)

-------------------------------------------------------------------------------
-- Elenco di produzioni per l'AI - le ho divise per livello per una maggiore visibilità, ma sono soltanto nomi di gruppi e nessuno vieta che al livello 3 si posssa usare il gruppo "ICU_armlab_light_patrol_1" del livello 0. Basta elencare i gruppi che si voglio creare, in base al livello, nel paragrafo 2b
-------------------------------------------------------------------------------

---------------
-- ICU gruppi creati per il lvl 0 -------- 
---------------
	["ICU_armlab_light_patrol_1"] = {
		units = { "icupatroller", "icupatroller", "icurock", "icurock" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["ICU_armlab_light_patrol_2"] = {
		units = { "icuwar", "icuwar", "icurock", "icurock" },				
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["ICU_armvp_light_patrol_1"] = {
		units = { "armfav", "icuflash", "icuflash", "icuflash" }, 
		type = "ground"
	},
	["ICU_armvp_light_patrol_2"] = {
		units = { "armsam", "armsam", "armstump", "armpincer", "armpincer","tawf013" }, 
		type = "ground"
	},	
	["ICU_armap_air_raid_1"] = { 			
		units = { "armkam", "armfig", "armfig", "armkam", "armkam" },
		type = "air_toground"
	},
	["ICU_armap_antiair_raid_1"] = { 
		units = { "armfig", "armfig", "armfig" },
		type = "air_toair"
	},
	["ICU_armap_air_bomber_1"] = { 
		units = { "armthund", "armthund", "armthund", "armthund", "armthund" }, 	-- gruppo da 5 bombardieri
		type = "air_bomber"
	},	
--	["naval_fleet"] = {
--		units = { "corbats", "corbats", "corbats" },
--		type = "naval"
--	}

---------------
-- AND lvl 0 -------- 
---------------
	["AND_andlab_light_patrol_1"] = {
		units = { "andscouter", "andscouter", "andscouter", "andscouter" },
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["AND_andlab_light_patrol_2"] = {
		units = { "andscouter", "anddauber", "anddauber", "andbrskr" },
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["AND_andalab_light_patrol_1"] = { 
		units = { "walker", "walker", "exxec", "andogre" },
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["AND_andalab_light_patrol_2"] = { 
		units = { "andogre", "interceptor", "walker", "exxec" },
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		
	["AND_andhp_light_patrol_1"] = {
		units = { "andgaso", "andlipo", "andlipo", "andgaso" }, 
		type = "ground_hovercraft"
	},
	["AND_andhp_light_patrol_2"] = {
		units = { "andgaso", "andlipo", "andlipo", "andgaso","andmisa","andmisa" }, 
		type = "ground_hovercraft"
	},	
	["AND_andahp_light_patrol_1"] = {
		units = { "androck", "andtanko", "andtesla", "andnikola" }, 
		type = "ground_hovercraft"
	},	
	["AND_andahp_light_patrol_2"] = {
		units = { "andnikola", "andnikola", "androck", "androck", "andtanko" }, 
		type = "ground_hovercraft"
	},		
	["AND_andplatplat_air_raid_1"] = { 			
		units = { "andstr", "andfig", "andfig", "andstr", "andstr" },
		type = "air_toground"
	},
	["AND_andplat_antiair_raid_1"] = { 
		units = { "andfig", "andfig", "andfig" },
		type = "air_toair"
	},
	["AND_andplat_air_bomber_1"] = { 
		units = { "andbomb", "andbomb", "andbomb", "andbomb", "andbomb" }, 	-- gruppo da 5 bombardieri
		type = "air_bomber"
	},		



-------------------------------------------------------------------------------
-- Elenco di produzioni per l'AI al livello 1 - le fabbriche avranno gruppi più numerosi e composti da unità più forti 
-------------------------------------------------------------------------------
	
---------------
-- ICU lvl 1 -------- Elenco di produzioni per l'AI al livello 1
---------------
	["ICU_armlab_medium_patrol_1"] = {
		units = { "icuwar", "icuwar", "icuwar", "icuwar" , "icuwar" , "icuwar" , "icuwar" },
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["ICU_armlab_medium_patrol_2"] = {
		units = { "icuwar", "icuwar", "icuwar", "icuwar" , "icurock" , "icuwar" , "icuwar", "armjeth"},
		type = "ground" 
	},
		
	
	
}

--------------------------------------------------------------------------------
-- 2b) CONFIGURAZIONE FABBRICHE E BUILDLIST
--------------------------------------------------------------------------------
-- Funzione CONFIGURAZIONE FABBRICHE in base al livello_AI, selezionare gli squad_templates (le liste di costruzione)
-- ad ogni livello il numero di unità x squadra aumenta come aumenta la qualità delle unità prodotte
local FACTORY_CONFIG = {} 		-- all'inizio imposto la tabella vuota
local livello_AI = 0 			-- all'inizio imposto il livello della AI = 0 (livello iniziale
local lastLevel = -1 			-- Usiamo -1 così al primo frame carica il livello 0. Questa variabile serve come "antiripetizione" e verrà utilizzata per aumentare di livello l' AI una volta sola

local function configurazioneUnitaLivello()
Spring.Echo(">>> AI MISSION: Caricamento configurazione per Livello " .. livello_AI) -- debug
	if livello_AI == 0 then				-- al livello iniziale = 0 produci le unità di seguito
		FACTORY_CONFIG = {
		-- ICU --
			["armlab"] = { "ICU_armlab_light_patrol_1", "ICU_armlab_light_patrol_2" },
			["armap"]  = { "ICU_armap_antiair_raid_1", "ICU_armap_air_raid_1","ICU_armap_air_bomber_1" },
			["armvp"] = { "ICU_armvp_light_patrol_1", "ICU_armvp_light_patrol_2" },
		--	["armsy"]  = { "naval_fleet" },

		-- AND --
			["andlab"] = { "AND_andlab_light_patrol_1", "AND_andlab_light_patrol_2" },
			["andalab"] = { "AND_andalab_light_patrol_1", "AND_andalab_light_patrol_2" }, 
			["andhp"] = { "AND_andhp_light_patrol_1", "AND_andhp_light_patrol_2" },
			["andahp"] = { "AND_andahp_light_patrol_1", "AND_andahp_light_patrol_2" },		
			["andplat"]  = { "AND_andplatplat_air_raid_1", "AND_andplat_antiair_raid_1","AND_andplat_air_bomber_1" },
		}
	elseif livello_AI == 1 then				-- al livello 1 produci le unità di seguito
		FACTORY_CONFIG = {
		-- ICU --
			["armlab"] = { "ICU_armlab_medium_patrol_1", "ICU_armlab_medium_patrol_2" },
			["armap"]  = { "ICU_armap_antiair_raid_1", "ICU_armap_air_raid_1","ICU_armap_air_bomber_1" },
			["armvp"] = { "ICU_armvp_light_patrol_1", "ICU_armvp_light_patrol_2" },
		--	["armsy"]  = { "naval_fleet" },

		-- AND --
			["andlab"] = { "AND_andlab_light_patrol_1", "AND_andlab_light_patrol_2" },
			["andhp"] = { "AND_andhp_light_patrol_1", "AND_andhp_light_patrol_2" },
			["andplat"]  = { "AND_andplatplat_air_raid_1", "AND_andplat_antiair_raid_1","AND_andplat_air_bomber_1" },
		}
	end
end

configurazioneUnitaLivello()	-- avvio all'inizio la funzione per caricare le fabbriche del livello 0
local TARGET_AI_NAME = "WarMachinesRTSmissionAI" 
local SQUAD_TIMEOUT_SECONDS = 600 -- questo timeout definisce i secondi di attesa per la formazione del gruppo delle unità uscite dalla fabbrica. Oltre questo timeout il gruppo si completa cosi com'è e parte all'attacco o difesa 

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
				-- La tipologia "air_bomber" manda il gruppo di unità all'attacco direttamente su una singola unità (UTILE PER I BOMBARDIERI) di tipo "ground", "building", "strategicbuilding"
				elseif squadType == "air_bomber" then 
					if enemyCat == "ground" or enemyCat == "building" or enemyCat == "strategicbuilding" then 
						return {x=x, y=y, z=z, id=uID} -- restituisco anche l'ID dell'unità che si intende bersagliare, utilizzato poi nella logica degli ordini, vedi punto 5)
					end		
				-- La tipologia "air_bomber_strategic" manda il gruppo di unità all'attacco direttamente su una singola unità di tipo "strategicbuilding"
				elseif squadType == "air_bomber_strategic" then 
					if enemyCat == "strategicbuilding" or enemyCat == "building" then 
						return {x=x, y=y, z=z, id=uID} -- restituisco anche l'ID dell'unità che si intende bersagliare, utilizzato poi nella logica degli ordini, vedi punto 5)
					end								
				-------------
				-- TERRA: 
				-------------				
				elseif squadType == "ground" then
					if enemyCat == "ground" or enemyCat == "unknown" or enemyCat == "building" or enemyCat == "strategicbuilding" then 
						return {x=x, y=y, z=z}
					elseif enemyCat == "hover" and y >= -1 then -- da -1 (spiaggia) a sopra il livello dell'acqua (montagna)
						return {x=x, y=y, z=z}
					end
				elseif squadType == "ground_hovercraft" then
					if enemyCat == "ground" or enemyCat == "unknown" or enemyCat == "building" or enemyCat == "strategicbuilding" or enemyCat == "hover" then 
						return {x=x, y=y, z=z}
					end				
				-------------					
				-- NAVALI: Attaccano naval e hover (solo se in acqua) ---- ################################### implementare
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

--[[ local function GiveAttackOrder(unitID, targetPos)
	if not targetPos then return end
		if targetData.id and Spring.ValidUnitID(targetData.id) then -- ## valutare se introdurre Spring.ValidUnitID(targetData.id) ########
--		if targetData.id then 	-- ORDINE DI ATTACCO DIRETTO ALL'UNITÀ (Cruciale per i bombardieri). Se la logica 4) smuove lo squadtype dedicato ai bombardieri, questi devono attaccare direttamente l'unità bersaglio altrimenti col comando fight o patrol non lo farebbero, "siedendosi" a destinazione
			Spring.GiveOrderToUnit(unitID, CMD.ATTACK, {targetData.id}, {})
		else				  	-- ALTRIMENTI ORDINE DI ATTACCO FIGHT. Per tutte le unità che rispondono a questo comando, attaccando naturalmente le unità lungo il percorso.
			Spring.GiveOrderToUnit(unitID, CMD.STOP, {}, {})
			local tx = targetPos.x + math.random(-250, 250)
			local tz = targetPos.z + math.random(-250, 250)
			local ty = Spring.GetGroundHeight(tx, tz)

		end
end
]]--
local function GiveAttackOrder(unitID, targetData)
	if not targetData then 
		return 
	end
	Spring.GiveOrderToUnit(unitID, CMD.STOP, {}, {}) 					-- ######## valutare se mantenere questa linea per "pulire gli ordini precedenti" ################################
	if targetData.id and Spring.ValidUnitID(targetData.id) then			-- Se abbiamo un unitID valido...
		Spring.GiveOrderToUnit(unitID, CMD.ATTACK, {targetData.id}, {}) -- ... SPARTISCO L' ORDINE DI ATTACCO DIRETTO ALL'UNITÀ (Cruciale per i bombardieri)
	else																-- Se non abbiamo un unitID, usiamo le coordinate come ripiego (Area Attack)
		local tx = targetData.x + math.random(-250, 250)
		local tz = targetData.z + math.random(-250, 250)
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
-- GESTIONE AVANZAMENTO DI LIVELLO
-- livello_AI = math.floor(Spring.GetGameSeconds() / 60)	-- ############################################ RIATTIVARE QUESTA RIGA PER L'AVANZAMENTO DEL LIVELLO DELLA AI    -- Avanzamento automatico del livello ogni 60 secondi (per test)  ############################
--	math.floor(Spring.GetGameSeconds() / 60) è un calcolo matematico "assoluto":
--  A 0 secondi: 0 / 60 = 0.0 -> floor = 0
--  A 59 secondi: 59 / 60 = 0.98 -> floor = 0
--  A 60 secondi: 60 / 60 = 1.0 -> floor = 1
--  A 120 secondi: 120 / 60 = 2.0 -> floor = 2
--  Se volessi fare ogni 18 minuti?
--	Basta cambiare il divisore. Siccome 1 minuto = 60 secondi, 18 minuti sono 18×60=1080  secondi.La riga diventerebbe: 18×60=1080
if livello_AI > 1 then livello_AI = 1 end 					-- Evitiamo di sforare i livelli che abbiamo definito, riportando a "x" il livello della AI
-- SE IL LIVELLO È CAMBIATO, AGGIORNA LA TABELLA
    if livello_AI ~= lastLevel then
		Spring.Echo("WMRTS AI:cambio livello") 	-- DEBUG ############################################### CANCELLARE
        configurazioneUnitaLivello()
        lastLevel = livello_AI
    end									-- Aggiorno le tabelle delle costruzioni
Spring.Echo(livello_AI)					-- DEBUG ############################################### CANCELLARE
	-- GESTIONE FABBRICHE
	for fID, fData in pairs(factories) do
		local qSize = Spring.GetCommandQueue(fID, 0)
		
		-- SE qSize è nil, perchè una fabbrica non esiste più (è stata distrutta, rimossa con mission editor, ecc), la rimuoviamo dalla lista, altrimenti l' AI va in errore per valori NIL
		if qSize == nil then
			factories[fID] = nil -- La rimuoviamo dalla lista così non ci darà più noia
		else		
		
		local isBuilding = Spring.GetUnitIsBuilding(fID)
		local isLocked = false
		
		if fData.squadID and squads[fData.squadID] then -- Ora qSize è sicuramente un numero (grazie all'else sopra)
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
		end -- Fine else (qSize ~= nil)
	end 	-- Fine loop fabbriche

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