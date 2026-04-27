	function gadget:GetInfo()
		return {
			name      = "WMRTS Construction Manager AI",
			desc      = "Gestore costruzioni V17 - War Machines RTS",
			author    = "molix & AI",
			date      = "2026",
			license   = "GPL",
			layer     = 90,
			enabled   = true
		}
	end
	-- 19/01/2026 = realizzato questo gadget, molix
	-- 28/01/2026 = implementata la logica introducendo il RESET LIVELLO. In questo modo quando certe strutture scendono sotto il limite, l'AI resetta il livello e parte da capo con le costruzioni, per prevenire lo stallo economico/tecnologico
	-- 29/01/2026 = le costruzioni vengono costruite ad una certa distanza dai giacimenti di metallo e dalle strutture già costruite per evitare sovrapposizioni
	-- 30/01/2026 = VER 8 implementando logica del pathfinding ( prima la distanza con cui sceglieva il giacimento di metallo più vicino era "in linea d'aria", ora stiamo cercando di implementare la lunghezza effettiva del pathfinding, se il giacimento più vicino è quello dall'altra parte del fiume, un mezzo a terra avrà comunque una distanza maggiore reale da percorrere per raggiungerlo.
	-- 02/02/2026 = VER 9 il pathfinding non sempre restituisce il valore reale della lunghezza. A volte il costruttore di terra, fà per attraversare un fiume per andare a costuire l'estrattore sul giacimento di metallo più vicino "in linea d'aria" e rimane comunque bloccato sulla sponda nell'intento di raggiungere l'altra per costurire il giacimento
	--				viene quindi implementato il timeout: se una unità appartenente al gruppo "LIMITED_CONSTRUCTORS" (solitamente costruttori di terra) rimane ferma per x tempo e non sta costruendo niente (come un comandante bloccato sulla sponda nel tentativo di raggiungere l'altra),
	--				a quel team ID viene messo nella blacklist lo spot di metallo irraggiungibile per le unità di terra. In questo modo l'unità riceve il comando STOP e rimane IDLE, cosi il sistema la impiega per altri lavori (o la ricerca di un nuovo spot di metallo)
	-- 02/02/2026 = inserita la funzione antistallo costruttivo: il builder x può costruire l'unità y?  se no -> interroga il builder successivo, se si -> impiegalo per costruirla. Se tutti i builder successivi non hanno la possibilità di costruirla, allora andrà in stallo. Ma basta tenere, per ogni livello, i builder T1 e T2 tra i requisiti.
	-- 03/02/2026 = inserito il controllo del comandante per livello, ora può essere impiegato per eseguire patrol (come aiutante) o costruttore
	-- 05/02/2026 = V13 inserita funzione upgrade di metallo T1 to T2 o T3 (in futuro).
	-- 06/02/2026 = Corretti comandi per Reclaim e build
	-- 09/02/2026 = V14 Implementato raggio dinamico sviluppo base, in funzione del livello. I raggi sono settati livello per livello
	-- 12/02/2026 = V15 Aggiunto T3, shield, longrange cannon - per ora tutto ICU
	-- 20/02/2026 = V16 Aggiungo tre variabili globali. a) le variabili "AI_RaggioDifesa" e "AI_BasePos" che sono il valore dell'espansione attuale della base che ogni team controllato dalla WMRTSAI, dettato dalla variabile "raggioDinamicoFactory" e la posizione centrale della base. b) la variabile di "AI_StatoGuerra" di ogni team controllato dalla WMRTSAI, e questa variabile può assumere due valori: "attacco", "difesa_leggera", "difesa_pesante". Questa variabile globale servirà a variare il comportamento delle unità in possesso dal team gestite dal gadget "wmrts_AI_militaryMenagement.lua" e che manderà all'attacco o in difesa le unità.	
	-- 20/02/2026 = bugfix: l'AI carica se è impostata come "WMAI", prima partiva a prescindere dal nome.
	-- 26/02/2026 = V17 aggiunte unità NFA
	-- 02/03/2026 = V18 aggiunte unità nella lista dei livelli - cambio nome della AI da "WarMachinesRTSmissionAI" a "WMAI", per inserirlo nella lobby del gioco
	-- 06/03/2026 = V20, aggiungo un test di raggiungimento della destinazione per i builder, non solo per la costruzione del metallo, ma anche per tutte le altre unità.
	-- 19/03/2026 = Added Andronians faction. Molix
	
	-- TO DO

	-- implementare naval e sub
	-- creare la categorizzazione land/air/sea per gli estrattori di metallo (logicamente land e air avranno lo stesso icumetex mentre sea avrà ad esempio undewatermetex). Vedere se fare lo stesso per le floating torrette T1 e T2 ed eventualmente le centrali energia.
	-- creare funzione behaviour ai costruttori fermi, come con il comandante: Patrol/costruisci. La prima gira attorno alla base se non ci sono più ordini da eseguire.
	-- ridurre il timeout nel caso i costruttori rimangano fermi per costruire giacimenti di metallo. ## -> 02/02/2025 fatto per ora lo teniamo cosi molix
	--[[ ########################## to do
	costruire missili e antimissili
costruire air repair
costruire logica espansiva della base (al livello 10 e anche prima arrivi ad aver già occupato lo spazio massimo ammissibile)
nanotower o costruttori aiutanti???
########################################
	--]]

	if (not gadgetHandler:IsSyncedCode()) then return end

	--------------------------------------------------------------------------------
	-- 1) DATABASE E CONFIGURAZIONE
	--------------------------------------------------------------------------------

	-- Carico il database delle unità. 	
	local unitDB = VFS.Include("LuaRules/Configs/WMRTS_AI_mission_db.lua")

	local MAP_PROFILES = {
		["Default"]      = { land = true, air = true, sea = false },		-- configurazione di default per le mappe senza profili mappa
	--    ["Zoty Outpost"] = { land = true, air = true, sea = false },		-- cancello perchè è come default
	}

	-- tabella per monitorare la posizione nel tempo delle unità indicate, serve alla logica per monitorare la posizione dei costruttori e individuare quelli che sono bloccati (perchè non raggiungono una posizione per la costruzione dell'estrattore di metallo)
	local LIMITED_CONSTRUCTORS = {
		-- ICU
		["icucom"] = true, ["icuck"] = true, ["armcv"] = true, ["armcs"] = true, ["kicucom"] = true,
		-- AND
		["andcom"] = true, ["andcon"] = true, ["andcv"] = true, ["andcs"] = true, -- ######################### sistemare la tabella AND #######################
	}

	-- tabella dei comandanti, serve alla logica per capire quali sono i comandanti e controllarne il comportamento in funzione della variabile "combehaviour" in "local AI_BUILD_LEVELS"
	local COMMANDER_TABLE = {
		["ICU"] = { ["icucom"] = true, ["kicucom"] = true },
		["NFA"] = { ["nfacom"] = true, ["knfacom"] = true },
		["AND"] = { ["andcom"] = true }, 
	}
	-- Tabella per la Blacklist degli spot (se una delle unità definite in LIMITED_CONSTRUCTORS rimarra bloccata nel tentativo di costruire un giacimento, metteremo quel giacimento nella blacklist)
	local blacklistedSpots = {} -- [teamID][spotIndex] = true

	-- Tabella per memorizzare la posizione delle unità definite in LIMITED_CONSTRUCTORS
	local builderTracker = {} -- Memorizza {lastX, lastZ, lastFrame, targetSpotIndex}

	-- categorizzazione delle unità
	local CATEGORY_TO_UNIT = {
	--	Puoi randomizzare le costruzioni scrivendo più unità per categoria es.: ["CAT_LASER_T1"] = { "armrl", "armllt", "armteeth" },
	--  Se vuoi che un'unità sia costruita più spesso di un'altra, puoi ripetere il nome nella lista es.: ["CAT_MEX_T1"] = { "mex_normale", "mex_normale", "mex_corazzato" } Qui l'AI avrà il 66% di probabilità di fare quello normale e il 33% di fare quello corazzato.
	--	Aggiungi la categoria che vuoi ["CAT_esempio_robotT3"] = = { "icuraz" }, -- Meglio se la categoria "CAT_esempio_robotT3" sia presente in tutte le fazioni. Usa poi la categoria nella "AI_BUILD_LEVELS"
	----------------------------
	-- ICU
	----------------------------
		["ICU"] = {
	-- categorie per le FUNZIONI - utilizzate nelle funzioni helper o nella logica CORE del gadget. ATTENZIONE, QUANDO SI MODIFICA UNA DI QUESTE CATEGORIE, VERIFICARE SEMPRE DOVE VIENE USATA NELLA LOGICA!!!!
			["CAT_ALL_CONSTRUCTORS"] 		= { "icucom", "icuck", "armcv", "armca", "armcs" }, 	-- categoria con tutti i costruttori (incluso il comandante), la uso al livello 0 per due motivi: 1) in caso di distruzione totale, quando l'AI torna a 0, se uno dei costruttori elencati è sopravvissuto, lo usa per ripartire con le costruzioni dal livello 0. 2) col game start, si parte col comandante, che è incluso nella lista. Soddisfa quindi il requisito del lvl 0.	
			["CAT_ALL_AIR_CONSTRUCTORS"] 	= { "armca", "armaca" }, 								-- categoria con tutti gli aerei costruttori, necessaria ad ignorare le unità indicate nella funzione per il calcolo del pathfinding durante la costruzione dell'estrattore più vicino. Vanno direttamente a costruire in quel punto x,y,z preferendo la "linea d'aria"
	-- categorie per le costruzioni
			["CAT_MEX_T1"]          = { "icumetex" },				-- estrattori T1			
			["CAT_MEX_T2"]          = { "armmoho","advmoho"	},		-- estrattori T2	
			["CAT_ENERGY_T1"]      	= { "armsolar" },				-- energyplant T1
			["CAT_ENERGY_T1_2"]    	= { "icuadvsol" },				-- energyplant T1/2		
			["CAT_ENERGY_T2"]      	= { "aafus", "armfus","armfus","armfus" },					-- energyplant T2, con più possibilità di realizzare armfus
			["CAT_ESTORAGE_T1"]		= { "icuestor" },				-- storage Energy T1
			["CAT_MSTORAGE_T1"]		= { "armmstor" },				-- storage Metal T1		
			["CAT_LASER_T1"]       	= { "iculighlturr" },
			["CAT_LASER_T1_2"]      = { "armhlt" },		
			["CAT_LASER_T2"]      	= { "armanni" },		
			["CAT_CANNON_T2"]      	= { "armamb" },			
			["CAT_AA_T1"]          	= { "armrl" },
			["CAT_AA_T1_2"]         = { "packo" },			
			["CAT_SHIELD"]         	= { "armgate" },						
			["CAT_LONG_CANNON"]     = { "armbrtha" },									
			["CAT_AA_T2"]          	= { "armflak", "armflak", "armflak", "mercury" },		
			["CAT_ATOMICDEFENCE"]   = { "armamd" },						
			["CAT_ATOMICATTACK"]    = { "armsilo" },							
			
			["CAT_FACTORY_T1"] = {									-- fabbrica T1 si categorizza per tipologia ( terra, aria o mare), in funzione dei MAP_PROFILES l'AI effettuerà una scelta
				land = { "armlab", "armvp" },						-- randomizza la fabbrica
				air  = { "armap" },
				sea  = { "armsy" },
			},
			["CAT_FACTORY_T2"] = {
				land = { "armalab", "armavp" },
				air  = { "armaap" },
				sea  = { "armasy" },
			},		
			["CAT_FACTORY_T3"] = {
				land = { "icugant", "armshltx" },
				air  = { "icufff" },
				sea  = { "armasy" }, -- pagliativo per non bloccare l'AI
			},		
			["CAT_CONSTRUCTORS_T1"]		= { "icuck", "armcv", "armca", "armcs" }, 				-- solo costruttori T1
			["CAT_CONSTRUCTORS_T2"] 	= { "armack", "armacv", "armaca", "armacs" }, 			-- solo costruttori T2	
		}, -- end ICU
	----------------------------
	-- NFA
	----------------------------		
		["NFA"] = {
	-- categorie per le FUNZIONI - utilizzate nelle funzioni helper o nella logica CORE del gadget. ATTENZIONE, QUANDO SI MODIFICA UNA DI QUESTE CATEGORIE, VERIFICARE SEMPRE DOVE VIENE USATA NELLA LOGICA!!!!
			["CAT_ALL_CONSTRUCTORS"] 		= { "nfacom", "corck", "corcv", "corca", "corcs" }, 	-- categoria con tutti i costruttori (incluso il comandante), la uso al livello 0 per due motivi: 1) in caso di distruzione totale, quando l'AI torna a 0, se uno dei costruttori elencati è sopravvissuto, lo usa per ripartire con le costruzioni dal livello 0. 2) col game start, si parte col comandante, che è incluso nella lista. Soddisfa quindi il requisito del lvl 0.	
			["CAT_ALL_AIR_CONSTRUCTORS"] 	= { "corca", "coraca" }, 								-- categoria con tutti gli aerei costruttori, necessaria ad ignorare le unità indicate nella funzione per il calcolo del pathfinding durante la costruzione dell'estrattore più vicino. Vanno direttamente a costruire in quel punto x,y,z preferendo la "linea d'aria"
	-- categorie per le costruzioni
			["CAT_MEX_T1"]          = { "cormex" },					-- estrattori T1			
			["CAT_MEX_T2"]          = { "cormoho","cormexp"	},		-- estrattori T2	
			["CAT_ENERGY_T1"]      	= { "corsolar" },				-- energyplant T1
			["CAT_ENERGY_T1_2"]    	= { "coradvsol" },				-- energyplant T1/2		
			["CAT_ENERGY_T2"]      	= { "cafus", "corfus","corfus","corfus" },					-- energyplant T2, con più possibilità di realizzare corfus
			["CAT_ESTORAGE_T1"]		= { "corestor" },				-- storage Energy T1
			["CAT_MSTORAGE_T1"]		= { "cormstor" },				-- storage Metal T1		
			["CAT_LASER_T1"]       	= { "corllt" },
			["CAT_LASER_T1_2"]      = { "corhlt" },		
			["CAT_LASER_T2"]      	= { "cordoom" },		
			["CAT_CANNON_T2"]      	= { "cortoast" },			
			["CAT_AA_T1"]          	= { "corrl" },
			["CAT_AA_T1_2"]         = { "madsam" },			
			["CAT_SHIELD"]         	= { "corgate" },						
			["CAT_LONG_CANNON"]     = { "corint" },									
			["CAT_AA_T2"]          	= { "corflak", "corflak", "corflak", "screamer" },		
			["CAT_ATOMICDEFENCE"]   = { "corfmd" },						
			["CAT_ATOMICATTACK"]    = { "corsilo" },							
			
			["CAT_FACTORY_T1"] = {									-- fabbrica T1 si categorizza per tipologia ( terra, aria o mare), in funzione dei MAP_PROFILES l'AI effettuerà una scelta
				land = { "corlab", "corvp" },						-- randomizza la fabbrica
				air  = { "corap" },
				sea  = { "corsy" },
			},
			["CAT_FACTORY_T2"] = {
				land = { "coralab", "coravp" },
				air  = { "coraap" },
				sea  = { "corasy" },
			},		
			["CAT_FACTORY_T3"] = {
				land = { "corgant" },
				air  = { "nfafff" },
				sea  = { "corasy" },
			},		
			["CAT_CONSTRUCTORS_T1"]		= { "corck", "corcv", "corca", "corcs" }, 				-- solo costruttori T1
			["CAT_CONSTRUCTORS_T2"] 	= { "corack", "coracv", "coraca", "coracs" }, 			-- solo costruttori T2	
		}, -- end NFA
	----------------------------
	-- AND
	----------------------------
		["AND"] = {
	-- categorie per le FUNZIONI - utilizzate nelle funzioni helper o nella logica CORE del gadget. ATTENZIONE, QUANDO SI MODIFICA UNA DI QUESTE CATEGORIE, VERIFICARE SEMPRE DOVE VIENE USATA NELLA LOGICA!!!!
			["CAT_ALL_CONSTRUCTORS"] 		= { "andcom", "andcsp", "andch", "andca" }, 			-- categoria con tutti i costruttori (incluso il comandante), la uso al livello 0 per due motivi: 1) in caso di distruzione totale, quando l'AI torna a 0, se uno dei costruttori elencati è sopravvissuto, lo usa per ripartire con le costruzioni dal livello 0. 2) col game start, si parte col comandante, che è incluso nella lista. Soddisfa quindi il requisito del lvl 0.	
			["CAT_ALL_AIR_CONSTRUCTORS"] 	= { "andca", "andaca" }, 								-- categoria con tutti gli aerei costruttori, necessaria ad ignorare le unità indicate nella funzione per il calcolo del pathfinding durante la costruzione dell'estrattore più vicino. Vanno direttamente a costruire in quel punto x,y,z preferendo la "linea d'aria"
	-- categorie per le costruzioni
			["CAT_MEX_T1"]          = { "andmexun" },									-- estrattori T1			
			["CAT_MEX_T2"]          = { "andametex" },									-- estrattori T2	
			["CAT_ENERGY_T1"]      	= { "andsolar" },									-- energyplant T1
			["CAT_ENERGY_T1_2"]    	= { "andadvsol" },									-- energyplant T1/2		#################################################################################################################
			["CAT_ENERGY_T2"]      	= { "andaafus", "andfus","andfus","andfus" },					-- energyplant T2, con più possibilità di realizzare armfus
			["CAT_ESTORAGE_T1"]		= { "andestor" },									-- storage Energy T1
			["CAT_MSTORAGE_T1"]		= { "andmstor" },									-- storage Metal T1		
			["CAT_LASER_T1"]       	= { "andlartic" },
			["CAT_LASER_T1_2"]      = { "andhartic" },		
			["CAT_LASER_T2"]      	= { "andill", "andchaos" },		
			["CAT_CANNON_T2"]      	= { "anddfens" },			
			["CAT_AA_T1"]          	= { "andrl" },
			["CAT_AA_T1_2"]         = { "andaa" },			
			["CAT_SHIELD"]         	= { "andshield" },						
			["CAT_LONG_CANNON"]     = { "andangel" },									
			["CAT_AA_T2"]          	= { "andernie", "andernie", "andernie", "chemist" },		
			["CAT_ATOMICDEFENCE"]   = { "anddefensor" },										
			["CAT_ATOMICATTACK"]    = { "andlaunch" },									-- ##########				
			
			["CAT_FACTORY_T1"] = {									-- fabbrica T1 si categorizza per tipologia ( terra, aria o mare), in funzione dei MAP_PROFILES l'AI effettuerà una scelta
				land = { "andlab", "andhp" },						-- randomizza la fabbrica
				air  = { "andplat" },
				sea  = { "andhp" },
			},
			["CAT_FACTORY_T2"] = {
				land = { "andalab", "andahp" },
				air  = { "andaplat" },
				sea  = { "andahp" },
			},		
			["CAT_FACTORY_T3"] = {
				land = { "andgant" },															-- #################### aggiungere "andspidfactory"
				air  = { "andaplat" },															-- #################### aggiungere andfff appena completato
				sea  = { "andahp" }, -- pagliativo per non bloccare l'AI
			},		
			["CAT_CONSTRUCTORS_T1"]		= { "andcsp", "andch", "andca" }, 						-- solo costruttori T1
			["CAT_CONSTRUCTORS_T2"] 	= { "andacsp", "andach", "andaca" }, 					-- solo costruttori T2	
		} -- end AND
	} -- end "CATEGORY_TO_UNIT"

	local AI_BUILD_LEVELS = {
	-- il numero [0] o [1] rappresenta il livello della AI. L'AI parte sempre dal livello 0. Per ogni livello vengono specificate quante unità devono essere costruite. l'AI sale di livello una volta che ha completato tutte le unità di quel livello. Se vengono distrutte le unità, e i requisiti di un livello non vengono rispettati, l'AI scende di livello per "recuperare" i requisiti che lo soddisfano.
	-- REMINDER: ogni volta che si aggiunge o toglie il livello a questo gadget, aggiornare anche i livelli in wmrts_AI_militaryMenagement.lua !!!!!!!
	-- "simultanea ="  ad ogni ciclo di controllo (150 frame / 5 secondi), questa variabile definisce il numero massimo di ordini simultanei da impartire ai costruttori fermi( es simultanea = 6 -> in quel livello l'AI cercherà di "mettere al lavoro" fino a 6 costruttori diversi contemporaneamente in quel singolo ciclo.)
	-- "cat=" rappresenta quali unità  di categoria l'AI deve costruire in quel determinato livello. Le categorie sono definite sopra e si possono aggiungere a piacimento (a patto che sia presente in tutte le fazioni)
	-- "count=" rappresenta la variabile ASSOLUTA di quante unità della categoria corrispondente devono essere attive in quel dato livello
	-- "combehaviour=" è il comportamento del comandante in quello specifico livello. può essere
	--			= constructor, 		ossia si comporta come un costruttore che costruisce delle building, importante ad esempio nei primi livelli
	--			= patrolbase,		ossia esegue un patrol intorno al centro della base, cosi da aiutare le costruzioni.
	-- "T2metalBuildType" gestisce come vengono costruiti gli estrattori T2:
	--			= new,				default - l'estrattore T2 viene costruito su uno spot di metallo libero
	--			= upgrade,			l'AI preferirà potenziare i mex esistenti a partire da quelli più vicino alla base
		[0] = { 												-- livello di partenza. può diventare anche livello di RESET LIVELLO AI quando subisce pesanti attacchi (vedere sotto logica di RESET LIVELLO). E' importante che vi siano, in questo livello, le costruzioni che, in loro assenza/mancato numero (definito dalla logica di "RESET LIVELLO") resettino l'AI, altrimenti si entra in un LOOP infinito di salto livello (0 -> 1 e torna subito a 0)
			simultanea = 1,
			fattoreVariazioneRaggio = 0,			
			combehaviour = "constructor",
			T2metalBuildType = "new",
			requisiti = {
				{cat = "CAT_ALL_CONSTRUCTORS", 	count = 1}, 	-- al livello 0 ne deve avere almeno 1 in totale. In fase di start skirmish è il comandante. In caso di restart AI, può essere qualunque costruttore, se presente. Ecco il motivo per cui metto la categoria "CAT_ALL_CONSTRUCTORS"
				{cat = "CAT_ENERGY_T1",         count = 1},		-- importanti per la logica RESET LIVELLO !! estrattori T1, energia T1 e fabbrica T1 devono essere inclusi in questo livello per andare al successivo, altrimenti la logica del core entra in loop
				{cat = "CAT_MEX_T1",            count = 1},		-- importanti per la logica RESET LIVELLO !! estrattori T1, energia T1 e fabbrica T1 devono essere inclusi in questo livello per andare al successivo, altrimenti la logica del core entra in loop
				{cat = "CAT_ENERGY_T1",         count = 2},		-- importanti per la logica RESET LIVELLO !! estrattori T1, energia T1 e fabbrica T1 devono essere inclusi in questo livello per andare al successivo, altrimenti la logica del core entra in loop			
				{cat = "CAT_MEX_T1",            count = 3}, 
				{cat = "CAT_ENERGY_T1",         count = 3},		
				{cat = "CAT_FACTORY_T1",        count = 1}, 	
			} 	-- end requisiti di livello
		},		-- end livello  [n]
		[1] = {													-- reminder: aggiorna anche le costruzioni di livello corrispondente nel gadget military
			simultanea = 4,
			fattoreVariazioneRaggio = 0,						
			combehaviour = "patrolbase",	
			T2metalBuildType = "new",			
			requisiti = {
				{cat = "CAT_CONSTRUCTORS_T1", 	count = 4},
				{cat = "CAT_FACTORY_T1",        count = 3}, 				
				{cat = "CAT_LASER_T1", 			count = 1},		
				{cat = "CAT_AA_T1", 			count = 1},		
				{cat = "CAT_ENERGY_T1",         count = 7},						
				{cat = "CAT_MEX_T1",            count = 6},
			} 	-- end requisiti di livello
		},		-- end livello  [n]
		[2] = {													-- reminder: aggiorna anche le costruzioni di livello corrispondente nel gadget military
			simultanea = 4,
			fattoreVariazioneRaggio = 0,						
			combehaviour = "patrolbase",	
			T2metalBuildType = "new",			
			requisiti = {		
				{cat = "CAT_CONSTRUCTORS_T1", 	count = 4},		
				{cat = "CAT_ENERGY_T1_2",       count = 1},
				{cat = "CAT_FACTORY_T1", 		count = 3},
	            {cat = "CAT_MEX_T1",            count = 6},
				{cat = "CAT_LASER_T1", 			count = 2},		
				{cat = "CAT_AA_T1", 			count = 2},			
			} 	-- end requisiti di livello
		},		-- end livello  [n]	
		[3] = {													-- reminder: aggiorna anche le costruzioni di livello corrispondente nel gadget military
			simultanea = 4,
			fattoreVariazioneRaggio = 0,						
			combehaviour = "patrolbase",	
			T2metalBuildType = "new",			
			requisiti = {
				{cat = "CAT_CONSTRUCTORS_T1", 	count = 4},
				{cat = "CAT_MEX_T1",            count = 6},		
				{cat = "CAT_FACTORY_T1", 		count = 3},			
				{cat = "CAT_ENERGY_T1_2",       count = 2},
				{cat = "CAT_AA_T1_2", 			count = 1},					
				{cat = "CAT_FACTORY_T2", 		count = 1},						
			} 	-- end requisiti di livello
		},		-- end livello  [n]	
		[4] = {													-- reminder: aggiorna anche le costruzioni di livello corrispondente nel gadget military
			simultanea = 5,
			fattoreVariazioneRaggio = 1,						
			combehaviour = "patrolbase",	
			T2metalBuildType = "upgrade",			
			requisiti = {
				{cat = "CAT_CONSTRUCTORS_T2", 	count = 2},	
				{cat = "CAT_MEX_T1",            count = 3},		
				{cat = "CAT_ENERGY_T1_2",       count = 3},				
				{cat = "CAT_MEX_T2",            count = 1},	
				{cat = "CAT_ENERGY_T2",      	count = 1},					
				{cat = "CAT_FACTORY_T1", 		count = 4},			
				{cat = "CAT_CONSTRUCTORS_T1", 	count = 4},
				{cat = "CAT_LASER_T1_2", 		count = 1},						
			} 	-- end requisiti di livello
		},		-- end livello  [n]		
		[5] = {													-- reminder: aggiorna anche le costruzioni di livello corrispondente nel gadget military
			simultanea = 6,
			fattoreVariazioneRaggio = 1,						
			combehaviour = "patrolbase",		
			T2metalBuildType = "upgrade",			
			requisiti = {
				{cat = "CAT_FACTORY_T2", 		count = 1},		
				{cat = "CAT_FACTORY_T1", 		count = 5},	
				{cat = "CAT_CONSTRUCTORS_T1", 	count = 4},
				{cat = "CAT_CONSTRUCTORS_T2", 	count = 2},			
				{cat = "CAT_ENERGY_T1_2",       count = 2},
				{cat = "CAT_MEX_T1",            count = 7},		
			} 	-- end requisiti di livello
		},		-- end livello  [n]		
		[6] = {													-- reminder: aggiorna anche le costruzioni di livello corrispondente nel gadget military
			simultanea = 7,
			fattoreVariazioneRaggio = 1,						
			combehaviour = "patrolbase",
			T2metalBuildType = "upgrade",				
			requisiti = {
				{cat = "CAT_FACTORY_T2", 		count = 1},		
				{cat = "CAT_FACTORY_T1", 		count = 4},	
				{cat = "CAT_CONSTRUCTORS_T1", 	count = 4},
				{cat = "CAT_CONSTRUCTORS_T2", 	count = 3},			
				{cat = "CAT_ENERGY_T1_2",       count = 3},
				{cat = "CAT_MEX_T2",            count = 2},					
				{cat = "CAT_MEX_T1",            count = 3},		
			} 	-- end requisiti di livello
		},		-- end livello  [n]			
		[7] = {													-- reminder: aggiorna anche le costruzioni di livello corrispondente nel gadget military
			simultanea = 7,
			fattoreVariazioneRaggio = 1,						
			combehaviour = "patrolbase",	
			T2metalBuildType = "upgrade",				
			requisiti = {
				{cat = "CAT_ENERGY_T2",      	count = 2},	
				{cat = "CAT_FACTORY_T2", 		count = 2},		
				{cat = "CAT_FACTORY_T1", 		count = 6},	
				{cat = "CAT_CONSTRUCTORS_T1", 	count = 4},
				{cat = "CAT_CONSTRUCTORS_T2", 	count = 3},			
--				{cat = "CAT_ENERGY_T1_2",       count = 3},
				{cat = "CAT_MEX_T2",            count = 2},					
				{cat = "CAT_MEX_T1",            count = 2},		
				{cat = "CAT_AA_T2", 			count = 1},					
--				{cat = "CAT_LASER_T2", 			count = 1},							
			} 	-- end requisiti di livello
		},		-- end livello  [n]			
		[8] = {													-- reminder: aggiorna anche le costruzioni di livello corrispondente nel gadget military
			simultanea = 8,							
			fattoreVariazioneRaggio = 2,						
			combehaviour = "patrolbase",	
			T2metalBuildType = "upgrade",			
			requisiti = {
				{cat = "CAT_FACTORY_T2", 		count = 4},		
				{cat = "CAT_FACTORY_T1", 		count = 8},	
				{cat = "CAT_CONSTRUCTORS_T1", 	count = 4},
				{cat = "CAT_CONSTRUCTORS_T2", 	count = 4},			
				{cat = "CAT_MEX_T2",            count = 3},					
				{cat = "CAT_ENERGY_T2",         count = 3},				
			} 	-- end requisiti di livello
		},		-- end livello  [n]			
		[9] = {													-- reminder: aggiorna anche le costruzioni di livello corrispondente nel gadget military
			simultanea = 9,								
			fattoreVariazioneRaggio = 2,						
			combehaviour = "patrolbase",	
			T2metalBuildType = "upgrade",				
			requisiti = {
				{cat = "CAT_FACTORY_T2", 		count = 5},		
				{cat = "CAT_FACTORY_T1", 		count = 9},	
				{cat = "CAT_CONSTRUCTORS_T1", 	count = 4},
				{cat = "CAT_CONSTRUCTORS_T2", 	count = 5},			
				{cat = "CAT_MEX_T2",            count = 4},					
				{cat = "CAT_ENERGY_T2",         count = 3},	
				{cat = "CAT_CANNON_T2",         count = 3},		
				{cat = "CAT_AA_T2", 			count = 2},						
				
			} 	-- end requisiti di livello
		},		-- end livello  [n]			
		[10] = {													-- reminder: aggiorna anche le costruzioni di livello corrispondente nel gadget military
			simultanea = 9,								
			fattoreVariazioneRaggio = 3,						
			combehaviour = "patrolbase",	
			T2metalBuildType = "upgrade",				
			requisiti = {
				{cat = "CAT_CONSTRUCTORS_T1", 	count = 4},
				{cat = "CAT_CONSTRUCTORS_T2", 	count = 5},			
				{cat = "CAT_FACTORY_T2", 		count = 6},		
				{cat = "CAT_LASER_T2", 			count = 1},					
				{cat = "CAT_FACTORY_T1", 		count = 10},	
				{cat = "CAT_MEX_T2",            count = 5},	
				{cat = "CAT_SHIELD", 			count = 1},						
				{cat = "CAT_ENERGY_T2",         count = 4},		
				{cat = "CAT_AA_T2", 			count = 4},		
				{cat = "CAT_SHIELD", 			count = 2},						
				{cat = "CAT_LASER_T2", 			count = 3},	
				{cat = "CAT_CANNON_T2", 		count = 3},		
				{cat = "CAT_SHIELD", 			count = 3},														
			} 	-- end requisiti di livello
		},		-- end livello  [n]	
		[11] = {													-- reminder: aggiorna anche le costruzioni di livello corrispondente nel gadget military
			simultanea = 9,								
			fattoreVariazioneRaggio = 4,						
			combehaviour = "patrolbase",	
			T2metalBuildType = "upgrade",				
			requisiti = {
				{cat = "CAT_SHIELD", 			count = 3},				
				{cat = "CAT_CONSTRUCTORS_T1", 	count = 4},
				{cat = "CAT_CONSTRUCTORS_T2", 	count = 5},	
				{cat = "CAT_LONG_CANNON", 		count = 1},					
				{cat = "CAT_FACTORY_T3", 		count = 2},						
				{cat = "CAT_FACTORY_T2", 		count = 6},		
				{cat = "CAT_FACTORY_T1", 		count = 10},	
				{cat = "CAT_MEX_T2",            count = 5},					
				{cat = "CAT_ENERGY_T2",         count = 5},	
				{cat = "CAT_LONG_CANNON", 		count = 2},								
				{cat = "CAT_LASER_T2", 			count = 4},	
				{cat = "CAT_AA_T2", 			count = 6},	
				{cat = "CAT_CANNON_T2", 		count = 6},		
				{cat = "CAT_LONG_CANNON", 		count = 3},		
				{cat = "CAT_SHIELD", 			count = 4},								
			} 	-- end requisiti di livello
		},		-- end livello  [n]		
		[12] = {													-- reminder: aggiorna anche le costruzioni di livello corrispondente nel gadget military
			simultanea = 9,								
			fattoreVariazioneRaggio = 7,						
			combehaviour = "patrolbase",	
			T2metalBuildType = "upgrade",				
			requisiti = {			
				{cat = "CAT_CONSTRUCTORS_T1", 	count = 4},
				{cat = "CAT_CONSTRUCTORS_T2", 	count = 5},	
				{cat = "CAT_FACTORY_T3", 		count = 3},						
				{cat = "CAT_FACTORY_T2", 		count = 6},		
				{cat = "CAT_FACTORY_T1", 		count = 10},	
				{cat = "CAT_MEX_T2",            count = 5},					
				{cat = "CAT_ENERGY_T2",         count = 5},	
				{cat = "CAT_LASER_T2", 			count = 4},	
				{cat = "CAT_AA_T2", 			count = 6},	
				{cat = "CAT_CANNON_T2", 		count = 6},		
				{cat = "CAT_LONG_CANNON", 		count = 3},		
				{cat = "CAT_SHIELD", 			count = 4},								
				{cat = "CAT_ATOMICDEFENCE",		count = 2},						
				{cat = "CAT_ATOMICATTACK",		count = 2},										
			} 	-- end requisiti di livello
		}		-- end livello  [n]				
	}

	-- inserimento manuale degli spot di metallo per ogni mappa, utilizzare widget: WMRTS_Maker_exportMetal.lua (comando /exportmetal in chat)
	local MANUAL_MAP_DATA = {
		["Akilon"] 					= { {x = 671, z = 586}, {x = 892, z = 723}, {x = 1932, z = 728}, {x = 680, z = 826}, {x = 2062, z = 917}, {x = 1835, z = 948}, {x = 5006, z = 1230}, {x = 5225, z = 1318}, {x = 5001, z = 1467}, {x = 676, z = 1503}, {x = 2625, z = 1552}, {x = 458, z = 1592}, {x = 2854, z = 1700}, {x = 685, z = 1739}, {x = 2637, z = 1785}, {x = 3972, z = 2253}, {x = 7318, z = 2429}, {x = 7094, z = 2582}, {x = 7309, z = 2665}, {x = 963, z = 2872}, {x = 753, z = 2976}, {x = 976, z = 3112}, {x = 5826, z = 3172}, {x = 4427, z = 3250}, {x = 5618, z = 3275}, {x = 5835, z = 3412}, {x = 2852, z = 3593}, {x = 7490, z = 3754}, {x = 7712, z = 3840}, {x = 7482, z = 3987}, {x = 709, z = 4204}, {x = 480, z = 4352}, {x = 701, z = 4437}, {x = 5339, z = 4598}, {x = 2356, z = 4779}, {x = 2573, z = 4916}, {x = 3764, z = 4941}, {x = 2365, z = 5020}, {x = 7216, z = 5080}, {x = 7438, z = 5215}, {x = 7228, z = 5320}, {x = 882, z = 5526}, {x = 1097, z = 5609}, {x = 873, z = 5762}, {x = 4082, z = 6077}, {x = 5554, z = 6406}, {x = 7506, z = 6452}, {x = 5337, z = 6491}, {x = 7733, z = 6600}, {x = 5566, z = 6639}, {x = 7515, z = 6688}, {x = 3190, z = 6724}, {x = 2966, z = 6873}, {x = 3185, z = 6961}, {x = 6432, z = 7168}, {x = 6204, z = 7198}, {x = 7512, z = 7365}, {x = 6333, z = 7384}, {x = 7299, z = 7468}, {x = 7520, z = 7606} },
		["Alone"] 					= { {x = 607, z = 168}, {x = 7259, z = 162}, {x = 4744, z = 205}, {x = 388, z = 392}, {x = 721, z = 435}, {x = 4512, z = 445}, {x = 7469, z = 448}, {x = 4804, z = 504}, {x = 7112, z = 536}, {x = 5990, z = 835}, {x = 5692, z = 902}, {x = 3048, z = 1065}, {x = 656, z = 1092}, {x = 5931, z = 1128}, {x = 966, z = 1238}, {x = 2819, z = 1305}, {x = 3113, z = 1356}, {x = 721, z = 1465}, {x = 6468, z = 1872}, {x = 4005, z = 2037}, {x = 6233, z = 2110}, {x = 6528, z = 2168}, {x = 4236, z = 2270}, {x = 3862, z = 2337}, {x = 5522, z = 2691}, {x = 717, z = 2728}, {x = 7224, z = 2777}, {x = 5285, z = 2922}, {x = 960, z = 2955}, {x = 664, z = 3019}, {x = 7452, z = 3017}, {x = 5590, z = 3064}, {x = 7080, z = 3081}, {x = 749, z = 3620}, {x = 2616, z = 3624}, {x = 6436, z = 3623}, {x = 2950, z = 3664}, {x = 6772, z = 3665}, {x = 392, z = 3712}, {x = 2730, z = 3893}, {x = 6548, z = 3892}, {x = 608, z = 3995} },		
		["Alos"] 					= { {x = 1795, z = 122}, {x = 2982, z = 164}, {x = 5147, z = 154}, {x = 5016, z = 104}, {x = 1206, z = 289}, {x = 912, z = 432}, {x = 696, z = 476}, {x = 385, z = 830}, {x = 4631, z = 1212}, {x = 1289, z = 1244}, {x = 4760, z = 1224}, {x = 4420, z = 1987}, {x = 4546, z = 2008}, {x = 1206, z = 2133}, {x = 1040, z = 2240}, {x = 5979, z = 2405}, {x = 264, z = 2560}, {x = 42, z = 2602}, {x = 568, z = 2624}, {x = 5094, z = 3092}, {x = 2590, z = 3349}, {x = 2728, z = 3382}, {x = 6089, z = 4268}, {x = 4313, z = 4825}, {x = 5203, z = 4905}, {x = 4400, z = 5056}, {x = 3726, z = 5531}, {x = 3584, z = 5485}, {x = 5974, z = 5987} },		
		["Aminos Island"] 			= { {x = 5484, z = 940}, {x = 10177, z = 1015}, {x = 9968, z = 1119}, {x = 5352, z = 1130}, {x = 5581, z = 1165}, {x = 10187, z = 1254}, {x = 3456, z = 1292}, {x = 3246, z = 1397}, {x = 3466, z = 1532}, {x = 6593, z = 1846}, {x = 6822, z = 1878}, {x = 6691, z = 2067}, {x = 4785, z = 2156}, {x = 5015, z = 2305}, {x = 10322, z = 2310}, {x = 4796, z = 2387}, {x = 2696, z = 2450}, {x = 10550, z = 2457}, {x = 10331, z = 2544}, {x = 2908, z = 2554}, {x = 2688, z = 2691}, {x = 7725, z = 2866}, {x = 7497, z = 3014}, {x = 7714, z = 3101}, {x = 1455, z = 3302}, {x = 1678, z = 3435}, {x = 1465, z = 3540}, {x = 8176, z = 3586}, {x = 7960, z = 3672}, {x = 8186, z = 3821}, {x = 9690, z = 3968}, {x = 5202, z = 3974}, {x = 5420, z = 4064}, {x = 9914, z = 4120}, {x = 5194, z = 4211}, {x = 9699, z = 4205}, {x = 5645, z = 4465}, {x = 5512, z = 4652}, {x = 5741, z = 4685}, {x = 8646, z = 4998}, {x = 8428, z = 5131}, {x = 8636, z = 5238}, {x = 8123, z = 5446}, {x = 8349, z = 5578}, {x = 3096, z = 5672}, {x = 8137, z = 5684}, {x = 2877, z = 5809}, {x = 2466, z = 5918}, {x = 3085, z = 5914}, {x = 2248, z = 6003}, {x = 2474, z = 6152}, {x = 9369, z = 7174}, {x = 9164, z = 7278}, {x = 9382, z = 7414}, {x = 6568, z = 7445}, {x = 6362, z = 7548}, {x = 1595, z = 7561}, {x = 6584, z = 7685}, {x = 1464, z = 7752}, {x = 1694, z = 7784}, {x = 8422, z = 8057}, {x = 8649, z = 8089}, {x = 8518, z = 8278}, {x = 4392, z = 8552}, {x = 3775, z = 8640}, {x = 3998, z = 8677}, {x = 4616, z = 8696}, {x = 4397, z = 8784}, {x = 3871, z = 8859}, {x = 5313, z = 9223}, {x = 5542, z = 9254}, {x = 3328, z = 9346}, {x = 5412, z = 9446}, {x = 3558, z = 9494}, {x = 3341, z = 9578}, {x = 1925, z = 10136}, {x = 1716, z = 10239}, {x = 1936, z = 10376}, {x = 9378, z = 10562}, {x = 9608, z = 10595}, {x = 9476, z = 10778}, {x = 7146, z = 11036}, {x = 7376, z = 11184}, {x = 7158, z = 11272}, {x = 11968, z = 11953}, {x = 12194, z = 11984}, {x = 12067, z = 12171} },
		["AstroTurf_v2"]			= { {x = 6198, z = 2778}, {x = 6922, z = 3098}, {x = 5386, z = 3158}, {x = 6838, z = 3542}, {x = 5606, z = 3610}, {x = 4038, z = 3642}, {x = 8554, z = 3722}, {x = 3846, z = 3754}, {x = 6586, z = 3846}, {x = 8422, z = 3862}, {x = 4038, z = 3878}, {x = 5958, z = 3926}, {x = 8650, z = 3942}, {x = 7990, z = 4522}, {x = 9146, z = 4534}, {x = 4378, z = 4726}, {x = 3670, z = 5018}, {x = 3798, z = 5254}, {x = 3526, z = 5286}, {x = 7430, z = 5318}, {x = 8550, z = 5386}, {x = 2790, z = 5410}, {x = 4710, z = 5446}, {x = 8394, z = 5510}, {x = 5430, z = 5590}, {x = 8554, z = 5654}, {x = 6518, z = 5894}, {x = 5750, z = 5946}, {x = 7446, z = 5974}, {x = 4918, z = 6326}, {x = 6394, z = 6378}, {x = 5818, z = 6454}, {x = 4006, z = 6598}, {x = 6806, z = 6646}, {x = 3942, z = 6762}, {x = 7446, z = 6758}, {x = 4118, z = 6806}, {x = 9386, z = 6938}, {x = 8806, z = 7002}, {x = 4954, z = 7082}, {x = 8602, z = 7130}, {x = 8794, z = 7270}, {x = 7914, z = 7562}, {x = 4570, z = 7626}, {x = 3350, z = 7734}, {x = 3882, z = 8358}, {x = 8410, z = 8378}, {x = 3658, z = 8426}, {x = 8214, z = 8570}, {x = 3786, z = 8614}, {x = 8458, z = 8634}, {x = 5846, z = 8746}, {x = 6374, z = 8758}, {x = 5498, z = 9018}, {x = 6582, z = 9062}, {x = 6902, z = 9510}, {x = 5514, z = 9530}, {x = 6122, z = 9590} },				
		["Battlefield"]				= { {x = 5489, z = 489}, {x = 921, z = 570}, {x = 5648, z = 496}, {x = 798, z = 606}, {x = 7352, z = 688}, {x = 7488, z = 804}, {x = 2475, z = 948}, {x = 7353, z = 866}, {x = 2313, z = 925}, {x = 5196, z = 1382}, {x = 5312, z = 1392}, {x = 6692, z = 2007}, {x = 6552, z = 1992}, {x = 7849, z = 2130}, {x = 7979, z = 2100}, {x = 1678, z = 2142}, {x = 1809, z = 2257}, {x = 5012, z = 2352}, {x = 1675, z = 2320}, {x = 4857, z = 2338}, {x = 7072, z = 2800}, {x = 7192, z = 2936}, {x = 6067, z = 2976}, {x = 7066, z = 2973}, {x = 6212, z = 3089}, {x = 3345, z = 3240}, {x = 6073, z = 3154}, {x = 3505, z = 3265}, {x = 7922, z = 3636}, {x = 8042, z = 3582}, {x = 4144, z = 3608}, {x = 4728, z = 3865}, {x = 4184, z = 4047}, {x = 4003, z = 4080}, {x = 3464, z = 4326}, {x = 251, z = 4562}, {x = 4048, z = 4584}, {x = 136, z = 4584}, {x = 360, z = 4600}, {x = 4839, z = 4949}, {x = 4681, z = 4925}, {x = 2083, z = 5124}, {x = 1944, z = 5108}, {x = 1099, z = 5291}, {x = 941, z = 5279}, {x = 3168, z = 5839}, {x = 3328, z = 5852}, {x = 6498, z = 5962}, {x = 6345, z = 5954}, {x = 384, z = 6061}, {x = 224, z = 6072}, {x = 1461, z = 6095}, {x = 1602, z = 6205}, {x = 1464, z = 6272}, {x = 3013, z = 6818}, {x = 2884, z = 6771}, {x = 5716, z = 7243}, {x = 5878, z = 7266}, {x = 809, z = 7415}, {x = 664, z = 7400}, {x = 7267, z = 7625}, {x = 7389, z = 7570}, {x = 2689, z = 7700}, {x = 2537, z = 7698} },		
		["Battlefield_quad"] 		= { {x = 592, z = 181}, {x = 13743, z = 181}, {x = 2401, z = 190}, {x = 11934, z = 190}, {x = 4678, z = 306}, {x = 9657, z = 306}, {x = 3228, z = 354}, {x = 11108, z = 354}, {x = 1510, z = 413}, {x = 6801, z = 409}, {x = 7534, z = 409}, {x = 12825, z = 413}, {x = 2507, z = 425}, {x = 11828, z = 425}, {x = 2336, z = 668}, {x = 12000, z = 668}, {x = 3694, z = 881}, {x = 10641, z = 881}, {x = 1822, z = 1061}, {x = 12513, z = 1061}, {x = 3033, z = 1076}, {x = 11302, z = 1076}, {x = 6240, z = 1121}, {x = 8095, z = 1121}, {x = 571, z = 1238}, {x = 13764, z = 1238}, {x = 7168, z = 1408}, {x = 2214, z = 1507}, {x = 12121, z = 1507}, {x = 4949, z = 1664}, {x = 9386, z = 1664}, {x = 7168, z = 1715}, {x = 2458, z = 1800}, {x = 11877, z = 1800}, {x = 1134, z = 1827}, {x = 13201, z = 1827}, {x = 672, z = 1832}, {x = 13664, z = 1832}, {x = 116, z = 1878}, {x = 14220, z = 1878}, {x = 2206, z = 1984}, {x = 12129, z = 1984}, {x = 2726, z = 2026}, {x = 11610, z = 2026}, {x = 5835, z = 2083}, {x = 8500, z = 2083}, {x = 3492, z = 2304}, {x = 10844, z = 2304}, {x = 685, z = 2340}, {x = 13650, z = 2340}, {x = 1806, z = 2547}, {x = 12529, z = 2547}, {x = 776, z = 2605}, {x = 13560, z = 2605}, {x = 1190, z = 2877}, {x = 13145, z = 2877}, {x = 6932, z = 2914}, {x = 7403, z = 2914}, {x = 345, z = 3032}, {x = 13990, z = 3032}, {x = 5998, z = 3081}, {x = 8337, z = 3081}, {x = 1120, z = 3112}, {x = 13216, z = 3112}, {x = 4656, z = 3320}, {x = 9680, z = 3320}, {x = 3304, z = 3336}, {x = 11032, z = 3336}, {x = 275, z = 3366}, {x = 14060, z = 3366}, {x = 6892, z = 3801}, {x = 7443, z = 3801}, {x = 2512, z = 3848}, {x = 3907, z = 3846}, {x = 10428, z = 3846}, {x = 11824, z = 3848}, {x = 6048, z = 4056}, {x = 8288, z = 4056}, {x = 1169, z = 4086}, {x = 13166, z = 4086}, {x = 6822, z = 4136}, {x = 7513, z = 4136}, {x = 235, z = 4253}, {x = 14100, z = 4253}, {x = 5977, z = 4290}, {x = 8358, z = 4290}, {x = 6392, z = 4562}, {x = 7944, z = 4562}, {x = 5361, z = 4620}, {x = 8974, z = 4620}, {x = 6482, z = 4827}, {x = 7853, z = 4827}, {x = 3676, z = 4864}, {x = 10660, z = 4864}, {x = 1332, z = 5084}, {x = 13003, z = 5084}, {x = 4442, z = 5142}, {x = 9894, z = 5142}, {x = 4961, z = 5183}, {x = 9374, z = 5183}, {x = 7052, z = 5290}, {x = 7284, z = 5290}, {x = 6033, z = 5340}, {x = 6496, z = 5336}, {x = 7840, z = 5336}, {x = 8302, z = 5340}, {x = 4792, z = 5373}, {x = 9544, z = 5373}, {x = 48, z = 5452}, {x = 14288, z = 5452}, {x = 2218, z = 5503}, {x = 12117, z = 5503}, {x = 4953, z = 5660}, {x = 9382, z = 5660}, {x = 48, z = 5760}, {x = 14288, z = 5760}, {x = 6596, z = 5929}, {x = 7739, z = 5929}, {x = 927, z = 6046}, {x = 13408, z = 6046}, {x = 4134, z = 6091}, {x = 5345, z = 6106}, {x = 8990, z = 6106}, {x = 10201, z = 6091}, {x = 3473, z = 6286}, {x = 10862, z = 6286}, {x = 4832, z = 6500}, {x = 9504, z = 6500}, {x = 366, z = 6758}, {x = 4660, z = 6742}, {x = 5657, z = 6754}, {x = 8678, z = 6754}, {x = 9675, z = 6742}, {x = 13969, z = 6758}, {x = 3940, z = 6814}, {x = 10396, z = 6814}, {x = 2489, z = 6861}, {x = 11846, z = 6861}, {x = 4766, z = 6977}, {x = 6575, z = 6986}, {x = 7760, z = 6986}, {x = 9569, z = 6977}, {x = 6575, z = 7349}, {x = 7760, z = 7349}, {x = 4766, z = 7358}, {x = 9569, z = 7358}, {x = 2489, z = 7474}, {x = 11846, z = 7474}, {x = 3940, z = 7522}, {x = 10396, z = 7522}, {x = 366, z = 7577}, {x = 5657, z = 7581}, {x = 8678, z = 7581}, {x = 13969, z = 7577}, {x = 4660, z = 7593}, {x = 9675, z = 7593}, {x = 4832, z = 7836}, {x = 9504, z = 7836}, {x = 3473, z = 8049}, {x = 10862, z = 8049}, {x = 5345, z = 8229}, {x = 8990, z = 8229}, {x = 4134, z = 8244}, {x = 10201, z = 8244}, {x = 927, z = 8289}, {x = 13408, z = 8289}, {x = 6596, z = 8406}, {x = 7739, z = 8406}, {x = 48, z = 8576}, {x = 14288, z = 8576}, {x = 4953, z = 8675}, {x = 9382, z = 8675}, {x = 2218, z = 8832}, {x = 12117, z = 8832}, {x = 48, z = 8883}, {x = 14288, z = 8883}, {x = 4792, z = 8962}, {x = 9544, z = 8962}, {x = 6033, z = 8995}, {x = 8302, z = 8995}, {x = 6496, z = 9000}, {x = 7840, z = 9000}, {x = 7052, z = 9046}, {x = 7284, z = 9046}, {x = 4961, z = 9152}, {x = 9374, z = 9152}, {x = 4442, z = 9194}, {x = 9894, z = 9194}, {x = 1332, z = 9251}, {x = 13003, z = 9251}, {x = 3676, z = 9472}, {x = 10660, z = 9472}, {x = 6482, z = 9508}, {x = 7853, z = 9508}, {x = 5361, z = 9715}, {x = 8974, z = 9715}, {x = 6392, z = 9773}, {x = 7944, z = 9773}, {x = 5977, z = 10045}, {x = 8358, z = 10045}, {x = 235, z = 10082}, {x = 14100, z = 10082}, {x = 6822, z = 10200}, {x = 7513, z = 10200}, {x = 1169, z = 10249}, {x = 13166, z = 10249}, {x = 6048, z = 10280}, {x = 8288, z = 10280}, {x = 2512, z = 10488}, {x = 3907, z = 10489}, {x = 10428, z = 10489}, {x = 11824, z = 10488}, {x = 6892, z = 10534}, {x = 7443, z = 10534}, {x = 275, z = 10969}, {x = 14060, z = 10969}, {x = 3304, z = 11000}, {x = 4656, z = 11016}, {x = 9680, z = 11016}, {x = 11032, z = 11000}, {x = 1120, z = 11224}, {x = 13216, z = 11224}, {x = 5998, z = 11254}, {x = 8337, z = 11254}, {x = 345, z = 11304}, {x = 13990, z = 11304}, {x = 6932, z = 11421}, {x = 7403, z = 11421}, {x = 1190, z = 11458}, {x = 13145, z = 11458}, {x = 776, z = 11730}, {x = 13560, z = 11730}, {x = 1806, z = 11788}, {x = 12529, z = 11788}, {x = 685, z = 11995}, {x = 13650, z = 11995}, {x = 3492, z = 12032}, {x = 10844, z = 12032}, {x = 5835, z = 12252}, {x = 8500, z = 12252}, {x = 2726, z = 12310}, {x = 11610, z = 12310}, {x = 2206, z = 12351}, {x = 12129, z = 12351}, {x = 116, z = 12458}, {x = 14220, z = 12458}, {x = 672, z = 12504}, {x = 1134, z = 12508}, {x = 13201, z = 12508}, {x = 13664, z = 12504}, {x = 2458, z = 12536}, {x = 11877, z = 12536}, {x = 7168, z = 12620}, {x = 4949, z = 12671}, {x = 9386, z = 12671}, {x = 2214, z = 12828}, {x = 12121, z = 12828}, {x = 7168, z = 12928}, {x = 571, z = 13097}, {x = 13764, z = 13097}, {x = 6240, z = 13214}, {x = 8095, z = 13214}, {x = 1822, z = 13274}, {x = 3033, z = 13259}, {x = 11302, z = 13259}, {x = 12513, z = 13274}, {x = 3694, z = 13454}, {x = 10641, z = 13454}, {x = 2336, z = 13668}, {x = 12000, z = 13668}, {x = 1510, z = 13922}, {x = 2507, z = 13910}, {x = 6801, z = 13926}, {x = 7534, z = 13926}, {x = 11828, z = 13910}, {x = 12825, z = 13922}, {x = 3228, z = 13982}, {x = 11108, z = 13982}, {x = 4678, z = 14029}, {x = 9657, z = 14029}, {x = 592, z = 14154}, {x = 2401, z = 14145}, {x = 11934, z = 14145}, {x = 13743, z = 14154} },		
		["Big Orbital Station One"] = { {x = 7393, z = 2856}, {x = 9089, z = 2856}, {x = 7393, z = 3320}, {x = 7801, z = 3329}, {x = 8688, z = 3328}, {x = 9089, z = 3320}, {x = 7394, z = 3821}, {x = 9088, z = 3822}, {x = 6398, z = 6536}, {x = 7227, z = 6546}, {x = 9209, z = 6534}, {x = 10040, z = 6544}, {x = 6398, z = 7000}, {x = 6801, z = 7000}, {x = 7227, z = 7010}, {x = 9210, z = 7000}, {x = 9609, z = 7001}, {x = 10040, z = 7008}, {x = 3042, z = 7138}, {x = 3542, z = 7138}, {x = 4006, z = 7138}, {x = 12274, z = 7138}, {x = 12770, z = 7138}, {x = 13234, z = 7138}, {x = 6398, z = 7496}, {x = 7228, z = 7496}, {x = 9209, z = 7497}, {x = 10040, z = 7498}, {x = 3536, z = 7540}, {x = 12766, z = 7539}, {x = 3535, z = 8798}, {x = 6376, z = 8812}, {x = 9208, z = 8812}, {x = 7206, z = 8825}, {x = 10038, z = 8825}, {x = 12766, z = 8824}, {x = 3066, z = 9202}, {x = 3530, z = 9202}, {x = 4029, z = 9202}, {x = 12296, z = 9226}, {x = 12760, z = 9226}, {x = 13259, z = 9225}, {x = 6376, z = 9276}, {x = 6776, z = 9280}, {x = 9208, z = 9276}, {x = 9608, z = 9280}, {x = 7206, z = 9289}, {x = 10038, z = 9289}, {x = 6376, z = 9776}, {x = 7208, z = 9776}, {x = 9208, z = 9776}, {x = 10040, z = 9776}, {x = 7352, z = 12332}, {x = 9089, z = 12332}, {x = 7352, z = 12796}, {x = 7752, z = 12800}, {x = 8688, z = 12800}, {x = 9090, z = 12797}, {x = 7352, z = 13296}, {x = 9090, z = 13293} },		
		["Crater"] 					= { {x = 180, z = 171}, {x = 14155, z = 171}, {x = 3261, z = 214}, {x = 11074, z = 214}, {x = 295, z = 313}, {x = 14044, z = 314}, {x = 3460, z = 328}, {x = 10875, z = 328}, {x = 200, z = 344}, {x = 5250, z = 496}, {x = 9098, z = 499}, {x = 3318, z = 445}, {x = 11017, z = 445}, {x = 5360, z = 456}, {x = 8974, z = 468}, {x = 968, z = 1346}, {x = 13371, z = 1347}, {x = 13272, z = 1336}, {x = 3622, z = 1812}, {x = 10713, z = 1812}, {x = 3461, z = 1909}, {x = 10874, z = 1909}, {x = 3640, z = 2008}, {x = 10696, z = 2008}, {x = 242, z = 2601}, {x = 14105, z = 2601}, {x = 13997, z = 2605}, {x = 11254, z = 3748}, {x = 11133, z = 3741}, {x = 2811, z = 4214}, {x = 2990, z = 4369}, {x = 2781, z = 4422}, {x = 242, z = 5590}, {x = 14093, z = 5590}, {x = 3640, z = 6184}, {x = 10696, z = 6184}, {x = 3461, z = 6282}, {x = 10874, z = 6282}, {x = 3622, z = 6379}, {x = 10713, z = 6379}, {x = 968, z = 6845}, {x = 13368, z = 6845}, {x = 5257, z = 7697}, {x = 9082, z = 7697}, {x = 8968, z = 7704}, {x = 3318, z = 7746}, {x = 11017, z = 7746}, {x = 288, z = 7881}, {x = 14067, z = 7898}, {x = 3460, z = 7864}, {x = 10875, z = 7864}, {x = 13968, z = 7896}, {x = 3261, z = 7977}, {x = 11074, z = 7977}, {x = 178, z = 8022}, {x = 14164, z = 8030} },		
		["Delta Siege dry"] 		= { {x = 7070, z = 116}, {x = 3095, z = 142}, {x = 7286, z = 201}, {x = 2878, z = 231}, {x = 7057, z = 351}, {x = 3105, z = 379}, {x = 598, z = 482}, {x = 9641, z = 482}, {x = 373, z = 632}, {x = 5044, z = 635}, {x = 9866, z = 632}, {x = 588, z = 718}, {x = 9651, z = 718}, {x = 5817, z = 1177}, {x = 3383, z = 1620}, {x = 8133, z = 1609}, {x = 4904, z = 1637}, {x = 7907, z = 1641}, {x = 6554, z = 1757}, {x = 5122, z = 1769}, {x = 8037, z = 1832}, {x = 4912, z = 1876}, {x = 2381, z = 1885}, {x = 2608, z = 1918}, {x = 2480, z = 2105}, {x = 458, z = 2307}, {x = 8518, z = 2297}, {x = 9878, z = 2406}, {x = 588, z = 2494}, {x = 362, z = 2529}, {x = 9752, z = 2592}, {x = 5177, z = 2628}, {x = 9977, z = 2628}, {x = 4601, z = 2681}, {x = 1676, z = 2691}, {x = 2811, z = 2843}, {x = 7428, z = 2843}, {x = 2592, z = 2980}, {x = 7647, z = 2980}, {x = 2799, z = 3085}, {x = 7440, z = 3085}, {x = 5664, z = 3656}, {x = 10035, z = 3896}, {x = 4576, z = 3928}, {x = 9812, z = 4032}, {x = 3888, z = 4133}, {x = 10024, z = 4138}, {x = 2697, z = 4153}, {x = 7542, z = 4153}, {x = 204, z = 4248}, {x = 2566, z = 4340}, {x = 7673, z = 4340}, {x = 429, z = 4382}, {x = 2793, z = 4374}, {x = 7446, z = 4374}, {x = 6073, z = 4406}, {x = 216, z = 4488}, {x = 8737, z = 4583}, {x = 1757, z = 4662}, {x = 8947, z = 4689}, {x = 1552, z = 4763}, {x = 4263, z = 4763}, {x = 6808, z = 4763}, {x = 8728, z = 4824}, {x = 1768, z = 4901} },		
		["Delta Siege dry duo"] 	= { {x = 7070, z = 116}, {x = 3095, z = 142}, {x = 7286, z = 201}, {x = 2878, z = 231}, {x = 7057, z = 351}, {x = 3105, z = 379}, {x = 598, z = 482}, {x = 9641, z = 482}, {x = 373, z = 632}, {x = 5044, z = 635}, {x = 9866, z = 632}, {x = 588, z = 718}, {x = 9651, z = 718}, {x = 5817, z = 1177}, {x = 3383, z = 1620}, {x = 8133, z = 1609}, {x = 4904, z = 1637}, {x = 7907, z = 1641}, {x = 6554, z = 1757}, {x = 5122, z = 1769}, {x = 8037, z = 1832}, {x = 4912, z = 1876}, {x = 2381, z = 1885}, {x = 2608, z = 1918}, {x = 2480, z = 2105}, {x = 458, z = 2307}, {x = 8518, z = 2297}, {x = 9878, z = 2406}, {x = 588, z = 2494}, {x = 362, z = 2529}, {x = 9752, z = 2592}, {x = 5177, z = 2628}, {x = 9977, z = 2628}, {x = 4601, z = 2681}, {x = 1676, z = 2691}, {x = 2811, z = 2843}, {x = 7428, z = 2843}, {x = 2592, z = 2980}, {x = 7647, z = 2980}, {x = 2799, z = 3085}, {x = 7440, z = 3085}, {x = 5664, z = 3656}, {x = 10035, z = 3896}, {x = 4576, z = 3928}, {x = 9812, z = 4032}, {x = 3888, z = 4133}, {x = 10024, z = 4138}, {x = 2697, z = 4153}, {x = 7542, z = 4153}, {x = 204, z = 4248}, {x = 2566, z = 4340}, {x = 7673, z = 4340}, {x = 429, z = 4382}, {x = 2793, z = 4374}, {x = 7446, z = 4374}, {x = 6073, z = 4406}, {x = 216, z = 4488}, {x = 8737, z = 4583}, {x = 1757, z = 4662}, {x = 8947, z = 4689}, {x = 1552, z = 4763}, {x = 4263, z = 4763}, {x = 6808, z = 4763}, {x = 8728, z = 4824}, {x = 1768, z = 4901}, {x = 1768, z = 5338}, {x = 8728, z = 5416}, {x = 1552, z = 5476}, {x = 3431, z = 5476}, {x = 5704, z = 5476}, {x = 8947, z = 5550}, {x = 1757, z = 5578}, {x = 8737, z = 5656}, {x = 216, z = 5752}, {x = 4166, z = 5833}, {x = 429, z = 5857}, {x = 2793, z = 5865}, {x = 7446, z = 5865}, {x = 2566, z = 5899}, {x = 7673, z = 5899}, {x = 204, z = 5992}, {x = 2697, z = 6086}, {x = 7542, z = 6086}, {x = 6352, z = 6106}, {x = 10024, z = 6101}, {x = 9812, z = 6207}, {x = 5664, z = 6312}, {x = 10035, z = 6344}, {x = 4576, z = 6584}, {x = 2799, z = 7154}, {x = 7440, z = 7154}, {x = 2592, z = 7259}, {x = 7647, z = 7259}, {x = 2811, z = 7396}, {x = 7428, z = 7396}, {x = 1676, z = 7548}, {x = 4601, z = 7558}, {x = 5177, z = 7611}, {x = 9977, z = 7611}, {x = 9752, z = 7648}, {x = 362, z = 7710}, {x = 588, z = 7745}, {x = 9878, z = 7833}, {x = 458, z = 7932}, {x = 8518, z = 7942}, {x = 2480, z = 8134}, {x = 2608, z = 8321}, {x = 2381, z = 8354}, {x = 4912, z = 8363}, {x = 8037, z = 8408}, {x = 5122, z = 8470}, {x = 6554, z = 8482}, {x = 7907, z = 8598}, {x = 4904, z = 8602}, {x = 3383, z = 8619}, {x = 8133, z = 8630}, {x = 5817, z = 9062}, {x = 588, z = 9521}, {x = 9651, z = 9521}, {x = 373, z = 9608}, {x = 5044, z = 9604}, {x = 9866, z = 9608}, {x = 598, z = 9757}, {x = 9641, z = 9757}, {x = 3105, z = 9860}, {x = 7057, z = 9888}, {x = 2878, z = 10008}, {x = 7286, z = 10038}, {x = 3095, z = 10097}, {x = 7070, z = 10123} },
		["Desert of Sninon"] 		= { {x = 3733, z = 136}, {x = 6514, z = 212}, {x = 9587, z = 350}, {x = 1843, z = 484}, {x = 9865, z = 518}, {x = 9366, z = 600}, {x = 2088, z = 608}, {x = 3748, z = 647}, {x = 5384, z = 701}, {x = 1833, z = 771}, {x = 7936, z = 1031}, {x = 8699, z = 1418}, {x = 5272, z = 1435}, {x = 381, z = 1731}, {x = 650, z = 1816}, {x = 1979, z = 1832}, {x = 10833, z = 1822}, {x = 3928, z = 1876}, {x = 2518, z = 1912}, {x = 10571, z = 1952}, {x = 444, z = 2051}, {x = 9344, z = 2096}, {x = 10941, z = 2179}, {x = 6561, z = 2581}, {x = 5646, z = 3213}, {x = 8185, z = 3230}, {x = 1472, z = 3300}, {x = 9811, z = 3298}, {x = 1218, z = 3391}, {x = 10072, z = 3393}, {x = 4200, z = 3483}, {x = 7097, z = 3478}, {x = 9740, z = 3657}, {x = 1542, z = 3665}, {x = 2675, z = 3880}, {x = 8459, z = 4320}, {x = 10906, z = 4506}, {x = 11219, z = 4514}, {x = 5584, z = 4564}, {x = 11143, z = 4810}, {x = 2820, z = 4921}, {x = 8609, z = 5346}, {x = 4268, z = 5556}, {x = 7027, z = 5560}, {x = 1542, z = 5566}, {x = 9740, z = 5574}, {x = 1218, z = 5840}, {x = 10070, z = 5843}, {x = 1472, z = 5931}, {x = 9814, z = 5937}, {x = 3098, z = 6011}, {x = 5595, z = 6096}, {x = 6720, z = 6598}, {x = 4693, z = 6629}, {x = 346, z = 7050}, {x = 1923, z = 7143}, {x = 10830, z = 7179}, {x = 712, z = 7280}, {x = 8767, z = 7314}, {x = 7358, z = 7355}, {x = 9292, z = 7401}, {x = 457, z = 7417}, {x = 10632, z = 7415}, {x = 10900, z = 7488}, {x = 6004, z = 7804}, {x = 2586, z = 7815}, {x = 3346, z = 8190}, {x = 9448, z = 8462}, {x = 5895, z = 8518}, {x = 7533, z = 8586}, {x = 1912, z = 8634}, {x = 9190, z = 8625}, {x = 1416, z = 8712}, {x = 9448, z = 8744}, {x = 1704, z = 8891}, {x = 4760, z = 9026}, {x = 7562, z = 9096} },		
		["Dworld_V1"] 				= { {x = 5912, z = 2056}, {x = 5696, z = 2224}, {x = 4808, z = 2272}, {x = 5976, z = 2328}, {x = 4848, z = 2456}, {x = 3760, z = 2544}, {x = 3544, z = 2704}, {x = 3792, z = 2744}, {x = 7288, z = 2832}, {x = 9528, z = 2920}, {x = 10688, z = 3008}, {x = 7056, z = 3120}, {x = 9584, z = 3144}, {x = 10816, z = 3216}, {x = 10560, z = 3280}, {x = 5040, z = 3288}, {x = 8376, z = 3368}, {x = 2888, z = 3448}, {x = 3088, z = 3480}, {x = 8600, z = 3552}, {x = 8312, z = 3656}, {x = 11608, z = 3744}, {x = 12496, z = 3880}, {x = 11624, z = 3960}, {x = 3408, z = 4312}, {x = 5896, z = 4312}, {x = 3224, z = 4528}, {x = 1360, z = 4568}, {x = 6072, z = 4576}, {x = 10624, z = 4584}, {x = 3520, z = 4632}, {x = 7944, z = 4736}, {x = 6304, z = 4744}, {x = 5304, z = 4832}, {x = 9384, z = 4832}, {x = 10776, z = 4848}, {x = 10464, z = 4872}, {x = 9208, z = 4992}, {x = 4424, z = 5248}, {x = 4440, z = 5416}, {x = 8528, z = 5880}, {x = 10264, z = 6064}, {x = 8688, z = 6128}, {x = 3376, z = 6136}, {x = 8376, z = 6160}, {x = 6944, z = 6288}, {x = 11344, z = 6352}, {x = 3488, z = 6376}, {x = 3168, z = 6400}, {x = 7080, z = 6504}, {x = 8992, z = 6912}, {x = 4704, z = 6928}, {x = 4528, z = 7088}, {x = 8896, z = 7120}, {x = 5864, z = 7400}, {x = 6048, z = 7664}, {x = 5768, z = 7720}, {x = 9144, z = 7776}, {x = 10352, z = 7944}, {x = 9336, z = 8000}, {x = 9040, z = 8056}, {x = 7688, z = 8096}, {x = 11192, z = 8120}, {x = 10304, z = 8200}, {x = 11488, z = 8200}, {x = 7872, z = 8280}, {x = 6520, z = 8440}, {x = 11256, z = 8448}, {x = 7888, z = 8496}, {x = 6328, z = 8616}, {x = 6568, z = 9376}, {x = 11120, z = 9464}, {x = 6712, z = 9648}, {x = 6424, z = 9656}, {x = 11440, z = 9672}, {x = 9904, z = 9816}, {x = 7656, z = 9944}, {x = 4220, z = 10048}, {x = 9728, z = 10088}, {x = 10032, z = 10112}, {x = 8536, z = 10256}, {x = 5520, z = 10272}, {x = 5680, z = 10456}, {x = 8672, z = 10504}, {x = 2640, z = 10536}, {x = 2752, z = 10760}, {x = 2448, z = 10808}, {x = 6376, z = 11040}, {x = 3792, z = 11256}, {x = 6424, z = 11256}, {x = 4912, z = 11312}, {x = 7560, z = 11480}, {x = 4712, z = 11504}, {x = 5056, z = 11512}, {x = 7392, z = 11736}, {x = 7720, z = 11776}, {x = 5976, z = 13128} },
		["Eridlon Island"] 			= { {x = 10566, z = 1226}, {x = 10783, z = 1364}, {x = 5864, z = 1408}, {x = 10578, z = 1468}, {x = 5652, z = 1512}, {x = 5873, z = 1645}, {x = 9751, z = 1707}, {x = 7219, z = 1904}, {x = 6722, z = 2059}, {x = 7144, z = 2117}, {x = 6504, z = 2142}, {x = 3796, z = 2192}, {x = 4015, z = 2328}, {x = 10613, z = 2338}, {x = 3807, z = 2435}, {x = 10818, z = 2442}, {x = 10600, z = 2579}, {x = 6240, z = 2725}, {x = 6250, z = 2962}, {x = 5562, z = 3221}, {x = 5773, z = 3326}, {x = 5554, z = 3462}, {x = 9139, z = 3521}, {x = 9356, z = 3608}, {x = 11109, z = 3666}, {x = 8721, z = 3678}, {x = 9132, z = 3760}, {x = 8495, z = 3825}, {x = 11221, z = 3874}, {x = 8713, z = 3912}, {x = 10988, z = 3911}, {x = 4722, z = 3958}, {x = 3304, z = 3994}, {x = 4505, z = 4043}, {x = 3090, z = 4101}, {x = 8080, z = 4099}, {x = 4733, z = 4192}, {x = 3316, z = 4233}, {x = 7609, z = 4250}, {x = 7840, z = 4264}, {x = 8091, z = 4338}, {x = 4842, z = 4364}, {x = 11111, z = 4396}, {x = 11364, z = 4450}, {x = 5063, z = 4498}, {x = 4856, z = 4602}, {x = 11205, z = 4619}, {x = 10083, z = 4904}, {x = 7923, z = 4952}, {x = 9874, z = 5007}, {x = 7714, z = 5055}, {x = 7936, z = 5192}, {x = 3958, z = 6161}, {x = 3832, z = 6348}, {x = 4051, z = 6453}, {x = 9624, z = 6378}, {x = 4275, z = 6542}, {x = 9493, z = 6568}, {x = 9721, z = 6598}, {x = 4146, z = 6728}, {x = 6680, z = 7228}, {x = 6450, z = 7266}, {x = 10906, z = 7328}, {x = 6614, z = 7446}, {x = 11130, z = 7480}, {x = 10915, z = 7566}, {x = 5872, z = 7726}, {x = 6104, z = 7760}, {x = 9217, z = 8626}, {x = 9120, z = 8720}, {x = 9764, z = 8731}, {x = 9983, z = 8870}, {x = 9775, z = 8979}, {x = 3211, z = 9657}, {x = 3561, z = 9740}, {x = 3535, z = 9950}, {x = 4929, z = 10096}, {x = 5158, z = 10246}, {x = 4941, z = 10333}, {x = 8094, z = 10425}, {x = 9632, z = 10486}, {x = 8301, z = 10521}, {x = 2606, z = 10592}, {x = 9409, z = 10619}, {x = 9622, z = 10724} },
		["Folsom Dam"] 				= { {x = 76, z = 112}, {x = 8115, z = 112}, {x = 1438, z = 134}, {x = 298, z = 245}, {x = 7893, z = 245}, {x = 88, z = 352}, {x = 8104, z = 352}, {x = 6577, z = 361}, {x = 2947, z = 457}, {x = 5244, z = 457}, {x = 2817, z = 649}, {x = 5374, z = 649}, {x = 3042, z = 680}, {x = 5149, z = 680}, {x = 321, z = 1262}, {x = 4025, z = 1264}, {x = 7870, z = 1262}, {x = 101, z = 1350}, {x = 8090, z = 1350}, {x = 327, z = 1500}, {x = 7864, z = 1500}, {x = 1551, z = 1582}, {x = 6792, z = 1632}, {x = 3280, z = 1864}, {x = 4912, z = 1864}, {x = 3502, z = 1999}, {x = 4689, z = 1999}, {x = 2427, z = 2059}, {x = 3289, z = 2103}, {x = 4902, z = 2103}, {x = 5990, z = 2218}, {x = 7248, z = 2594}, {x = 897, z = 2601}, {x = 1031, z = 2788}, {x = 7122, z = 2781}, {x = 7344, z = 2816}, {x = 800, z = 2821}, {x = 1604, z = 3085}, {x = 2840, z = 3096}, {x = 4048, z = 3096}, {x = 5208, z = 3096}, {x = 6587, z = 3085}, {x = 491, z = 3627}, {x = 7780, z = 3707}, {x = 273, z = 3763}, {x = 7942, z = 3833}, {x = 478, z = 3866}, {x = 7684, z = 3915}, {x = 2200, z = 3944}, {x = 5992, z = 3944}, {x = 3337, z = 4054}, {x = 4854, z = 4054}, {x = 3549, z = 4159}, {x = 4642, z = 4159}, {x = 3328, z = 4296}, {x = 4864, z = 4296}, {x = 1279, z = 4497}, {x = 6912, z = 4497}, {x = 411, z = 4619}, {x = 7780, z = 4619}, {x = 192, z = 4756}, {x = 7999, z = 4756}, {x = 7776, z = 4842}, {x = 398, z = 4858}, {x = 4025, z = 4880}, {x = 3104, z = 5472}, {x = 5088, z = 5472}, {x = 2876, z = 5504}, {x = 5315, z = 5504}, {x = 3005, z = 5689}, {x = 5186, z = 5689}, {x = 100, z = 5803}, {x = 8091, z = 5803}, {x = 320, z = 5888}, {x = 7872, z = 5888}, {x = 1438, z = 5977}, {x = 6753, z = 5977}, {x = 93, z = 6037}, {x = 8098, z = 6037} },		
		["Lava Island"] 			= { {x = 2114, z = 1336}, {x = 8125, z = 1336}, {x = 2249, z = 1521}, {x = 7990, z = 1521}, {x = 2016, z = 1553}, {x = 8223, z = 1553}, {x = 1287, z = 1715}, {x = 8952, z = 1715}, {x = 1062, z = 1868}, {x = 9177, z = 1868}, {x = 1281, z = 1953}, {x = 8958, z = 1953}, {x = 2397, z = 2426}, {x = 7842, z = 2426}, {x = 2177, z = 2563}, {x = 8062, z = 2563}, {x = 2386, z = 2671}, {x = 7853, z = 2671}, {x = 5176, z = 3928}, {x = 5784, z = 4592}, {x = 4640, z = 4677}, {x = 6366, z = 5142}, {x = 3837, z = 5165}, {x = 5293, z = 5181}, {x = 4465, z = 5542}, {x = 5750, z = 5957}, {x = 5072, z = 6283}, {x = 2386, z = 7568}, {x = 7853, z = 7568}, {x = 2177, z = 7676}, {x = 8062, z = 7676}, {x = 2397, z = 7813}, {x = 7842, z = 7813}, {x = 1281, z = 8286}, {x = 8958, z = 8286}, {x = 1062, z = 8371}, {x = 9177, z = 8371}, {x = 1287, z = 8524}, {x = 8952, z = 8524}, {x = 2016, z = 8686}, {x = 8223, z = 8686}, {x = 2249, z = 8718}, {x = 7990, z = 8718}, {x = 2114, z = 8904}, {x = 8125, z = 8904} },		
		["Nuclear Winter"] 			= { {x = 338, z = 159}, {x = 3267, z = 152}, {x = 6972, z = 152}, {x = 9901, z = 159}, {x = 2148, z = 214}, {x = 8091, z = 214}, {x = 121, z = 246}, {x = 10118, z = 246}, {x = 2369, z = 349}, {x = 7870, z = 349}, {x = 5165, z = 364}, {x = 348, z = 396}, {x = 9891, z = 396}, {x = 2160, z = 452}, {x = 8080, z = 452}, {x = 4955, z = 465}, {x = 5177, z = 601}, {x = 3531, z = 827}, {x = 6708, z = 827}, {x = 6259, z = 1409}, {x = 3980, z = 1457}, {x = 200, z = 1888}, {x = 10040, z = 1888}, {x = 412, z = 1991}, {x = 9827, z = 1991}, {x = 190, z = 2127}, {x = 10049, z = 2127}, {x = 2249, z = 2134}, {x = 7990, z = 2134}, {x = 4348, z = 2214}, {x = 2461, z = 2239}, {x = 7778, z = 2239}, {x = 4140, z = 2317}, {x = 4358, z = 2454}, {x = 5970, z = 2509}, {x = 6178, z = 2614}, {x = 5960, z = 2750}, {x = 2920, z = 3137}, {x = 7319, z = 3137}, {x = 2793, z = 3323}, {x = 7446, z = 3323}, {x = 6397, z = 3858}, {x = 6169, z = 3892}, {x = 3844, z = 4060}, {x = 6299, z = 4083}, {x = 4072, z = 4096}, {x = 4864, z = 4188}, {x = 5375, z = 4188}, {x = 3941, z = 4281}, {x = 413, z = 4764}, {x = 9826, z = 4764}, {x = 184, z = 4912}, {x = 10056, z = 4912}, {x = 1982, z = 4919}, {x = 8257, z = 4919}, {x = 402, z = 4992}, {x = 4368, z = 4984}, {x = 5872, z = 4984}, {x = 9837, z = 4992}, {x = 1775, z = 5022}, {x = 8464, z = 5022}, {x = 4574, z = 5086}, {x = 5665, z = 5086}, {x = 1992, z = 5158}, {x = 8247, z = 5158}, {x = 204, z = 5702}, {x = 10035, z = 5702}, {x = 414, z = 5806}, {x = 9825, z = 5806}, {x = 192, z = 5942}, {x = 10047, z = 5942} },
		["Orbital Station One"] 	= { {x = 9736, z = 1072}, {x = 11228, z = 1144}, {x = 9528, z = 1160}, {x = 9712, z = 1264}, {x = 3699, z = 1432}, {x = 4544, z = 1432}, {x = 3702, z = 1658}, {x = 3896, z = 1664}, {x = 4344, z = 1664}, {x = 4550, z = 1658}, {x = 10252, z = 1780}, {x = 9651, z = 1816}, {x = 11216, z = 1832}, {x = 10845, z = 1944}, {x = 3699, z = 1912}, {x = 4544, z = 1912}, {x = 10120, z = 1980}, {x = 10296, z = 2048}, {x = 10943, z = 2577}, {x = 10209, z = 2577}, {x = 11101, z = 2578}, {x = 9688, z = 2840}, {x = 8923, z = 2988}, {x = 9404, z = 2963}, {x = 10552, z = 3096}, {x = 3200, z = 3272}, {x = 3612, z = 3272}, {x = 4602, z = 3270}, {x = 5018, z = 3274}, {x = 10428, z = 3288}, {x = 10656, z = 3288}, {x = 3200, z = 3496}, {x = 3400, z = 3500}, {x = 4602, z = 3498}, {x = 4808, z = 3500}, {x = 3610, z = 3510}, {x = 5016, z = 3507}, {x = 1526, z = 3574}, {x = 1768, z = 3571}, {x = 2006, z = 3574}, {x = 6136, z = 3571}, {x = 6390, z = 3574}, {x = 6616, z = 3571}, {x = 3200, z = 3752}, {x = 3612, z = 3752}, {x = 4602, z = 3750}, {x = 5018, z = 3750}, {x = 1768, z = 3768}, {x = 6384, z = 3768}, {x = 1768, z = 4403}, {x = 3190, z = 4406}, {x = 3606, z = 4410}, {x = 4604, z = 4408}, {x = 5018, z = 4410}, {x = 6380, z = 4408}, {x = 1530, z = 4602}, {x = 1766, z = 4602}, {x = 2012, z = 4600}, {x = 6152, z = 4616}, {x = 6380, z = 4616}, {x = 6632, z = 4616}, {x = 3192, z = 4636}, {x = 4600, z = 4636}, {x = 13965, z = 4671}, {x = 3384, z = 4643}, {x = 3606, z = 4646}, {x = 4808, z = 4643}, {x = 5018, z = 4646}, {x = 15528, z = 4768}, {x = 3190, z = 4890}, {x = 3603, z = 4888}, {x = 4604, z = 4888}, {x = 5018, z = 4890}, {x = 14520, z = 4968}, {x = 13780, z = 5077}, {x = 14373, z = 5203}, {x = 15147, z = 5201}, {x = 14988, z = 5256}, {x = 15082, z = 5402}, {x = 13563, z = 5902}, {x = 14658, z = 5984}, {x = 3674, z = 6166}, {x = 4547, z = 6168}, {x = 3674, z = 6394}, {x = 3880, z = 6396}, {x = 4344, z = 6400}, {x = 4550, z = 6394}, {x = 14048, z = 6432}, {x = 15408, z = 6472}, {x = 14904, z = 6549}, {x = 13350, z = 6598}, {x = 3674, z = 6646}, {x = 4547, z = 6648}, {x = 15716, z = 6776}, {x = 14288, z = 6728}, {x = 15608, z = 6824}, {x = 13854, z = 6929}, {x = 14004, z = 6894}, {x = 15320, z = 7144}, {x = 15464, z = 7075} },		
		["Port Island Dry"] 		= { {x = 3957, z = 465}, {x = 11520, z = 483}, {x = 432, z = 488}, {x = 6422, z = 592}, {x = 7803, z = 619}, {x = 10212, z = 619}, {x = 2505, z = 763}, {x = 5867, z = 851}, {x = 7296, z = 888}, {x = 9104, z = 888}, {x = 8403, z = 1073}, {x = 10415, z = 1073}, {x = 7810, z = 1082}, {x = 4665, z = 1270}, {x = 11582, z = 1311}, {x = 3590, z = 1363}, {x = 10328, z = 1373}, {x = 5656, z = 1448}, {x = 8602, z = 1680}, {x = 1471, z = 1774}, {x = 6219, z = 1801}, {x = 6888, z = 1864}, {x = 1259, z = 1933}, {x = 2777, z = 1934}, {x = 1625, z = 2130}, {x = 4260, z = 2190}, {x = 11430, z = 2286}, {x = 960, z = 2296}, {x = 5002, z = 2369}, {x = 9810, z = 2426}, {x = 3582, z = 2558}, {x = 8543, z = 2693}, {x = 202, z = 2928}, {x = 1814, z = 2974}, {x = 560, z = 3000}, {x = 3856, z = 3080}, {x = 11019, z = 3083}, {x = 11432, z = 3309}, {x = 2676, z = 3428}, {x = 874, z = 3439}, {x = 9510, z = 3499}, {x = 211, z = 3595}, {x = 10815, z = 3690}, {x = 1574, z = 3965}, {x = 11856, z = 4072}, {x = 5280, z = 4147}, {x = 5489, z = 4140}, {x = 6798, z = 4145}, {x = 7007, z = 4138}, {x = 5494, z = 4341}, {x = 7011, z = 4345}, {x = 5280, z = 4352}, {x = 6798, z = 4353}, {x = 104, z = 4496}, {x = 709, z = 4598}, {x = 10212, z = 4635}, {x = 1584, z = 4782}, {x = 212, z = 4909}, {x = 520, z = 5008}, {x = 2276, z = 5236}, {x = 11984, z = 5240}, {x = 9632, z = 5280}, {x = 4222, z = 5290}, {x = 4429, z = 5289}, {x = 7880, z = 5288}, {x = 8081, z = 5292}, {x = 4233, z = 5500}, {x = 8075, z = 5501}, {x = 4440, z = 5504}, {x = 7870, z = 5505}, {x = 11430, z = 5502}, {x = 2990, z = 5580}, {x = 508, z = 5838}, {x = 10312, z = 5912}, {x = 11217, z = 6099}, {x = 1070, z = 6188}, {x = 1976, z = 6376}, {x = 11780, z = 6449}, {x = 9297, z = 6707}, {x = 857, z = 6785}, {x = 4225, z = 6805}, {x = 8082, z = 6810}, {x = 4429, z = 6809}, {x = 7880, z = 6808}, {x = 2656, z = 7008}, {x = 4230, z = 7020}, {x = 8076, z = 7019}, {x = 4441, z = 7021}, {x = 7869, z = 7021}, {x = 304, z = 7048}, {x = 10011, z = 7051}, {x = 11768, z = 7280}, {x = 12075, z = 7378}, {x = 10703, z = 7505}, {x = 2075, z = 7652}, {x = 11578, z = 7689}, {x = 5280, z = 7784}, {x = 5494, z = 7794}, {x = 6800, z = 7784}, {x = 7009, z = 7793}, {x = 12184, z = 7792}, {x = 5282, z = 7987}, {x = 6800, z = 7989}, {x = 5491, z = 7997}, {x = 7008, z = 7998}, {x = 432, z = 8216}, {x = 10713, z = 8322}, {x = 1472, z = 8597}, {x = 12076, z = 8692}, {x = 2777, z = 8788}, {x = 11413, z = 8848}, {x = 9611, z = 8859}, {x = 856, z = 8978}, {x = 1268, z = 9204}, {x = 8432, z = 9208}, {x = 11728, z = 9288}, {x = 10473, z = 9313}, {x = 12085, z = 9359}, {x = 3744, z = 9594}, {x = 8705, z = 9729}, {x = 2477, z = 9861}, {x = 7285, z = 9918}, {x = 857, z = 10001}, {x = 11328, z = 9992}, {x = 8028, z = 10097}, {x = 10662, z = 10157}, {x = 9510, z = 10353}, {x = 11029, z = 10355}, {x = 5400, z = 10424}, {x = 6736, z = 10488}, {x = 10816, z = 10513}, {x = 3685, z = 10607}, {x = 6187, z = 10747}, {x = 1960, z = 10914}, {x = 8697, z = 10924}, {x = 705, z = 10976}, {x = 7622, z = 11017}, {x = 4477, z = 11205}, {x = 1872, z = 11214}, {x = 3884, z = 11214}, {x = 5974, z = 11346}, {x = 3184, z = 11400}, {x = 4992, z = 11400}, {x = 9782, z = 11524}, {x = 2075, z = 11668}, {x = 4484, z = 11668}, {x = 6536, z = 11693}, {x = 768, z = 11804}, {x = 11856, z = 11800}, {x = 8330, z = 11822} },		
		["Port Island Dry Center"] 	= { {x = 5291, z = 4147}, {x = 5501, z = 4140}, {x = 6811, z = 4147}, {x = 7023, z = 4138}, {x = 5500, z = 4339}, {x = 7026, z = 4342}, {x = 5289, z = 4354}, {x = 6814, z = 4353}, {x = 4236, z = 5294}, {x = 4434, z = 5292}, {x = 7896, z = 5290}, {x = 8100, z = 5294}, {x = 4238, z = 5502}, {x = 4444, z = 5505}, {x = 7886, z = 5505}, {x = 8090, z = 5504}, {x = 4234, z = 6816}, {x = 4435, z = 6816}, {x = 7892, z = 6813}, {x = 8097, z = 6816}, {x = 4237, z = 7024}, {x = 4445, z = 7029}, {x = 7886, z = 7025}, {x = 8090, z = 7027}, {x = 5288, z = 7792}, {x = 6810, z = 7794}, {x = 5500, z = 7804}, {x = 7025, z = 7803}, {x = 5289, z = 7998}, {x = 5501, z = 8003}, {x = 6809, z = 7998}, {x = 7023, z = 8005} },		
		["Port Island Water"] 		= { {x = 3957, z = 465}, {x = 11520, z = 483}, {x = 432, z = 488}, {x = 6422, z = 592}, {x = 7803, z = 619}, {x = 10212, z = 619}, {x = 2505, z = 763}, {x = 5867, z = 851}, {x = 7296, z = 888}, {x = 9104, z = 888}, {x = 8403, z = 1073}, {x = 10415, z = 1073}, {x = 7810, z = 1082}, {x = 4665, z = 1270}, {x = 11582, z = 1311}, {x = 3590, z = 1363}, {x = 10328, z = 1373}, {x = 5656, z = 1448}, {x = 8602, z = 1680}, {x = 1471, z = 1774}, {x = 6219, z = 1801}, {x = 6888, z = 1864}, {x = 1259, z = 1933}, {x = 2777, z = 1934}, {x = 1625, z = 2130}, {x = 4260, z = 2190}, {x = 11430, z = 2286}, {x = 960, z = 2296}, {x = 5002, z = 2369}, {x = 9810, z = 2426}, {x = 3582, z = 2558}, {x = 8543, z = 2693}, {x = 202, z = 2928}, {x = 1814, z = 2974}, {x = 560, z = 3000}, {x = 3856, z = 3080}, {x = 11019, z = 3083}, {x = 11432, z = 3309}, {x = 2676, z = 3428}, {x = 874, z = 3439}, {x = 9510, z = 3499}, {x = 211, z = 3595}, {x = 10815, z = 3690}, {x = 1574, z = 3965}, {x = 11856, z = 4072}, {x = 5280, z = 4147}, {x = 5489, z = 4140}, {x = 6798, z = 4145}, {x = 7007, z = 4138}, {x = 5494, z = 4341}, {x = 7011, z = 4345}, {x = 5280, z = 4352}, {x = 6798, z = 4353}, {x = 104, z = 4496}, {x = 709, z = 4598}, {x = 10212, z = 4635}, {x = 1584, z = 4782}, {x = 212, z = 4909}, {x = 520, z = 5008}, {x = 2276, z = 5236}, {x = 11984, z = 5240}, {x = 9632, z = 5280}, {x = 4222, z = 5290}, {x = 4429, z = 5289}, {x = 7880, z = 5288}, {x = 8081, z = 5292}, {x = 4233, z = 5500}, {x = 8075, z = 5501}, {x = 4440, z = 5504}, {x = 7870, z = 5505}, {x = 11430, z = 5502}, {x = 2990, z = 5580}, {x = 508, z = 5838}, {x = 10312, z = 5912}, {x = 11217, z = 6099}, {x = 1070, z = 6188}, {x = 1976, z = 6376}, {x = 11780, z = 6449}, {x = 9297, z = 6707}, {x = 857, z = 6785}, {x = 4225, z = 6805}, {x = 8082, z = 6810}, {x = 4429, z = 6809}, {x = 7880, z = 6808}, {x = 2656, z = 7008}, {x = 4230, z = 7020}, {x = 8076, z = 7019}, {x = 4441, z = 7021}, {x = 7869, z = 7021}, {x = 304, z = 7048}, {x = 10011, z = 7051}, {x = 11768, z = 7280}, {x = 12075, z = 7378}, {x = 10703, z = 7505}, {x = 2075, z = 7652}, {x = 11578, z = 7689}, {x = 5280, z = 7784}, {x = 5494, z = 7794}, {x = 6800, z = 7784}, {x = 7009, z = 7793}, {x = 12184, z = 7792}, {x = 5282, z = 7987}, {x = 6800, z = 7989}, {x = 5491, z = 7997}, {x = 7008, z = 7998}, {x = 432, z = 8216}, {x = 10713, z = 8322}, {x = 1472, z = 8597}, {x = 12076, z = 8692}, {x = 2777, z = 8788}, {x = 11413, z = 8848}, {x = 9611, z = 8859}, {x = 856, z = 8978}, {x = 1268, z = 9204}, {x = 8432, z = 9208}, {x = 11728, z = 9288}, {x = 10473, z = 9313}, {x = 12085, z = 9359}, {x = 3744, z = 9594}, {x = 8705, z = 9729}, {x = 2477, z = 9861}, {x = 7285, z = 9918}, {x = 857, z = 10001}, {x = 11328, z = 9992}, {x = 8028, z = 10097}, {x = 10662, z = 10157}, {x = 9510, z = 10353}, {x = 11029, z = 10355}, {x = 5400, z = 10424}, {x = 6736, z = 10488}, {x = 10816, z = 10513}, {x = 3685, z = 10607}, {x = 6187, z = 10747}, {x = 1960, z = 10914}, {x = 8697, z = 10924}, {x = 705, z = 10976}, {x = 7622, z = 11017}, {x = 4477, z = 11205}, {x = 1872, z = 11214}, {x = 3884, z = 11214}, {x = 5974, z = 11346}, {x = 3184, z = 11400}, {x = 4992, z = 11400}, {x = 9782, z = 11524}, {x = 2075, z = 11668}, {x = 4484, z = 11668}, {x = 6536, z = 11693}, {x = 768, z = 11804}, {x = 11856, z = 11800}, {x = 8330, z = 11822} },		
		["Stronghold_beta"] 		= { {x = 6488, z = 232}, {x = 920, z = 440}, {x = 3384, z = 440}, {x = 6120, z = 568}, {x = 1464, z = 680}, {x = 6632, z = 744}, {x = 5016, z = 792}, {x = 3096, z = 808}, {x = 952, z = 968}, {x = 3640, z = 984}, {x = 7752, z = 1064}, {x = 7224, z = 1096}, {x = 4472, z = 1432}, {x = 6632, z = 1528}, {x = 1464, z = 1576}, {x = 6120, z = 1592}, {x = 744, z = 1608}, {x = 7512, z = 1608}, {x = 4648, z = 1656}, {x = 3016, z = 1672}, {x = 232, z = 1752}, {x = 1960, z = 1784}, {x = 6424, z = 2024}, {x = 1528, z = 2088}, {x = 568, z = 2120}, {x = 3976, z = 2184}, {x = 5528, z = 2488}, {x = 2488, z = 2664}, {x = 6520, z = 3016}, {x = 3304, z = 3112}, {x = 7416, z = 3128}, {x = 712, z = 3160}, {x = 5080, z = 3304}, {x = 7784, z = 3416}, {x = 1656, z = 3544}, {x = 7240, z = 3672}, {x = 1432, z = 3720}, {x = 4248, z = 3960}, {x = 6008, z = 3976}, {x = 2184, z = 4216}, {x = 3944, z = 4232}, {x = 6760, z = 4472}, {x = 1000, z = 4536}, {x = 6536, z = 4648}, {x = 456, z = 4792}, {x = 3112, z = 4888}, {x = 7480, z = 5032}, {x = 824, z = 5080}, {x = 4888, z = 5080}, {x = 1672, z = 5176}, {x = 5704, z = 5528}, {x = 2664, z = 5704}, {x = 4216, z = 6008}, {x = 7624, z = 6168}, {x = 1704, z = 6200}, {x = 6552, z = 6216}, {x = 6152, z = 6472}, {x = 5176, z = 6520}, {x = 3544, z = 6536}, {x = 7960, z = 6536}, {x = 648, z = 6616}, {x = 2008, z = 6632}, {x = 6648, z = 6680}, {x = 7448, z = 6680}, {x = 1496, z = 6696}, {x = 3720, z = 6760}, {x = 936, z = 7128}, {x = 408, z = 7160}, {x = 4456, z = 7272}, {x = 7160, z = 7272}, {x = 1528, z = 7432}, {x = 5000, z = 7448}, {x = 3160, z = 7480}, {x = 6648, z = 7560}, {x = 2040, z = 7608}, {x = 7192, z = 7800}, {x = 4712, z = 7816}, {x = 1672, z = 7944} },		
		["Tabula"] 					= { {x = 2277, z = 111}, {x = 4287, z = 148}, {x = 640, z = 441}, {x = 861, z = 576}, {x = 7804, z = 608}, {x = 648, z = 682}, {x = 5224, z = 696}, {x = 5951, z = 702}, {x = 7584, z = 744}, {x = 7794, z = 850}, {x = 3373, z = 924}, {x = 2384, z = 1009}, {x = 3928, z = 1269}, {x = 3142, z = 1526}, {x = 4904, z = 1532}, {x = 6683, z = 1544}, {x = 2506, z = 1885}, {x = 7550, z = 2080}, {x = 5047, z = 2289}, {x = 1284, z = 2303}, {x = 687, z = 2324}, {x = 5617, z = 2479}, {x = 3176, z = 2502}, {x = 7622, z = 2530}, {x = 328, z = 2613}, {x = 7846, z = 2678}, {x = 2746, z = 2755}, {x = 4192, z = 2774}, {x = 7631, z = 2765}, {x = 6008, z = 2856}, {x = 616, z = 2974}, {x = 2271, z = 3149}, {x = 5287, z = 3163}, {x = 2994, z = 3373}, {x = 5197, z = 3746}, {x = 2904, z = 3956}, {x = 5920, z = 3970}, {x = 7575, z = 4145}, {x = 2184, z = 4264}, {x = 560, z = 4354}, {x = 3999, z = 4345}, {x = 5446, z = 4364}, {x = 345, z = 4441}, {x = 7864, z = 4506}, {x = 570, z = 4589}, {x = 5015, z = 4618}, {x = 2574, z = 4640}, {x = 7504, z = 4795}, {x = 6907, z = 4816}, {x = 3144, z = 4830}, {x = 641, z = 5039}, {x = 5686, z = 5234}, {x = 1508, z = 5575}, {x = 5049, z = 5593}, {x = 3297, z = 5638}, {x = 4264, z = 5850}, {x = 5819, z = 6150}, {x = 4818, z = 6196}, {x = 397, z = 6269}, {x = 607, z = 6375}, {x = 2240, z = 6417}, {x = 2969, z = 6413}, {x = 7544, z = 6437}, {x = 388, z = 6512}, {x = 7330, z = 6543}, {x = 7551, z = 6678}, {x = 5914, z = 7008}, {x = 3906, z = 7025} },		
		["The Rock"] 				= { {x = 5131, z = 119}, {x = 10044, z = 129}, {x = 3159, z = 228}, {x = 3793, z = 214}, {x = 4790, z = 234}, {x = 8380, z = 257}, {x = 9824, z = 264}, {x = 10032, z = 371}, {x = 767, z = 558}, {x = 6286, z = 559}, {x = 996, z = 588}, {x = 5752, z = 581}, {x = 8379, z = 630}, {x = 4134, z = 657}, {x = 866, z = 776}, {x = 5899, z = 786}, {x = 10022, z = 819}, {x = 4008, z = 844}, {x = 2384, z = 824}, {x = 4232, z = 878}, {x = 7383, z = 942}, {x = 9896, z = 1004}, {x = 10120, z = 1038}, {x = 5230, z = 1337}, {x = 6723, z = 1361}, {x = 5704, z = 1365}, {x = 4736, z = 1656}, {x = 5726, z = 1738}, {x = 7705, z = 1856}, {x = 360, z = 1882}, {x = 7110, z = 1905}, {x = 9884, z = 1912}, {x = 10094, z = 2016}, {x = 488, z = 2074}, {x = 264, z = 2104}, {x = 9872, z = 2152}, {x = 5812, z = 2459}, {x = 7027, z = 2486}, {x = 8665, z = 2502}, {x = 835, z = 2742}, {x = 9872, z = 2744}, {x = 10094, z = 2879}, {x = 9884, z = 2984}, {x = 8600, z = 3098}, {x = 3891, z = 3111}, {x = 6668, z = 3112}, {x = 2093, z = 3136}, {x = 2929, z = 3192}, {x = 1884, z = 3240}, {x = 2103, z = 3379}, {x = 7018, z = 3557}, {x = 5518, z = 3606}, {x = 8216, z = 3653}, {x = 9794, z = 3761}, {x = 246, z = 3834}, {x = 10068, z = 3829}, {x = 6230, z = 3896}, {x = 462, z = 3971}, {x = 5170, z = 4024}, {x = 4010, z = 4296}, {x = 4664, z = 4360}, {x = 2024, z = 4538}, {x = 3221, z = 4634}, {x = 8136, z = 4812}, {x = 8355, z = 4952}, {x = 7310, z = 4999}, {x = 8146, z = 5056}, {x = 6348, z = 5080}, {x = 1792, z = 5131}, {x = 355, z = 5208}, {x = 3426, z = 5274}, {x = 145, z = 5312}, {x = 368, z = 5448}, {x = 9404, z = 5449}, {x = 1574, z = 5689}, {x = 3212, z = 5705}, {x = 4427, z = 5732}, {x = 368, z = 6040}, {x = 9976, z = 6088}, {x = 9752, z = 6117}, {x = 145, z = 6175}, {x = 355, z = 6280}, {x = 9880, z = 6309}, {x = 3128, z = 6339}, {x = 2639, z = 6358}, {x = 4513, z = 6453}, {x = 5504, z = 6536}, {x = 3516, z = 6830}, {x = 4536, z = 6826}, {x = 5009, z = 6854}, {x = 119, z = 7153}, {x = 344, z = 7187}, {x = 2856, z = 7249}, {x = 6007, z = 7313}, {x = 6232, z = 7347}, {x = 218, z = 7372}, {x = 4340, z = 7405}, {x = 7856, z = 7368}, {x = 9373, z = 7416}, {x = 6105, z = 7534}, {x = 1860, z = 7561}, {x = 9243, z = 7603}, {x = 4488, z = 7610}, {x = 3953, z = 7632}, {x = 9472, z = 7633}, {x = 207, z = 7820}, {x = 415, z = 7927}, {x = 1859, z = 7934}, {x = 5450, z = 7957}, {x = 7080, z = 7963}, {x = 6446, z = 7977}, {x = 195, z = 8062}, {x = 5108, z = 8072} },
	    ["Titan"] 					= { {x = 1512, z = 305}, {x = 7730, z = 294}, {x = 1376, z = 248}, {x = 7851, z = 228}, {x = 448, z = 677}, {x = 8735, z = 710}, {x = 312, z = 721}, {x = 8840, z = 712}, {x = 8610, z = 776}, {x = 3648, z = 872}, {x = 3776, z = 1174}, {x = 8465, z = 1865}, {x = 846, z = 1912}, {x = 8600, z = 1912}, {x = 8344, z = 1920}, {x = 704, z = 1960}, {x = 3576, z = 2165}, {x = 5640, z = 2165}, {x = 4041, z = 2803}, {x = 4182, z = 2728}, {x = 5071, z = 2787}, {x = 5204, z = 2723}, {x = 3400, z = 2744}, {x = 5816, z = 2744}, {x = 865, z = 2770}, {x = 8350, z = 2770}, {x = 4615, z = 3086}, {x = 4108, z = 3339}, {x = 5143, z = 3358}, {x = 8374, z = 3331}, {x = 865, z = 3373}, {x = 5803, z = 3369}, {x = 3968, z = 3380}, {x = 3400, z = 3400}, {x = 5008, z = 3419}, {x = 3576, z = 3978}, {x = 5640, z = 3978}, {x = 793, z = 4281}, {x = 934, z = 4225}, {x = 8376, z = 4288}, {x = 8608, z = 4248}, {x = 5439, z = 4969}, {x = 5568, z = 5272}, {x = 8555, z = 5391}, {x = 8699, z = 5339}, {x = 543, z = 5437}, {x = 397, z = 5397}, {x = 472, z = 5536}, {x = 7738, z = 5847}, {x = 1473, z = 5888}, {x = 7857, z = 5870}, {x = 7624, z = 5912}, {x = 1336, z = 5936} },
		["Tropical"] 				= { {x = 6402, z = 1641}, {x = 2872, z = 1706}, {x = 2093, z = 1810}, {x = 3473, z = 1820}, {x = 5775, z = 1791}, {x = 3334, z = 1797}, {x = 5890, z = 1773}, {x = 1952, z = 1863}, {x = 5701, z = 1932}, {x = 7228, z = 2045}, {x = 3528, z = 1960}, {x = 7360, z = 2080}, {x = 7115, z = 2120}, {x = 5544, z = 2293}, {x = 3683, z = 2342}, {x = 4606, z = 2520}, {x = 3306, z = 2733}, {x = 2329, z = 2976}, {x = 7119, z = 3009}, {x = 6039, z = 2940}, {x = 2192, z = 3028}, {x = 6987, z = 3076}, {x = 5022, z = 3601}, {x = 4096, z = 3608}, {x = 4034, z = 3948}, {x = 6400, z = 4008}, {x = 3192, z = 4122}, {x = 5711, z = 4186}, {x = 5601, z = 4376}, {x = 3467, z = 4400}, {x = 2760, z = 4437}, {x = 6208, z = 4565}, {x = 5830, z = 4697}, {x = 2888, z = 4734}, {x = 3268, z = 4873}, {x = 4803, z = 5082}, {x = 4076, z = 5153}, {x = 4438, z = 5078}, {x = 4661, z = 5106}, {x = 3934, z = 5107}, {x = 4526, z = 5385}, {x = 5622, z = 5430}, {x = 5997, z = 5560}, {x = 3066, z = 5592}, {x = 2691, z = 5725}, {x = 6126, z = 5863}, {x = 5423, z = 5900}, {x = 3307, z = 5940}, {x = 3198, z = 6123}, {x = 5700, z = 6180}, {x = 4120, z = 6245}, {x = 2512, z = 6304}, {x = 4088, z = 6835}, {x = 5150, z = 6846}, {x = 2095, z = 7141}, {x = 6805, z = 7139}, {x = 1950, z = 7093}, {x = 6953, z = 7081}, {x = 3299, z = 7432}, {x = 6009, z = 7602}, {x = 4606, z = 7719}, {x = 3683, z = 7897}, {x = 5544, z = 7946}, {x = 2020, z = 8199}, {x = 7208, z = 8195}, {x = 1878, z = 8149}, {x = 7347, z = 8143}, {x = 3489, z = 8415}, {x = 5734, z = 8352}, {x = 3346, z = 8440}, {x = 4524, z = 8424}, {x = 5837, z = 8461}, {x = 5699, z = 8516}, {x = 2872, z = 8533}, {x = 6402, z = 8598} },
		["TMA-0 v1_1"] 				= { {x = 7872, z = 3024}, {x = 9984, z = 3168}, {x = 7856, z = 3232}, {x = 10304, z = 3488}, {x = 9872, z = 3552}, {x = 5744, z = 3568}, {x = 6064, z = 3888}, {x = 5664, z = 3952}, {x = 11712, z = 4288}, {x = 11520, z = 4496}, {x = 3472, z = 4688}, {x = 10256, z = 4736}, {x = 3664, z = 4896}, {x = 10256, z = 5040}, {x = 5408, z = 5056}, {x = 7984, z = 5168}, {x = 5312, z = 5392}, {x = 7840, z = 5472}, {x = 8208, z = 5472}, {x = 9472, z = 5552}, {x = 6496, z = 5648}, {x = 12960, z = 5680}, {x = 9360, z = 5776}, {x = 6656, z = 5840}, {x = 12768, z = 5984}, {x = 13168, z = 6064}, {x = 10688, z = 6080}, {x = 4240, z = 6144}, {x = 10896, z = 6368}, {x = 10400, z = 6416}, {x = 4224, z = 6432}, {x = 5568, z = 6480}, {x = 2960, z = 6496}, {x = 11872, z = 6608}, {x = 5408, z = 6672}, {x = 3184, z = 6704}, {x = 5680, z = 6736}, {x = 8032, z = 6736}, {x = 8288, z = 6736}, {x = 2848, z = 6784}, {x = 11856, z = 6864}, {x = 9024, z = 7648}, {x = 5504, z = 7904}, {x = 9184, z = 7920}, {x = 6736, z = 7952}, {x = 8816, z = 7952}, {x = 10496, z = 8064}, {x = 5504, z = 8096}, {x = 7888, z = 8112}, {x = 6928, z = 8192}, {x = 6608, z = 8272}, {x = 10400, z = 8288}, {x = 7904, z = 8368}, {x = 3024, z = 8384}, {x = 4304, z = 8496}, {x = 3024, z = 8688}, {x = 4064, z = 8688}, {x = 13200, z = 8736}, {x = 4384, z = 8800}, {x = 11344, z = 8896}, {x = 13184, z = 9056}, {x = 11168, z = 9152}, {x = 11488, z = 9216}, {x = 5808, z = 9248}, {x = 6032, z = 9248}, {x = 9232, z = 9424}, {x = 9360, z = 9664}, {x = 6336, z = 10304}, {x = 8528, z = 10336}, {x = 3776, z = 10480}, {x = 6576, z = 10496}, {x = 4080, z = 10544}, {x = 8800, z = 10560}, {x = 11264, z = 10624}, {x = 6256, z = 10640}, {x = 8464, z = 10656}, {x = 10992, z = 10688}, {x = 5088, z = 10960}, {x = 7440, z = 11072}, {x = 5216, z = 11168}, {x = 7328, z = 11296}, {x = 12368, z = 11408}, {x = 12672, z = 11680}, {x = 12256, z = 11792}, {x = 8544, z = 12000}, {x = 8800, z = 12000}, {x = 4336, z = 12016}, {x = 10256, z = 12080}, {x = 6384, z = 12160}, {x = 4640, z = 12240}, {x = 10352, z = 12272}, {x = 4256, z = 12400}, {x = 6384, z = 12464}, {x = 7632, z = 13008}, {x = 8048, z = 13024}, {x = 7792, z = 13328} },
		["Throne"] 					= { {x = 5136, z = 905}, {x = 5356, z = 1043}, {x = 5144, z = 1146}, {x = 6377, z = 1572}, {x = 7338, z = 1925}, {x = 10256, z = 2024}, {x = 4653, z = 2081}, {x = 8373, z = 2163}, {x = 10034, z = 2158}, {x = 10245, z = 2264}, {x = 5650, z = 2406}, {x = 5433, z = 2491}, {x = 5662, z = 2639}, {x = 3464, z = 2881}, {x = 1507, z = 2886}, {x = 6528, z = 2936}, {x = 1729, z = 3018}, {x = 1520, z = 3124}, {x = 4968, z = 3448}, {x = 7769, z = 3453}, {x = 9859, z = 3640}, {x = 6763, z = 3949}, {x = 6973, z = 4054}, {x = 6755, z = 4190}, {x = 4231, z = 4332}, {x = 9235, z = 4334}, {x = 1720, z = 4371}, {x = 9368, z = 4522}, {x = 9141, z = 4558}, {x = 6184, z = 4682}, {x = 10268, z = 4736}, {x = 3533, z = 4876}, {x = 2530, z = 5032}, {x = 2662, z = 5218}, {x = 2432, z = 5252}, {x = 5174, z = 5241}, {x = 7284, z = 5312}, {x = 6305, z = 5543}, {x = 10450, z = 5597}, {x = 6097, z = 5644}, {x = 8836, z = 5643}, {x = 4342, z = 5670}, {x = 4552, z = 5774}, {x = 6317, z = 5782}, {x = 4332, z = 5912}, {x = 1896, z = 5946}, {x = 7208, z = 6120}, {x = 5272, z = 6250}, {x = 3463, z = 6315}, {x = 6137, z = 6718}, {x = 8503, z = 6774}, {x = 11198, z = 6824}, {x = 10441, z = 6916}, {x = 11415, z = 6910}, {x = 11189, z = 7059}, {x = 7088, z = 7387}, {x = 7315, z = 7536}, {x = 4388, z = 7561}, {x = 7098, z = 7618}, {x = 1072, z = 7657}, {x = 856, z = 7744}, {x = 1079, z = 7892}, {x = 9797, z = 8040}, {x = 8612, z = 8059}, {x = 8831, z = 8196}, {x = 6136, z = 8203}, {x = 8621, z = 8300}, {x = 7412, z = 8343}, {x = 2603, z = 8472}, {x = 4595, z = 8664}, {x = 4465, z = 8855}, {x = 4690, z = 8888}, {x = 9451, z = 9108}, {x = 3815, z = 9825}, {x = 7801, z = 9961}, {x = 6117, z = 10222}, {x = 9117, z = 10764}, {x = 8888, z = 10912}, {x = 4511, z = 10974}, {x = 9107, z = 10995}, {x = 4740, z = 11004}, {x = 4610, z = 11192} },
		["Zoty Outpost"] 			= { {x = 2241, z = 675}, {x = 492, z = 1206}, {x = 1918, z = 1285}, {x = 844, z = 1942}, {x = 1328, z = 2341}, {x = 661, z = 2387}, {x = 2108, z = 2422} },
	}

	--------------------------------------------------------------------------------
	-- 2) VARIABILI DI STATO
	--------------------------------------------------------------------------------
	local aiTeamIDs = {}
	local teamLevels = {}       
	local teamFactions = {}     
	local teamBasePos = {}      
	local metalSpots = {}
	local scanDone = false
	local commanderCurrentBehaviour = {} 							-- comportamento del comandante
	local TARGET_AI_NAME = "WMAI"									-- nome della AI per assegnarla al team
	-- Inizializzo le tabelle/variabili globali 
	if (not GG.AI_RaggioDifesa) then GG.AI_RaggioDifesa = {} end 	-- raggio di difesa della base del team
	if (not GG.AI_StatoGuerra) then GG.AI_StatoGuerra = {} end		-- stato di guerra del team
	if (not GG.AI_BasePos) then GG.AI_BasePos = {} end				-- posizione della base del team

	--------------------------------------------------------------------------------
	-- 3) FUNZIONI DI SUPPORTO
	--------------------------------------------------------------------------------
