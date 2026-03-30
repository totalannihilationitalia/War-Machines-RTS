-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armscab= {
               acceleration = 0.018,
--               badTargetCategory = VTOL,
               brakerate  = 0.034,
               buildcostenergy = 88000,
               buildcostmetal = 1437,
               builder = false,
               buildpic = "armscab.png",
               buildtime  = 95678,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               damagemodifier = 0.5,
--               defaultmissiontype = Standby,
               description = "Mobile Anti-missile Defense",
--               firestandorders = 1,
               energymake = 200,
               energystorage = 1000,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 780,
               maxslope = 10,
               maxvelocity = 1.63,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TKBOT3",
               name = "Scarab",
               nochasecategory = "ALL",
               objectname = "icuscarab.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 450,
--               soundcategory= "ARM_KBOT",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 473,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
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
		armscab_weapon = {
                     areaofeffect = 420,
                     avoidfeature = true,
--                     cegTag = "",
                     collidefriendly = false,
                     coverage = 2000,
                     interceptor = 1, --specificare ID missili che verranno intercettati.
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 7500,
                     explosiongenerator = "custom:FLASH4",
                     firestarter = 100,
                     flighttime = 120,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 150,
                     model = "amdrocket",
                     name= "Rocket",
                     noselfdamage = true,
                     range = 72000,
                     reloadtime = 2,
                     smoketrail = true,
                     soundhit = "xplomed4",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Rockhvy1",
                     stockpile = true,
                     stockpiletime = 90,
                     tolerance = 4000,
                     tracks = true, 
                     turnrate = 99000,
                     weaponacceleration = 75,
                     weapontimer = 5,
                     weapontype = "StarburstLauncher",
                     weaponvelocity  = 3000,
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
                 badtargetcategory = "NOTAIR",
                 def = "armscab_weapon",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
