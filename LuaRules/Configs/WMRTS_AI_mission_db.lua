-- units database for WMRTS mission AI, by molix
-- 09/01/2026

--------------------------------------------------------------------------------
-- 1) DATABASE UNITÀ -- caricato dal file wmrts_missionAI.lua
--------------------------------------------------------------------------------
-- Qui puoi aggiungere campi extra in futuro (es. priority, armor_type, ecc.)
-- La tipologia di ogni singola unità è necessaria affinchè la AI gestisca le squadre/gruppi (punto 2) contro le singole unità.
-- Ad esempio le tipologie di unità "ground" definite qui verranno bersagliate dai gruppi tipo "ground" e "air_toground" definiti nel punto 2 del gadget. 
-- Questa logica di "chi attacca cosa" è definita poi nel punto 4) "LOGICA DI TARGETING BASATA SU DATABASE" del gadget
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
--			type = strategicshield		-> unità fissa shield (plasma repulsor) -- viene utilizzata: a) nel gadget "longWeaponManagement" per identificare i plasma repulsor ed evitare di colpire bersagli all'interno dello scudo con l'artiglieria a lungo raggio; b) nel gadget "wmrts_AI_militaryMenagement.lua" come target obiettivo delle unità attaccanti
--			tutte le unità che non sono identificate in questo database, prenderanno valore type = unknown , vedere poi la logica di targetin come gestirle
-- definizione della caratteristica "ignore": può essere true o false (se non dichiarata). Se True, l'unità ad esso associata verrà completamente ignorata dal gadget "military_factory": quando creata dalla fabbrica, quell'unità non viene inclusa in alcun gruppo e non viene mandata all'attacco. Sarà un altro Gadget a gestire l'unità (come ad esempio i costruttori) oppure le unità saranno gestite dal mission editor
-- definizione della caratteristica "isLRA = true": se true, il gadget "wmrts_AI_longWeaponManagement.lua" vede l'unità come cannone Long Range Artillery
-- definizione della caratteristica "isSILO = true": se true, il gadget "wmrts_AI_longWeaponManagement.lua" vede l'unità come silos di missili nucleari
-- definizione della caratteristica "isAMD = true": se true, il gadget "wmrts_AI_longWeaponManagement.lua" vede l'unità come silos di difesa da missili nucleari
-- definizione della caratteristica "range = xxx": la gettata delle armi (definita nello weaponDef - range). Ho difficoltà a reperire direttamente questa informazione, pertanto per ora la scrivo manualmente
-- definizione della caratteristica "shieldRange = xxx": rappresenta il diametro dello scudo di un "strategicshield"(scudo al plasma, es: armgate). Questa variabile viene usata nel "wmrts_AI_longWeaponManagement.lua" per capire se un target di un (LRA, es un bertha) è dentro/protetto da uno scudo, nel caso scarterà il target dalla lista.

-- 09/02/2026 = Aggiunte categorie defence e strategicdefence. Molix
-- 20/02/2026 = Aggiunte definizioni isLRA, isSILO, isAMD per il gadget "wmrts_AI_longWeaponManagement.lua". Molix
-- 20/02/2026 = Aggiunto type "strategicshield"