-- Funzione per verificare se un builder specifico può raggiungere una posizione X, Y, Z dalla posizione in cui è al momento
local function CanBuilderReachPos(builderID, tx, ty, tz, faction)
    local udID = Spring.GetUnitDefID(builderID)
    if not udID then return false end
    
    local ud = UnitDefs[udID]
    local udName = ud.name

    -- Se è un aereo, può raggiungere qualsiasi punto (salta il test) ------- verificare però, perchè se l'aereo costruisce una base di terra e lo può fare sul cocuzzolo, poi le unità non scendono, pertanto usare (nel caso dell'aereo) un unità di terra per il test???? ---------------- molix #######################
    local isAirConstructor = false
    local airList = CATEGORY_TO_UNIT[faction]["CAT_ALL_AIR_CONSTRUCTORS"]
    if airList then
        for _, name in ipairs(airList) do
            if name == udName then isAirConstructor = true; break end
        end
    end
    if isAirConstructor then return true end

    -- Se è un'unità di terra/mare, eseguiamo il TestMoveOrder -- con l'unità corrente
    local bx, by, bz = Spring.GetUnitPosition(builderID)
    -- TestMoveOrder restituisce true se il pathfinder trova un passaggio
    local isReachable = Spring.TestMoveOrder(udID, bx, by, bz, tx, ty, tz)
    
    return isReachable
