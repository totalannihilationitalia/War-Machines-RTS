-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armsub= {
               acceleration = 0.018,
               activatewhenbuilt = true,
--               badTargetCategory = HOVER NOTSHIP,
               brakerate  = 0.225,
               buildcostenergy = 3724,
               buildcostmetal = 651,
               builder = false,
               buildpic = "icusub.png",
               buildtime  = 9894,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "UNDERWATER ALL MOBILE WEAPON NOTLAND NOTAIR",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armsub_dead",
--               defaultmissiontype = Standby,
               description = "Submarine",
--               firestandorders = 1,
               energymake = 0.4,
               energystorage = 0,
               energyUse = 0.4,
               explodeas = "SMALL_UNITEX",
               footprintx = 3,
               footprintz = 3,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 835,
               maxvelocity = 2.77,
               metalStorage = 0,
               minWaterDepth= 20,
--               mobilestandorders= 1,
               movementclass = "UBOAT3",
               name = "Lurker",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icusub.s3o",
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 364,
               sonardistance = 450,
--               soundcategory= "ARM_SUB",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "WATER", -- verificare se necessario
               turnrate = 255,
               upright = true,
               waterline = 15,
               workertime = 0,
               wpri_badtargetcategory = "HOVER NOTSHIP",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Lurker Wreckage",
               category = "corpses",
               object = "ARMSUB_DEAD",
               featuredead = "armsub_heap",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 423,
               damage = 501,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Lurker Heap",
               category = "heaps",
               object = "3X3A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 251,
               damage = 2016,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
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
                     [1] = "suarmmov",
                    },
               select = {
                     [1] = "suarmsel",
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
                 maxAngleDif = 120,
                 maindir = "0 0 1",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
