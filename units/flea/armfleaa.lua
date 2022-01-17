-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armfleaa= {
               acceleration = 0.9,
--               badTargetCategory = VTOL,
               brakerate  = 0.0001,
               buildcostenergy = 542,
               buildcostmetal = 81,
               builder = false,
               buildpic = "flea_2.png",
               buildtime  = 1000,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT WEAPON NOTAIR NOTSUB SURFACE",
               --collisionvolumeoffsets = "0 0 0",
               --collisionvolumescales = "8 10 8",
               --collisionvolumetype = "box",
--               defaultmissiontype = Standby,
               description = "Long Range Kbot",
--               firestandorders = 1,
               energymake = 0.4,
               energystorage = 0,
               energyUse = 0.4,
               explodeas = "noweapon",
               footprintx = 2,
               footprintz = 2,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 358,
               maxslope = 32,
               maxvelocity = 4,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Accurate Flea",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "flea_2.s3o",
               radardistance = 0,
               selfdestructas = "noweapon",
               sightdistance = 763,
               sonardistance = 800,
--               soundcategory= "ARM_KBOT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 1300,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:POPUPFLAREFASTFLEA",
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
		armfleaa_weapon = {
                     areaofeffect = 48,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     name= "Plasma Cannon",
                     range = 720,
                     reloadtime = 5,
                     rgbcolor = "1 0.0 1",
                     size = "1.5",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannon2",
                     tolerance = 500,
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 530,
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
                 def = "armfleaa_weapon",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