end

-- Questa funzione serve per aggiornare la variabile globale "stato di guerra" e il raggio di difesa (che varia in funzione del livello) per il team specificato. Cosi da comunicarlo ad altri gadget (ad esempio al "wmrts_AI_militaryMenagement.lua")
local function UpdateTeamWarStatus(teamID, basePos, currentFactoryRadius)
    if not basePos then return end
    
    local scanRadius = currentFactoryRadius + 2000
    local unitsInArea = Spring.GetUnitsInSphere(basePos.x, basePos.y, basePos.z, scanRadius)
    local enemyCount = 0

    -- Definiamo quali tipi vogliamo contare come minaccia per la base
    local targetTypes = { 
        ["ground"] = true, 
        ["naval"] = true,
        -- ["air"] = true, -- Aggiungilo qui se vuoi contare anche gli aerei
    }

    for i=1, #unitsInArea do
        local uID = unitsInArea[i]
        
        -- 1. Controlliamo se è un nemico
        if not Spring.AreTeamsAllied(teamID, Spring.GetUnitTeam(uID)) then
            local udID = Spring.GetUnitDefID(uID)
            local unitName = UnitDefs[udID].name
            
            -- 2. Cerchiamo l'unità nel database caricato
            local unitInfo = unitDB[unitName]
            
            if unitInfo then
                -- 3. Verifichiamo se il tipo è tra quelli che ci interessano 
                -- e che non abbia il flag 'ignore'
                if targetTypes[unitInfo.type] and not unitInfo.ignore then
                    enemyCount = enemyCount + 1
                end
            else
                -- Opzionale: Se un'unità nemica NON è nel DB, cosa facciamo?
                -- Per sicurezza, se è un'unità mobile (non una struttura), potremmo volerla contare comunque
                local ud = UnitDefs[udID]
                if not ud.isImmobile then
                    -- enemyCount = enemyCount + 1 -- Scommenta se vuoi contare unità sconosciute mobili
                end
            end
        end
    end

    -- Logica degli stati basata sul conteggio filtrato
    local statoGuerra = "attacco"
    if enemyCount > 35 then
        statoGuerra = "difesa_pesante"
    elseif enemyCount > 0 then
        statoGuerra = "difesa_leggera"
    end

    -- Esportazione variabili globali
    GG.AI_StatoGuerra[teamID] = statoGuerra
    GG.AI_RaggioDifesa[teamID] = scanRadius
    GG.AI_BasePos[teamID] = { x = basePos.x, y = basePos.y, z = basePos.z }
    
    -- Debug per vedere cosa sta contando
    -- Spring.Echo(string.format("AI Team %d: Nemici Pericolosi (Ground/Naval) = %d -> Stato: %s", teamID, enemyCount, statoGuerra))
