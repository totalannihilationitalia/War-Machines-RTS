-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corssub = {
               acceleration = 0.028,
               activatewhenbuilt = true,
--               badTargetCategory = HOVER NOTSHIP,
               brakerate  = 0.188,
               buildcostenergy = 11940,
               buildcostmetal = 1757,
               builder = false,
               buildpic = "nfassub.png",
               buildtime  = 23007,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL UNDERWATER MOBILE WEAPON NOTLAND NOTAIR",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corssub_dead",
--               defaultmissiontype = Standby,
               description = "Battle Submarine",
--               firestandorders = 1,
               energymake = 15,
               energystorage = 0,
               energyUse = 15,
               explodeas = "BIG_UNITEX",
               footprintx = 4,
               footprintz = 4,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 2320,
               maxvelocity = 2.59,
               metalStorage = 0,
               minWaterDepth= 20,
--               mobilestandorders= 1,
               movementclass = "UBOAT3",
               name = "Leviathan",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfassub.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 520,
               sonardistance = 550,
--               soundcategory= "CORE_SUB",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "WATER", -- verificare se necessario
               turnrate = 395,
               upright = true,
               waterline = 15,
               workertime = 0,
               wpri_badtargetcategory = "HOVER NOTSHIP",
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
		corssub_weapon = {
                     areaofeffect = 16,
                     avoidfeature = true,
--                     burnblow = true,
--                     cegTag = "",
                     collidefriendly = false,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH3",
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "advtorpedo",
                     name= "advTorpedo",
                     noselfdamage = true,
                     range = 690,
                     reloadtime = 1.5,
                     soundhit = "xplodep1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "torpedo1",
                     startvelocity = 150,
                     tolerance = 32767,
                     tracks = true, 
                     turnrate = 1500,
                     turret  = true, 
                     waterweapon = true, 
                     weaponacceleration = 25,
                     weapontimer = 4,
                     weapontype = "TorpedoLauncher",
                     weaponvelocity  = 220,
                     damage = {
                         default = 500,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "HOVER NOTSHIP",
                 def = "corssub_weapon",
--               onlytargetcategory = " ",
                 maxAngleDif = 75,
                 maindir = "0 0 1",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
