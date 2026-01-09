-- units database for WMRTS mission AI, by molix
-- 09/01/2025

--------------------------------------------------------------------------------
-- 1) DATABASE UNITÀ caricato da wmrts_missionAI.lua
--------------------------------------------------------------------------------
-- Qui puoi aggiungere campi extra in futuro (es. priority, armor_type, ecc.)
-- La tipologia di ogni singola unità è necessaria affinchè la AI gestisca le squadre/gruppi (punto 2) contro le singole unità.
-- Ad esempio le tipologie "ground" definite qui verranno bersagliate dai gruppi tipo "ground" e "air_toground" definiti nel punto 2. 
-- Questa logica di "chi attacca cosa" è definita poi nel punto "4) LOGICA DI TARGETING BASATA SU DATABASE"
-- definizione delle tipologie:
--			type = ground 				-> unità mobile di terra (veicoli e Kbot)
--			type = air 					-> unità mobile aerea
--			type = hovercraft 			-> unità mobile di terra che può andare sul mare
--			type = naval 				-> unità mobile navale (di superficie, no SUB)
--			type = building 			-> unità fissa di superficie su terra (di difesa/produzione/energia)
--			type = navalbuilding 		-> unità fissa di superficie su mare (di difesa/produzione/energia)
--			type = strategicbuilding 	-> unità fissa di superficie strategica ( Es factory 3 livello, silos, antipalline )