end

-- Questa funzione serve per effettuare l'upgrade degli estrattori di metallo T1. Restituisce l'ID dell'estrattore T1 da upgradare, e le sue posizioni x y e z
local function GetMexT1ToUpgrade(teamID, faction, basePos)
	local t1MexNames = CATEGORY_TO_UNIT[faction]["CAT_MEX_T1"]
	if not t1MexNames then return nil end

	local t1IDs = {}
	for _, name in ipairs(t1MexNames) do
		local ud = UnitDefNames[name]
		if ud then t1IDs[ud.id] = true end
	end

	local bestMexID = nil
	local targetPos = nil
	local minDist = math.huge

	local units = Spring.GetTeamUnits(teamID)
	for _, uID in ipairs(units) do
		local udID = Spring.GetUnitDefID(uID)
		if t1IDs[udID] then
			local ux, uy, uz = Spring.GetUnitPosition(uID)
			
			-- Controlliamo se qualcuno lo sta già buildando/reclaimando
			local nearbyUnits = Spring.GetUnitsInSphere(ux, uy, uz, 64)
			local alreadyTargeted = false
			for _, nID in ipairs(nearbyUnits) do
				if nID ~= uID then
					local nudID = Spring.GetUnitDefID(nID)
					local nud = UnitDefs[nudID]
					-- Se c'è già un T2 o una costruzione T2
					if nud.isExtractor and not t1IDs[nudID] then
						alreadyTargeted = true; break
					end
				end
			end

			if not alreadyTargeted then
				local dist = (ux - basePos.x)^2 + (uz - basePos.z)^2
				if dist < minDist then
					minDist = dist
					bestMexID = uID
					targetPos = {x = ux, y = uy, z = uz}
				end
			end
		end
	end
	if bestMexID then
		return bestMexID, targetPos.x, targetPos.y, targetPos.z
	end
	return nil
