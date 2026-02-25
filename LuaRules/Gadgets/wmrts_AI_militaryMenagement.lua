function gadget:GetInfo()
	return {
		name      = "WMRTS Squad Commander AI",
		desc      = "AI V16-17 for War Machnines RTS",
		author    = "molix",
		date      = "2025",
		license   = "GPL",
		layer     = 100,
		enabled   = true
	}
end

-- 08/01/2025 = creata l'AI WMRTS_AI per missioni (base per l'AI skirmish)
-- 09/01/2025 = implementato il comando attack al gruppo di bombardieri. Prima l'AI gestiva solamente il comando FIGHT ma i bombardieri non bombardano automaticamente, bisogna indicargli il punto da bombardare con il comando Attack.
-- 09/01/2025 = esternizzata la tabella/db delle unità in WMRTS_AI_mission_db.lua
-- 11/01/2025 = sistemato bug tabelle NIL quando una fabbrica viene distrutta/rimossa
-- 12/01/2025 = agguiunti i livelli di difficoltà della AI. Per ora scattano dopo x minuti di tempo. Predisposto per una logica migliore di avanzamento (ad esempio quando ci sarà il controllo dei costruttori e l'avanzamento è dato da quanti estrattori e/o centrali solari l'AI ha costruito)
-- 14/01/2025 = le AI sono ora indipendenti (mentre prima il livello delle AI era unico per tutti i teams
-- 14/01/2025 = Aggiungo la gestione " ignore = true" nel database, da applicare ai costruttori (o altre unità), gestiti da altri gadget. In questo gadget le unità con ignore = true devono essere ignorate (cioè non devono essere inseriti in gruppi e mandati all'attacco), devono essere considerati invece solo come bersagli da attaccare ("ground" o relativi), a seconda di come sono impostate nel database esterno.
-- 29/01/2025 = Ora l'avanzamento di livello viene gestito dal gadget construcionManagement
-- 09/02/2025 = Aggiunta priorità nella categoria di attacco (per bombardieri & Co) e aggiunta categoria defence e strategicdefence
-- 20/02/2026 = Ho aggiunto la categoria (type) strategicshield in quanto prima gli shield erano inclusi in "strategicbuilding". In questo modo i cannoni a lungo raggio gestiti dalla AI del gadget "wmrts_AI_longWeaponManagement.lua" non prendono di mira gli shield (antiplasma) che prima erano categorizzati come "strategicbuilding". Il codice in questo gadget viene modificato in modo che, se prima, la categoria "X" attaccava solo "strategicbuilding", ora deve attaccare anche la type scorporata "strategicbuilding"
-- 24/02/2026 = road to V17 - ora il gadget riceve lo stato di guerra, il punto base e il raggio della base. a seconda dello stato di guerra, gestisce le unità dentro/fuori raggio base mandandole all'attacco o in difesa
-- to do LIST ################################
-- 1) implementare i SUB


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
-- definizione delle tipologie "type":
--			type = ground 				-> unità mobile di terra (veicoli e Kbot)
--			type = air 					-> unità mobile aerea
--			type = hovercraft 			-> unità mobile di terra che può andare sul mare
--			type = naval 				-> unità mobile navale (di superficie, no SUB)
--			type = building 			-> unità fissa di superficie su terra (di difesa/produzione/energia)
--			type = navalbuilding 		-> unità fissa di superficie su mare (di difesa/produzione/energia)
--			type = defence 				-> unità fissa di difesa T1-2 + ( Es torrette di difesa importanti, antiaerea ecc )
--			type = strategicbuilding 	-> unità fissa di superficie strategica ( Es factory 3 livello, silos, antipalline, ecc )
--			type = strategicdefence 	-> unità fissa di difesa strategica ( Es bertha, corbuzz, toaster, ecc )
--			type = strategicshield		-> unità fissa shield (es. plasma repulsor) 
--			tutte le unità che non sono identificate in questo database, prenderanno valore type = unknown , vedere poi la logica di targetin come gestirle

local dbPath = "LuaRules/Configs/WMRTS_AI_mission_db.lua"
local UNIT_DB = VFS.Include(dbPath)

-- Debug in caso di mancanza del database
if not UNIT_DB then
    Spring.Echo("WMRTS_militMngm_AI: WARNING -> WM AI units database not found in: " .. dbPath)
    UNIT_DB = {}
end

--------------------------------------------------------------------------------
-- 2a) CONFIGURAZIONE SQUADRE / GRUPPI (LISTE DI COSTRUZIONE) e tipologia
--------------------------------------------------------------------------------

-- Il nome dello "squad_template" identifica solamente il nome del gruppo da creare. Es. ["ICU_armlab_light_patrol_1"], verrà poi impiegato nel punto 2b per dire alla fabbrica: costruisci le unità di questo gruppo e forma il gruppo
-- units = l'elenco delle unità (solo militari) che comporranno il gruppo (ad esempio il gruppo "ICU_armlab_light_patrol_1". Le unità di costruzione (dichiarate nel database) non verranno gestite nel gruppo ma verranno ignorate per essere gestite da altri gadget
-- type = tipologia di squadra, la tipologia verrà impiegata nella logica di targeting (punto 4) per dire quali unità devono attaccare. In generale descrizioni a seguito:
-- 					type = "ground" 				-> manda all'attacco verso la prima unità, trovata in base all'ID, che corrisponda a "ground", "building", "strategicbuilding", "strategicdefence", "unknown" e "defence" se y di quest'ultima > -1 (vedere punto 4). Ideale per le truppe di terra o gli aerei.
-- 					type = "ground_hovercraft" 		-> manda all'attacco verso la prima unità, trovata in base all'ID, che corrisponda a "ground", "building", "strategicbuilding", "strategicdefence", "unknown", "defence" e "hover" a prescindere dalla y di quest'ultima (rispetto al gruppo "ground". Ideale per gli hovecraft e per gli aerei
--					type = "air_toair" 				-> tutti gli aerei destinati ad attaccare solo aerei
--					type = "air_toground" 			-> tutti gli aerei destinati ad attaccare tutte le unità mobili di terra (ground, hovercraft e naval). Attenzione: non sono presenti "building", "strategicbuilding", "strategicdefence", "defence". In questa categoria non mettere bombardieri in quanto sorvolerebbero solamente la zona per poi "sedersi". Per loro ci vuole una logica di attacco diretto sull'unità, per questo usare i gruppi specifici per bombardieri
--					type = "air_bomber" 			-> specifico per tutti gli aerei da bombardamento. In questo gruppo possono essere inclusi anche gli aerei di attacco a terra (tipo armfig e bombardieri). Hanno una logica con priorità sui target e manda le unità all'attacco direttamente sull'unità di tipo (in ordine di priorità): "building", "defence", "strategicbuilding", "strategicdefence", "ground")
--					type = "air_bomber_strategic" 	-> specifico per tutti gli aerei da bombardamento. In questo gruppo possono essere inclusi anche gli aerei di attacco a terra (tipo armfig e bombardieri). Hanno una logica con priorità sui target e manda le unità all'attacco direttamente sull'unità di tipo (in ordine di priorità):"strategicbuilding", "strategicdefence", "building", "defence" e "ground"