local UNIT_DB = {
	--------------------
	-- ICU
	--------------------	
["icucom"]          = { type = "ground" },
-- Costruzioni Tier 1
["armsolar"] = { type = "building" },
["icuwind"] = { type = "building" },
["armmstor"] = { type = "building" },
["icuestor"] = { type = "building" },
["icumetex"] = { type = "building" },
["armmakr"] = { type = "building" },
["armlab"] = { type = "building" },
["armvp"] = { type = "building" },
["armap"] = { type = "building" },
["armsy"] = { type = "navalbuilding" },
["armeyes"] = { type = "building" },
["armrad"] = { type = "building" },
["armsonar"] = { type = "navalbuilding" },
["armdrag"] = { type = "building" },
["iculighlturr"] = { type = "building" },
["armtl"] = { type = "navalbuilding" },
["armrl"] = { type = "building" },
["armfrad"] = { type = "navalbuilding" },
["armfrl"] = { type = "navalbuilding" },
["armfllt"] = { type = "navalbuilding" },

-- Costruzioni Tier 2
["aafus"] = { type = "building" },
["armfus"] = { type = "building" },
["amgeo"] = { type = "building" },
["armgmm"] = { type = "building" },
["armmoho"] = { type = "building" },
["armmmkr"] = { type = "building" },
["armuwadves"] = { type = "building" },
["armuwadvms"] = { type = "building" },
["armarad"] = { type = "building" },
["armveil"] = { type = "building" },
["armfort"] = { type = "building" },
["armasp"] = { type = "building" },
["armtarg"] = { type = "building" },
["armsd"] = { type = "building" },
["armgate"] = { type = "building" },
["armamb"] = { type = "building" },
["armpb"] = { type = "building" },
["armanni"] = { type = "building" },
["armflak"] = { type = "building" },
["mercury"] = { type = "building" },
["armamd"] = { type = "building" },
["armsilo"] = { type = "building" },
["armbrtha"] = { type = "building" },
["armvulc"] = { type = "building" },
["advmoho"] = { type = "building" },
["armfarad"] = { type = "navalbuilding" },
["armfamb"] = { type = "navalbuilding" },
["armfanni"] = { type = "navalbuilding" },
["armfflak"] = { type = "navalbuilding" },
["armfmercury"] = { type = "navalbuilding" },

-- Unità prodotte da armlab (Kbot)
["icuck"] = { type = "ground" },
["icupatroller"] = { type = "ground" },
["icurock"] = { type = "ground" },
["icuinv"] = { type = "ground" },
["armjeth"] = { type = "ground" },
["icuwar"] = { type = "ground" },

-- Unità prodotte da armvp (Veicoli)
["armcv"] = { type = "ground" },
["armfav"] = { type = "ground" },
["icuflash"] = { type = "ground" },
["armpincer"] = { type = "ground" },
["armstump"] = { type = "ground" },
["tawf013"] = { type = "ground" },
["icujanus"] = { type = "ground" },
["armsam"] = { type = "ground" },

-- Unità prodotte da armap (Aerei)
["armca"] = { type = "air" },
["armpeep"] = { type = "air" },
["armfig"] = { type = "air" },
["armthund"] = { type = "air" },
["armatlas"] = { type = "air" },
["armkam"] = { type = "air" },

-- Unità prodotte da armsy (Navi)
["armcs"] = { type = "naval" },
["armsub"] = { type = "naval" }, -- ############################ sistemare categorizzazione e gestire sub
["armpt"] = { type = "naval" }, 
["decade"] = { type = "naval" },
["armroy"] = { type = "naval" },

-- Unità prodotte da armavp
["armavp"] = { type = "ground" }, 
["armacv"] = { type = "ground" },
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

-- Unità prodotte da armalab
["armalab"] = { type = "ground" },
["armack"] = { type = "ground" },
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

-- Unità prodotte da armshltx
["armshltx"] = { type = "ground" },
["icuraz"] = { type = "ground" },
["warhammer"] = { type = "ground" },
["icufurie"] = { type = "ground" },

-- Unità prodotte da icugant
["icugant"] = { type = "ground" },
["armtigre"] = { type = "ground" },
["armshock"] = { type = "ground" },

-- Unità prodotte da armasy
["armasy"] = { type = "navalbuilding" },
["armacsub"] = { type = "naval" }, 	-- ############################ sistemare categorizzazione e gestire sub
["armsubk"] = { type = "naval" },	-- ############################ sistemare categorizzazione e gestire sub
["armaas"] = { type = "naval" },
["armcrus"] = { type = "naval" },
["armbats"] = { type = "naval" },
["armmship"] = { type = "naval" },
["aseadragon"] = { type = "naval" },
["armcarry"] = { type = "naval" },

-- Unità prodotte da icufff
["icufff"] = { type = "ground" },
["cirr"] = { type = "air" },
["orcl"] = { type = "air" },
["demr"] = { type = "air" },

-- Unità prodotte da armaap
["armaap"] = { type = "ground" },
["armaca"] = { type = "air" },
["armbrawl"] = { type = "air" },
["armpnix"] = { type = "air" },
["armlance"] = { type = "air" },
["armhawk"] = { type = "air" },
["armawac"] = { type = "air" },
["armdfly"] = { type = "air" },
["blade"] = { type = "air" },
["armcybr"] = { type = "air" },


	--------------------
	-- NFA
	--------------------	
["nfacom"]          = { type = "ground" },	

-- Costruzioni dirette del Comandante e Tier 1
["corsolar"] = { type = "ground" },
["corwin"] = { type = "ground" },
["cormstor"] = { type = "ground" },
["corestor"] = { type = "ground" },
["cormex"] = { type = "ground" },
["cormakr"] = { type = "ground" },
["corlab"] = { type = "ground" },
["corvp"] = { type = "ground" },
["corap"] = { type = "ground" },
["corsy"] = { type = "ground" },
["coreyes"] = { type = "ground" },
["corrad"] = { type = "ground" },
["corsonar"] = { type = "ground" },
["cordrag"] = { type = "ground" },
["corllt"] = { type = "ground" },
["cortl"] = { type = "ground" },
["corrl"] = { type = "ground" },
["corfrad"] = { type = "ground" },
["corfrl"] = { type = "ground" },
["corfllt"] = { type = "ground" },

-- Unità prodotte da corlab
["corck"] = { type = "ground" },
["nfaak"] = { type = "ground" },
["nfastorm"] = { type = "ground" },
["nfathud"] = { type = "ground" },
["corcrash"] = { type = "ground" },

-- Unità prodotte da corvp
["corcv"] = { type = "ground" },
["nfafav"] = { type = "ground" },
["nfagator"] = { type = "ground" },
["nfagarp"] = { type = "ground" },
["nfaraid"] = { type = "ground" },
["nfalevlr"] = { type = "ground" },
["corwolv"] = { type = "ground" },
["cormist"] = { type = "ground" },

-- Unità prodotte da corap
["corca"] = { type = "ground" },
["corfink"] = { type = "ground" },
["corveng"] = { type = "ground" },
["corshad"] = { type = "ground" },
["corvalk"] = { type = "ground" },
["bladew"] = { type = "ground" },

-- Tier 2, Tier 3 e Navi Avanzate
["coralab"] = { type = "ground" },
["coravp"] = { type = "ground" },
["corgant"] = { type = "ground" },
["nfafff"] = { type = "ground" },
["corack"] = { type = "ground" },
["coracv"] = { type = "ground" },
["coraca"] = { type = "ground" },
["coracsub"] = { type = "ground" },
["nfakarg"] = { type = "ground" },
["nfacoug"] = { type = "ground" },
["corkrog"] = { type = "ground" },
["armraven"] = { type = "ground" },
["gorg"] = { type = "ground" },
["taln"] = { type = "ground" },
["odyc"] = { type = "ground" },
["ostr"] = { type = "ground" },	
	
	--------------------
	-- AND
	--------------------		
["andcom"] = { type = "ground" },	
	
-- Costruzioni dirette del Comandante
["andsolar"] = { type = "ground" },
["andwind"] = { type = "ground" },
["andmstor"] = { type = "ground" },
["andestor"] = { type = "ground" },
["andmexun"] = { type = "ground" },
["andlab"] = { type = "ground" },
["andhp"] = { type = "ground" },
["andplat"] = { type = "ground" },
["andrad"] = { type = "ground" },
["andlartic"] = { type = "ground" },

-- Unità prodotte da andlab (Livello 1)
["andcsp"] = { type = "ground" },
["andscouter"] = { type = "ground" },
["anddauber"] = { type = "ground" },
["andbrskr"] = { type = "ground" },

-- Unità prodotte da andhp (Hovercraft Livello 1)
["andch"] = { type = "ground" },
["andgaso"] = { type = "ground" },
["andlipo"] = { type = "ground" },
["andmisa"] = { type = "ground" },

-- Tier 2 e Fabbriche Avanzate (Incubator/Adv Hover)
["andainc"] = { type = "ground" },
["andahp"] = { type = "ground" },
["andacsp"] = { type = "ground" },
["andach"] = { type = "ground" },
["walker"] = { type = "ground" },
["andogre"] = { type = "ground" },
["exxec"] = { type = "ground" },
["andtanko"] = { type = "ground" },
["andtesla"] = { type = "ground" },
["androck"] = { type = "ground" },
["andnikola"] = { type = "ground" },	

	--------------------
	-- EUF
	--------------------
["eufcd"] = { type = "ground" },		

-- Costruzioni dirette del Construction Drone (Tier 1)
["eufsolar"] = { type = "ground" },
["eufmstor"] = { type = "ground" },
["eufestor"] = { type = "ground" },
["eufmetex"] = { type = "ground" },
["eufametex"] = { type = "ground" },
["eufvp"] = { type = "ground" },
["eufap"] = { type = "ground" },
["euf_radar"] = { type = "ground" },
["eufpathsmall"] = { type = "ground" },
["eufsnpr"] = { type = "ground" },
["eufpath"] = { type = "ground" },
["armarch"] = { type = "ground" },
["eufloony"] = { type = "ground" },
["eufblab"] = { type = "ground" },
["euf_fence_gate"] = { type = "ground" },
["euf_fence_wall"] = { type = "ground" },

-- Unità prodotte da eufvp (Tank Plant T1)
["eufthorn"] = { type = "ground" },
["eufsab"] = { type = "ground" },

-- Unità prodotte da eufavp (Advanced Vehicle Plant T2)
["eufacd"] = { type = "ground" },
["eufbomb"] = { type = "ground" },
["eufher"] = { type = "ground" },
["euflong"] = { type = "ground" },
["eufopp"] = { type = "ground" },
["eufrld"] = { type = "ground" },
["eufshat"] = { type = "ground" },
["eufbigfoot"] = { type = "ground" },
["eufkaat"] = { type = "ground" },
["eufpilonax"] = { type = "ground" },

-- Unità prodotte da eufap e eufblab
["euffig"] = { type = "ground" },
["armmedic"] = { type = "ground" },

}