-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  icupatroller= {
               acceleration = 0.36,
--               badTargetCategory = ANTIEMG,
               brakerate  = 0.2,
               buildcostenergy = 897,
               buildcostmetal = 45,
               builder = false,
               buildpic = "icupatroller.png",
               buildtime  = 1420,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "icupatroller_dead",
--               defaultmissiontype = Standby,
               description = "ICU Light Fantry Robot",
--               firestandorders = 1,
               energymake = 0.3,
               energystorage = 0,
               energyUse = 0.3,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 300,
               maxslope = 16,
               maxvelocity = 2.8,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Patroller",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icupatroller.s3o",
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 429,
--               soundcategory= "ARMPW",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 1056,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "ANTIEMG",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
		featuredefs = {
			dead = {
				blocking = false,
				category = "corpses",
				collisionvolumeoffsets = "0.979118347168 -0.453806965332 -0.796119689941",
				collisionvolumescales = "30.1392364502 7 29.797164917",
				collisionvolumetype = "Box",
				damage = 192,
				description = "Peewee Wreckage",
				energy = 0,
				featuredead = "icupatroller_heap",
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 40,
				hitdensity = 100,
				metal = 29,
				object = "ARMPW_DEAD",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
			heap = {
				blocking = false,
				category = "heaps",
				damage = 96,
				description = "Peewee Heap",
				energy = 0,
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 4,
				hitdensity = 100,
				metal = 12,
				object = "2X2F",
		               collisionvolumescales = "35.0 4.0 6.0",
		               collisionvolumetype = "cylY",
				reclaimable = true,
				resurrectable = 0,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
		},
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
                     [1] = "servtny2",
                    },
               select = {
                     [1] = "servtny2",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		emg = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     burst = 3, -- lua:salvoSize
                     burstrate = 0.1, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:EMG_HIT",
                     firestarter = 100,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     Intensity = 0.7,
                     name= "peewee",
                     noselfdamage = true,
                     range = 180,
                     reloadtime = 0.31,
                     rgbcolor = "1 0.95 0.4",
                     size = "1.75",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "flashemg",
                     sprayangle = 1180,
                     tolerance = 5000,
                     turret  = true, 
                     weapontimer = 0.1,
                     weapontype = "Cannon",
                     weaponvelocity  = 500,
                     damage = {
                         default = 11,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "emg",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
