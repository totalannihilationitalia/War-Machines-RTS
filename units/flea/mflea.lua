-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  mflea= {
               acceleration = 0.14,
--               badTargetCategory = VTOL,
               brakerate  = 1.25,
               buildcostenergy = 8563,
               buildcostmetal = 935,
               builder = false,
               buildpic = "",
               buildtime  = 4013,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "0 0 0",
               --collisionvolumescales = "28 15 28",
               --collisionvolumetype = "box",
--               defaultmissiontype = Standby,
               description = "Killer Kbot",
--               firestandorders = 1,
               energymake = 0.4,
               energystorage = 0,
               energyUse = 0.4,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 1154,
               maxslope = 32,
               maxvelocity = 3,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Marco Flea",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "flea_3.s3o",
               radardistance = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 999,
--               soundcategory= "ARM_KBOT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 2600,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:greenflare",
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
		armflea_killer = {
                     areaofeffect = 24,
                     avoidfeature = true,
--                     beamweapon = true,
                     cegTag = "GREENCRAP",
--                     craterareaofeffect =  ,
                     explosiongenerator = "custom:GreenLaser",
                     firestarter = 90,
                     name= "High Energy Laser",
                     range = 450,
                     reloadtime = 2.00,
                     rgbcolor = "0.000 1.000 0.259",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrhvy3",
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 700,
                     damage = {
                         default = 148,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "armflea_killer",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
