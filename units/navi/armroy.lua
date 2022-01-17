-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armroy= {
               acceleration = 0.054,
               activatewhenbuilt = true,
--               badTargetCategory = SHIP,
               brakerate  = 0.13,
--               buildangle = 16384,
               buildcostenergy = 5671,
               buildcostmetal = 987,
               builder = false,
               buildpic = "icuroy.png",
               buildtime  = 13391,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE WEAPON NOTSUB SHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armroy_dead",
--               defaultmissiontype = Standby,
               description = "Destroyer",
--               firestandorders = 1,
               energymake = 2,
               energystorage = 0,
               energyUse = 2,
               explodeas = "BIG_UNITEX",
               footprintx = 4,
               footprintz = 4,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 2575,
               maxvelocity = 3.34,
               metalStorage = 0,
               minWaterDepth= 12,
--               mobilestandorders= 1,
               movementclass = "BOAT4",
               name = "Crusader",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icuroy.s3o",
--               scale = 0.5,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 490,
               sonardistance = 400,
--               soundcategory= "ARM_SHIP",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 199,
               workertime = 0,
               wspe_badtargetcategory = "ANTILASER",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Crusader Wreckage",
               category = "corpses",
               object = "ARMROY_DEAD",
               featuredead = "armroy_heap",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 558,
               damage = 1545,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Crusader Heap",
               category = "heaps",
               object = "5X5B",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 234,
               damage = 2016,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:POPUPFLAREFAST",
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
		arm_roy = {
                     areaofeffect = 32,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH3",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HeavyCannon",
                     noselfdamage = true,
                     range = 700,
                     reloadtime = 1.4,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannon3",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 300,
                     damage = {
                         default = 160,
                     }, -- close damage
             }, --close single weapon definitions

		depthcharge = {
                     areaofeffect = 32,
                     avoidfeature = true,
--                     burnblow = true,
--                     cegTag = "",
                     collidefriendly = false,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.99,
                     explosiongenerator = "custom:FLASH2",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "DEPTHCHARGE",
                     name= "DepthCharge",
                     noselfdamage = true,
                     range = 400,
                     reloadtime = 2.5,
                     soundhit = "xplodep2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "torpedo1",
                     startvelocity = 100,
                     tolerance = 1000,
                     tracks = true, 
                     turnrate = 1700,
                     turret  = true, 
                     waterweapon = true, 
                     weaponacceleration = 15,
                     weapontimer = 3,
                     weapontype = "TorpedoLauncher",
                     weaponvelocity  = 100,
                     damage = {
                         default = 210,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "arm_roy",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 badtargetcategory = "NOTSUB",
                 def = "depthcharge",
--               onlytargetcategory = " ", -- weapon 2
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
