-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  Order_drill= {
               acceleration = 0.666,
--               badTargetCategory = VTOL,
               brakerate  = 0.0,
               buildcostenergy = 31212,
               buildcostmetal = 1551,
               builder = false,
               buildpic = "Order_drill.jpg",
               buildtime  = 100000,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
--               defaultmissiontype = Standby,
               description = "Fire-Breathing WallBuster",
--               firestandorders = 1,
               energymake = 0.4,
               energystorage = 0,
               energyUse = 0.4,
               explodeas = "CRAWL_BLASTSML",
               footprintx = 5,
               footprintz = 5,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 13543,
               maxslope = 32,
               maxvelocity = 0.9555,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "kbot2",
               name = "Unknown Contraption",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "flea_5.s3o",
               radardistance = 0,
               selfdestructas = "CRAWL_BLASTSML",
               sightdistance = 663,
               sonardistance = 800,
--               soundcategory= "ARM_KBOT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 200,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:DirtBALLTRAIL",
               [2]="custom:DirtBALLTRAIL",
               [3]="custom:fireballboom",
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
		fire_drillweapon = {
                     accuracy = 4000,
                     areaofeffect = 96,
                     avoidfeature = true,
                     burst = 10, -- lua:salvoSize
                     burstrate = 0.1, -- lua: salvoDelay
                     cegTag = "FIREBALLTRAIL",
--                     craterareaofeffect =  ,
                     explosiongenerator = "custom:fireballboom",
                     firestarter = 100,
                     name= "Flame Thrower",
                     range = 400,
                     reloadtime = 6.0,
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Flamhvy1",
                     soundtrigger = "1",
                     sprayangle = 30000,
                     texture2 = "null",
                     tolerance = 8000,
                     turret  = true, 
                     weapontimer = 5,
                     weapontype = "Flame",
                     weaponvelocity  = 360,
                     damage = {
                         default = 44,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "fire_drillweapon",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 160,
                 maindir = "0 0 1",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
