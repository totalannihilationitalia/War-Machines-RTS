-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andafig= {
               acceleration = 2.5,
               brakerate  = 7.5,
               buildcostenergy = 4300,
               buildcostmetal = 130,
               buildpic = "andafig.png",
               buildtime  = 6800,
               canAttack = true,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL MOBILE WEAPON ANTIGATOR NOTSUB ANTIFLAME ANTIEMG ANTILASER NOTLAND VTOL NOTSHIP",
               collide = false,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 110,
--               defaultmissiontype = VTOL_standby,
               description = "Air Fighter",
--               firestandorders = 1,
               energymake = 0.7,
               energystorage = 0,
               energyUse = 0.7,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "air",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 1280,
--               mass = 0 --definire massa,
               maxdamage = 300,
               maxslope = 10,
               maxvelocity = 9.64,
               maxwaterdepth = 255,
               metalStorage = 0,
--               mobilestandorders= 1,
               name = "Advance Fighter",
               noAutoFire = false,
               objectname = "andfight.s3o",
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 700,
--               soundcategory= "ARM_VTOL",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "VTOL", -- verificare se necessario
               turnrate = 891,
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
-----------------------------------------------------------
--- WEAPONS
-----------------------------------------------------------
weapondefs = {
			armvtol_missile_a2a = {
				areaofeffect = 55,
				avoidfeature = false,
				burst = 3, 
				burstrate = 0.25, 
				collidefriendly = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				explosiongenerator = "custom:FLASH2",
				firestarter = 0,
				impulseboost = 0,
				impulsefactor = 0,
				metalpershot = 0,
				model = "missile",
				name = "GuidedMissiles",
				noselfdamage = true,
				range = 700,
				reloadtime = 0.9,
				smoketrail = true,
				soundhit = "xplosml2",
				soundhitwet = "splshbig",
				soundhitwetvolume = 0.5,
				soundstart = "Rocklit3",
				startvelocity = 700, --625
				texture2 = "armsmoketrail",
				tolerance = 12000,
				tracks = true,
				turnrate = 24000,
				weaponacceleration = 150,
				weapontimer = 4.25,
				weapontype = "MissileLauncher",
				weaponvelocity = 775,
				damage = {
					bombers = 125,
					commanders = 5,
					default = 23,
					fighters = 200,
					subs = 5,
					vtol = 125,
				},
			},
		},


	   	       weapons = {
                 [1] = {
                 def = "ARMVTOL_MISSILE_A2A",
			  onlytargetcategory = "VTOL SURFACE",
                 },
               },
               }, 
               }
