-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  ARMFLYK= {
		acceleration = 0.0302,
--               badTargetCategory = VTOL,
               brakerate  = 0.585,
               buildcostenergy = 1000,
               buildcostmetal = 100,
               builder = false,
               buildpic = "",
               buildtime  = 333,
               canAttack = true,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
		category = "ALL MOBILE WEAPON NOTLAND ANTIGATOR VTOL ANTIFLAME ANTIEMG ANTILASER NOTSUB NOTSHIP",
               collide = false,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruisealt = 110,   -------------------------------------
--               defaultmissiontype = Standby,
               description = "Fly bomber",
--               firestandorders = 1,
               energymake = 0.4,
               energystorage = 0,
               energyUse = 0.4,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
		icontype = "air",
--               maneuverleashlength  = 1280,
--               mass = 0 --definire massa,
               maxdamage = 101,
               maxslope = 0,
               maxvelocity = 17,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               name = "Fly bomber",
--		kamikaze=true,
--		kamikazedistance=120,   ----------------------------
--	       hoverattack = true,
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "uflea_2.s3o",
               radardistance = 0,
--               scale = 1,
               selfdestructas = "fleammine3",
--		selfdestructcountdown = 5,
               sightdistance = 321,
--               soundcategory= "ARM_KBOT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "VTOL", -- verificare se necessario
		turninplaceanglelimit = 140,
		turninplacespeedlimit = 5.313,
		turnrate = 807,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               cant = {
                     [1] = "cantdo4",
                      },
               ok = {
                     [1] = "kbarmmov",
                    },
               select = {
                     [1] = "kbarmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
		weapondefs = {
			fleabomb = {
				accuracy = 500,
				areaofeffect = 188,
				avoidfeature = false,
				burst = 2,
				burstrate = 0.3,
				collidefriendly = false,
				commandfire = false,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				explosiongenerator = "custom:T1COREBOMB",
				gravityaffected = "true",
				impulseboost = 0.3,
				impulsefactor = 0.3,
				interceptedbyshieldtype = 16,
				model = "bomb",
				name = "Bombs",
				noselfdamage = true,
				range = 1280,
				reloadtime = 12,
				soundhitdry = "xplomed2",
				soundstart = "bombrel",
				sprayangle = 300,
				weapontype = "AircraftBomb",
				damage = {
					bomb_resistant = 50,
					bombers = 5,
					commanders = 75,
					default = 150,
					fighters = 5,
					flak_resistant = 5,
					unclassed_air = 5,
				},
			},
		},
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
		weapons = {
			[1] = {
				badtargetcategory = "VTOL",
				def = "fleabomb",
				onlytargetcategory = "SURFACE",
			},
--			[2] = {
--				def = "CRAWL_DETONATOR",
--				onlytargetcategory = "SURFACE",
--			},
		},  -- close weapon usage

}, -- close unit data 
} -- close total
