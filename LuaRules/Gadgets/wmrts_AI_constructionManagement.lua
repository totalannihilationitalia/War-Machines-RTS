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
	-- AND ########################################################################################### configurare
	----------------------------
		["AND"] = {
			["CAT_MEX_T1"]      	= { "andmex" },
			["CAT_ENERGY_T1"]     	= { "andsolar" },
			["CAT_LASER_T1"]   		= { "andlaser" },
			["CAT_AA_T1"]          	= { "andaa" },
			["CAT_FACTORY_T1"] = {
				land = { "andlab", "andhp" },
				air  = { "andplat" },
				sea  = { "andplat", "andhp" },
			},
			["CAT_ALL_CONSTRUCTORS"] = { "andcom", "andcon", "andcv", "andca", "andcs" },
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
		["Aminos Island"] 		= { {x = 5484, z = 940}, {x = 10177, z = 1015}, {x = 9968, z = 1119}, {x = 5352, z = 1130}, {x = 5581, z = 1165}, {x = 10187, z = 1254}, {x = 3456, z = 1292}, {x = 3246, z = 1397}, {x = 3466, z = 1532}, {x = 6593, z = 1846}, {x = 6822, z = 1878}, {x = 6691, z = 2067}, {x = 4785, z = 2156}, {x = 5015, z = 2305}, {x = 10322, z = 2310}, {x = 4796, z = 2387}, {x = 2696, z = 2450}, {x = 10550, z = 2457}, {x = 10331, z = 2544}, {x = 2908, z = 2554}, {x = 2688, z = 2691}, {x = 7725, z = 2866}, {x = 7497, z = 3014}, {x = 7714, z = 3101}, {x = 1455, z = 3302}, {x = 1678, z = 3435}, {x = 1465, z = 3540}, {x = 8176, z = 3586}, {x = 7960, z = 3672}, {x = 8186, z = 3821}, {x = 9690, z = 3968}, {x = 5202, z = 3974}, {x = 5420, z = 4064}, {x = 9914, z = 4120}, {x = 5194, z = 4211}, {x = 9699, z = 4205}, {x = 5645, z = 4465}, {x = 5512, z = 4652}, {x = 5741, z = 4685}, {x = 8646, z = 4998}, {x = 8428, z = 5131}, {x = 8636, z = 5238}, {x = 8123, z = 5446}, {x = 8349, z = 5578}, {x = 3096, z = 5672}, {x = 8137, z = 5684}, {x = 2877, z = 5809}, {x = 2466, z = 5918}, {x = 3085, z = 5914}, {x = 2248, z = 6003}, {x = 2474, z = 6152}, {x = 9369, z = 7174}, {x = 9164, z = 7278}, {x = 9382, z = 7414}, {x = 6568, z = 7445}, {x = 6362, z = 7548}, {x = 1595, z = 7561}, {x = 6584, z = 7685}, {x = 1464, z = 7752}, {x = 1694, z = 7784}, {x = 8422, z = 8057}, {x = 8649, z = 8089}, {x = 8518, z = 8278}, {x = 4392, z = 8552}, {x = 3775, z = 8640}, {x = 3998, z = 8677}, {x = 4616, z = 8696}, {x = 4397, z = 8784}, {x = 3871, z = 8859}, {x = 5313, z = 9223}, {x = 5542, z = 9254}, {x = 3328, z = 9346}, {x = 5412, z = 9446}, {x = 3558, z = 9494}, {x = 3341, z = 9578}, {x = 1925, z = 10136}, {x = 1716, z = 10239}, {x = 1936, z = 10376}, {x = 9378, z = 10562}, {x = 9608, z = 10595}, {x = 9476, z = 10778}, {x = 7146, z = 11036}, {x = 7376, z = 11184}, {x = 7158, z = 11272}, {x = 11968, z = 11953}, {x = 12194, z = 11984}, {x = 12067, z = 12171} },
		["Delta Siege dry duo"] = { {x = 7070, z = 116}, {x = 3095, z = 142}, {x = 7286, z = 201}, {x = 2878, z = 231}, {x = 7057, z = 351}, {x = 3105, z = 379}, {x = 598, z = 482}, {x = 9641, z = 482}, {x = 373, z = 632}, {x = 5044, z = 635}, {x = 9866, z = 632}, {x = 588, z = 718}, {x = 9651, z = 718}, {x = 5817, z = 1177}, {x = 3383, z = 1620}, {x = 8133, z = 1609}, {x = 4904, z = 1637}, {x = 7907, z = 1641}, {x = 6554, z = 1757}, {x = 5122, z = 1769}, {x = 8037, z = 1832}, {x = 4912, z = 1876}, {x = 2381, z = 1885}, {x = 2608, z = 1918}, {x = 2480, z = 2105}, {x = 458, z = 2307}, {x = 8518, z = 2297}, {x = 9878, z = 2406}, {x = 588, z = 2494}, {x = 362, z = 2529}, {x = 9752, z = 2592}, {x = 5177, z = 2628}, {x = 9977, z = 2628}, {x = 4601, z = 2681}, {x = 1676, z = 2691}, {x = 2811, z = 2843}, {x = 7428, z = 2843}, {x = 2592, z = 2980}, {x = 7647, z = 2980}, {x = 2799, z = 3085}, {x = 7440, z = 3085}, {x = 5664, z = 3656}, {x = 10035, z = 3896}, {x = 4576, z = 3928}, {x = 9812, z = 4032}, {x = 3888, z = 4133}, {x = 10024, z = 4138}, {x = 2697, z = 4153}, {x = 7542, z = 4153}, {x = 204, z = 4248}, {x = 2566, z = 4340}, {x = 7673, z = 4340}, {x = 429, z = 4382}, {x = 2793, z = 4374}, {x = 7446, z = 4374}, {x = 6073, z = 4406}, {x = 216, z = 4488}, {x = 8737, z = 4583}, {x = 1757, z = 4662}, {x = 8947, z = 4689}, {x = 1552, z = 4763}, {x = 4263, z = 4763}, {x = 6808, z = 4763}, {x = 8728, z = 4824}, {x = 1768, z = 4901}, {x = 1768, z = 5338}, {x = 8728, z = 5416}, {x = 1552, z = 5476}, {x = 3431, z = 5476}, {x = 5704, z = 5476}, {x = 8947, z = 5550}, {x = 1757, z = 5578}, {x = 8737, z = 5656}, {x = 216, z = 5752}, {x = 4166, z = 5833}, {x = 429, z = 5857}, {x = 2793, z = 5865}, {x = 7446, z = 5865}, {x = 2566, z = 5899}, {x = 7673, z = 5899}, {x = 204, z = 5992}, {x = 2697, z = 6086}, {x = 7542, z = 6086}, {x = 6352, z = 6106}, {x = 10024, z = 6101}, {x = 9812, z = 6207}, {x = 5664, z = 6312}, {x = 10035, z = 6344}, {x = 4576, z = 6584}, {x = 2799, z = 7154}, {x = 7440, z = 7154}, {x = 2592, z = 7259}, {x = 7647, z = 7259}, {x = 2811, z = 7396}, {x = 7428, z = 7396}, {x = 1676, z = 7548}, {x = 4601, z = 7558}, {x = 5177, z = 7611}, {x = 9977, z = 7611}, {x = 9752, z = 7648}, {x = 362, z = 7710}, {x = 588, z = 7745}, {x = 9878, z = 7833}, {x = 458, z = 7932}, {x = 8518, z = 7942}, {x = 2480, z = 8134}, {x = 2608, z = 8321}, {x = 2381, z = 8354}, {x = 4912, z = 8363}, {x = 8037, z = 8408}, {x = 5122, z = 8470}, {x = 6554, z = 8482}, {x = 7907, z = 8598}, {x = 4904, z = 8602}, {x = 3383, z = 8619}, {x = 8133, z = 8630}, {x = 5817, z = 9062}, {x = 588, z = 9521}, {x = 9651, z = 9521}, {x = 373, z = 9608}, {x = 5044, z = 9604}, {x = 9866, z = 9608}, {x = 598, z = 9757}, {x = 9641, z = 9757}, {x = 3105, z = 9860}, {x = 7057, z = 9888}, {x = 2878, z = 10008}, {x = 7286, z = 10038}, {x = 3095, z = 10097}, {x = 7070, z = 10123} },
		["Eridlon Island"] 		= { {x = 10566, z = 1226}, {x = 10783, z = 1364}, {x = 5864, z = 1408}, {x = 10578, z = 1468}, {x = 5652, z = 1512}, {x = 5873, z = 1645}, {x = 9751, z = 1707}, {x = 7219, z = 1904}, {x = 6722, z = 2059}, {x = 7144, z = 2117}, {x = 6504, z = 2142}, {x = 3796, z = 2192}, {x = 4015, z = 2328}, {x = 10613, z = 2338}, {x = 3807, z = 2435}, {x = 10818, z = 2442}, {x = 10600, z = 2579}, {x = 6240, z = 2725}, {x = 6250, z = 2962}, {x = 5562, z = 3221}, {x = 5773, z = 3326}, {x = 5554, z = 3462}, {x = 9139, z = 3521}, {x = 9356, z = 3608}, {x = 11109, z = 3666}, {x = 8721, z = 3678}, {x = 9132, z = 3760}, {x = 8495, z = 3825}, {x = 11221, z = 3874}, {x = 8713, z = 3912}, {x = 10988, z = 3911}, {x = 4722, z = 3958}, {x = 3304, z = 3994}, {x = 4505, z = 4043}, {x = 3090, z = 4101}, {x = 8080, z = 4099}, {x = 4733, z = 4192}, {x = 3316, z = 4233}, {x = 7609, z = 4250}, {x = 7840, z = 4264}, {x = 8091, z = 4338}, {x = 4842, z = 4364}, {x = 11111, z = 4396}, {x = 11364, z = 4450}, {x = 5063, z = 4498}, {x = 4856, z = 4602}, {x = 11205, z = 4619}, {x = 10083, z = 4904}, {x = 7923, z = 4952}, {x = 9874, z = 5007}, {x = 7714, z = 5055}, {x = 7936, z = 5192}, {x = 3958, z = 6161}, {x = 3832, z = 6348}, {x = 4051, z = 6453}, {x = 9624, z = 6378}, {x = 4275, z = 6542}, {x = 9493, z = 6568}, {x = 9721, z = 6598}, {x = 4146, z = 6728}, {x = 6680, z = 7228}, {x = 6450, z = 7266}, {x = 10906, z = 7328}, {x = 6614, z = 7446}, {x = 11130, z = 7480}, {x = 10915, z = 7566}, {x = 5872, z = 7726}, {x = 6104, z = 7760}, {x = 9217, z = 8626}, {x = 9120, z = 8720}, {x = 9764, z = 8731}, {x = 9983, z = 8870}, {x = 9775, z = 8979}, {x = 3211, z = 9657}, {x = 3561, z = 9740}, {x = 3535, z = 9950}, {x = 4929, z = 10096}, {x = 5158, z = 10246}, {x = 4941, z = 10333}, {x = 8094, z = 10425}, {x = 9632, z = 10486}, {x = 8301, z = 10521}, {x = 2606, z = 10592}, {x = 9409, z = 10619}, {x = 9622, z = 10724} },
		["Tabula"] 				= { {x = 2277, z = 111}, {x = 4287, z = 148}, {x = 640, z = 441}, {x = 861, z = 576}, {x = 7804, z = 608}, {x = 648, z = 682}, {x = 5224, z = 696}, {x = 5951, z = 702}, {x = 7584, z = 744}, {x = 7794, z = 850}, {x = 3373, z = 924}, {x = 2384, z = 1009}, {x = 3928, z = 1269}, {x = 3142, z = 1526}, {x = 4904, z = 1532}, {x = 6683, z = 1544}, {x = 2506, z = 1885}, {x = 7550, z = 2080}, {x = 5047, z = 2289}, {x = 1284, z = 2303}, {x = 687, z = 2324}, {x = 5617, z = 2479}, {x = 3176, z = 2502}, {x = 7622, z = 2530}, {x = 328, z = 2613}, {x = 7846, z = 2678}, {x = 2746, z = 2755}, {x = 4192, z = 2774}, {x = 7631, z = 2765}, {x = 6008, z = 2856}, {x = 616, z = 2974}, {x = 2271, z = 3149}, {x = 5287, z = 3163}, {x = 2994, z = 3373}, {x = 5197, z = 3746}, {x = 2904, z = 3956}, {x = 5920, z = 3970}, {x = 7575, z = 4145}, {x = 2184, z = 4264}, {x = 560, z = 4354}, {x = 3999, z = 4345}, {x = 5446, z = 4364}, {x = 345, z = 4441}, {x = 7864, z = 4506}, {x = 570, z = 4589}, {x = 5015, z = 4618}, {x = 2574, z = 4640}, {x = 7504, z = 4795}, {x = 6907, z = 4816}, {x = 3144, z = 4830}, {x = 641, z = 5039}, {x = 5686, z = 5234}, {x = 1508, z = 5575}, {x = 5049, z = 5593}, {x = 3297, z = 5638}, {x = 4264, z = 5850}, {x = 5819, z = 6150}, {x = 4818, z = 6196}, {x = 397, z = 6269}, {x = 607, z = 6375}, {x = 2240, z = 6417}, {x = 2969, z = 6413}, {x = 7544, z = 6437}, {x = 388, z = 6512}, {x = 7330, z = 6543}, {x = 7551, z = 6678}, {x = 5914, z = 7008}, {x = 3906, z = 7025} },		
		["Tropical"] 			= { {x = 6402, z = 1641}, {x = 2872, z = 1706}, {x = 2093, z = 1810}, {x = 3473, z = 1820}, {x = 5775, z = 1791}, {x = 3334, z = 1797}, {x = 5890, z = 1773}, {x = 1952, z = 1863}, {x = 5701, z = 1932}, {x = 7228, z = 2045}, {x = 3528, z = 1960}, {x = 7360, z = 2080}, {x = 7115, z = 2120}, {x = 5544, z = 2293}, {x = 3683, z = 2342}, {x = 4606, z = 2520}, {x = 3306, z = 2733}, {x = 2329, z = 2976}, {x = 7119, z = 3009}, {x = 6039, z = 2940}, {x = 2192, z = 3028}, {x = 6987, z = 3076}, {x = 5022, z = 3601}, {x = 4096, z = 3608}, {x = 4034, z = 3948}, {x = 6400, z = 4008}, {x = 3192, z = 4122}, {x = 5711, z = 4186}, {x = 5601, z = 4376}, {x = 3467, z = 4400}, {x = 2760, z = 4437}, {x = 6208, z = 4565}, {x = 5830, z = 4697}, {x = 2888, z = 4734}, {x = 3268, z = 4873}, {x = 4803, z = 5082}, {x = 4076, z = 5153}, {x = 4438, z = 5078}, {x = 4661, z = 5106}, {x = 3934, z = 5107}, {x = 4526, z = 5385}, {x = 5622, z = 5430}, {x = 5997, z = 5560}, {x = 3066, z = 5592}, {x = 2691, z = 5725}, {x = 6126, z = 5863}, {x = 5423, z = 5900}, {x = 3307, z = 5940}, {x = 3198, z = 6123}, {x = 5700, z = 6180}, {x = 4120, z = 6245}, {x = 2512, z = 6304}, {x = 4088, z = 6835}, {x = 5150, z = 6846}, {x = 2095, z = 7141}, {x = 6805, z = 7139}, {x = 1950, z = 7093}, {x = 6953, z = 7081}, {x = 3299, z = 7432}, {x = 6009, z = 7602}, {x = 4606, z = 7719}, {x = 3683, z = 7897}, {x = 5544, z = 7946}, {x = 2020, z = 8199}, {x = 7208, z = 8195}, {x = 1878, z = 8149}, {x = 7347, z = 8143}, {x = 3489, z = 8415}, {x = 5734, z = 8352}, {x = 3346, z = 8440}, {x = 4524, z = 8424}, {x = 5837, z = 8461}, {x = 5699, z = 8516}, {x = 2872, z = 8533}, {x = 6402, z = 8598} },
		["The Rock"] 			= { {x = 5131, z = 119}, {x = 10044, z = 129}, {x = 3159, z = 228}, {x = 3793, z = 214}, {x = 4790, z = 234}, {x = 8380, z = 257}, {x = 9824, z = 264}, {x = 10032, z = 371}, {x = 767, z = 558}, {x = 6286, z = 559}, {x = 996, z = 588}, {x = 5752, z = 581}, {x = 8379, z = 630}, {x = 4134, z = 657}, {x = 866, z = 776}, {x = 5899, z = 786}, {x = 10022, z = 819}, {x = 4008, z = 844}, {x = 2384, z = 824}, {x = 4232, z = 878}, {x = 7383, z = 942}, {x = 9896, z = 1004}, {x = 10120, z = 1038}, {x = 5230, z = 1337}, {x = 6723, z = 1361}, {x = 5704, z = 1365}, {x = 4736, z = 1656}, {x = 5726, z = 1738}, {x = 7705, z = 1856}, {x = 360, z = 1882}, {x = 7110, z = 1905}, {x = 9884, z = 1912}, {x = 10094, z = 2016}, {x = 488, z = 2074}, {x = 264, z = 2104}, {x = 9872, z = 2152}, {x = 5812, z = 2459}, {x = 7027, z = 2486}, {x = 8665, z = 2502}, {x = 835, z = 2742}, {x = 9872, z = 2744}, {x = 10094, z = 2879}, {x = 9884, z = 2984}, {x = 8600, z = 3098}, {x = 3891, z = 3111}, {x = 6668, z = 3112}, {x = 2093, z = 3136}, {x = 2929, z = 3192}, {x = 1884, z = 3240}, {x = 2103, z = 3379}, {x = 7018, z = 3557}, {x = 5518, z = 3606}, {x = 8216, z = 3653}, {x = 9794, z = 3761}, {x = 246, z = 3834}, {x = 10068, z = 3829}, {x = 6230, z = 3896}, {x = 462, z = 3971}, {x = 5170, z = 4024}, {x = 4010, z = 4296}, {x = 4664, z = 4360}, {x = 2024, z = 4538}, {x = 3221, z = 4634}, {x = 8136, z = 4812}, {x = 8355, z = 4952}, {x = 7310, z = 4999}, {x = 8146, z = 5056}, {x = 6348, z = 5080}, {x = 1792, z = 5131}, {x = 355, z = 5208}, {x = 3426, z = 5274}, {x = 145, z = 5312}, {x = 368, z = 5448}, {x = 9404, z = 5449}, {x = 1574, z = 5689}, {x = 3212, z = 5705}, {x = 4427, z = 5732}, {x = 368, z = 6040}, {x = 9976, z = 6088}, {x = 9752, z = 6117}, {x = 145, z = 6175}, {x = 355, z = 6280}, {x = 9880, z = 6309}, {x = 3128, z = 6339}, {x = 2639, z = 6358}, {x = 4513, z = 6453}, {x = 5504, z = 6536}, {x = 3516, z = 6830}, {x = 4536, z = 6826}, {x = 5009, z = 6854}, {x = 119, z = 7153}, {x = 344, z = 7187}, {x = 2856, z = 7249}, {x = 6007, z = 7313}, {x = 6232, z = 7347}, {x = 218, z = 7372}, {x = 4340, z = 7405}, {x = 7856, z = 7368}, {x = 9373, z = 7416}, {x = 6105, z = 7534}, {x = 1860, z = 7561}, {x = 9243, z = 7603}, {x = 4488, z = 7610}, {x = 3953, z = 7632}, {x = 9472, z = 7633}, {x = 207, z = 7820}, {x = 415, z = 7927}, {x = 1859, z = 7934}, {x = 5450, z = 7957}, {x = 7080, z = 7963}, {x = 6446, z = 7977}, {x = 195, z = 8062}, {x = 5108, z = 8072} },
		["Throne"] 				= { {x = 5136, z = 905}, {x = 5356, z = 1043}, {x = 5144, z = 1146}, {x = 6377, z = 1572}, {x = 7338, z = 1925}, {x = 10256, z = 2024}, {x = 4653, z = 2081}, {x = 8373, z = 2163}, {x = 10034, z = 2158}, {x = 10245, z = 2264}, {x = 5650, z = 2406}, {x = 5433, z = 2491}, {x = 5662, z = 2639}, {x = 3464, z = 2881}, {x = 1507, z = 2886}, {x = 6528, z = 2936}, {x = 1729, z = 3018}, {x = 1520, z = 3124}, {x = 4968, z = 3448}, {x = 7769, z = 3453}, {x = 9859, z = 3640}, {x = 6763, z = 3949}, {x = 6973, z = 4054}, {x = 6755, z = 4190}, {x = 4231, z = 4332}, {x = 9235, z = 4334}, {x = 1720, z = 4371}, {x = 9368, z = 4522}, {x = 9141, z = 4558}, {x = 6184, z = 4682}, {x = 10268, z = 4736}, {x = 3533, z = 4876}, {x = 2530, z = 5032}, {x = 2662, z = 5218}, {x = 2432, z = 5252}, {x = 5174, z = 5241}, {x = 7284, z = 5312}, {x = 6305, z = 5543}, {x = 10450, z = 5597}, {x = 6097, z = 5644}, {x = 8836, z = 5643}, {x = 4342, z = 5670}, {x = 4552, z = 5774}, {x = 6317, z = 5782}, {x = 4332, z = 5912}, {x = 1896, z = 5946}, {x = 7208, z = 6120}, {x = 5272, z = 6250}, {x = 3463, z = 6315}, {x = 6137, z = 6718}, {x = 8503, z = 6774}, {x = 11198, z = 6824}, {x = 10441, z = 6916}, {x = 11415, z = 6910}, {x = 11189, z = 7059}, {x = 7088, z = 7387}, {x = 7315, z = 7536}, {x = 4388, z = 7561}, {x = 7098, z = 7618}, {x = 1072, z = 7657}, {x = 856, z = 7744}, {x = 1079, z = 7892}, {x = 9797, z = 8040}, {x = 8612, z = 8059}, {x = 8831, z = 8196}, {x = 6136, z = 8203}, {x = 8621, z = 8300}, {x = 7412, z = 8343}, {x = 2603, z = 8472}, {x = 4595, z = 8664}, {x = 4465, z = 8855}, {x = 4690, z = 8888}, {x = 9451, z = 9108}, {x = 3815, z = 9825}, {x = 7801, z = 9961}, {x = 6117, z = 10222}, {x = 9117, z = 10764}, {x = 8888, z = 10912}, {x = 4511, z = 10974}, {x = 9107, z = 10995}, {x = 4740, z = 11004}, {x = 4610, z = 11192} },
		["Zoty Outpost"] 		= { {x = 2241, z = 675}, {x = 492, z = 1206}, {x = 1918, z = 1285}, {x = 844, z = 1942}, {x = 1328, z = 2341}, {x = 661, z = 2387}, {x = 2108, z = 2422} },
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
	local TARGET_AI_NAME = "WMAI"				-- nome della AI
	-- Inizializzo le tabelle/variabili globali 
	if (not GG.AI_RaggioDifesa) then GG.AI_RaggioDifesa = {} end 	-- raggio di difesa della base del team
	if (not GG.AI_StatoGuerra) then GG.AI_StatoGuerra = {} end		-- stato di guerra del team
	if (not GG.AI_BasePos) then GG.AI_BasePos = {} end				-- posizione della base del team

	--------------------------------------------------------------------------------
	-- 3) FUNZIONI DI SUPPORTO
	--------------------------------------------------------------------------------

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
					-- Altrimenti usa il pathfinding standard
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
--[[
	local function CountUnitsInQueues(teamID, category, faction)
		local entry = CATEGORY_TO_UNIT[faction][category]
		if not entry then return 0 end
		
		-- Trasformiamo i nomi in ID per un confronto veloce
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
		else fillIDs(entry) end

		local totalInQueue = 0
		local teamUnits = Spring.GetTeamUnits(teamID)
		for _, uID in ipairs(teamUnits) do
			local ud = UnitDefs[Spring.GetUnitDefID(uID)]
			if ud and ud.isFactory then
				local queue = Spring.GetFullBuildQueue(uID)
				if queue then
					for _, buildItem in ipairs(queue) do
						-- buildItem è { [unitDefID] = count }
						for uDefID, count in pairs(buildItem) do
							if validIDs[uDefID] then
								totalInQueue = totalInQueue + count
							end
						end
					end
				end
			end
		end
		return totalInQueue
	end
]]--
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
--				if aiName and aiName ~= "" then
					aiTeamIDs[teamID] = true
					teamLevels[teamID] = 0
					local side = select(5, Spring.GetTeamInfo(teamID))
					local lowerSide = string.lower(side or "")
					if string.find(lowerSide, "and") then
						teamFactions[teamID] = "AND"
					elseif string.find(lowerSide, "nfa") then
						teamFactions[teamID] = "NFA"
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
					Spring.Echo(string.char(255, 0, 0, 0))
					Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " Critical Failure (" .. motivo .. ")! Reverting to Level 0.")
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
				Spring.Echo(string.char(0, 255, 0, 0))
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
					local targetUpgradeMexID = nil
					
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
										-- LOGICA di costruzione ESTRATTORI T1 e T2 (definite dalla tabella AI_BUILD_LEVELS)
										if req.cat == "CAT_MEX_T1" or req.cat == "CAT_MEX_T2" then 				-- se la logica richiede un "CAT_MEX_T1" o "CAT_MEX_T2"...
											if req.cat == "CAT_MEX_T2" and T2metalBuildType == "upgrade" then 	-- se la logica richiede un "CAT_MEX_T2" in modalità "upgrade"...
												-- ...esegui la funzione per eseguire l'upgrade
												targetUpgradeMexID, mx, my, mz = GetMexT1ToUpgrade(teamID, faction, teamBasePos[teamID]) -- prendi dalla funzione l'id dell'estrattore T1 e la relativa posizione						
												if targetUpgradeMexID then 		-- se ha trovato un estrattore upgradabile...
													bx, by, bz = mx, my, mz -- ...salva le coordinate per dopo (l'upgrade, che funziona prima "richiamando" l'estrattore T1 reamite ID e poi costurendo l'estrattore T2 in mx,my mz
												end
												if not bx then -- se non ha trovato le coordinate per l'upgrade... vuol dire che l'AI non trova alcun Mex T1 da potenziare (magari sono già tutti T2), a questo punto...
													local bx_curr, by_curr, bz_curr = Spring.GetUnitPosition(bID) 				-- ...salva le coordinate del builder per la funzione "GetClosestMetalSpot"...
													bx, by, bz = GetClosestMetalSpot(bx_curr, bz_curr, bID, faction, teamID) 	-- ... e preleva le coordinate dello spot più vicino per costruire l'estrattore ( raticamente come se T2metalBuildType fosse impostato su "new" perchè ha gia eseguito tutti gli "upgrade" possibili)
												end			-- fine modalità upgrade
											else 			-- se la logica richiede un "CAT_MEX_T2" in modalità "new" (default)...  
												local bx_curr, by_curr, bz_curr = Spring.GetUnitPosition(bID)					-- ...salva le coordinate del builder per la funzione "GetClosestMetalSpot"...
												bx, by, bz = GetClosestMetalSpot(bx_curr, bz_curr, bID, faction, teamID)		-- ... e preleva le coordinate dello spot più vicino per costruire l'estrattore ( raticamente come se T2metalBuildType fosse impostato su "new" perchè ha gia eseguito tutti gli "upgrade" possibili)
											end

											if bx == nil then
--												Spring.Echo("WMRTS_contrMngm_AI: Nessun metallo (nuovo o upgrade) raggiungibile per " .. UnitDefs[Spring.GetUnitDefID(bID)].name)
											end
										-- LOGICA di costruzione FABBRICHE (definite dalla tabella AI_BUILD_LEVELS)
										elseif req.cat == "CAT_FACTORY_T1" or req.cat == "CAT_FACTORY_T2" then														-- se l'AI deve costruire una fabbrica...
												bx, by, bz = GetSafeBuildPosFactory(uDef.id, teamBasePos[teamID], metalSpots, raggioDinamicoFactory)       			-- Chiama la funzione specifica per le fabbriche
										-- LOGICA di costruzione del RESTO DELLE COSTRUZIONI non sopra specificate (definite dalla tabella AI_BUILD_LEVELS)
										else			
											bx, by, bz = GetSafeBuildPos(uDef.id, teamBasePos[teamID], metalSpots, raggioDinamicoStrutture) 						-- ...Usa la funzione sicura per centrali e fabbriche       
										end 										----------------------------- end LOGICA di costruzione									
										if targetUpgradeMexID then -- Se siamo in fase di upgrade metallo....
										-- Definiamo i parametri per CMD.INSERT: {posizione, cmdID, opzioni, parametri...}
    
											-- 1. Inseriamo il RECLAIM in posizione 0 (sovrascrive o sposta tutto il resto)
											-- I parametri sono: {0, ID_COMANDO, OPZIONI, ID_TARGET}
											Spring.GiveOrderToUnit(bID, CMD.INSERT, {0, CMD.RECLAIM, 0, targetUpgradeMexID}, {"alt"})
											
											-- 2. Inseriamo la COSTRUZIONE nella lista degli ordini, in posizione 1 (subito dopo il reclaim). Se dessi un ordine diretto con "shift" non funzionerebbe perchè essendoci ancora l'estrattore, fisicamente SPRING non può costruirci sopra niente.
											Spring.GiveOrderToUnit(bID, CMD.INSERT, {1, -uDef.id, 0, mx, 0, mz, 1}, {"alt"})
    										--    Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " Upgrade via CMD_INSERT (Reclaim + Build)")
											table.remove(builders, i)		-- Rimuovi il builder dalla lista perché ora è occupato	
											started = started + 1
											assigned = true
											break -- Esci dal ciclo dei builder, abbiamo trovato chi lo fa												
										elseif bx and (not targetUpgradeMexID) then										-- Se invece non si tratta di upgrade metallo T1 to T2 (not targetUpgradeMexID) allora procedi con il resto delle costruzioni