local UNIT_DB = {
	--------------------------------------------------------------------------------
	-- ICU
	--------------------------------------------------------------------------------	
-- Commander
["icucom"] = { type = "ground", ignore = true },

-- Costruzioni Tier 1
["armsolar"] = { type = "building" },
["icuadvsol"] = { type = "building" },
["icuwind"] = { type = "building" },
["armmstor"] = { type = "building" },
["armgeo"] = { type = "building" },
["icuestor"] = { type = "building" },
["icumetex"] = { type = "building" },
["armamex"] = { type = "building" },
["armmakr"] = { type = "building" },
["armeyes"] = { type = "building" },
["armrad"] = { type = "building" },
["armsonar"] = { type = "navalbuilding" },
["armdrag"] = { type = "building" },
["iculighlturr"] = { type = "building" },
["armhlt"] = { type = "defence" },
["tawf001"] = { type = "defence" },
["armguard"] = { type = "defence" },
["armrl"] = { type = "building" },
["packo"] = { type = "building" },
["armjamt"] = { type = "building" },
["armtl"] = { type = "navalbuilding" },
["armfrad"] = { type = "navalbuilding" },
["armfrl"] = { type = "navalbuilding" }, 		-- ### creare floating defence????
["armfllt"] = { type = "navalbuilding" },		-- ### creare floating defence????
["armfhlt"] = { type = "navalbuilding" },		-- ### creare floating defence????
["armfhllt"] = { type = "navalbuilding" },		-- ### creare floating defence????
["armfguard"] = { type = "navalbuilding" },		-- ### creare floating defence????
["fpacko"] = { type = "navalbuilding" },		-- ### creare floating defence????

-- Costruzioni Tier 2 e +
["aafus"] = { type = "strategicbuilding" },
["armfus"] = { type = "strategicbuilding" },
["amgeo"] = { type = "strategicbuilding" },
["armgmm"] = { type = "strategicbuilding" },
["armmoho"] = { type = "strategicbuilding" },
["armmmkr"] = { type = "strategicbuilding" },
["armuwadves"] = { type = "building" },
["armuwadvms"] = { type = "building" },
["armarad"] = { type = "building" },
["armveil"] = { type = "building" },
["armfort"] = { type = "building" },
["armasp"] = { type = "building" },
["armtarg"] = { type = "building" },
["armsd"] = { type = "building" },
["armgate"] = { type = "strategicshield", shieldRange = 300 },
["armamb"] = { type = "strategicdefence" },
["armpb"] = { type = "defence" },
["armanni"] = { type = "strategicdefence" },
["armflak"] = { type = "building" },
["mercury"] = { type = "building" },
["armamd"] = { type = "strategicbuilding", isAMD = true },
["armsilo"] = { type = "strategicbuilding", isSILO = true, range = 72000 },
["armbrtha"] = { type = "strategicdefence", isLRA = true, range = 6100 },
["armvulc"] = { type = "strategicdefence", isLRA = true, range = 5600 },
["advmoho"] = { type = "strategicbuilding" },
["armfarad"] = { type = "navalbuilding" },
["armfamb"] = { type = "navalbuilding" },		-- ### creare floating defence????
["armfanni"] = { type = "navalbuilding" },		-- ### creare floating defence????
["armfflak"] = { type = "navalbuilding" },		-- ### creare floating defence????
["armfmercury"] = { type = "navalbuilding" },	-- ### creare floating defence????

-- fabbriche Tier 1
["armlab"] = { type = "building" },
["armvp"] = { type = "building" },
["armap"] = { type = "building" },
["armsy"] = { type = "navalbuilding" },

-- fabbriche Tier 2 e +
["armavp"] = { type = "building" }, 
["armalab"] = { type = "building" },
["armaap"] = { type = "building" },
["armasy"] = { type = "navalbuilding" },
["armshltx"] = { type = "strategicbuilding" },
["icugant"] = { type = "strategicbuilding" },
["icufff"] = { type = "strategicbuilding" },

-- Unità prodotte da armlab (Kbot)
["icuck"] = { type = "ground", ignore = true },
["icupatroller"] = { type = "ground" },
["icurock"] = { type = "ground" },
["icuinv"] = { type = "ground" },
["armjeth"] = { type = "ground" },
["icuwar"] = { type = "ground" },

-- Unità prodotte da armvp (Veicoli)
["armcv"] = { type = "ground", ignore = true },
["armfav"] = { type = "ground" },
["icuflash"] = { type = "ground" },
["armpincer"] = { type = "ground" },
["armstump"] = { type = "ground" },
["tawf013"] = { type = "ground" },
["icujanus"] = { type = "ground" },
["armsam"] = { type = "ground" },

-- Unità prodotte da armap (Aerei)
["armca"] = { type = "air", ignore = true },
["armpeep"] = { type = "air" },
["armfig"] = { type = "air" },
["armthund"] = { type = "air" },
["armatlas"] = { type = "air" },
["armkam"] = { type = "air" },

-- Unità prodotte da armsy (Navi)
["armcs"] = { type = "naval", ignore = true },
["armsub"] = { type = "naval" }, -- ############################ sistemare categorizzazione e gestire sub
["armpt"] = { type = "naval" }, 
["decade"] = { type = "naval" },
["armroy"] = { type = "naval" },

-- Unità prodotte da armalab
["armack"] = { type = "ground", ignore = true  },
["armfast"] = { type = "ground" },
["armzeus"] = { type = "ground" },
["armmav"] = { type = "ground" },
["armsptk"] = { type = "ground" },
["armfido"] = { type = "ground" },
["armsnipe"] = { type = "ground" },
["icufboy"] = { type = "ground" },
["armaak"] = { type = "ground" },
["icudecom"] = { type = "ground" },
["armmark"] = { type = "ground" },
["armscab"] = { type = "ground" },

-- Unità prodotte da armavp
["armacv"] = { type = "ground", ignore = true  },
["armcroc"] = { type = "ground" },
["armlatnk"] = { type = "ground" },
["icubull"] = { type = "ground" },
["armst"] = { type = "ground" },
["armmart"] = { type = "ground" },
["armmerl"] = { type = "ground" },
["armmanni"] = { type = "ground" },
["armyork"] = { type = "ground" },
["icuseer"] = { type = "ground" },
["armjam"] = { type = "ground" },
["armcamp"] = { type = "ground" },

-- Unità prodotte da armaap
["armaca"] = { type = "air", ignore = true  },
["armbrawl"] = { type = "air" },
["armpnix"] = { type = "air" },
["armlance"] = { type = "air" },
["armhawk"] = { type = "air" },
["armawac"] = { type = "air" },
["armdfly"] = { type = "air" },
["blade"] = { type = "air" },
["armcybr"] = { type = "air" },

-- Unità prodotte da armasy
["armacsub"] = { type = "naval", ignore = true  }, 	-- ############################ sistemare categorizzazione e gestire sub
["armsubk"] = { type = "naval" },					-- ############################ sistemare categorizzazione e gestire sub
["armaas"] = { type = "naval" },
["armcrus"] = { type = "naval" },
["armbats"] = { type = "naval" },
["armmship"] = { type = "naval" },
["aseadragon"] = { type = "naval" },
["armcarry"] = { type = "naval" },

-- Unità prodotte da armshltx
["icuraz"] = { type = "ground" },
["warhammer"] = { type = "ground" },
["icufurie"] = { type = "ground" },

-- Unità prodotte da icugant
["armtigre"] = { type = "ground" },
["armshock"] = { type = "ground" },

-- Unità prodotte da icufff
["cirr"] = { type = "air" },
["orcl"] = { type = "air" },
["demr"] = { type = "air" },

	--------------------------------------------------------------------------------
	-- NFA
	--------------------------------------------------------------------------------
-- Commander
["nfacom"] = { type = "ground", ignore = true  },	

-- Costruzioni Tier 1
["corsolar"] = { type = "building" },
["coradvsol"] = { type = "building" },
["cornanotc"] = { type = "building" },
["corwin"] = { type = "building" },
["corgeo"] = { type = "building" },
["corjamt"] = { type = "building" }, 
["cormstor"] = { type = "building" },
["corestor"] = { type = "building" },
["cormex"] = { type = "building" },
["corexp"] = { type = "building" },
["cormakr"] = { type = "building" },
["coreyes"] = { type = "building" },
["corrad"] = { type = "building" },
["corsonar"] = { type = "navalbuilding" },
["cordrag"] = { type = "building" },
["corllt"] = { type = "building" },
["hllt"] = { type = "building" },
["corhlt"] = { type = "defence" },
["cormaw"] = { type = "defence" },
["corpun"] = { type = "defence" },
["cortl"] = { type = "building" },
["madsam"] = { type = "building" },
["corrl"] = { type = "building" },
["corfrad"] = { type = "navalbuilding" },	
["corfhlt"] = { type = "navalbuilding" },		-- ### creare floating defence????
["corfpun"] = { type = "navalbuilding" },		-- ### creare floating defence????
["fmadsam"] = { type = "navalbuilding" },		-- ### creare floating defence????
["corfrad"] = { type = "navalbuilding" },		-- ### creare floating defence????
["corfrl"] = { type = "navalbuilding" },		-- ### creare floating defence????
["corfllt"] = { type = "navalbuilding" },		-- ### creare floating defence????

-- Costruzioni Tier 2 e +
["corfus"] = { type = "strategicbuilding" },
["cafus"] = { type = "strategicbuilding" },
["cmgeo"] = { type = "strategicbuilding" },
["corbhmth"] = { type = "strategicdefence" },
["cormoho"] = { type = "strategicdefence" },
["cormexp"] = { type = "strategicdefence" },
["cormmkr"] = { type = "building" },
["coruwadves"] = { type = "building" },
["coruwadvms"] = { type = "building" },
["corarad"] = { type = "building" },
["corshroud"] = { type = "building" },
["corfort"] = { type = "building" },
["corasp"] = { type = "building" },
["cortarg"] = { type = "building" },
["corsd"] = { type = "building" },
["corgate"] = { type = "strategicshield",shieldRange = 300 },			
["cortoast"] = { type = "strategicdefence" },
["corvipe"] = { type = "building" },
["cordoom"] = { type = "strategicdefence" },
["corflak"] = { type = "building" },
["screamer"] = { type = "building" },
["corfmd"] = { type = "strategicbuilding", isAMD = true },
["corsilo"] = { type = "strategicbuilding", isSILO = true, range = 72000 },
["corint"] = { type = "strategicdefence", isLRA = true, range = 6500 },
["corbuzz"] = { type = "strategicdefence",isLRA = true, range = 6000 },
["corvp"] = { type = "building" },
["coravp"] = { type = "building" },
["corfarad"] = { type = "navalbuilding" },
["corftoast"] = { type = "navalbuilding" },		-- ### creare floating defence????
["corfvipe"] = { type = "navalbuilding" },		-- ### creare floating defence????
["corfdoom"] = { type = "navalbuilding" },		-- ### creare floating defence????
["corfflak"] = { type = "navalbuilding" },		-- ### creare floating defence????
["corfscreamer"] = { type = "navalbuilding" },	-- ### creare floating defence????

-- Fabbriche Tier 1
["corlab"] = { type = "building" },
["corvp"] = { type = "building" },
["corap"] = { type = "building" },
["corsy"] = { type = "navalbuilding" },

-- Fabbriche Tier 2
["coralab"] = { type = "building" },
["coravp"] = { type = "building" },
["coraap"] = { type = "building" },
["corasy"] = { type = "navalbuilding" },
["corgant"] = { type = "strategicbuilding" },
["nfafff"] = { type = "strategicbuilding" },

-- Unità prodotte da corlab
["corck"] = { type = "ground", ignore = true  },
["nfaak"] = { type = "ground" },
["nfastorm"] = { type = "ground" },
["nfathud"] = { type = "ground" },
["corcrash"] = { type = "ground" },

-- Unità prodotte da corvp
["corcv"] = { type = "ground", ignore = true  },
["nfafav"] = { type = "ground" },
["nfagator"] = { type = "ground" },
["nfagarp"] = { type = "ground" },
["nfaraid"] = { type = "ground" },
["nfalevlr"] = { type = "ground" },
["corwolv"] = { type = "ground" },
["cormist"] = { type = "ground" },

-- Unità prodotte da corap
["corca"] = { type = "air", ignore = true  },
["corfink"] = { type = "air" },
["corveng"] = { type = "air" },
["corshad"] = { type = "air" },
["corvalk"] = { type = "air" },
["bladew"] = { type = "air" },

-- Unità prodotte da corsy
["corcs"] = { type = "naval", ignore = true  },
["corsub"] = { type = "naval" },	  -- ############################ sistemare categorizzazione e gestire sub
["corpt"] = { type = "naval" },
["coresupp"] = { type = "naval" },
["corroy"] = { type = "naval" },

-- Unità prodotte da coralab
["corack"] = { type = "ground", ignore = true  },
["nfapyro"] = { type = "ground" },
["corcan"] = { type = "ground" },
["corsumo"] = { type = "ground" },
["cormort"] = { type = "ground" },
["corhrk"] = { type = "ground" },
["coraak"] = { type = "ground" },
["corvoyr"] = { type = "ground" },
["corspy"] = { type = "ground" },
["corspec"] = { type = "ground" },

-- Unità prodotte da coravp
["coracv"] = { type = "ground", ignore = true  },
["corseal"] = { type = "ground" },
["nfareap"] = { type = "ground" },
["corparrow"] = { type = "ground" },
["nfagol"] = { type = "ground" },
["tawf114"] = { type = "ground" },
["cormart"] = { type = "ground" },
["corvroc"] = { type = "ground" },
["corsent"] = { type = "ground" },
["cormabm"] = { type = "strategicbuilding" },
["coreter"] = { type = "ground" },
["nfavrad"] = { type = "ground" },

-- Unità prodotte da coraap
["coraca"] = { type = "air", ignore = true  },
["corape"] = { type = "air" },
["corhurc"] = { type = "air" },
["cortitan"] = { type = "air" },
["corvamp"] = { type = "air" },
["corawac"] = { type = "air" },
["corcrw"] = { type = "air" },

-- Unità prodotte da corasy
["coracsub"] = { type = "naval", ignore = true  },		-- ############################ sistemare categorizzazione e gestire sub 
["corshark"] = { type = "naval" },		-- ############################ sistemare categorizzazione e gestire sub 
["corssub"] = { type = "naval" },		-- ############################ sistemare categorizzazione e gestire sub 
["corarch"] = { type = "naval" },
["corcrus"] = { type = "naval" },
["corbats"] = { type = "naval" },
["corblackhy"] = { type = "naval" },
["corcarry"] = { type = "naval" },
["corsjam"] = { type = "naval" },

-- Unità prodotte da corgant
["nfakarg"] = { type = "ground" },
["nfacoug"] = { type = "ground" },
["corkrog"] = { type = "ground" },
["armraven"] = { type = "ground" },
["gorg"] = { type = "ground" },

-- Unità prodotte da nfafff
["taln"] = { type = "air" },
["odyc"] = { type = "air" },
["ostr"] = { type = "air" },	

	--------------------------------------------------------------------------------
	-- AND
	--------------------------------------------------------------------------------
-- Commander
["andcom"] = { type = "ground", ignore = true  },	
	
-- Costruzioni Tier 1
["andsolar"] = { type = "building" },
["andwind"] = { type = "building" },
["andmstor"] = { type = "building" },
["andestor"] = { type = "building" },
["andmexun"] = { type = "building" },
["andmex"] = { type = "building" },
["andrad"] = { type = "building" }, 
["andlartic"] = { type = "building" },
["andartic"] = { type = "building" },
["andhartic"] = { type = "defence" },
["andpopaa"] = { type = "building" },

-- Costruzioni Tier 2
["andfus"] = { type = "strategicbuilding" },
["andaafus"] = { type = "strategicbuilding" },
["andametex"] = { type = "building" },
["andaestor"] = { type = "building" },
["andarad"] = { type = "building" },
["andshield"] = { type = "strategicshield", shieldRange = 300 },
["anddfens"] = { type = "strategicdefence" },
["andill"] = { type = "strategicdefence" },
["andchaos"] = { type = "strategicdefence" },
["andernie"] = { type = "building" },
["chemist"] = { type = "building" },
["andlaunch"] = { type = "strategicbuilding",  isLRA = true, range = 65000 }, -- non è un cannone ma è un arma energetica a lungo raggio
["andangel"] = { type = "strategicdefence", isLRA = true },
["medusa"] = { type = "building" },

-- Fabbriche Tier 1
["andlab"] = { type = "building" },
["andhp"] = { type = "building" },
["andplat"] = { type = "building" },
["andinc"] = { type = "building" }, 

-- Fabbriche Tier 2 e +
["andalab"] = { type = "building" },
["andahp"] = { type = "building" },
["andaplat"] = { type = "building" },
["andainc"] = { type = "building" },
["andgant"] = { type = "strategicbuilding" },

-- Unità prodotte da andlab 
["andcsp"] = { type = "ground", ignore = true  },
["andscouter"] = { type = "ground" },
["anddauber"] = { type = "ground" },
["andbrskr"] = { type = "ground" },
["andspmis"] = { type = "ground" },
["andspaa"] = { type = "ground" },

-- Unità prodotte da andhp
["andch"] = { type = "hovercraft", ignore = true  },
["andgaso"] = { type = "hovercraft" },
["andlipo"] = { type = "hovercraft" },
["andmisa"] = { type = "hovercraft" },
["andhart"] = { type = "hovercraft" },

-- Unità prodotte da andplat
["andca"] = { type = "air", ignore = true  },
["andfig"] = { type = "air" },
["andbomb"] = { type = "air" },
["andstr"] = { type = "air" },
["andmer"] = { type = "air" },

-- Unità prodotte da andinc
-- sono le stesse di andlab + andhp

-- Unità prodotte da andalab 
["andacsp"] = { type = "ground", ignore = true  },
["walker"] = { type = "ground" },
["andogre"] = { type = "ground" },
["exxec"] = { type = "ground" },
["interceptor"] = { type = "ground" },

-- Unità prodotte da andahp
["andach"] = { type = "hovercraft", ignore = true  },
["androck"] = { type = "hovercraft" },
["andtanko"] = { type = "hovercraft" },
["andtesla"] = { type = "hovercraft" },
["andnikola"] = { type = "hovercraft" },
["andahaa"] = { type = "hovercraft" },
 
-- Unità prodotte da andaplat
["andstr"] = { type = "air" },
["anddragon"] = { type = "air" },
["corhors"] = { type = "air" },
["andhawk"] = { type = "air" },

-- Unità prodotte da andgant
["cordem"] = { type = "ground" },
["conartist"] = { type = "ground" },
["bigb"] = { type = "ground" },
["ebigb"] = { type = "ground" },
["kill2"] = { type = "ground" },
["armpraet"] = { type = "ground" },

-- Unità prodotte da andainc
-- sono le stesse prodotte da andalab + andahp

	--------------------------------------------------------------------------------
	-- EUF
	--------------------------------------------------------------------------------
-- Commander
-- da definire ###################################################################################

-- Costruzioni Tier 1
["eufsolar"] = { type = "building" },
["eufmstor"] = { type = "building" },
["eufestor"] = { type = "building" },
["eufmetex"] = { type = "building" },
["eufametex"] = { type = "building" },
["euf_radar"] = { type = "building" },
["eufpathsmall"] = { type = "building" },
["eufsnpr"] = { type = "building" },
["eufpath"] = { type = "building" },
["armarch"] = { type = "building" },
["eufloony"] = { type = "building" },
["euf_fence_gate"] = { type = "building" },
["euf_fence_wall"] = { type = "building" },

-- Costruzioni Tier 2
["eufadvmetex"] = { type = "building" },

-- Fabbriche Tier 1
["eufvp"] = { type = "building" },
["eufap"] = { type = "building" },
["eufblab"] = { type = "building" },

-- Fabbriche Tier 2
["eufavp"] = { type = "building" },

-- Unità prodotte da eufvp
["eufcd"] = { type = "ground", ignore = true  },
["eufthorn"] = { type = "ground" },
["eufsab"] = { type = "ground" },

-- Unità prodotte da eufap
["euffig"] = { type = "air" },

-- Unità prodotte da eufblab -- ########################## implementare
["armmedic"] = { type = "ground", ignore = true  },

-- Unità prodotte da eufavp
["eufacd"] = { type = "ground", ignore = true  },
["eufbomb"] = { type = "ground" },
["eufher"] = { type = "ground" },
["euflong"] = { type = "ground" },
["eufopp"] = { type = "ground" },
["eufrld"] = { type = "ground" },
["eufshat"] = { type = "ground" },
["eufbigfoot"] = { type = "ground" },
["eufkaat"] = { type = "ground" },
["eufpilonax"] = { type = "ground" },


}

return UNIT_DB