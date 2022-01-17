-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  decade= {
               acceleration = 0.084,
               activatewhenbuilt = true,
               brakerate  = 0.019,
--               buildangle = 16384,
               buildcostenergy = 2055,
               buildcostmetal = 378,
               builder = false,
               buildpic = "icudecade.png",
               buildtime  = 6525,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL WEAPON NOTSUB SHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "decade_dead",
--               defaultmissiontype = Standby,
               description = "Corvette",
--               firestandorders = 1,
               energymake = 1,
               energystorage = 0,
               energyUse = 1,
               explodeas = "BIG_UNITEX",
               footprintx = 4,
               footprintz = 4,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 1650,
               maxvelocity = 3.25,
               metalStorage = 0,
               minWaterDepth= 12,
--               mobilestandorders= 1,
               movementclass = "BOAT4",
               name = "Decade",
               noAutoFire = false,
               objectname = "icudecade.s3o",
--               scale = 0.5,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 429,
--               soundcategory= "ARM_SHIP",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 530,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:emgflare",
               }, -- close effects list
}, -- close section sfxtypes
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
                     [1] = "sharmmov",
                    },
               select = {
                     [1] = "sharmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
			corvette_emg_front = {
				areaofeffect = 8,
				avoidfeature = false,
				burst = 3,
				burstrate = 0.12,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				explosiongenerator = "custom:EMG_HIT",
				impulseboost = 0.123,
				impulsefactor = 0.123,
				intensity = 0.7,
				name = "flash",
				noselfdamage = true,
				range = 310,
				reloadtime = 0.37,
				rgbcolor = "1 0.95 0.4",
				size = 1.75,
				soundhitwet = "splshbig",
				soundhitwetvolume = 0.5,
				soundstart = "flashemg",
				sprayangle = 1250,
				tolerance = 5000,
				turret = true,
				weapontimer = 0.1,
				weapontype = "Cannon",
				weaponvelocity = 500,
				damage = {
					bombers = 3,
					default = 9,
					fighters = 3,
					subs = 1,
					vtol = 3,
				},
			},
			corvette_emg_rear = {
				areaofeffect = 8,
				avoidfeature = false,
				burst = 3,
				burstrate = 0.13,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				explosiongenerator = "custom:EMG_HIT",
				impulseboost = 0.123,
				impulsefactor = 0.123,
				intensity = 0.7,
				name = "flash",
				noselfdamage = true,
				range = 310,
				reloadtime = 0.4,
				rgbcolor = "1 0.95 0.4",
				size = 1.75,
				soundhitwet = "splshbig",
				soundhitwetvolume = 0.5,
				soundstart = "flashemg",
				sprayangle = 1250,
				tolerance = 5000,
				turret = true,
				weapontimer = 0.1,
				weapontype = "Cannon",
				weaponvelocity = 500,
				damage = {
					bombers = 3,
					default = 9,
					fighters = 3,
					subs = 1,
					vtol = 3,
				},
			},
}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "corvette_emg_front",
               onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 def = "corvette_emg_rear",
               onlytargetcategory = "SURFACE", -- weapon 2
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