end

	-- Questa funzione restituisce l'ID del Comandante se è vivo
	local function GetCommanderID(teamID, faction)
		local allowedComs = COMMANDER_TABLE[faction]
		if not allowedComs then return nil end

		local units = Spring.GetTeamUnits(teamID)
		for _, uID in ipairs(units) do
			local udID = Spring.GetUnitDefID(uID)
			local udName = UnitDefs[udID].name
			
			-- Controlla se il nome dell'unità è presente nella lista dei comandanti della fazione
			if allowedComs[udName] then
				return uID
			end
		end
		return nil
	end

	-- Questa funzione serve per costruire le fabbriche. Quando richiamata verifica dove posizionare la fabbrica in un punto lontano da giacimenti di metallo (per non imperdire la costruzione di estrattori) e lontano da "dirupi" per evitare che l'AI costruisca la fabbrica in un punto (come un dirupo, una montagna) da cui poi le unità non escono
	local function GetSafeBuildPosFactory(uDefID, basePos, metalSpots, maxRadius)
		for _ = 1, 50 do -- Più tentativi perché i criteri sono più stringenti
			local angle = math.random() * math.pi * 2
			 local dist = math.random(200, maxRadius) 		-- per le fabbriche, raggio min e raggio max dipendente dalla tabella dei livelli
			local tx = basePos.x + math.cos(angle) * dist
			local tz = basePos.z + math.sin(angle) * dist
			local ty = Spring.GetGroundHeight(tx, tz)

			-- 1. Controllo Pendenza (Dirupi)
			-- Prendiamo la "normale" del terreno. 1.0 = perfettamente piatto.
			local nx, ny, nz = Spring.GetGroundNormal(tx, tz)
			
			-- Se ny < 0.92 il terreno è troppo inclinato per una fabbrica
			if ny > 0.92 then 
				
				-- 2. Controllo Metallo (Raggio generoso 200 per lasciare spazio di manovra)
				local tooCloseToMetal = false
				for _, spot in ipairs(metalSpots) do
					if (math.abs(tx - spot.x) < 200 and math.abs(tz - spot.z) < 200) then 
						tooCloseToMetal = true; break 
					end
				end

				if not tooCloseToMetal then
					-- 3. Controllo Spazio per Unità (Testiamo 4 punti cardinali attorno alla fabbrica)
					-- Serve a capire se le unità prodotte possono uscire o se sono circondate da montagne
					local testDist = 120 
					local points = {
						{tx + testDist, tz}, {tx - testDist, tz},
						{tx, tz + testDist}, {tx, tz - testDist}
					}
					
					local exitClear = true
					for _, p in ipairs(points) do
						-- Testiamo se un'unità generica (es. un tank) può stare in quei punti
						if Spring.TestBuildOrder(UnitDefNames["icuck"].id, p[1], Spring.GetGroundHeight(p[1], p[2]), p[2], 0) <= 0 then
							exitClear = false; break
						end
					end

					if exitClear then
						-- 4. Controllo finale: L'edificio ci sta fisicamente?
						if Spring.TestBuildOrder(uDefID, tx, ty, tz, 0) == 2 then
							return tx, ty, tz
						end
					end
				end
			end
		end
		return nil 
	end
	
	-- Questa funzione controlla se un'unità "x" può effettivamente costruire un'altra unità "y". Ad esempio verifica se "icucom" può costruire "icuadvsol", cosi che il core vada a chiamare il successivo builder per eseguire di nuovo questa verifica. Restituisce true se può costruire l'unità codi da ingaggiarla, oppure false cosi il core interroga il builder successivo
	local function CanBuilderBuildThis(builderID, unitDefID)
		local ud = UnitDefs[Spring.GetUnitDefID(builderID)]
		if not ud or not ud.buildOptions then return false end
		for _, optID in ipairs(ud.buildOptions) do
			if optID == unitDefID then return true end
		end
		return false
	end

	-- Questa funzione controlla se i costruttori sono bloccati.
	local function CheckStuckBuilders(teamID, frame)
		local units = Spring.GetTeamUnits(teamID)
		for _, uID in ipairs(units) do
			local udID = Spring.GetUnitDefID(uID)
			local udName = UnitDefs[udID].name
			
			if LIMITED_CONSTRUCTORS[udName] then         -- Controlliamo solo se fa parte della lista costruttore monitorato con un ordine di costruzione
				-- 1. Verifichiamo se l'unità sta effettivamente costruendo qualcosa
				-- Spring.GetUnitIsBuilding restituisce l'ID dell'edificio se sta "lavorando"
				local isBuildingSomething = Spring.GetUnitIsBuilding(uID)
				
				local cmd = Spring.GetUnitCommands(uID, 1)  -- Prendi il primo comando
				
				if isBuildingSomething then
					-- Se sta costruendo, NON è bloccata. Resettiamo il tracker e passiamo oltre.
					builderTracker[uID] = nil
				elseif cmd and #cmd > 0 and (cmd[1].id < 0) then -- cmd.id < 0 indica costruzione
					
					local tx, ty, tz = cmd[1].params[1], cmd[1].params[2], cmd[1].params[3]
					local curX, curY, curZ = Spring.GetUnitPosition(uID)
					local distToTarget = math.sqrt((tx-curX)^2 + (tz-curZ)^2) -- Calcola distanza dal target
					
					-- Se è ancora lontano dal target (più di 35 pixel)
					if distToTarget > 35 then
						local data = builderTracker[uID]
						
						if not data then
							builderTracker[uID] = {x = curX, z = curZ, frame = frame} -- Inizia il monitoraggio
						else
							if (frame - data.frame) > 450 then -- Per fare ad esempio 30 secondi -> (30 * 30 frames = 900)  	-- ########################### portato da 30 secondi a 15 secondi 02/02/2026
								local movedDist = math.sqrt((data.x - curX)^2 + (data.z - curZ)^2)
								
								-- Se non si è mosso (meno di 30 pixel) E non sta costruendo (già verificato sopra)
								if movedDist < 30 then
