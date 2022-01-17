-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  ARMFLEA= {
               acceleration = 0.9,
--               badTargetCategory = VTOL,
               brakerate  = 0.0001,
               buildcostenergy = 212,
               buildcostmetal = 21,
               builder = false,
               buildpic = "flea_1.png",
               buildtime  = 1000,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "0 0 0",
               --collisionvolumescales = "8 10 8",
               --collisionvolumetype = "box",
--               defaultmissiontype = Standby,
               description = "Fast Light Scout Kbot",
--               firestandorders = 1,
               energymake = 0.4,
               energystorage = 0,
               energyUse = 0.4,
               explodeas = "noweapon",
               footprintx = 1,
               footprintz = 1,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 58,
               maxslope = 32,
               maxvelocity = 3,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Flea",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "flea_1.s3o",
               radardistance = 0,
               selfdestructas = "noweapon",
               sightdistance = 300,
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
               [1]="custom:pinkflareflea",
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
		armfleabowl_weapon = {
                     areaofeffect = 8,
                     avoidfeature = true,
--                     beamweapon = true,
 --                    cegTag = "PINKCRAP",
--                     craterareaofeffect =  ,
                     duration = 0.04,
                     energypershot = 0,
                     explosiongenerator = "custom:SMALL_PINK_BURN",
                     firestarter = 30,
                     Intensity = 0.5,
                     name= "Light Laser",
                     range = 360,
                     reloadtime = 0.5,
                     rgbcolor = "1 0 1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir3",
                     soundtrigger = "0",
                     thickness = 0.8,
                     tolerance = 500,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 900,
                     damage = {
                         default = 3,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "armfleabowl_weapon",
                 onlytargetcategory = "SURFACE VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
