-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andfig= {
               acceleration = 2.5,
		    badTargetCategory = "OGGETTISTATICI",
               brakerate  = 7.5,
               buildcostenergy = 2687,
               buildcostmetal = 68,
               buildpic = "andfig.png",
               buildtime  = 3465,
               canAttack = true,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL MOBILE WEAPON ANTIGATOR NOTSUB ANTIFLAME ANTIEMG ANTILASER NOTLAND VTOL NOTSHIP",
               collide = false,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 110, --110
--               defaultmissiontype = VTOL_standby,
               description = "Fighter",
--               firestandorders = 1,
               energymake = 0.7,
               energystorage = 0,
               energyUse = 0,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "air",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 1280,
--               mass = 0 --definire massa,
               maxdamage = 450,
               maxslope = 10,
               maxvelocity = 9.64,
               maxwaterdepth = 255,
               metalStorage = 0,
--               mobilestandorders= 1,
               name = "Andrionian Fighter",
               noAutoFire = false,
               objectname = "andfight.s3o",
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 530,
--               soundcategory= "ARM_VTOL",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "VTOL", -- verificare se necessario
               turnrate = 891,
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
                     [1] = "vtolarmv",
                    },
               select = {
                     [1] = "vtolarac",
                        },
               underattack = "warning1",
               },
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		arm_lightlaser = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.05,
--                     beamweapon = true,
                     cegTag = "BLUCRAP",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 0,
                     explosiongenerator = "custom:Gatorazzurro",
                     firestarter = 30,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 500,
                     reloadtime = 0.28,
                     rgbcolor = "0 0.5 1",
                     soundhit = "lasrhit2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir3",
                     soundtrigger = "1",
                     targetmoveerror = 0.1,
                     thickness = 2.5,
                     tolerance = 10000,
                     turret  = false, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 3000,
                     damage = {
                         default = 75,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "ANTILASER",
                 def = "arm_lightlaser",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total