--									Spring.Echo("WMRTS_contrMngm_AI: Team "..teamID.." - builder " .. udName .. " bloccato e NON sta costruendo! Blacklisto spot.") -- L'UNITA' E' BLOCCATA!
									
									for i, spot in ipairs(metalSpots) do -- Trova quale spot era (confrontando le coordinate tx, tz)
										if math.abs(spot.x - tx) < 10 and math.abs(spot.z - tz) < 10 then
											if not blacklistedSpots[teamID] then blacklistedSpots[teamID] = {} end
											blacklistedSpots[teamID][i] = true
											break
										end
									end
									
									--Spring.GiveOrderToUnit(uID, 16, {}, {}) 
									Spring.GiveOrderToUnit(uID, CMD.STOP, {}, {}) -- CMD.STOP -- Cancella ordine e resetta tracker
									builderTracker[uID] = nil
								else
									builderTracker[uID] = {x = curX, z = curZ, frame = frame} -- Si è mossa, aggiorna il tracker per il prossimo controllo
								end
							end
						end
					else
						-- È molto vicino al target, probabilmente sta per iniziare o ha finito
						builderTracker[uID] = nil
					end
				else
					-- Non ha ordini di costruzione, puliamo il tracker
					builderTracker[uID] = nil
				end
			end
		end
	end

	-- Misura la distanza reale sommando i segmenti del sentiero calcolato dal motore, dopo aver ricevuto l'ordine di costruzione
	local function GetRealDistAfterOrder(unitID)
		-- Spring.GetUnitEstimatedPath restituisce 2 tabelle, a noi serve la prima (waypoints)
		local waypoints = Spring.GetUnitEstimatedPath(unitID)
		
		if not waypoints or #waypoints == 0 then return -1 end
		
		local totalDist = 0
		local curX, curY, curZ = Spring.GetUnitPosition(unitID)
		
		for i = 1, #waypoints do
			local wp = waypoints[i]
			
			-- Il motore Spring usa indici numerici: [1]=x, [2]=y, [3]=z
			local wx = wp[1] or wp.x
			local wz = wp[3] or wp.z
			
			if wx and wz then
				local dx = wx - curX
				local dz = wz - curZ
				totalDist = totalDist + math.sqrt(dx*dx + dz*dz)
				
				-- Aggiorniamo la posizione corrente per il prossimo segmento
				curX = wx
				curZ = wz
			end
		end
		
		return totalDist
	end

	-- Questa funzione serve a non costruire gli edifici sopra un giacimento di metallo entro un raggio di 150, onde evitare di mandare in stallo l'AI
	local function GetSafeBuildPos(uDefID, basePos, metalSpots, maxRadius)
		for _ = 1, 40 do -- Proviamo 40 posizioni casuali
			local angle = math.random() * math.pi * 2
			local dist = math.random(150, maxRadius)				-- Raggio di costruzione dalla base (min, max definito dalla tabella dei livelli)
			local tx = basePos.x + math.cos(angle) * dist
			local tz = basePos.z + math.sin(angle) * dist
			local ty = Spring.GetGroundHeight(tx, tz)

			-- 1. Controllo: Non sopra un giacimento di metallo (Raggio 150)
			local tooCloseToMetal = false
			for _, spot in ipairs(metalSpots) do
				local dx, dz = tx - spot.x, tz - spot.z
				if (dx*dx + dz*dz) < (150*150) then tooCloseToMetal = true; break end
			end

			if not tooCloseToMetal then
				-- 2. Controllo: Spazio libero intorno (evita fabbriche ammassate)
				-- Cerchiamo unità in un raggio di 180 unità
				local blockingUnits = Spring.GetUnitsInSphere(tx, ty, tz, 190)	-- Spazio minimo tra le costruzioni (era 180)
				
				if #blockingUnits == 0 then
					-- 3. Controllo finale: Il terreno è edificabile?
					if Spring.TestBuildOrder(uDefID, tx, ty, tz, 0) == 2 then
						return tx, ty, tz
					end
				end
			end
		end
		return nil -- Nessuna posizione sicura trovata
	end

	-- Questa funzione serve a capire dove si trovano le risorse.
	--	•	Controlla se esistono coordinate predefinite per la mappa corrente in MANUAL_MAP_DATA.
	--	•	Se non ci sono, scansiona l'intera mappa con un salto di 32 pixel cercando punti dove il valore del metallo è superiore a 0.1.
	--	•	Salva le coordinate in una tabella metalSpots per usi futuri.
	local function AnalyzeMetalMap()
		metalSpots = {}
		local mapName = Game.mapName
		if MANUAL_MAP_DATA[mapName] then
			for _, spot in ipairs(MANUAL_MAP_DATA[mapName]) do table.insert(metalSpots, {x = spot.x, z = spot.z}) end
		else
			local step = 32
			for z = 16, Game.mapSizeZ, step do
				for x = 16, Game.mapSizeX, step do
					if Spring.GetMetalAmount(x, z) > 0.1 then
						table.insert(metalSpots, {x = x, z = z})
					end
				end
			end
		end
		scanDone = true
