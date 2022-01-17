-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armthund= {
               acceleration = 0.096,
--               badTargetCategory = MOBILE,
               brakerate  = 0.5,
               buildcostenergy = 4075,
               buildcostmetal = 145,
               builder = false,
               buildpic = "icuthund.png",
               buildtime  = 4778,
               canAttack = true,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL MOBILE WEAPON NOTLAND ANTIGATOR NOTSUB ANTIFLAME ANTIEMG ANTILASER VTOL NOTSHIP",
               collide = false,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 165,
--               defaultmissiontype = VTOL_standby,
               description = "Bomber",
--               firestandorders = 1,
               energymake = 1.1,
               energystorage = 0,
               energyUse = 1.1,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
               icontype = "air",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 1380,
--               mass = 0 --definire massa,
               maxdamage = 560,
               maxslope = 10,
               maxvelocity = 8.4,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               name = "Thunder",
               noAutoFire = true,
               nochasecategory = "MOBILE",
               objectname = "icuthund.s3o",
--               scale = 1,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 195,
--               soundcategory= "ARM_VTOL",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "VTOL", -- verificare se necessario
               turnrate = 829,
               workertime = 0,
               wpri_badtargetcategory = "MOBILE",
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
                     [1] = "vtolarmv",
                    },
               select = {
                     [1] = "vtolarac",
                        },
               underattack = "warning1",
               },
weapondefs = {
			armbomb = {
				accuracy = 500,
				areaofeffect = 144,
				avoidfeature = false,
				burst = 5,
				burstrate = 0.3,
				collidefriendly = false,
				commandfire = false,
				craterareaofeffect = 144,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.4,
				explosiongenerator = "custom:T1ARMBOMB",
				gravityaffected = "true",
				impulseboost = 0.5,
				impulsefactor = 0.5,
				model = "bomb",
				name = "Bombs",
				noselfdamage = true,
				range = 1280,
				reloadtime = 9,
				soundhit = "xplomed2",
				soundhitwet = "splsmed",
				soundhitwetvolume = 0.5,
				soundstart = "bombrel",
				sprayangle = 300,
				weapontype = "AircraftBomb",
				damage = {
					default = 140,
					subs = 5,
				},
			},
		},

-----------------------------------------------------------
--- WEAPONS
-----------------------------------------------------------
	   	       weapons = {
                 [1] = {
                 badtargetcategory = "MOBILE",
                 def = "ARMBOMB",
				onlytargetcategory = "SURFACE",
                 },
               },
               }, 
               }