local SQUAD_TEMPLATES = {

-- divido qui sotto i template di costruzione in funzione del livello, solo per maggior chiarezza. Quando il livello sale, vado a cambiare i templates di costruzione in 2b)

-------------------------------------------------------------------------------
--  Set di gruppi per l'AI - le ho divise per livello per una maggiore visibilità, ma sono soltanto nomi di gruppi e nessuno vieta che al livello 3 si posssa produrre il gruppo "ICU_armlab_light_patrol_1" del livello 0. Basta elencare i gruppi che si voglio creare, in base al livello, nel paragrafo 2b
-------------------------------------------------------------------------------

---------------
-- ICU gruppi creati per il lvl 0÷4 -------- 
---------------
-- armlab
	["ICU_armlab_light_patrol_1"] = {
		units = { "icupatroller", "icupatroller", "icurock", "icurock" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["ICU_armlab_light_patrol_2"] = {
		units = { "icuwar", "icupatroller", "icurock", "icurock" },				
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- armvp	
	["ICU_armvp_light_patrol_1"] = {
		units = { "armfav", "icuflash", "icuflash", "icuflash" }, 
		type = "ground"
	},
	["ICU_armvp_light_patrol_2"] = {
		units = { "armsam", "armsam", "armstump", "armpincer", "armpincer","tawf013" }, 
		type = "ground"
	},	
-- armap	
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
-- armalab
	["ICU_armalab_light_patrol_1"] = {
		units = { "armfast", "armfast", "armfast" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["ICU_armalab_light_patrol_2"] = {
		units = { "armfast", "armfast", "armzeus" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- armavp
	["ICU_armavp_light_patrol_1"] = {
		units = { "armmart", "armmart", "armlatnk" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["ICU_armavp_light_patrol_2"] = {
		units = { "armlatnk", "armlatnk"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- armaap
	["ICU_armaap_light_patrol_1"] = {
		units = { "armhawk", "armhawk", "armhawk" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["ICU_armaap_light_patrol_2"] = {
		units = { "armhawk", "armhawk"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		
---------------
-- AND gruppi creati per il lvl 0÷4 -------- 
---------------
-- andlab
	["AND_andlab_light_patrol_1"] = {
		units = { "andscouter", "andscouter", "andspmis", "andspmis" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["AND_andlab_light_patrol_2"] = {
		units = { "anddauber", "andscouter", "andspmis", "andspmis" },				
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- andhp	
	["AND_andhp_light_patrol_1"] = {
		units = { "andgaso", "andgaso", "andgaso", "andlipo" }, 
		type = "ground"
	},
	["AND_andhp_light_patrol_2"] = {
		units = { "andmisa", "andmisa", "andlipo", "andlipo", "andlipo","andhart" }, 
		type = "ground"
	},	
-- andplat	
	["AND_andplat_air_raid_1"] = { 			
		units = { "andmer", "andfig", "andfig", "andmer", "andmer" },
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
--	["naval_fleet"] = {
--		units = { "corbats", "corbats", "corbats" },
--		type = "naval"
--	}
-- andalab
	["AND_andalab_light_patrol_1"] = {
		units = { "walker", "walker", "walker" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["AND_andalab_light_patrol_2"] = {
		units = { "walker", "walker", "exxec" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- andahp
	["AND_andahp_light_patrol_1"] = {
		units = { "armmart", "armmart", "armlatnk" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["AND_andahp_light_patrol_2"] = {
		units = { "armlatnk", "armlatnk"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- andaplat
	["AND_andaplat_light_patrol_1"] = {
		units = { "anddragon", "corhors", "corhors" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["AND_andaplat_light_patrol_2"] = {
		units = { "anddragon", "corhors"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		

-------------------------------------------------------------------------------
-- Elenco di produzioni per l'AI al livello 5+ - le fabbriche avranno gruppi più numerosi e composti da unità più forti 
-------------------------------------------------------------------------------
	
---------------
-- ICU gruppi creati per il lvl 5+ -------- 
---------------
-- armlab
	["ICU_armlab_medium_patrol_1"] = {
		units = { "icuwar", "icuwar", "icuwar", "icurock", "icurock" , "icurock", "icuinv", "armjeth"  }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["ICU_armlab_medium_patrol_2"] = {
		units = { "icuwar", "icuwar", "icurock", "icurock", "icurock", "icurock", "armjeth", "icuinv", "icuinv" },				
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- armvp	
	["ICU_armvp_medium_patrol_1"] = {
		units = { "armsam", "armsam", "armsam", "tawf013", "armsam", "armstump", "armpincer", "armsam" }, 
		type = "ground"
	},
	["ICU_armvp_medium_patrol_2"] = {
		units = { "armsam", "armsam", "armsam", "tawf013", "armstump", "tawf013", "armstump", "armpincer", "armpincer", "armpincer" }, 
		type = "ground"
	},	
-- armap	
	["ICU_armap_air_mediumraid_1"] = { 			
		units = { "armkam", "armfig", "armfig", "armkam", "armkam", "armkam", "armkam", "armkam", "armkam", "armkam" },
		type = "air_toground"
	},
	["ICU_armap_antiair_mediumraid_1"] = { 
		units = { "armfig", "armfig", "armfig", "armfig", "armfig", "armfig", "armfig", "armfig", "armfig", "armfig" },
		type = "air_toair"
	},
	["ICU_armap_air_mediumbomber_1"] = { 
		units = { "armthund", "armthund", "armthund", "armthund", "armthund", "armthund", "armthund", "armthund", "armthund", "armthund" }, 	-- gruppo da 10 bombardieri
		type = "air_bomber"
	},	
	["ICU_armap_air_mediumstrategicbomber_1"] = { 
		units = { "armthund", "armthund", "armthund", "armthund", "armthund", "armthund", "armthund", "armthund", "armthund", "armthund", "armthund", "armthund" }, 	-- gruppo da 12 bombardieri
		type = "air_bomber_strategic"
	},				
--	["naval_fleet"] = {
--		units = { "corbats", "corbats", "corbats" },
--		type = "naval"
--	}
-- armalab
	["ICU_armalab_medium_patrol_1"] = {
		units = { "icufboy", "icufboy", "icufboy", "armaak", "icufboy", "icufboy", "armfido" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["ICU_armalab_medium_patrol_2"] = {
		units = { "armsptk", "armsptk", "armsptk", "armsptk", "armsptk", "armaak", "armsptk", "armsptk" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- armavp
	["ICU_armavp_medium_patrol_1"] = {
		units = { "armmart", "armmart", "armyork", "armmart", "armmart", "armmart", "armmart", "armmart", "armmart", "icubull", "icubull" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["ICU_armavp_medium_patrol_2"] = {
		units = { "armlatnk", "armlatnk", "icubull", "icubull", "armmart", "armyork"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["ICU_armavp_medium_patrol_3"] = {
		units = { "armlatnk", "armlatnk", "icubull", "icubull", "armmart", "armyork", "armmanni", "armcroc", "armcroc"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		
-- armaap
	["ICU_armaap_medium_patrol_1"] = {
		units = { "armhawk", "armhawk", "armhawk", "armhawk", "armhawk", "armhawk", "armhawk", "armhawk", "armhawk" }, 
		type = "air_toair" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["ICU_armaap_medium_patrol_2"] = {
		units = { "blade", "blade", "armbrawl", "armbrawl", "blade", "blade", "armbrawl", "armbrawl", "armbrawl", "armbrawl"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		
	["ICU_armaap_air_bomber_1"] = { 
		units = { "armbrawl", "armbrawl", "armbrawl", "armbrawl", "armpnix", "armpnix", "armbrawl", "armbrawl", "armbrawl" }, 	
		type = "air_bomber"
	},		
	["ICU_armaap_air_bomber_2"] = { 
		units = { "armpnix", "armpnix", "armpnix", "armpnix", "armpnix", "armpnix", "armpnix", "armpnix", "armpnix", "armpnix", "armpnix", "armpnix", "armpnix", "armcybr", "armcybr" }, 	
		type = "air_bomber_strategic"
	},		
	["ICU_armaap_air_bomber_3"] = { 
		units = { "armcybr", "armcybr", "armcybr", "armcybr", "armcybr" }, 	
		type = "air_bomber_strategic"
	},			
-- icugant
	["ICU_icugant_medium_patrol_1"] = {
		units = { "armshock", "armshock", "armtigre" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		
	["ICU_icugant_medium_patrol_2"] = {
		units = { "armshock", "armshock" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},			
	["ICU_icugant_medium_patrol_3"] = {
		units = { "armtigre", "armtigre" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},			
-- armshltx
	["ICU_armshltx_medium_patrol_1"] = {
		units = { "icuraz", "icuraz", "icuraz" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["ICU_armshltx_medium_patrol_2"] = {
		units = { "icuraz", "icuraz", "icuraz", "icuraz", "warhammer" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["ICU_armshltx_medium_patrol_3"] = {
		units = { "icufurie" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["ICU_armshltx_medium_patrol_4"] = {
		units = { "icufurie", "icuraz","icuraz" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},			
	["ICU_armshltx_medium_patrol_5"] = {
		units = { "warhammer", "warhammer", "icuraz","icuraz" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},				
---------------
-- AND gruppi creati per il lvl 5+ -------- 
---------------
-- andlab
	["AND_andlab_medium_patrol_1"] = {
		units = { "anddauber", "anddauber", "andbrskr", "andspmis", "andspmis" , "andspmis", "andspaa", "andbrskr"  }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["AND_andlab_medium_patrol_2"] = {
		units = { "anddauber", "andbrskr", "andspmis", "andspmis", "andspmis", "andspmis", "andbrskr", "andspaa", "anddauber" },				
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- andhp	
	["AND_andhp_medium_patrol_1"] = {
		units = { "andmisa", "andmisa", "andmisa", "andhart", "andmisa", "andlipo", "andlipo", "andmisa" }, 
		type = "ground"
	},
	["AND_andhp_medium_patrol_2"] = {
		units = { "andmisa", "andmisa", "andmisa", "andhart", "andlipo", "andhart", "andlipo", "andlipo", "andlipo", "andlipo" }, 
		type = "ground"
	},	
-- andplat	
	["AND_andplat_air_mediumraid_1"] = { 			
		units = { "andmer", "andfig", "andfig", "andmer", "andmer", "andmer", "andmer", "andmer", "andmer", "andmer" },
		type = "air_toground"
	},
	["AND_andplat_antiair_mediumraid_1"] = { 
		units = { "andfig", "andfig", "andfig", "andfig", "andfig", "andfig", "andfig", "andfig", "andfig", "andfig" },
		type = "air_toair"
	},
	["AND_andplat_air_mediumbomber_1"] = { 
		units = { "andbomb", "andbomb", "andbomb", "andbomb", "andbomb", "andbomb", "andbomb", "andbomb", "andbomb", "andbomb" }, 	-- gruppo da 10 bombardieri
		type = "air_bomber"
	},	
	["AND_andplat_air_mediumstrategicbomber_1"] = { 
		units = { "andbomb", "andbomb", "andbomb", "andbomb", "andbomb", "andbomb", "andbomb", "andbomb", "andbomb", "andbomb", "andbomb", "andbomb" }, 	-- gruppo da 12 bombardieri
		type = "air_bomber_strategic"
	},				
--	["naval_fleet"] = { -- ## nel caso non ci sono unità navali -> usare hovercraft
--		units = { "corbats", "corbats", "corbats" },
--		type = "naval"
--	}
-- andalab
	["AND_andalab_medium_patrol_1"] = {
		units = { "andogre", "andogre", "exxec", "walker", "interceptor", "interceptor", "andogre" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["AND_andalab_medium_patrol_2"] = {
		units = { "walker", "walker", "exxec", "walker", "walker", "walker", "walker", "walker" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- andahp
	["AND_andahp_medium_patrol_1"] = {
		units = { "androck", "androck", "andahaa", "androck", "androck", "androck", "androck", "androck", "androck", "andtanko", "andtanko" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["AND_andahp_medium_patrol_2"] = {
		units = { "andnikola", "andnikola", "andtanko", "andtanko", "androck", "andahaa"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["AND_andahp_medium_patrol_3"] = {
		units = { "andnikola", "andnikola", "andtanko", "andtanko", "androck", "andahaa", "andnikola", "andtanko", "andtanko"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		
-- andaplat
	["AND_andaplat_medium_patrol_1"] = {
		units = { "andhawk", "andhawk", "andhawk", "andhawk", "andhawk", "andhawk", "andhawk", "andhawk", "andhawk" }, 
		type = "air_toair" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["AND_andaplat_medium_patrol_2"] = {
		units = { "anddragon", "anddragon", "corhors", "corhors", "anddragon", "anddragon", "corhors", "corhors", "corhors", "corhors"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		
	["AND_andaplat_air_bomber_1"] = { 
		units = { "corhors", "corhors", "corhors", "corhors", "andstr", "andstr", "corhors", "corhors", "corhors" }, 	
		type = "air_bomber"
	},		
	["AND_andaplat_air_bomber_2"] = { 
		units = { "andstr", "andstr", "andstr", "andstr", "andstr", "andstr", "andstr", "andstr", "andstr", "andstr", "andstr", "andstr", "andstr", "corhors", "corhors" }, 	
		type = "air_bomber_strategic"
	},		
	["AND_andaplat_air_bomber_3"] = { 
		units = { "corhors", "corhors", "anddragon", "anddragon", "anddragon" }, 	
		type = "air_bomber_strategic"
	},			
-- andgant_terrestre -- ####################### definire ed inserire i ragnoni
	["AND_andgant_terrestre_medium_patrol_1"] = { -- ####################### definire ed inserire i ragnoni
		units = { "armshock", "armshock", "armtigre" },  -- ####################### definire ed inserire i ragnoni
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		
	["AND_andgant_terrestre_medium_patrol_2"] = { -- ####################### definire ed inserire i ragnoni
		units = { "armshock", "armshock" },  -- ####################### definire ed inserire i ragnoni
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},			
	["AND_andgant_terrestre_medium_patrol_3"] = { -- ####################### definire ed inserire i ragnoni
		units = { "armtigre", "armtigre" },  -- ####################### definire ed inserire i ragnoni
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},			
-- andgant
	["AND_andgant_medium_patrol_1"] = {
		units = { "bigb", "bigb", "bigb" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["AND_andgant_medium_patrol_2"] = {
		units = { "bigb", "bigb", "bigb", "bigb", "conartist" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["AND_andgant_medium_patrol_3"] = {
		units = { "armpraet" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["AND_andgant_medium_patrol_4"] = {
		units = { "cordem", "bigb","bigb" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},			
	["AND_andgant_medium_patrol_5"] = {
		units = { "conartist", "conartist", "bigb","bigb" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		
} -- end tabella squadre

--------------------------------------------------------------------------------
-- 2b) CONFIGURAZIONE FABBRICHE E BUILDLIST
--------------------------------------------------------------------------------
-- Funzione CONFIGURAZIONE FABBRICHE in base al teamLevels, selezionare gli squad_templates (le liste di costruzione)
-- ad ogni livello il numero di unità x squadra aumenta come aumenta la qualità delle unità prodotte
-- ogni livello è indipendente per ogni team
local teamLevels = {}       -- Tabella: [teamID] = livello attuale dell'AI per ogni singolo team (0, 1, 2...)
local teamConfigs = {}      -- Tabella: [teamID] = la FACTORY_CONFIG specifica per livello di ogni team

local FACTORY_CONFIG = {} 		-- all'inizio imposto la tabella vuota ################################  SOSTITUIRE???

local function GetConfigPerLivello(livello) -- Questa funzione restituisce, per ciascun team, la tabella delle fabbriche in funzione del livello corrente del team
    if livello <= 4 then					
        return {
            -- ICU --
            ["armlab"] = { "ICU_armlab_light_patrol_1", "ICU_armlab_light_patrol_2" },
            ["armvp"] = { "ICU_armvp_light_patrol_1", "ICU_armvp_light_patrol_2" },
            ["armap"]  = { "ICU_armap_antiair_raid_1", "ICU_armap_air_raid_1","ICU_armap_air_bomber_1" },			
            ["armalab"] = { "ICU_armalab_light_patrol_1", "ICU_armalab_light_patrol_2" },							-- inseriti in caso di recessione della AI dal livello 4+ a 0
            ["armavp"] = { "ICU_armavp_light_patrol_1", "ICU_armavp_light_patrol_2" },			
            ["armaap"]  = { "ICU_armaap_light_patrol_1", "ICU_armaap_light_patrol_2"},			
            -- AND --
            ["andlab"] = { "AND_andlab_light_patrol_1", "AND_andlab_light_patrol_2" },
            ["andhp"] = { "AND_andhp_light_patrol_1", "AND_andhp_light_patrol_2" },
            ["andplat"]  = { "AND_andplat_antiair_raid_1", "AND_andplat_air_raid_1","AND_andplat_air_bomber_1" },			
            ["andalab"] = { "AND_andalab_light_patrol_1", "AND_andalab_light_patrol_2" },							-- inseriti in caso di recessione della AI dal livello 4+ a 0
            ["andahp"] = { "AND_andahp_light_patrol_1", "AND_andahp_light_patrol_2" },			
            ["andaplat"]  = { "AND_andaplat_light_patrol_1", "AND_andaplat_light_patrol_2"},	
        }
    elseif livello > 4 then
        return {
            -- ICU --
            ["armlab"] = { "ICU_armlab_medium_patrol_1", "ICU_armlab_medium_patrol_2" },
            ["armvp"] = { "ICU_armvp_medium_patrol_1", "ICU_armvp_medium_patrol_2" },
            ["armap"]  = { "ICU_armap_air_mediumraid_1", "ICU_armap_antiair_mediumraid_1","ICU_armap_air_mediumbomber_1","ICU_armap_air_mediumstrategicbomber_1" },
            ["armalab"] = { "ICU_armalab_medium_patrol_1", "ICU_armalab_medium_patrol_2" },			
            ["armavp"] = { "ICU_armavp_medium_patrol_1", "ICU_armavp_medium_patrol_2", "ICU_armavp_medium_patrol_3" },
            ["armaap"]  = { "ICU_armaap_medium_patrol_1", "ICU_armaap_medium_patrol_2","ICU_armaap_air_bomber_1","ICU_armaap_air_bomber_2", "ICU_armaap_air_bomber_3" },		
            ["icugant"] = { "ICU_icugant_medium_patrol_1", "ICU_icugant_medium_patrol_2", "ICU_icugant_medium_patrol_3" },		
            ["armshltx"] = { "ICU_armshltx_medium_patrol_1", "ICU_armshltx_medium_patrol_2", "ICU_armshltx_medium_patrol_3", "ICU_armshltx_medium_patrol_4", "ICU_armshltx_medium_patrol_5" },		
            -- AND --
            ["andlab"] = { "AND_andlab_medium_patrol_1", "AND_andlab_medium_patrol_2" },
            ["andhp"] = { "AND_andhp_medium_patrol_1", "AND_andhp_medium_patrol_2" },
            ["andplat"]  = { "AND_andplat_air_mediumraid_1", "AND_andplat_antiair_mediumraid_1","AND_andplat_air_mediumbomber_1","AND_andplat_air_mediumstrategicbomber_1" },
            ["andalab"] = { "AND_andalab_medium_patrol_1", "AND_andalab_medium_patrol_2" },			
            ["andahp"] = { "AND_andahp_medium_patrol_1", "AND_andahp_medium_patrol_2", "AND_andahp_medium_patrol_3" },
            ["andaplat"]  = { "AND_andaplat_medium_patrol_1", "AND_andaplat_medium_patrol_2","AND_andaplat_air_bomber_1","AND_andaplat_air_bomber_2", "AND_andaplat_air_bomber_3" },		
            ["andgant_terrestre"] = { "AND_andgant_terrestre_medium_patrol_1", "AND_andgant_terrestre_medium_patrol_2", "AND_andgant_terrestre_medium_patrol_3" },		
            ["andgant"] = { "AND_andgant_medium_patrol_1", "AND_andgant_medium_patrol_2", "AND_andgant_medium_patrol_3", "AND_andgant_medium_patrol_4", "AND_andgant_medium_patrol_5" },				
        }
    end
    return {} -- default vuoto
end

local TARGET_AI_NAME = "WarMachinesRTSmissionAI" 
local SQUAD_TIMEOUT_SECONDS = 600 -- questo timeout definisce i secondi di attesa per la formazione del gruppo delle unità uscite dalla fabbrica. Oltre questo timeout il gruppo si completa cosi com'è e parte all'attacco o difesa 

--------------------------------------------------------------------------------
-- 3) VARIABILI
--------------------------------------------------------------------------------

local aiTeamIDs = {}      
local factories = {}      
local squads = {}     
local basePoint = {}		-- Tabella: [teamID] = coordinate del punto base per ogni singolo team (0, 1, 2...)
local baseRadius = {}		-- Tabella: [teamID] = raggio di difesa della base per ogni singolo team (0, 1, 2...)
local warStatus = {}		-- Tabella: [teamID] = stato di guerra  per ogni singolo team (0, 1, 2...), può essere "attacco", "difesa_leggera", "difesa_pesante". Si veda "wmrts_AI_constructionManagement.lua" per maggiori dettagli        

--------------------------------------------------------------------------------
-- 4) LOGICA DI TARGETING BASATA SU DATABASE
--------------------------------------------------------------------------------

-- Funzione per ottenere la categoria dal NOSTRO database
local function GetUnitCategoryFromDB(unitID)
	local uDefID = Spring.GetUnitDefID(unitID)	-- definizione di Spring.GetUnitDefID(unitID)
	if not uDefID then return "unknown" end		-- se non esiste ID assegnato all'unità la funzione restituisce il valore "unknown"
	local unitName = UnitDefs[uDefID].name		-- altrimenti prosegui e assegna a unitrname il nome dell'unità
	
	if UNIT_DB[unitName] then					-- se nel database è presente la voce col il nome dell'unità (unitName)
		return UNIT_DB[unitName].type			-- restituisci type inerente al nome di quella unità
	end											
	return "unknown" 							-- altrimenti se niente di cui sopra è avvenuto, restituisci "unknown"
end

--------------------------------------------------------------------------------
-- 4b) LOGICA DI TARGETING LIMITATA AL RAGGIO DELLA BASE
--------------------------------------------------------------------------------
-- Funzione per trovare tutte le unità all'interno e all'esterno del raggio della base
local function SplitUnitsByRadius(unitList, bPos, bRad)
    local unitsInside = {}
    local unitsOutside = {}
    
    if not bPos or not bRad then return unitsInside, unitsOutside end

    local radSq = bRad * bRad
    for i = 1, #unitList do
        local uID = unitList[i]
        if Spring.ValidUnitID(uID) then
            local ux, _, uz = Spring.GetUnitPosition(uID)
            if ux then
                local dx = ux - bPos.x
                local dz = uz - bPos.z
                local distSq = (dx * dx) + (dz * dz)
                
                if distSq <= radSq then
                    table.insert(unitsInside, uID)
                else
                    table.insert(unitsOutside, uID)
                end
            end
        end
    end
    return unitsInside, unitsOutside
end

-- Funzione per trovare il bersaglio in tutta la mappa (verrà utilizzata nella modalità attacco)
local function GetSmartEnemyTarget(myTeamID, squadType)
	local allUnits = Spring.GetAllUnits()
	local gaiaTeamID = Spring.GetGaiaTeamID()
	
	-- Variabili per la logica di priorità dei bombardieri 
	local bestTarget = nil
	local highestPriority = -1

	for i = 1, #allUnits do
		local uID = allUnits[i]
		local uTeam = Spring.GetUnitTeam(uID)
		
		if uTeam ~= gaiaTeamID and not Spring.AreTeamsAllied(myTeamID, uTeam) then
			local enemyCat = GetUnitCategoryFromDB(uID)
			local x, y, z = Spring.GetUnitPosition(uID)
			
			if x then
				-------------
				-- TERRA: -- il ciclo for scansiona per ID di unità. l'AI quindi sceglie la prima unità che trova e che corrisponde ad una delle seguenti categorie "enemyCat". Quindi senza priorità.
				-------------	
				if squadType == "ground" then -- solo truppe di terra vs terra
				-- "ground", "building", "strategicbuilding", "unknown" e "defence"
					if enemyCat == "ground" or enemyCat == "unknown" or enemyCat == "building" or enemyCat == "strategicbuilding" or enemyCat == "strategicdefence" or enemyCat == "defence" or enemyCat == "strategicshield" then 
						return {x=x, y=y, z=z}
					elseif enemyCat == "hover" and y >= -1 then	-- se gli hovercraft sono o sulla riva o sulla terraferma
						return {x=x, y=y, z=z}
					end

				elseif squadType == "ground_hovercraft" then -- solo truppe di mare e terra vs hovercraft 
					if enemyCat == "ground" or enemyCat == "unknown" or enemyCat == "building" or enemyCat == "strategicbuilding" or enemyCat == "strategicdefence"or enemyCat == "hover" or enemyCat == "defence" or enemyCat == "strategicshield" then  
						return {x=x, y=y, z=z}
					end
				-------------					
				-- NAVALI: Attaccano naval e hover (solo se sopra la superficie dell' acqua) ---- ################################### implementare
				-------------				
				elseif squadType == "naval" then
					if enemyCat == "naval" then
						return {x=x, y=y, z=z}
					elseif enemyCat == "hover" and y < -1 then -- minore di -1 (da -x a -1) rispetto al livello dell'acqua, si presume tutti gli hovercraft che sono in acqua  ###################### verificare se il parametro altezza è corretto per definire che l'hovercraft è in acqua
						return {x=x, y=y, z=z}
					end
				-------------
				-- AEREI: 
				-------------	
				elseif squadType == "air_toair" then
					if enemyCat == "air" then 
						return {x=x, y=y, z=z} 
					end
				elseif squadType == "air_toground" then
					if enemyCat == "ground" or enemyCat == "naval" or enemyCat == "hover" then
						return {x=x, y=y, z=z} 
					end				
				elseif squadType == "air_bomber" then 					--(su "airbomber" non usiamo "return" subito perché vogliamo scansionare tutto e dare ai bombardieri una priorità sulle categorie da attaccare e, se non esiste la prima (priorità più alta), vai sulla seconda e cosi via...
					local currentPriority = 0
					if enemyCat == "defence" then
						currentPriority = 6
					elseif enemyCat == "building" then
						currentPriority = 5
					elseif enemyCat == "strategicbuilding" then
						currentPriority = 4
					elseif enemyCat == "strategicdefence" then
						currentPriority = 3
					elseif enemyCat == "strategicshield" then
						currentPriority = 2						
					elseif enemyCat == "ground" then
						currentPriority = 1						
					end
						if currentPriority > highestPriority then
							highestPriority = currentPriority
							bestTarget = {x=x, y=y, z=z, id=uID}
							if highestPriority == 6 then break end -- Se trovo il top, interrompo il ciclo for
						end					
				elseif squadType == "air_bomber_strategic" then			--(su "air_bomber_strategic", non usiamo "return" subito perché vogliamo scansionare tutto e dare ai bombardieri una priorità sulle categorie da attaccare e, se non esiste la prima, vai sulla seconda e cosi via...
					local currentPriority = 0
					if enemyCat == "strategicbuilding" then
						currentPriority = 6
					elseif enemyCat == "strategicshield" then
						currentPriority = 5
					elseif enemyCat == "strategicdefence" then					
						currentPriority = 4						
					elseif enemyCat == "building" then
						currentPriority = 3
					elseif enemyCat == "defence" then
						currentPriority = 2
					elseif enemyCat == "ground" then
						currentPriority = 1		
					end
						if currentPriority > highestPriority then
							highestPriority = currentPriority
							bestTarget = {x=x, y=y, z=z, id=uID}
							if highestPriority == 6 then break end -- Se trovo il top, interrompo il ciclo for
						end
				end
			end
		end
	end
	
	-- Punto di uscita per chi usa la logica a priorità (Bombardieri)
	if bestTarget then
		return bestTarget
	end

	-- Fallback finale se non è stato trovato nulla
	return { x = Game.mapSizeX/2, y = 0, z = Game.mapSizeZ/2 }	-- decidere come impegnare le unità senza target
end

-- Funzione per trovare il bersaglio nel raggio della base (verrà utilizzata nella modalità difesa). Se non troverà alcun bersaglio all'interno dell'area (perchè ha distrutto tutto), chiama la funzione GetSmartEnemyTarget che è quella per l'attacco.
local function GetSmartEnemyTargetInBaseRadious(myTeamID, squadType)
	local bPos = basePoint[myTeamID]
	local bRad = baseRadius[myTeamID]
	
	-- Se non abbiamo informazioni sulla base o sul raggio, non possiamo filtrare
	if not bPos or not bRad then return nil end

	local allUnits = Spring.GetAllUnits()
	local gaiaTeamID = Spring.GetGaiaTeamID()
	local radSq = bRad * bRad -- Usiamo il quadrato del raggio per evitare math.sqrt (ottimizzazione)
	
	local bestTarget = nil
	local highestPriority = -1

	for i = 1, #allUnits do
		local uID = allUnits[i]
		local uTeam = Spring.GetUnitTeam(uID)
		
		-- Solo nemici (non alleati, non Gaia)
		if uTeam ~= gaiaTeamID and not Spring.AreTeamsAllied(myTeamID, uTeam) then
			local x, y, z = Spring.GetUnitPosition(uID)
			
			if x then
				-- CONTROLLO DISTANZA: L'unità nemica è dentro il raggio della base?
				local dx = x - bPos.x
				local dz = z - bPos.z
				local distSq = (dx * dx) + (dz * dz)

				if distSq <= radSq then
					local enemyCat = GetUnitCategoryFromDB(uID)
					
					-------------
					-- LOGICA CATEGORIE (Identica a GetSmartEnemyTarget)
					-------------
					if squadType == "ground" then
						if enemyCat == "ground" or enemyCat == "unknown" or enemyCat == "building" or enemyCat == "strategicbuilding" or enemyCat == "strategicdefence" or enemyCat == "defence" or enemyCat == "strategicshield" then 
							return {x=x, y=y, z=z, id=uID}
						elseif enemyCat == "hover" and y >= -1 then
							return {x=x, y=y, z=z, id=uID}
						end

					elseif squadType == "ground_hovercraft" then
						if enemyCat == "ground" or enemyCat == "unknown" or enemyCat == "building" or enemyCat == "strategicbuilding" or enemyCat == "strategicdefence" or enemyCat == "hover" or enemyCat == "defence" or enemyCat == "strategicshield" then  
							return {x=x, y=y, z=z, id=uID}
						end

					elseif squadType == "naval" then
						if enemyCat == "naval" then
							return {x=x, y=y, z=z, id=uID}
						elseif enemyCat == "hover" and y < -1 then
							return {x=x, y=y, z=z, id=uID}
						end

					elseif squadType == "air_toair" then
						if enemyCat == "air" then 
							return {x=x, y=y, z=z, id=uID} 
						end

					elseif squadType == "air_toground" then
						if enemyCat == "ground" or enemyCat == "naval" or enemyCat == "hover" then
							return {x=x, y=y, z=z, id=uID} 
						end				

					elseif squadType == "air_bomber" then 
						local currentPriority = 0
						if enemyCat == "defence" then currentPriority = 6
						elseif enemyCat == "building" then currentPriority = 5
						elseif enemyCat == "strategicbuilding" then currentPriority = 4
						elseif enemyCat == "strategicdefence" then currentPriority = 3
						elseif enemyCat == "strategicshield" then currentPriority = 2						
						elseif enemyCat == "ground" then currentPriority = 1						
						end
						
						if currentPriority > highestPriority then
							highestPriority = currentPriority
							bestTarget = {x=x, y=y, z=z, id=uID}
							if highestPriority == 6 then break end
						end					

					elseif squadType == "air_bomber_strategic" then
						local currentPriority = 0
						if enemyCat == "strategicbuilding" then currentPriority = 6
						elseif enemyCat == "strategicshield" then currentPriority = 5
						elseif enemyCat == "strategicdefence" then currentPriority = 4						
						elseif enemyCat == "building" then currentPriority = 3
						elseif enemyCat == "defence" then currentPriority = 2
						elseif enemyCat == "ground" then currentPriority = 1		
						end
						
						if currentPriority > highestPriority then
							highestPriority = currentPriority
							bestTarget = {x=x, y=y, z=z, id=uID}
							if highestPriority == 6 then break end
						end
					end
				end -- fine controllo raggio
			end
		end
	end
	return bestTarget -- Restituisce nil se non trova nessuno nel raggio
end

--------------------------------------------------------------------------------
-- 5) GESTIONE ORDINI E GADGET CORE 
--------------------------------------------------------------------------------
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

-- Questa funzione serve ad evitare che l'AI "rubi" o interferisca con unità non sue (ad esempio di altre AI), ci si assicura che le tabelle siano sempre pulite. In questo modo se spring dovesse riassegnare l'ID di una unità distrutta ad un altra squadra, il codice non lo utilizza come se fosse sua
function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
    -- 1. Se muore una fabbrica, cancellala subito dalle nostre liste
    if factories[unitID] then
        factories[unitID] = nil
    end

    -- 2. Se muore un'unità, rimuovila da qualsiasi squadra (squads) la stia usando
    for sID, sData in pairs(squads) do
        for i = #sData.units, 1, -1 do
            if sData.units[i] == unitID then
                table.remove(sData.units, i)
            end
        end
    end
end

-- Come UnitDestroyed ma in caso di "cambio di proprietà" (es. se un'unità viene catturata)
function gadget:UnitTaken(unitID, unitDefID, unitOldTeam, unitNewTeam)
    gadget:UnitDestroyed(unitID, unitDefID, unitOldTeam)
end

function gadget:Initialize()
	local teamList = Spring.GetTeamList()
	for _, teamID in ipairs(teamList) do
		local assignedAI = Spring.GetTeamLuaAI(teamID)
		if assignedAI and string.find(string.lower(assignedAI), string.lower(TARGET_AI_NAME)) then
			aiTeamIDs[teamID] = true
            teamLevels[teamID] = -1 						-- era 0, impostazione livello 0 per il team corrente (for... do...) 
            teamConfigs[teamID] = GetConfigPerLivello(0)	-- impostazione livello 0 per il team corrente (for... do...) 
		end
	end
end

-- Funzione per restituire true se l'unità è segnata come ignore nel DB WMRTS_AI_mission_db.lua (ignore = true). sono ignore = true tutte le unità che non devono essere gestite in questo gadget (come gruppi da mandare all'attacco)
local function IsUnitIgnored(unitID)
	local uDefID = Spring.GetUnitDefID(unitID)				-- definisci localmente uDefID
	if not uDefID then return false end						-- se uDefID non è presente restituisci false (usato per altre logiche)
	local unitName = UnitDefs[uDefID].name					-- altrimenti prosegui e definisci localmente unitName
	
	if UNIT_DB[unitName] and UNIT_DB[unitName].ignore then	-- se nel database è presente l'unità unitName, e la voce "ignore" di quella unità = true allora...
		return true											-- ...restituisci true (usato poi per altre logiche)
	end
	return false											-- ...altrimenti restituisci false (usato poi per altre logiche)
end

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
		-- CONTROLLO SE IL TEAM NON è L'AI
    if not aiTeamIDs[unitTeam] then return end 				-- se il team non è AI non fare niente, esci
	    -- CONTROLLO IGNORE: Se l'unità deve essere ignorata, definita nel database (ignore = true) esci subito e non gestire l'unità
    if IsUnitIgnored(unitID) then							-- utilizza la funzione IsUnitIgnored per capire se l'unità in questione è impostata con " ignore = true" nel file "WMRTS_AI_mission_db.lua", e restituisci true o false. se true non fare niente
 --        Spring.Echo("WMRTS_militMngm_AI: Unità ignorata per design: " .. unitID)
        return 
    end
		-- Altrimenti (se ignore = false o non impostate) associa l'unità ad una squadra
    local unitName = UnitDefs[unitDefID].name
    local config = teamConfigs[unitTeam]     	-- Recupero la configurazione attuale di QUESTO team
    if config and config[unitName] then 		-- 2) Controllo se il nome dell'unità appena finita è presente nella lista fabbriche e se config è NIL (per sicurezza), non facciamo nulla
        factories[unitID] = { defName = unitName, squadID = nil, teamID = unitTeam }
        return
    end
	local bestFactoryID = nil
	local nearestDist = 3000					-- distanza per associare l'unità creata alla fabbrica più vicino entro il valore "nearest", se non è presente alcuna fabbrica, l'unità rimane orfana
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
    if (n % 30 ~= 0) then return end  		-- una volta al secondo...
	-- Controlla il livello della AI gestito dal gadget "constructionManagement"
	for teamID, _ in pairs(aiTeamIDs) do
		local nuovoLivello = (GG.WMRTS_Levels and GG.WMRTS_Levels[teamID]) or 0		-- Leggo il valore globale (se non esiste ancora, considero livello 0)
        if teamLevels[teamID] ~= nuovoLivello then 								-- Se il livello del team è cambiato (o non è ancora inizializzato)
            teamLevels[teamID] = nuovoLivello
            teamConfigs[teamID] = GetConfigPerLivello(nuovoLivello)
            Spring.Echo("WMRTS_militMngm_AI:: Team " .. teamID .. " si è allineato al livello " .. nuovoLivello)      
        end
	-- Controlla la posizione della base gestita dal gadget "constructionManagement" 
        local newBP = GG.AI_BasePos and GG.AI_BasePos[teamID]
        if newBP then
            -- Se non esiste ancora una posizione locale, o se le coordinate sono cambiate
            if not basePoint[teamID] or 
               basePoint[teamID].x ~= newBP.x or 
               basePoint[teamID].z ~= newBP.z then              
               basePoint[teamID] = {x = newBP.x, y = newBP.y, z = newBP.z}
               Spring.Echo(string.format("WMRTS_militMngm_AI:: Team %d BasePos: X=%.0f Z=%.0f", teamID, newBP.x, newBP.z))
            end
        end
	-- Controlla il raggio di difersa della base gestito dal gadget "constructionManagement", servirà, in funzione dello stato di guerra, a mandare all'attacco le truppe o a difendere la base entro questo raggio
		local newRadius = (GG.AI_RaggioDifesa and GG.AI_RaggioDifesa[teamID]) or 100 				-- imposto un raggio di default poi tanto si aggiorna automaticamente	
        if baseRadius[teamID] ~= newRadius then 													-- Se il raggio di difesa del team è cambiato...
            baseRadius[teamID] = newRadius
            Spring.Echo("WMRTS_militMngm_AI:: Team " .. teamID .. " ha impostato il raggio della base a: " .. newRadius)
        end		
	-- Controlla lo stato di guerra gestito dal gadget "constructionManagement", servirà per mandare in attacco le truppe, difendere lievemente la base o difenderla pesantemente
		local newWS = (GG.AI_StatoGuerra and GG.AI_StatoGuerra[teamID]) or "attacco" 		-- imposto l'attacco di default, poi tanto si aggiorna automaticamente
        if warStatus[teamID] ~= newWS then 													-- se lo stato di guerra è cambiato...
            warStatus[teamID] = newWS
            Spring.Echo("WMRTS_militMngm_AI:: Team " .. teamID .. " ha impostato lo stato di guerra a: " .. newWS)
        end			
    end -- end ciclo for

    -- GESTIONE FABBRICHE
    for fID, fData in pairs(factories) do
        local qSize = Spring.GetCommandQueue(fID, 0)
        
        if qSize == nil then
            factories[fID] = nil 
        else		
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
                -- RECUPERO LA CONFIGURAZIONE SPECIFICA DI QUEL TEAM
                local configDelTeam = teamConfigs[fData.teamID]
                if configDelTeam then
                    local options = configDelTeam[fData.defName]
                    if options then
                        local templateName = options[math.random(1, #options)]
                        local template = SQUAD_TEMPLATES[templateName]
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
        end
    end

	-- GESTIONE SQUADRE, Questa sezione è il "cervello operativo" che decide cosa devono fare i gruppi di unità una volta usciti dalle fabbriche. Gestisce il ciclo di vita di una squadra, dalla sua nascita fino alla sua distruzione.
	-- Il codice divide le squadre in due stati principali: gathering (raduno) e attacking_monitor (attacco e monitoraggio).
	for sID, sData in pairs(squads) do	
		local teamID = sData.myTeam -- Definiamo teamID 
	-- gathering
	-- Cosa fa: Controlla se il numero di unità attuali (#sData.units) ha raggiunto la dimensione prevista (targetSize).
	-- Il Timeout: Se la fabbrica viene distrutta o rallenta, il SQUAD_TIMEOUT_SECONDS (10 minuti nel tuo codice) forza la squadra a partire anche se incompleta, per evitare che le unità restino ferme in base per sempre.
	-- Azione: Appena la squadra è pronta, cerca un bersaglio globale e impartisce il primo ordine di attacco.		
		if sData.state == "gathering" then
			if warStatus[teamID] == "attacco" then
				if #sData.units >= sData.targetSize or (Spring.GetGameSeconds() - sData.startTime) > SQUAD_TIMEOUT_SECONDS then -- CONTROLLO: La squadra è pronta o è passato troppo tempo?
					sData.state = "attacking_monitor" 									-- Cambia stato: si va all'attacco!
					sData.attackTarget = GetSmartEnemyTarget(sData.myTeam, sData.type)	-- Trova il primo bersaglio
					for _, uID in ipairs(sData.units) do								-- ORDINE INIZIALE: Invia tutte le unità della squadra al bersaglio
						if Spring.ValidUnitID(uID) then GiveAttackOrder(uID, sData.attackTarget) end
					end
				end
			elseif warStatus[teamID] == "difesa_leggera" or warStatus[teamID] == "difesa_pesante"  then -- se siamo in modalità difesa leggera o pesante, le unità in gathering passano in modalità attacco all'interno del raggio della base (ingaggiano in difesa)
				if #sData.units >= sData.targetSize or (Spring.GetGameSeconds() - sData.startTime) > SQUAD_TIMEOUT_SECONDS then -- CONTROLLO: La squadra è pronta o è passato troppo tempo?
					sData.state = "attacking_monitor" 									-- Cambia stato: si va all'attacco!
					sData.attackTarget = GetSmartEnemyTargetInBaseRadious(sData.myTeam, sData.type)	-- Trova il primo bersaglio all'interno del raggio della base, per difendere
					for _, uID in ipairs(sData.units) do								-- ORDINE INIZIALE: Invia tutte le unità della squadra al bersaglio
						if Spring.ValidUnitID(uID) then GiveAttackOrder(uID, sData.attackTarget) end
					end
				end			
			end
	-- attacking_monitor
	-- Ottimizzazione (n % 90): Non controlla ogni istante (sarebbe pesante per la CPU), ma ogni 3 secondi.
	-- Pulizia Lista: Cicla la lista delle unità all'indietro (da #sData.units a 1). Questo è fondamentale in programmazione: se rimuovi un elemento da una lista mentre la scorri in avanti, salteresti l'elemento successivo.
	-- Controllo Idle: Verifica se l'unità è "disoccupata" (CommandQueue == 0). Se ha finito di distruggere il suo bersaglio, diventerà Idle.	
		elseif sData.state == "attacking_monitor" then
			if n % 90 == 0 then			-- Esegue il controllo ogni 90 frame (circa ogni 3 secondi)
				local anyAlive = false	-- Controlla che il gruppo non sia stato completamente distrutto.
				local anyIdle = false	-- È una condizione di efficienza. Dice al gadget: "tutti i membri della squadra stanno ancora sparando a qualcosa"
				for i = #sData.units, 1, -1 do	-- CICLO DI PULIZIA: Rimuove i morti dalla tabella della squadra
					local uID = sData.units[i]
					if Spring.ValidUnitID(uID) and not Spring.GetUnitIsDead(uID) then
						anyAlive = true
						if Spring.GetCommandQueue(uID, 0) == 0 then anyIdle = true end	-- Controlla se l'unità ha finito gli ordini e ne imposti anyIdle true(è ferma/idle)
					else
						table.remove(sData.units, i)		-- Rimuove l'unità morta dalla lista
					end
				end
	-- Logica di ri-puntamento (Re-targeting)
	-- Nuovo Ordine: Se almeno un'unità della squadra è viva (anyAlive) e almeno una è ferma (anyIdle) e soprattutto se ogni singola unità è IDLE (Spring.GetCommandQueue(uID, 0) == 0), l'AI ricalcola il loro bersaglio (targetAttack/targetDefence) e lo assegna a seconda dello stato di guerra
	-- Efficienza: L'ordine di attacco viene ridato solo alle unità ferme (Spring.GetCommandQueue(uID, 0) == 0) e o dentro/fuori dal raggio della base (ipairs(insideUnits)/ipairs(outsideUnits)), a seconda dello stato di guerra. 
	-- Cancellazione Squadra: Se anyAlive è falso, significa che l'intera squadra è stata annientata. Il codice rimuove l'intera squadra (squads[sID] = nil) per liberare memoria.	
				if anyAlive and anyIdle then
					local targetAttack = nil															-- imposto i targetAttack di attacco
					local targetDefence = nil															-- imposto i target di difesa
					targetAttack = GetSmartEnemyTarget(sData.myTeam, sData.type)						-- ... cerca tutti i target in tutta la mappa e salvali in targetAttack
					targetDefence = GetSmartEnemyTargetInBaseRadious(sData.myTeam, sData.type)			-- ... cerca tutti i target all'interno del raggio della base e salvali in targetDefence
					local bPos = basePoint[teamID]
					local bRad = baseRadius[teamID]					
					local insideUnits, outsideUnits = SplitUnitsByRadius(sData.units, basePoint[teamID], baseRadius[teamID])	-- creo la lista insideUnits e outsideUnits, liste di unità rispettivamente dentro il raggio della base e fuori dal raggio della base
					-- attacco
					if warStatus[teamID] == "attacco" then										-- a) in modalità attacco...
						for _, uID in ipairs(sData.units) do									-- esegui un ciclo for su tutte le unità presenti sulla mappa...
							if Spring.GetCommandQueue(uID, 0) == 0 then							-- Controllo ogni singola unità, e, se è ferma (Idle)...  ##### verificare qui se dividere tra attacco, difesa leggera o difesa pesante (magari nella difesa pesante fare in modo che le unità tornino a prescindere che siano idle???) ##### molix
								GiveAttackOrder(uID, targetAttack)								-- ...invia l'ordine alle singole unità tramite la funzione "GiveAttackOrder")
							end
						end -- ciclo for
					-- difesa_leggera						
					elseif 	warStatus[teamID] == "difesa_leggera" then							-- b) in modalità difesa leggera...
						for _, uID in ipairs(insideUnits) do									-- cicla e trova tutte le unità all'interno del raggio della base
							if Spring.GetCommandQueue(uID, 0) == 0 then							-- Controllo ogni singola unità, se è ferma (Idle)...  ##### verificare qui se dividere tra attacco, difesa leggera o difesa pesante (magari nella difesa pesante fare in modo che le unità tornino a prescindere che siano idle???) ##### molix	
								if targetDefence then											-- Se è presente un target in difesa...
									GiveAttackOrder(uID, targetDefence)							-- attacca il targetDefence (difesa attiva)
								else															-- altrimenti...
									GiveAttackOrder(uID, targetAttack)							-- passa all'attacco a prescindere -- ### valutare se spostare le unità al centro della base e lasciare che si fermino, per ricevere un ulteriore ordine
								end
							end
						end			
						for _, uID in ipairs(outsideUnits) do									-- cicla e trova tutte le unità all'esterno del raggio della base
							if Spring.GetCommandQueue(uID, 0) == 0 then							-- Controllo ogni singola unità, se è ferma (Idle)...  ##### verificare qui se dividere tra attacco, difesa leggera o difesa pesante (magari nella difesa pesante fare in modo che le unità tornino a prescindere che siano idle???) ##### molix	
								GiveAttackOrder(uID, targetAttack)								-- attacca il targetDefence (difesa attiva)
							end
						end					
					-- difesa_pesante
					elseif warStatus[teamID] == "difesa_pesante" then							-- c) in modalità difesa pesante...
						for _, uID in ipairs(insideUnits) do									-- cicla e trova tutte le unità all'interno del raggio della base
							if Spring.GetCommandQueue(uID, 0) == 0 then		
								if targetDefence then
									GiveAttackOrder(uID, targetDefence)							-- attacca il target di difesa, se esiste... (difesa attiva)
								else 
									GiveAttackOrder(uID, targetAttack)							-- ...altrimenti attacca un target di attacco
								end -- end se esiste targetDefence
							end
						end	-- end ciclo for (unità interno base)		
						for _, uID in ipairs(outsideUnits) do									-- cicla e trova tutte le unità all'esterno del raggio della base
							if Spring.GetCommandQueue(uID, 0) == 0 then							-- Controllo ogni singola unità, se è ferma (Idle)...  ##### verificare qui se dividere tra attacco, difesa leggera o difesa pesante (magari nella difesa pesante fare in modo che le unità tornino a prescindere che siano idle???) ##### molix
								GiveAttackOrder(uID, targetDefence)								-- attacca il target (difesa attiva)							
							end
						end	-- end ciclo for (unità esterno base)
					end -- warStatus	
				end		-- end anyAlive and anyIdle		
				if not anyAlive then squads[sID] = nil end										-- Se sono tutti morti, elimina la squadra dal database globale
			end -- end anylive
		end
	end	-- end for gestione squadre
end	-- end funzione