--		Spring.Echo("WMRTS_contrMngm_AI: Metal scan complete (" .. #metalSpots .. " spots)")
	end

	-- funzione per rilevare il metalspot più vicino via pathfinding (se l'unità è di terra) o diretta, se l'unità è un aereo DICHIARATO NELLA CATEGORIA "CAT_ALL_AIR_CONSTRUCTORS" di ogni fazione
	local function GetClosestMetalSpot(cx, cz, builderID, faction, teamID)
		local bestSpot = nil
		local minDist = 1000000 * 1000000 
		
		local udID = Spring.GetUnitDefID(builderID)
		if not udID then return nil end
		local ud = UnitDefs[udID]
		local udName = ud.name 
		local isLimited = LIMITED_CONSTRUCTORS[udName] -- Determina se il builder è limitato

		-- Variabili per il Log
		local occupiedCount = 0
		local unreachableCount = 0
		local reachableCount = 0

		-- Controllo se l'unità appartiene alla categoria AIR della sua fazione
		local isAirConstructor = false
		local airList = CATEGORY_TO_UNIT[faction]["CAT_ALL_AIR_CONSTRUCTORS"]
		if airList then
			for _, name in ipairs(airList) do
				if name == udName then 
					isAirConstructor = true 
					break 
				end
			end
		end

		for i = 1, #metalSpots do
		
		-- CONTROLLO BLACKLIST: se l'unità è terra/mare e lo spot è blacklistato, saltalo
			if isLimited and blacklistedSpots[teamID] and blacklistedSpots[teamID][i] then
				-- Salta questo spot
			else
		
			local spot = metalSpots[i]
			local sx, sz = spot.x, spot.z
			local sy = Spring.GetGroundHeight(sx, sz)

			-- 1. Verifica occupazione
			local units = Spring.GetUnitsInSphere(sx, sy, sz, 64)
			local occupied = false
			for _, uID in ipairs(units) do
				local sud = UnitDefs[Spring.GetUnitDefID(uID)]
				if sud and sud.isExtractor then occupied = true; break end
			end

			if occupied then
				occupiedCount = occupiedCount + 1
			else
				local isReachable = false
				
				if isAirConstructor then
					-- Se è nella tua lista AIR, salta il pathfinding
					isReachable = true 
				else
					-- Altrimenti usa il pathfinding standard per testare se l'unità arriva a destinazione (il motore non controlla però gli ostacoli quali features, unità in mezzo ecc)
					isReachable = Spring.TestMoveOrder(udID, cx, Spring.GetGroundHeight(cx, cz), cz, sx, sy, sz )
				end

				if isReachable then
					reachableCount = reachableCount + 1
					local dx, dz = cx - sx, cz - sz
					local distSq = dx*dx + dz*dz
					if distSq < minDist then
						minDist = distSq
						bestSpot = spot
					end
				else
					unreachableCount = unreachableCount + 1
				end
			end
		end
		end
		
		------ LOG DI ISPEZIONE ---
		local logType = isAirConstructor and "ARIA (Ignora Path)" or "TERRA/MARE (Pathfinding)"
		if bestSpot then
			local dLin = math.sqrt(minDist)
--			Spring.Echo(string.format("WMRTS_contrMngm_AI: [%s] Team %d - %s: Spot TROVATO! x:%.0f z:%.0f | Dist. Linea Aria: %.0f", udName, teamID, logType, bestSpot.x, bestSpot.z, dLin))
		else
--			Spring.Echo(string.format("WMRTS_contrMngm_AI: [%s] Team %d - %s: NESSUN SPOT DISPONIBILE!", udName, teamID, logType))
		end
		---------------------------
		if bestSpot then 
			return bestSpot.x, Spring.GetGroundHeight(bestSpot.x, bestSpot.z), bestSpot.z 
		end
		return nil
	end

	-- È il "contabile" dell'AI.
	--	•	Riceve la categoria (es. "CAT_MEX_T1") e la fazione.
	--	•	Usa Spring.GetTeamUnitDefCount per contare quante unità di quel tipo il team possiede già sulla mappa.
	--	•	Gestisce anche le categorie multi-tipo (es. le fabbriche che possono essere Land, Air o Sea).
	local function CountUnitsInCategory(teamID, category, faction)
		local entry = CATEGORY_TO_UNIT[faction][category]
		if not entry then return 0 end
		local total = 0
		local function c(list)
			for _, name in ipairs(list) do
				local ud = UnitDefNames[name]
				if ud then total = total + Spring.GetTeamUnitDefCount(teamID, ud.id) end
			end
		end
		if entry.land or entry.air or entry.sea then
			if entry.land then c(entry.land) end
			if entry.air then c(entry.air) end
			if entry.sea then c(entry.sea) end
		else c(entry) end
		return total
	end

	-- Sceglie quale unità specifica costruire all'interno di una categoria.
	--	•	Utilizza i MAP_PROFILES per decidere se la mappa permette unità di terra, aria o mare.
	--	•	Restituisce un nome di unità casuale tra quelle valide per quel profilo (es. se la mappa è solo terra, non sceglierà una fabbrica navale).
	local function GetRandomUnitFromCat(faction, category)
		local entry = CATEGORY_TO_UNIT[faction][category]
		if not entry then return nil end
		local profile = MAP_PROFILES[Game.mapName] or MAP_PROFILES["Default"]
		local valid = {}
		
		if entry.land or entry.air or entry.sea then
			if profile.land and entry.land then for _,u in ipairs(entry.land) do table.insert(valid,u) end end
			if profile.air and entry.air then for _,u in ipairs(entry.air) do table.insert(valid,u) end end
			if profile.sea and entry.sea then for _,u in ipairs(entry.sea) do table.insert(valid,u) end end
			if #valid > 0 then return valid[math.random(#valid)] end
		else
			return entry[math.random(#entry)]
		end
		return nil
	end

	-- Funzione per contare quante unità di quella categoria sono "in arrivo" nelle code delle fabbriche 
local function CountUnitsInQueues(teamID, category, faction)
	local entry = CATEGORY_TO_UNIT[faction][category]
	if not entry then return 0 end
	
	-- 1. Prepariamo la tabella degli ID validi per questa categoria
	local validIDs = {}
	local function fillIDs(list)
		for _, name in ipairs(list) do
			local ud = UnitDefNames[name]
			if ud then validIDs[ud.id] = true end
		end
	end

	if entry.land or entry.air or entry.sea then
		if entry.land then fillIDs(entry.land) end
		if entry.air then fillIDs(entry.air) end
		if entry.sea then fillIDs(entry.sea) end
	else 
		fillIDs(entry) 
	end

	local totalInQueue = 0
	local teamUnits = Spring.GetTeamUnits(teamID)

	for _, uID in ipairs(teamUnits) do
		local udID = Spring.GetUnitDefID(uID)
		local ud = UnitDefs[udID]
		
		if ud then
			-- CASO A: Fabbriche (controlla la coda di produzione unità mobili)
			if ud.isFactory then
				local queue = Spring.GetFullBuildQueue(uID)
				if queue then
					for _, buildItem in ipairs(queue) do
						for uDefID, count in pairs(buildItem) do
							if validIDs[uDefID] then
								totalInQueue = totalInQueue + count
							end
						end
					end
				end
			end

			-- CASO B: Costruttori (controlla gli edifici/upgrade in coda)
			if ud.isBuilder or ud.canBuild then
				-- Prendiamo i comandi in coda (controlliamo i primi 5-10)
				local commands = Spring.GetUnitCommands(uID, 10)
				if commands then
					for _, cmd in ipairs(commands) do
						-- In Spring, gli ordini di COSTRUZIONE hanno sempre ID NEGATIVO
						-- Es: se l'unità ha ID 150, il comando di costruzione è -150
						if cmd.id < 0 then
							local unitID_in_queue = math.abs(cmd.id)
							if validIDs[unitID_in_queue] then
								totalInQueue = totalInQueue + 1
								-- Una volta trovato un ordine che soddisfa la categoria, 
								-- passiamo al prossimo builder (per non contare due volte lo stesso lavoro)
								break 
							end
						end
					end
				end
			end
		end
	end

	return totalInQueue
end	

	--------------------------------------------------------------------------------
	-- 4) GADGET CORE
	--------------------------------------------------------------------------------

	function gadget:GameFrame(n)
		if n < 35 then return end 
		if not scanDone then AnalyzeMetalMap() end
		if (n % 150 ~= 0) then return end 

		-- IDENTIFICAZIONE TEAM (Solo quelli con la tua IA specifica)
		local teamList = Spring.GetTeamList()
		for _, teamID in ipairs(teamList) do
			if not aiTeamIDs[teamID] then
				local aiName = Spring.GetTeamLuaAI(teamID)
				-- Filtro stringente sul nome dell'AI
				if aiName and string.find(string.lower(aiName), string.lower(TARGET_AI_NAME)) then
					aiTeamIDs[teamID] = true
					teamLevels[teamID] = 0
					local side = select(5, Spring.GetTeamInfo(teamID))
					local lowerSide = string.lower(side or "")
					if string.find(lowerSide, "and") then
						teamFactions[teamID] = "AND"
					elseif string.find(lowerSide, "nfa") then
						teamFactions[teamID] = "NFA"
					elseif string.find(lowerSide, "euf") then
						teamFactions[teamID] = "EUF"						
					else
						teamFactions[teamID] = "ICU" -- Default se non trova nulla o è ICU
					end
					Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " detected Side: " .. lowerSide .. " -> Assigned Faction: " .. teamFactions[teamID])
				end
			end
		end

		for teamID, _ in pairs(aiTeamIDs) do
			local faction = teamFactions[teamID]
	 
			CheckStuckBuilders(teamID, n) -- Chiama la funzione di controllo costruttori bloccati

			if not teamBasePos[teamID] then
				local units = Spring.GetTeamUnits(teamID)
				if units and #units > 0 then
					local x,y,z = Spring.GetUnitPosition(units[1])
					teamBasePos[teamID] = {x=x, y=y, z=z}
				else return end
			end

			local currentLvl = teamLevels[teamID]
		
			------------------------------------------------------------------------
			-- LOGICA DI RESET LIVELLO di tipo B: Ritorno al Livello 0 se:  le fabbriche sono distrutte oppure abbiamo meno di x estrattori oppure abbiamo meno di y fabbriche di energia
			------------------------------------------------------------------------
			if currentLvl > 0 then
				-- Contiamo tutti i tipi di fabbriche, Mex e Energia 
				local nFabbriche = CountUnitsInCategory(teamID, "CAT_FACTORY_T1", faction) 															-- per ora ho messo solo le fabbriche T1
				local nMex = CountUnitsInCategory(teamID, "CAT_MEX_T1", faction)+CountUnitsInCategory(teamID, "CAT_MEX_T2", faction) 				-- sommo gli estrattori delle categorie T1 e T2
				local nEnergia = CountUnitsInCategory(teamID, "CAT_ENERGY_T1", faction) + CountUnitsInCategory(teamID, "CAT_ENERGY_T2", faction) 	-- sommo le fabbriche di energia delle categorie T1 e T2
				
				-- Condizioni di fallimento critico:
				local fallimentoFabbriche = (nFabbriche == 0)		-- Se le fabbriche T0 sono totalmente distrutte
				local fallimentoMetallo   = (nMex < 2)       		-- Se scende sotto i 2 estrattori di metallo
				local fallimentoEnergia   = (nEnergia < 2)   		-- Se scende sotto i 2 powerplant

				if fallimentoFabbriche or fallimentoMetallo or fallimentoEnergia then 	-- Se è presente una di queste condizioni...
					teamLevels[teamID] = 0												-- ... livello AI torna a 0
					if commanderCurrentBehaviour[teamID] ~= "constructor" then							-- ... il comandante viene forzato a diventare costruttore ######## verificare se serve perchè a lvl è impostato come costruttore per cui non dovrebbe servire questa logica
						local comID = GetCommanderID(teamID, faction)									-- ... il comandante viene forzato a diventare costruttore ######## verificare se serve perchè a lvl è impostato come costruttore per cui non dovrebbe servire questa logica
						if comID then Spring.GiveOrderToUnit(comID, CMD.STOP, {}, {}) end				-- ... il comandante viene forzato a diventare costruttore ######## verificare se serve perchè a lvl è impostato come costruttore per cui non dovrebbe servire questa logica
					end																					-- ... il comandante viene forzato a diventare costruttore ######## verificare se serve perchè a lvl è impostato come costruttore per cui non dovrebbe servire questa logica
				commanderCurrentBehaviour[teamID] = "constructor" -- Forza il ritorno a costruttore		-- ... il comandante viene forzato a diventare costruttore ######## verificare se serve perchè a lvl è impostato come costruttore per cui non dovrebbe servire questa logica
					
					if GG.WMRTS_Levels then GG.WMRTS_Levels[teamID] = 0 end
					
					local motivo = fallimentoFabbriche and "No Factories" or (fallimentoMetallo and "Low Metal" or "Low Energy")
--					Spring.Echo(string.char(255, 0, 0, 0))
--					Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " Critical Failure (" .. motivo .. ")! Reverting to Level 0.")
					currentLvl = 0 
				end
			end
			------------------------------------------------------------------------		
			
			
			local config = AI_BUILD_LEVELS[currentLvl]
			if not config then return end

			-- Calcolo dinamico dei raggi della base (entro cui l'AI può costruire), basato sul "fattoreVariazioneRaggio " impostato per ogni livello
			local fvr = config.fattoreVariazioneRaggio or 0 						-- Se dimentichi di scriverlo nel livello, usa 0
			local raggioDinamicoStrutture = 600 + (fvr * 150) 						-- Ogni punto fattore aggiunge 150 elmos
			local raggioDinamicoFactory   = 700 + (fvr * 200) 						-- Le fabbriche si allargano di più
			UpdateTeamWarStatus(teamID, teamBasePos[teamID], raggioDinamicoFactory) -- Richiamo la funzione helper per aggiornare lo stato di guerra e i raggi della base e la posizione
    ------------------------------------------------------------------------			

	------------------------------------------------------------------------
			-- LOGICA COMPORTAMENTO COMANDANTE (combehaviour)
			------------------------------------------------------------------------
			local targetBehaviour = config.combehaviour or "constructor" 				-- constructor come comportamento di default
			
			-- Eseguiamo il comando solo se il comportamento è cambiato
			if commanderCurrentBehaviour[teamID] ~= targetBehaviour then
				local comID = GetCommanderID(teamID, faction)
				
				if comID then
					if targetBehaviour == "patrolbase" then								-- se il livello richiede patrolbase, gli dai un ordine di PATROL....
						Spring.GiveOrderToUnit(comID, CMD.STOP, {}, {})					-- ... prima "stoppa" qualunque funzione stesse facendo)
						local bp = teamBasePos[teamID]									-- preleva la posizione della base
						-- Creiamo un triangolo di pattuglia attorno alla base
						Spring.GiveOrderToUnit(comID, CMD.PATROL, {bp.x + 150, bp.y, bp.z + 150}, {"shift"})
						Spring.GiveOrderToUnit(comID, CMD.PATROL, {bp.x - 150, bp.y, bp.z - 150}, {"shift"})
--						Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " Comandante (" .. UnitDefs[Spring.GetUnitDefID(comID)].name .. ") in PATROL MODE")
					
					elseif targetBehaviour == "constructor" then						-- se il livello richiede constructor...
						Spring.GiveOrderToUnit(comID, CMD.STOP, {}, {})					-- ... dai al comandante un ordine di stop, lui rimarrà idle, il resto della logica lo vedrà fermo e lo impiegherà come costruttore.
