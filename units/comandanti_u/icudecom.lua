-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  icudecom= {
               acceleration = 0.18,
               activatewhenbuilt = true,
               autoheal = 5,
--               badTargetCategory = ANTILASER,
               brakerate  = 0.375,
               buildcostenergy = 12085,
               buildcostmetal = 705,
               builddistance = 120,
               builder = true,
               buildpic = "icucom.png",
               buildtime  = 26941,
               canAttack = true,
--               canDGun = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               cloakcost = 30,
               cloakcostmoving = 180,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
--               defaultmissiontype = Standby,
               description = "Decoy Commander",
--               firestandorders = 1,
               energymake = 15,
               energystorage = 50,
               explodeas = "DECOY_COMMANDER_BLAST",
               footprintx = 2,
               footprintz = 2,
               hidedamage = true,
               icontype = "icucommander",
               idleautoheal = 5,
               idletime = 1800,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 3000,
               maxslope = 20,
               maxvelocity = 1.25,
               maxwaterdepth = 35,
               metalmake = 0.5,
               metalStorage = 50,
               mincloakdistance = 50,
--               mobilestandorders= 1,
               movementclass = "AKBOT2",
               name = "ICU Commander",
               nochasecategory = "VTOL",
--               norestrict = "1",
               objectname = "ICUCOM.s3o",
               radardistance = 50,
               reclaimable = false,
               seismicsignature = 0,
               selfdestructas = "DECOY_COMMANDER_BLAST",
               showplayername = true,
               sightdistance = 377,
--               soundcategory= "COR_CKBOT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 0,
               TEDClass = "COMMANDER", -- verificare se necessario
               terraformspeed = 450,
               turnrate = 1133,
               upright = true,
               workertime = 150,
               wpri_badtargetcategory = "ANTILASER",
               wspe_badtargetcategory = "VTOL",
               buildoptions = { 
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               },



-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:Nano",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "nanlath2",
               capture = "capture2",
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
                     [1] = "kbcormov",
                    },
               repair = "repair2",
               select = {
                     [1] = "kbcorsel",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
			arm_disintegrator = {
				areaofeffect = 36,
				avoidfriendly = false,
				commandfire = true,
				craterboost = 0,
				cratermult = 0,
				energypershot = 500,
				explosiongenerator = "custom:DGUNTRACE",
				firestarter = 100,
				impulseboost = 0,
				impulsefactor = 0,
				name = "Disintegrator",
				noexplode = true,
				noselfdamage = true,
				range = 250,
				reloadtime = 1,
				soundhit = "xplomas2",
				soundstart = "disigun1",
				soundtrigger = true,
				tolerance = 10000,
				turret = true,
				weapontimer = 4.1999998092651,
				weapontype = "DGun",
				weaponvelocity = 300,
				damage = {
					default = 99999,
				},
			},
			armcomlaser = {
				areaofeffect = 12,
				avoidfeature = false,
				beamtime = 0.10000000149012,
				corethickness = 0.10000000149012,
				craterboost = 0,
				cratermult = 0,
				cylindertargetting = 1,
				edgeeffectiveness = 0.99000000953674,
				explosiongenerator = "custom:SMALL_AZURE_BURN",
				firestarter = 70,
				impactonly = 1,
				impulseboost = 0.12300000339746,
				impulsefactor = 0.12300000339746,
				laserflaresize = 7,
				name = "J7Laser",
				noselfdamage = true,
				range = 300,
				reloadtime = 0.40000000596046,
				rgbcolor = "0 0.5 1",
				soundhit = "lasrhit2",
				soundstart = "lasrfir1",
				soundtrigger = true,
				targetmoveerror = 0.050000000745058,
				thickness = 2,
				tolerance = 10000,
				turret = true,
				weapontype = "LaserCannon",
				weaponvelocity = 900,
				damage = {
					bombers = 180,
					default = 75,
					fighters = 110,
					subs = 5,
				},
			},
		},
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
		weapons = {
			[1] = {
				def = "ARMCOMLASER",
			},
			[3] = {
				def = "ARM_DISINTEGRATOR",
			},
				  } -- mancava una parentesi 03/10/2025

}, -- close weapon usage

}, -- close unit data 
} -- close total