--											Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " builder " .. bID .. " (" .. UnitDefs[Spring.GetUnitDefID(bID)].name .. ") builds " .. unitName)
											Spring.GiveOrderToUnit(bID, -uDef.id, {bx, by, bz, 0}, {})
											-- --- LOG DISTANZA REALE PATHFINDER ---
											local bName = UnitDefs[Spring.GetUnitDefID(bID)].name
											local pDist = GetRealDistAfterOrder(bID)
											if pDist > 0 then
--												  Spring.Echo(string.format("   -> DEBUG PATH Team %d: L'unita '%s' ID=%d percorrera %.0f unita reali per arrivare.", teamID, bName, bID, pDist))
											else
--												  Spring.Echo(string.format("   -> DEBUG PATH Team %d: L'unita '%s' ID=%d ha un percorso istantaneo o non ancora calcolato.", teamID, bName, bID))
											end
											--------
											table.remove(builders, i)		-- Rimuovi il builder dalla lista perché ora è occupato	
											started = started + 1
											assigned = true
											break -- Esci dal ciclo dei builder, abbiamo trovato chi lo fa
										end
									end
								end
							end
							
							-- LOG DI DEBUG AVANZATO
							if not assigned and (n % 450 == 0) then -- Notifica ogni 15 secondi per non intasare
								if totalFree == 0 then
--									Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " - STALLO: Nessun costruttore LIBERO per costruire " .. unitName)
								elseif not capableFound then
--									Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " - ERRORE COSTRUTTORE: " .. totalFree .. " costruttori liberi, ma NESSUNO sa costruire " .. unitName)
								else
									Spring.Echo("WMRTS_contrMngm_AI: Team " .. teamID .. " - SPAZIO PIENO: Costruttori pronti, ma non trovo una posizione valida (SafePos) per " .. unitName)
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
										Spring.Echo("WMRTS_contrMngm_AI: Factory " .. fID .. " priority production: inietto l'unità " .. unitName)
--										Spring.GiveOrderToUnit(fID, -uDef.id, {}, {"alt"}) 			-- elimino questa priorità, altrimenti interferirebbe con la formazione di gruppi nel target military, devo inserire l'unità senza interrompere quella che sta facendo
										Spring.GiveOrderToUnit(fID, CMD.INSERT, {1, -uDef.id, 0}, {"alt", "ctrl"})
										started = started + 1
										break 
									end
								end
							end
						end -- Fine distinzione edificio/mobile
					end
				end
			end -- Fine ciclo requisiti
		end -- Fine ciclo team
	end