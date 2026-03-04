function gadget:GetInfo()
	return {
		name      = "WMRTS Squad Commander AI",
		desc      = "AI V17-18 for War Machnines RTS",
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
-- 26/02/2026 = V17, aggiunte unità NFA e AND
-- 27/02/2026 = road to V18, sistemo un bug inerente alla modalità difesa, invece di attaccare direttamente una unità, si spostano le unità verso il bersaglio in modalità fight.
-- 01/03/2026 = V18, risolto il problema delle unità orfane durante il cambio di stato "attacco -> difesa_leggera"
-- 02/03/2026 = road to V19 - bombardieri non attaccano i target fuori dal radar o nella nebbia. Modificato codice per far si che attacchino direttamente a x, y e z del target uID, monitorandone costantemente se vivo o morto
-- 03/03/2026 = road to V20 - alcune fabbriche rimangono in standby e non producono più, variata logica per renderle libere
-- 03/03/2026 = inserita gestione "recupero orfani", ossia quelle unità che per qualche ragione di guerra (fabbrica distrutta, sotto attacco ecc) non riesce ad inserirsi in un gruppo e quindi non riceverebbe ordini

-- to do LIST ################################
-- includere i radar nelle costruzioni!!
-- risolvere il bersaglio dei bombardieri, loro attaccano direttamente l'unita tramite ID, ma se l'unità è al buio dal LOS, o dalla nebbia, queste vanno al punto target ma non sparano.
--	-- come risolvere?
--	-- o aumentare il raggio visuale dei bombardieri
--  -- o implementare la logica di attacco utilizzata nel "wmrts_AI_longWeaponManagement.lua" per i LRA
-- implementare i SUB
--[[
nello units database, ho inserito le seguenti unità:
ICU: armmark (radar mobile), armjam (jammer mobile).
NFA: corvoyr, corspec, coreter, nfavrad.
AND: andscouter.
Cosa succede: Queste unità non hanno armi. Quando il gadget dà l'ordine FIGHT o ATTACK, loro seguiranno il gruppo, ma se il bersaglio è un'unità nemica, cercheranno di "attaccarla" avvicinandosi molto (perché non hanno armi). Se vuoi che restino in vita più a lungo, potresti mettere anche loro in ignore = true e gestirle con uno script che le fa stare sempre dietro la linea di fuoco. Ma per ora, lasciarle in ground va bene se vuoi che facciano da "esca" o forniscano copertura mentre si muovono.
]]--


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
-- NFA gruppi creati per il lvl 0÷4 -------- 
---------------
-- corlab
	["NFA_corlab_light_patrol_1"] = {
		units = { "nfaak", "nfaak", "nfastorm", "nfastorm" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["NFA_corlab_light_patrol_2"] = {
		units = { "nfathud", "nfaak", "nfastorm", "nfastorm" },				
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- corvp	
	["NFA_corvp_light_patrol_1"] = {
		units = { "nfafav", "nfagator", "nfagator", "nfagator" }, 
		type = "ground"
	},
	["NFA_corvp_light_patrol_2"] = {
		units = { "cormist", "cormist", "nfagarp", "nfalevlr", "nfaraid","corwolv" }, 
		type = "ground"
	},	
-- corap	
	["NFA_corap_air_raid_1"] = { 			
		units = { "bladew", "corveng", "corveng", "bladew", "bladew" },
		type = "air_toground"
	},
	["NFA_corap_antiair_raid_1"] = { 
		units = { "corveng", "corveng", "corveng" },
		type = "air_toair"
	},
	["NFA_corap_air_bomber_1"] = { 
		units = { "corshad", "corshad", "corshad", "corshad", "corshad" }, 	-- gruppo da 5 bombardieri
		type = "air_bomber"
	},	
--	["naval_fleet"] = {
--		units = { "corbats", "corbats", "corbats" },
--		type = "naval"
--	}
-- coralab
	["NFA_coralab_light_patrol_1"] = {
		units = { "nfapyro", "nfapyro", "nfapyro" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["NFA_coralab_light_patrol_2"] = {
		units = { "nfapyro", "nfapyro", "corcan" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- coravp
	["NFA_coravp_light_patrol_1"] = {
		units = { "cormart", "cormart", "corparrow" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["NFA_coravp_light_patrol_2"] = {
		units = { "corparrow", "tawf114"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- coraap
	["NFA_coraap_light_patrol_1"] = {
		units = { "corvamp", "corvamp", "corvamp" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["NFA_coraap_light_patrol_2"] = {
		units = { "corvamp", "corvamp"}, 
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
	["ICU_armavp_medium_patrol_4"] = {
		units = { "armcamp", "armcamp", "icubull", "icubull", "armcamp", "armyork", "armmanni", "armcroc", "armcroc"}, 
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
-- icufff	
	["ICU_icufff_medium_patrol_1"] = {
		units = { "demr", "orcl", "cirr","cirr" }, 
		type = "air_toground" 
	},		
	["ICU_icufff_medium_patrol_2"] = {
		units = { "demr" }, 
		type = "air_toground" 
	},		
	["ICU_icufff_medium_patrol_3"] = {
		units = { "demr", "demr" }, 
		type = "air_toground" 
	},			
		
---------------
-- NFA gruppi creati per il lvl 5+ -------- 
---------------
-- corlab
	["NFA_corlab_medium_patrol_1"] = {
		units = { "nfathud", "nfathud", "nfathud", "nfastorm", "nfastorm" , "nfastorm", "nfathud", "corcrash"  }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["NFA_corlab_medium_patrol_2"] = {
		units = { "nfathud", "nfathud", "nfastorm", "nfastorm", "nfastorm", "nfastorm", "corcrash", "nfathud", "nfathud" },				
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- corvp	
	["NFA_corvp_medium_patrol_1"] = {
		units = { "cormist", "cormist", "cormist", "corwolv", "cormist", "nfagarp", "nfaraid", "cormist" }, 
		type = "ground"
	},
	["NFA_corvp_medium_patrol_2"] = {
		units = { "cormist", "cormist", "cormist", "corwolv", "nfagarp", "corwolv", "nfagarp", "nfaraid", "nfalevlr", "nfalevlr" }, 
		type = "ground"
	},	
-- corap	
	["NFA_corap_air_mediumraid_1"] = { 			
		units = { "bladew", "corveng", "corveng", "bladew", "bladew", "bladew", "bladew", "bladew", "bladew", "bladew" },
		type = "air_toground"
	},
	["NFA_corap_antiair_mediumraid_1"] = { 
		units = { "corveng", "corveng", "corveng", "corveng", "corveng", "corveng", "corveng", "corveng", "corveng", "corveng" },
		type = "air_toair"
	},
	["NFA_corap_air_mediumbomber_1"] = { 
		units = { "corshad", "corshad", "corshad", "corshad", "corshad", "corshad", "corshad", "corshad", "corshad", "corshad" }, 	-- gruppo da 10 bombardieri
		type = "air_bomber"
	},	
	["NFA_corap_air_mediumstrategicbomber_1"] = { 
		units = { "corshad", "corshad", "corshad", "corshad", "corshad", "corshad", "corshad", "corshad", "corshad", "corshad", "corshad", "corshad" }, 	-- gruppo da 12 bombardieri
		type = "air_bomber_strategic"
	},				
--	["naval_fleet"] = {
--		units = { "corbats", "corbats", "corbats" },
--		type = "naval"
--	}
-- coralab
	["NFA_coralab_medium_patrol_1"] = {
		units = { "corcan", "corsumo", "corsumo", "coraak", "corhrk", "corhrk", "cormort" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["NFA_coralab_medium_patrol_2"] = {
		units = { "cormort", "cormort", "cormort", "cormort", "cormort", "coraak", "cormort", "cormort" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["NFA_coralab_medium_patrol_3"] = {
		units = { "corsumo", "corsumo", "corsumo", "coraak", "corsumo" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
-- coravp
	["NFA_coravp_medium_patrol_1"] = {
		units = { "cormart", "cormart", "corsent", "cormart", "cormart", "cormart", "cormart", "cormart", "cormart", "nfareap", "nfareap" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},
	["NFA_coravp_medium_patrol_2"] = {
		units = { "tawf114", "corparrow", "nfareap", "nfareap", "cormart", "corsent"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["NFA_coravp_medium_patrol_3"] = {
		units = { "tawf114", "corparrow", "nfareap", "nfareap", "cormart", "corsent", "nfagol", "corparrow", "tawf114"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		
	["NFA_coravp_medium_patrol_4"] = {
		units = { "tawf114", "corparrow", "nfareap", "nfareap", "nfagol", "corsent", "nfagol", "nfagol", "corparrow"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},			
-- coraap
	["NFA_coraap_medium_patrol_1"] = {
		units = { "corvamp", "corvamp", "corvamp", "corvamp", "corvamp", "corvamp", "corvamp", "corvamp", "corvamp" }, 
		type = "air_toair" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare ################################### i NFA possono attaccare anche unità di terra. Creare una nuova categoria ait_toall ? cosi da definire poi le logiche di target in caso di assenza di aerei nemici ###
	},
	["NFA_coraap_medium_patrol_2"] = {
		units = { "blade", "blade", "corape", "corape", "blade", "blade", "corape", "corape", "corape", "corape"}, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		
	["NFA_coraap_air_bomber_1"] = { 
		units = { "corape", "corape", "corape", "corape", "corhurc", "corhurc", "corape", "corape", "corape" }, 	
		type = "air_bomber"
	},		
	["NFA_coraap_air_bomber_2"] = { 
		units = { "corhurc", "corhurc", "corhurc", "corhurc", "corhurc", "corhurc", "corhurc", "corhurc", "corhurc", "corhurc", "corhurc", "corhurc", "corhurc", "corcrw", "corcrw" }, 	
		type = "air_bomber_strategic"
	},		
	["NFA_coraap_air_bomber_3"] = { 
		units = { "corcrw", "corcrw", "corcrw", "corcrw", "corcrw" }, 	
		type = "air_bomber_strategic"
	},		
-- corgant
	["NFA_corgant_medium_patrol_1"] = {
		units = { "nfakarg", "nfakarg", "nfakarg" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["NFA_corgant_medium_patrol_2"] = {
		units = { "nfakarg", "nfakarg", "armraven", "armraven", "armraven" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["NFA_corgant_medium_patrol_3"] = {
		units = { "corkrog" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},	
	["NFA_corgant_medium_patrol_4"] = {
		units = { "corkrog", "nfakarg","nfakarg" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},			
	["NFA_corgant_medium_patrol_5"] = {
		units = { "armraven", "nfacoug", "nfakarg","nfakarg" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		
	["NFA_corgant_medium_patrol_6"] = {
		units = { "gorg" }, 
		type = "ground" -- squadtype, nella logica di targeting (punto 4) andrà a definire cosa attaccare 
	},		
-- nfafff
	["NFA_nfafff_medium_patrol_1"] = {
		units = { "ostr", "odyc", "taln","taln" }, 
		type = "air_toground" 
	},		
	["NFA_nfafff_medium_patrol_2"] = {
		units = { "ostr" }, 
		type = "air_toground" 
	},		
	["NFA_nfafff_medium_patrol_3"] = {
		units = { "ostr", "ostr" }, 
		type = "air_toground" 
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
local FACTORY_CONFIG = {} 	-- all'inizio imposto la tabella vuota 

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
            -- NFA --
            ["corlab"] = { "NFA_corlab_light_patrol_1", "NFA_corlab_light_patrol_2" },
            ["corvp"] = { "NFA_corvp_light_patrol_1", "NFA_corvp_light_patrol_2" },
            ["corap"]  = { "NFA_corap_antiair_raid_1", "NFA_corap_air_raid_1","NFA_corap_air_bomber_1" },			
            ["coralab"] = { "NFA_coralab_light_patrol_1", "NFA_coralab_light_patrol_2" },							-- inseriti in caso di recessione della AI dal livello 4+ a 0
            ["coravp"] = { "NFA_coravp_light_patrol_1", "NFA_coravp_light_patrol_2" },			
            ["coraap"]  = { "NFA_coraap_light_patrol_1", "NFA_coraap_light_patrol_2"},					
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
            ["armavp"] = { "ICU_armavp_medium_patrol_1", "ICU_armavp_medium_patrol_2", "ICU_armavp_medium_patrol_3", "ICU_armavp_medium_patrol_4" },
            ["armaap"]  = { "ICU_armaap_medium_patrol_1", "ICU_armaap_medium_patrol_2","ICU_armaap_air_bomber_1","ICU_armaap_air_bomber_2", "ICU_armaap_air_bomber_3" },		
            ["icugant"] = { "ICU_icugant_medium_patrol_1", "ICU_icugant_medium_patrol_2", "ICU_icugant_medium_patrol_3" },		
            ["armshltx"] = { "ICU_armshltx_medium_patrol_1", "ICU_armshltx_medium_patrol_2", "ICU_armshltx_medium_patrol_3", "ICU_armshltx_medium_patrol_4", "ICU_armshltx_medium_patrol_5" },		
            ["icufff"]  = { "ICU_icufff_medium_patrol_1", "ICU_icufff_medium_patrol_2","ICU_icufff_medium_patrol_3" },				
            -- NFA --
            ["corlab"] = { "NFA_corlab_medium_patrol_1", "NFA_corlab_medium_patrol_2" },
            ["corvp"] = { "NFA_corvp_medium_patrol_1", "NFA_corvp_medium_patrol_2" },
            ["corap"]  = { "NFA_corap_air_mediumraid_1", "NFA_corap_antiair_mediumraid_1","NFA_corap_air_mediumbomber_1","NFA_corap_air_mediumstrategicbomber_1" },
            ["coralab"] = { "NFA_coralab_medium_patrol_1", "NFA_coralab_medium_patrol_2" },			
            ["coravp"] = { "NFA_coravp_medium_patrol_1", "NFA_coravp_medium_patrol_2", "NFA_coravp_medium_patrol_3", "NFA_coravp_medium_patrol_4" },
            ["coraap"]  = { "NFA_coraap_medium_patrol_1", "NFA_coraap_medium_patrol_2","NFA_coraap_air_bomber_1","NFA_coraap_air_bomber_2", "NFA_coraap_air_bomber_3" },		
            ["corgant"] = { "NFA_corgant_medium_patrol_1", "NFA_corgant_medium_patrol_2", "NFA_corgant_medium_patrol_3", "NFA_corgant_medium_patrol_4", "NFA_corgant_medium_patrol_5", "NFA_corgant_medium_patrol_6" },					
            ["nfafff"]  = { "NFA_nfafff_medium_patrol_1", "NFA_nfafff_medium_patrol_2","NFA_nfafff_medium_patrol_3" },					
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

local TARGET_AI_NAME = "WMAI" 
local SQUAD_TIMEOUT_SECONDS = 600 -- questo timeout definisce i secondi di attesa per la formazione del gruppo delle unità uscite dalla fabbrica. Oltre questo timeout il gruppo si completa cosi com'è e parte all'attacco o difesa 

--------------------------------------------------------------------------------
-- 3) VARIABILI
--------------------------------------------------------------------------------

local aiTeamIDs = {}      
local factories = {}   		
-- Esempio contenuto:
-- factories[fID] = { 
--    inUso = false, 
--    unitName = "armap", 
--    nProgressivo = 0, 
--    squadType = "air_toair", 
--    bucket = {} -- Qui finiscono gli ID delle unità mentre vengono create
-- }
local squads = {}     		-- [sID] = { units = {}, targetSize, state, type, myTeam, etc }
local basePoint = {}		-- Tabella: [teamID] = coordinate del punto base per ogni singolo team (0, 1, 2...)
local baseRadius = {}		-- Tabella: [teamID] = raggio di difesa della base per ogni singolo team (0, 1, 2...)
local warStatus = {}		-- Tabella: [teamID] = stato di guerra  per ogni singolo team (0, 1, 2...), può essere "attacco", "difesa_leggera", "difesa_pesante". Si veda "wmrts_AI_constructionManagement.lua" per maggiori dettagli        
local bomberTargets = {} 	-- Tabella per memorizzare quale bombardiere sta puntando quale unità Memorizza -> [unitID_Bombardiere] = targetID_Nemico

--------------------------------------------------------------------------------
-- 4) FUNZIONI HELPER
--------------------------------------------------------------------------------

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
							return {x=x, y=y, z=z}
						elseif enemyCat == "hover" and y >= -1 then
							return {x=x, y=y, z=z}
						end
					elseif squadType == "ground_hovercraft" then
						if enemyCat == "ground" or enemyCat == "unknown" or enemyCat == "building" or enemyCat == "strategicbuilding" or enemyCat == "strategicdefence" or enemyCat == "hover" or enemyCat == "defence" or enemyCat == "strategicshield" then  
							return {x=x, y=y, z=z}
						end
					elseif squadType == "naval" then
						if enemyCat == "naval" then
							return {x=x, y=y, z=z}
						elseif enemyCat == "hover" and y < -1 then
							return {x=x, y=y, z=z}
						end
					elseif squadType == "air_toair" then
						if enemyCat == "air" then 
							return {x=x, y=y, z=z} 
						end
					elseif squadType == "air_toground" then
						if enemyCat == "ground" or enemyCat == "naval" or enemyCat == "hover" then
							return {x=x, y=y, z=z} 
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

-- Questa funzione aggiorna costantemente il punto di sgancio dei bombardieri 
-- seguendo le coordinate reali dell'unità target (anche se è in movimento o nella nebbia)
local function UpdateBomberTracking()
    for bID, tID in pairs(bomberTargets) do
        -- 1. Verifichiamo se il bombardiere è ancora operativo
        if not Spring.ValidUnitID(bID) or Spring.GetUnitIsDead(bID) then
            bomberTargets[bID] = nil
        else
            -- 2. Verifichiamo se il bersaglio è ancora vivo
            if not Spring.ValidUnitID(tID) or Spring.GetUnitIsDead(tID) then
                -- Il bersaglio è morto: fermiamo il bombardiere e liberiamolo
                Spring.GiveOrderToUnit(bID, CMD.STOP, {}, {})
                bomberTargets[bID] = nil
            else
                -- 3. Il bersaglio è vivo: prendiamo le sue coordinate attuali
                local tx, ty, tz = Spring.GetUnitPosition(tID)
                if tx then
                    -- Inviamo l'ordine di attacco alle nuove coordinate.
                    -- NOTA: NON usiamo CMD.STOP qui, altrimenti l'aereo resetta 
                    -- continuamente la sua traiettoria di volo (jittering).
                    -- Usiamo semplicemente CMD.ATTACK che sovrascrive il precedente.
                    Spring.GiveOrderToUnit(bID, CMD.ATTACK, {tx, ty, tz}, {})
                end
            end
        end
    end
end

-- Questa funzione serve ad impartire gli ordini di attacco specifici per bombardieri. La funzione associa l'ID del nemico al bombardiere ma impartisce l'ordine alle coordinate (tramite ID il bombardiere non attacca se il target è fuori dai radar o nella nebbia, tramite coordinate invece attacca sempre)
local function GiveBombingOrder(unitID, targetData)
    if not targetData or not targetData.id then return end 					-- se il target del bombardiere non esiste più, non restituire niente e ferma questa funzione
    bomberTargets[unitID] = targetData.id									-- ...altrimenti registra l'ID del bersaglio per questo bombardiere
--    Spring.GiveOrderToUnit(unitID, CMD.STOP, {}, {})						-- Stoppa e diamo l'ordine di attacco alle COORDINATE (x, y, z), questo permette al bombardiere di sganciare anche se perde LOS
    Spring.GiveOrderToUnit(unitID, CMD.ATTACK, {targetData.x, targetData.y, targetData.z}, {})
end

-- questa funzione serve ad impartire gli ordini di attacco
local function GiveAttackOrder(unitID, targetData, squadType)
	if not targetData then return end								-- se il target non esiste più, non restituire niente e ferma questa funzione
   -- Se l'unità è di tipo air_bomber o air_bomber_strategic, usa la funzione GiveBombingOrder
    if squadType == "air_bomber" or squadType == "air_bomber_strategic" then
        GiveBombingOrder(unitID, targetData)
	-- altrimenti utilizza la logica "standard" per le altre unità (ricerca con fight o attacco diretto)
    else	
	Spring.GiveOrderToUnit(unitID, CMD.STOP, {}, {}) 					-- ######## valutare se mantenere questa linea per "pulire gli ordini precedenti" ################################
		if targetData.id and Spring.ValidUnitID(targetData.id) then			-- Se abbiamo un unitID valido...
			Spring.GiveOrderToUnit(unitID, CMD.ATTACK, {targetData.id}, {}) -- ... SPARTISCO L' ORDINE DI ATTACCO DIRETTO ALL'UNITÀ (Cruciale per i bombardieri)
		else																-- Se non abbiamo un unitID, usiamo le coordinate come ripiego (Area Attack)
			local tx = targetData.x + math.random(-250, 250)
			local tz = targetData.z + math.random(-250, 250)
			local ty = Spring.GetGroundHeight(tx, tz)		
			Spring.GiveOrderToUnit(unitID, CMD.FIGHT, {tx, ty, tz}, {})
		end
	end -- end squadtype
end

--------------------------------------------------------------------------------
-- 5) FUNZIONI SPRING
--------------------------------------------------------------------------------
function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
    if not aiTeamIDs[unitTeam] then return end
    if IsUnitIgnored(unitID) then return end

    -- Se l'unità è prodotta da una nostra fabbrica
    if builderID and factories[builderID] then
        local fData = factories[builderID]
        
        -- Se la fabbrica è inUso, aggiungiamo l'ID al secchiello
        if fData.inUso then
            table.insert(fData.bucket, unitID)
            local uName = UnitDefs[unitDefID].name
            Spring.Echo(string.format("AI [Fabbrica %d]: Aggiunto %s al secchiello per il gruppo %d", builderID, uName, fData.nProgressivo))
        end
    end
end

-- unità distrutta -> rimuovila dalle tabelle
function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
    -- Se muore una fabbrica, cancellala subito dalle nostre liste
    if factories[unitID] then factories[unitID] = nil end
    -- Se muore un'unità, rimuovila da qualsiasi squadra (squads) la stia usando
    for sID, sData in pairs(squads) do
        for i = #sData.units, 1, -1 do
            if sData.units[i] == unitID then
                table.remove(sData.units, i)
            end
        end
    end
	-- Se muore il target di un bombardiere, eliminalo dalle nostre liste
    if bomberTargets[unitID] then bomberTargets[unitID] = nil end
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
            teamLevels[teamID] = 0 						
            teamConfigs[teamID] = GetConfigPerLivello(0)	
            
            -- SCANNER PER FABBRICHE ESISTENTI
            local teamUnits = Spring.GetTeamUnits(teamID)
            for _, uID in ipairs(teamUnits) do
                local uDefID = Spring.GetUnitDefID(uID)
                local uName = UnitDefs[uDefID].name
                if teamConfigs[teamID][uName] then
                    factories[uID] = { 
                        teamID = teamID, unitName = uName, inUso = false, 
                        nProgressivo = 0, bucket = {}, squadType = "unknown" 
                    }
                end
            end
		end
	end
end

-- Funzione che avviene a completamento costruzione unità (L'unità è pronta (100%))
function gadget:UnitFinished(unitID, unitDefID, unitTeam)
    if not aiTeamIDs[unitTeam] then return end
    if IsUnitIgnored(unitID) then return end

    local unitName = UnitDefs[unitDefID].name
    local config = teamConfigs[unitTeam]

    -- Se è una fabbrica, la registriamo con la NUOVA struttura
    if config and config[unitName] then 
factories[unitID] = { 
			teamID = unitTeam,
			unitName = unitName,
			inUso = false,
			bucket = {},
			nProgressivo = 0 }
        return
    end

    -- Se è un'unità militare, diamo l'ordine di uscita
    local fX, fY, fZ = Spring.GetUnitPosition(unitID)
    if fX then
        local tx = fX + math.random(-200, 200)
        local tz = fZ + math.random(250, 450)
        local ty = Spring.GetGroundHeight(tx, tz)
        Spring.GiveOrderToUnit(unitID, CMD.MOVE, {tx, ty, tz}, {"shift"})
    end
end

function gadget:GameFrame(n)

    -- 1) UPDATE BOMBARDIERI (Ogni secondo)
    if (n % 30 == 0) then 
        UpdateBomberTracking() 
    end

    -- 2) MONITORAGGIO ORFANI (Ogni 10 secondi) - Soccorso Stradale
    if (n % 300 == 0) then
        for tID, _ in pairs(aiTeamIDs) do
            local allUnits = Spring.GetTeamUnits(tID)
            if allUnits then
                for _, uID in ipairs(allUnits) do
                    if not IsUnitIgnored(uID) then
                        local hasSquad = false
                        for sID, sData in pairs(squads) do
                            if sData.myTeam == tID then
                                for _, suID in ipairs(sData.units) do
                                    if suID == uID then hasSquad = true; break end
                                end
                            end
                            if hasSquad then break end
                        end
                        if not hasSquad then
                            local uCat = GetUnitCategoryFromDB(uID)
                            if uCat == "air" or uCat == "ground" or uCat == "hover" then
                                local target = GetSmartEnemyTarget(tID, uCat)
                                if target then Spring.GiveOrderToUnit(uID, CMD.FIGHT, {target.x, target.y, target.z}, {}) end
                            end
                        end
                    end
                end
            end
        end
    end

    -- Esci se non è un frame di calcolo (ottimizzazione)
    if (n % 30 ~= 0) then return end

    -- 3) SINCRONIZZAZIONE STATO AI (Livelli, Base, Guerra)
    for teamID, _ in pairs(aiTeamIDs) do
        -- Livello
        local nuovoLivello = (GG.WMRTS_Levels and GG.WMRTS_Levels[teamID]) or 0
        if teamLevels[teamID] ~= nuovoLivello then 
            teamLevels[teamID] = nuovoLivello
            teamConfigs[teamID] = GetConfigPerLivello(nuovoLivello)
        end
        -- Posizione Base
        local newBP = GG.AI_BasePos and GG.AI_BasePos[teamID]
        if newBP then basePoint[teamID] = {x = newBP.x, y = newBP.y, z = newBP.z} end
        -- Raggio Base
        baseRadius[teamID] = (GG.AI_RaggioDifesa and GG.AI_RaggioDifesa[teamID]) or 2000
        -- Stato Guerra
        warStatus[teamID] = (GG.AI_StatoGuerra and GG.AI_StatoGuerra[teamID]) or "attacco"
    end

    -- 4) GESTIONE FABBRICHE (Logica "Secchiello" proposta da te)
    for fID, fData in pairs(factories) do
        local qSize = Spring.GetCommandQueue(fID, 0) or 0
        local isBuilding = Spring.GetUnitIsBuilding(fID)
        
        -- STATO A: Fabbrica IDLE e NON in uso -> Inizia nuovo gruppo
        if qSize == 0 and not isBuilding and not fData.inUso then
            local config = teamConfigs[fData.teamID]
            if config and config[fData.unitName] then
                local options = config[fData.unitName]
                local templateName = options[math.random(1, #options)]
                local template = SQUAD_TEMPLATES[templateName]
                
                if template then
                    fData.inUso = true
                    fData.squadType = template.type
                    fData.nProgressivo = fData.nProgressivo + 1
                    fData.bucket = {} 
                    
                    for i, uName in ipairs(template.units) do
                        local uDef = UnitDefNames[uName]
                        if uDef then
                            local cmdTag = (i == 1) and {} or {"shift"}
                            Spring.GiveOrderToUnit(fID, -uDef.id, {}, cmdTag)
                        end
                    end
                    Spring.Echo(string.format("AI [Fabbrica %d]: Avvio produzione gruppo %s", fID, templateName))
                end
            end

        -- STATO B: Fabbrica IDLE ma RISULTA IN USO -> Scarica Secchiello e Crea Squadra!
        elseif qSize == 0 and not isBuilding and fData.inUso then
            if #fData.bucket > 0 then
                local newSquadID = fID .. "_" .. fData.nProgressivo
                squads[newSquadID] = {
                    units = fData.bucket,
                    state = "attacking_monitor", -- Le unità sono già tutte finite, partono subito
                    myTeam = fData.teamID,
                    type = fData.squadType,
                    startTime = Spring.GetGameSeconds()
                }
                Spring.Echo(string.format("AI [Gruppo %s]: Gruppo pronto (%d unità). All'attacco!", newSquadID, #fData.bucket))
                
                -- Primo ordine d'attacco immediato
                local target = GetSmartEnemyTarget(fData.teamID, fData.squadType)
                for _, uID in ipairs(fData.bucket) do
                    if Spring.ValidUnitID(uID) then GiveAttackOrder(uID, target, fData.squadType) end
                end
            end
            fData.inUso = false
            fData.bucket = {}
        end
    end

    -- 5) GESTIONE SQUADRE (Monitoraggio e Re-targeting)
    -- Eseguiamo questo ogni 90 frame (3 secondi) per non pesare sulla CPU
    if n % 90 == 0 then
        for sID, sData in pairs(squads) do
            local anyAlive = false
            local anyIdle = false
            local teamID = sData.myTeam

            -- Pulizia morti e check Idle
            for i = #sData.units, 1, -1 do
                local uID = sData.units[i]
                if Spring.ValidUnitID(uID) and not Spring.GetUnitIsDead(uID) then
                    anyAlive = true
                    if Spring.GetCommandQueue(uID, 0) == 0 then anyIdle = true end
                else
                    table.remove(sData.units, i)
                end
            end

            if anyAlive then
                if anyIdle then
                    local targetAttack = GetSmartEnemyTarget(teamID, sData.type)
                    local targetDefence = GetSmartEnemyTargetInBaseRadious(teamID, sData.type)
                    local insideUnits, outsideUnits = SplitUnitsByRadius(sData.units, basePoint[teamID], baseRadius[teamID])
                    
                    -- Logica Attacco/Difesa
                    if warStatus[teamID] == "attacco" then
                        for _, uID in ipairs(sData.units) do
                            if Spring.GetCommandQueue(uID, 0) == 0 then GiveAttackOrder(uID, targetAttack, sData.type) end
                        end
                    elseif warStatus[teamID] == "difesa_leggera" or warStatus[teamID] == "difesa_pesante" then
                        local target = targetDefence or targetAttack
                        for _, uID in ipairs(sData.units) do
                            if Spring.GetCommandQueue(uID, 0) == 0 then GiveAttackOrder(uID, target, sData.type) end
                        end
                    end
                end
            else
                -- Se sono tutti morti, elimina la squadra
                squads[sID] = nil
            end
        end
    end
end -- Fine funzione GameFrame