--						Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " Comandante in BUILDER MODE")
					end
					
					commanderCurrentBehaviour[teamID] = targetBehaviour
				end
			end

			-- Logica Avanzamento Livello
			local levelBroken = false
			for _, req in ipairs(config.requisiti) do
				if CountUnitsInCategory(teamID, req.cat, faction) < req.count then
					levelBroken = true; break
				end
			end
			if not levelBroken and AI_BUILD_LEVELS[currentLvl + 1] then
				teamLevels[teamID] = currentLvl + 1
				if not GG.WMRTS_Levels then GG.WMRTS_Levels = {} end
				GG.WMRTS_Levels[teamID] = teamLevels[teamID]
--				Spring.Echo(string.char(0, 255, 0, 0))
				Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " Level Up -> " .. teamLevels[teamID])
				return
			end

			-- Identificazione Costruttori e Fabbriche
			local builders = {}
			local factories = {}
			local teamUnits = Spring.GetTeamUnits(teamID)
			for _, uID in ipairs(teamUnits) do
				local ud = UnitDefs[Spring.GetUnitDefID(uID)]
				if ud then
					if ud.canBuild or ud.isBuilder then
						if Spring.GetCommandQueue(uID, 0) == 0 and not Spring.GetUnitIsBuilding(uID) then -- Se il costruttore non ha ordini in coda (GetCommandQueue == 0) ...
							table.insert(builders, uID) --...allora consideralo libero e dagli un ordine
						end
					end
					if ud.isFactory then table.insert(factories, uID) end
				end
			end

			-- Esecuzione Requisiti
			local started = 0
			for _, req in ipairs(config.requisiti) do
				if started >= config.simultanea then break end
				
				local totalPresent = CountUnitsInCategory(teamID, req.cat, faction)
				local totalPending = CountUnitsInQueues(teamID, req.cat, faction)

				if (totalPresent + totalPending) < req.count then
					local unitName = GetRandomUnitFromCat(faction, req.cat)
					local uDef = UnitDefNames[unitName]
--					local targetUpgradeMexID = nil
					
					if uDef then
						-- CASO A: È una STRUTTURA (Richiede un Builder)		
						if uDef.isBuilding or uDef.isStructure then
							local assigned = false
							local totalFree = #builders
							local capableFound = false

							if totalFree > 0 then
							-- cerchiamo tra tutti i builders disponibili
								for i = #builders, 1, -1 do -- Ciclo inverso per poter rimuovere l'elemento
									local bID = builders[i]
									if CanBuilderBuildThis(bID, uDef.id) then
										capableFound = true
										local bx, by, bz
										local targetUpgradeMexID, mx, my, mz
										local T2metalBuildType = config.T2metalBuildType or "new" -- chiamo la variabile T2metalBuildType dalla tabella dei livelli
										-- LOGICA di costruzione ESTRATTORI T1 e T2 (definite dalla tabella AI_BUILD_LEVELS) ----------------------------------------------------------------
										if req.cat == "CAT_MEX_T1" or req.cat == "CAT_MEX_T2" then 				-- se la logica richiede un "CAT_MEX_T1" o "CAT_MEX_T2"...
											if req.cat == "CAT_MEX_T2" and T2metalBuildType == "upgrade" then 	-- se la logica richiede un "CAT_MEX_T2" in modalità "upgrade"...
												-- ...esegui la funzione per eseguire l'upgrade
												targetUpgradeMexID, mx, my, mz = GetMexT1ToUpgrade(teamID, faction, teamBasePos[teamID]) -- prendi dalla funzione l'id dell'estrattore T1 e la relativa posizione						
												if targetUpgradeMexID then 		-- se ha trovato un estrattore upgradabile...
													bx, by, bz = mx, my, mz -- ...salva le coordinate per dopo (l'upgrade, che funziona prima "richiamando" l'estrattore T1 reamite ID e poi costurendo l'estrattore T2 in mx,my mz
												end
											end
											if not bx then -- se non ha trovato le coordinate per l'upgrade... vuol dire che l'AI non trova alcun Mex T1 da potenziare (magari sono già tutti T2), a questo punto...
												local bx_curr, by_curr, bz_curr = Spring.GetUnitPosition(bID) 				-- ...salva le coordinate del builder per la funzione "GetClosestMetalSpot"...
												bx, by, bz = GetClosestMetalSpot(bx_curr, bz_curr, bID, faction, teamID) 	-- ... e preleva le coordinate dello spot più vicino per costruire l'estrattore ( raticamente come se T2metalBuildType fosse impostato su "new" perchè ha gia eseguito tutti gli "upgrade" possibili)
											end			-- fine modalità upgrade
										-- LOGICA di costruzione fabbriche	----------------------------------------------------------------------------------------------------------------
										elseif req.cat == "CAT_FACTORY_T1" or req.cat == "CAT_FACTORY_T2" or req.cat == "CAT_FACTORY_T3" then
												bx, by, bz = GetSafeBuildPosFactory(uDef.id, teamBasePos[teamID], metalSpots, raggioDinamicoFactory)
										-- LOGICA di costruzione di tutte le altre strutture -----------------------------------------------------------------------------------------------
										else
											bx, by, bz = GetSafeBuildPos(uDef.id, teamBasePos[teamID], metalSpots, raggioDinamicoStrutture)
										end

									-- controllo se l'unità riesce a raggiungere la posizione 
									if bx and CanBuilderReachPos(bID, bx, by, bz, faction) then 
										if targetUpgradeMexID then 			-- nel caso stia facendo un upgrade ad un estrattore di metallo
											Spring.GiveOrderToUnit(bID, CMD.INSERT, {0, CMD.RECLAIM, 0, targetUpgradeMexID}, {"alt"})
											Spring.GiveOrderToUnit(bID, CMD.INSERT, {1, -uDef.id, 0, mx, 0, mz, 1}, {"alt"})
										else 								-- nel caso stia costruendo normalmente una delle costruzioni definite dalla logica sopra (un costruttore da nuovo, una fabbrica o una delle altre strutture )
											Spring.GiveOrderToUnit(bID, -uDef.id, {bx, by, bz, 0}, {})
										end

										table.remove(builders, i)
										started = started + 1
										assigned = true
										break 
									end -- fine if raggiungibilità
								end -- fine if CanBuilderBuild
							end -- fine for builders
						end -- fine if totalFree
						
						-- LOG DI DEBUG AVANZATO
						if not assigned and (n % 450 == 0) then -- Notifica ogni 15 secondi per non intasare
							if totalFree == 0 then
--									Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " - STALLO: Nessun costruttore LIBERO per costruire " .. unitName)
							elseif not capableFound then
--									Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " - ERRORE COSTRUTTORE: " .. totalFree .. " costruttori liberi, ma NESSUNO sa costruire " .. unitName)
							else
--								Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " - SPAZIO PIENO: Costruttori pronti, ma non trovo una posizione valida (SafePos) per " .. unitName)
							end
						end
					-- CASO B: È un UNITA' MOBILE COSTRUTTRICE CHE RICHIEDE UNA FABBRICA
					else
						for _, fID in ipairs(factories) do
							local fud = UnitDefs[Spring.GetUnitDefID(fID)]
							local canProduce = false
							for _, optID in ipairs(fud.buildOptions) do
								if optID == uDef.id then canProduce = true; break end
							end
							
							if canProduce then
								-- Evita di spammare se la fabbrica ha già l'unità in coda
								local alreadyBuilding = false
								local q = Spring.GetFullBuildQueue(fID)
								if q then
									for _, item in ipairs(q) do
										if item[uDef.id] then alreadyBuilding = true; break end
									end
								end

								if not alreadyBuilding then
--									Spring.Echo("WMRTS_contrMngm_AI: Factory " .. fID .. " priority production: inietto l'unità " .. unitName)
--										Spring.GiveOrderToUnit(fID, -uDef.id, {}, {"alt"}) 			-- elimino questa priorità, altrimenti interferirebbe con la formazione di gruppi nel target military, devo inserire l'unità senza interrompere quella che sta facendo
									Spring.GiveOrderToUnit(fID, CMD.INSERT, {1, -uDef.id, 0}, {"alt", "ctrl"})
									started = started + 1
									break 
								end
							end -- fine canproduce
						end -- fine for factories
					end -- fine if isBuilding / else
				end -- fine if uDef
			end -- fine if totalPresent
		end -- fine for requisiti
	end -- fine for teamIDs
end -- fine function