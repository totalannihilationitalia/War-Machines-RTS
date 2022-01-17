-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corsub = {
               acceleration = 0.03,
               activatewhenbuilt = true,
--               badTargetCategory = HOVER NOTSHIP,
               brakerate  = 0.25,
               buildcostenergy = 3902,
               buildcostmetal = 679,
               builder = false,
               buildpic = "nfasub.png",
               buildtime  = 9729,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL UNDERWATER MOBILE WEAPON NOTLAND NOTAIR",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corsub_dead",
--               defaultmissiontype = Standby,
               description = "Submarine",
--               firestandorders = 1,
               energymake = 0.4,
               energystorage = 0,
               energyUse = 0.4,
               explodeas = "SMALL_UNITEX",
               footprintx = 4,
               footprintz = 4,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 835,
               maxvelocity = 2.7,
               metalStorage = 0,
               minWaterDepth= 20,
--               mobilestandorders= 1,
               movementclass = "UBOAT3",
               name = "Snake",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfasub.s3o",
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 364,
               sonardistance = 450,
--               soundcategory= "CORE_SUB",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 246,
               upright = true,
               waterline = 15,
               workertime = 0,
               wpri_badtargetcategory = "HOVER NOTSHIP",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
				blocking = false,
				category = "corpses",
				collisionvolumeoffsets = "2.76780700684 0.0 -0.0",
				collisionvolumescales = "24.2856140137 12.625 49.0312194824",
				collisionvolumetype = "Box",
				damage = 501,
				description = "Snake Wreckage",
				energy = 0,
				featuredead = "corsub_heap",
				footprintx = 3,
				footprintz = 3,
				height = 4,
				hitdensity = 100,
				metal = 353,
				object = "CORSUB_DEAD",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
               },  -- Close Dead Features
  heap = {
				blocking = false,
				category = "heaps",
				damage = 2016,
				description = "Snake Heap",
				energy = 0,
				footprintx = 2,
				footprintz = 2,
				height = 4,
				hitdensity = 100,
				metal = 150,
				object = "4X4B",
                                collisionvolumescales = "85.0 14.0 6.0",
                                collisionvolumetype = "cylY",
				reclaimable = true,
				resurrectable = 0,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
		                collisionvolumescales = "85.0 14.0 6.0",
		                collisionvolumetype = "cylY",
			},
},  --  Wreckage and heaps
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
                     [1] = "sucormov",
                    },
               select = {
                     [1] = "sucorsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		arm_torpedo = {
                     areaofeffect = 16,
                     avoidfeature = true,
--                     burnblow = true,
--                     cegTag = "",
                     collidefriendly = false,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH2",
                     flighttime = 2.3,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "torpedo",
                     name= "Torpedo",
                     noselfdamage = true,
                     range = 500,
                     reloadtime = 2.5,
                     soundhit = "xplodep1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "torpedo1",
                     startvelocity = 100,
                     tolerance = 32767,
                     turnrate = 8000,
                     turret  = false, 
                     waterweapon = true, 
                     weaponacceleration = 15,
                     weapontimer = 3,
                     weapontype = "TorpedoLauncher",
                     weaponvelocity  = 160,
                     damage = {
                         default = 600,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "HOVER NOTSHIP",
                 def = "arm_torpedo",
--               onlytargetcategory = " ",
                 maxAngleDif = 90,
                 maindir = "0 0 1",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
