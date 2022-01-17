-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  minigoth= {
               acceleration = 7.9,
               autoheal = 10,
--               badTargetCategory = VTOL,
               brakerate  = 0.1,
               buildcostenergy = 23412,
               buildcostmetal = 2621,
               builder = false,
               buildpic = "minigoth.jpg",
               buildtime  = 55555,
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
               description = "Fast Light Scout Kbot",
--               firestandorders = 1,
               energymake = 0.4,
               energystorage = 0,
               energyUse = 0.4,
               explodeas = "DECOY_COMMANDER_BLAST",
               footprintx = 2,
               footprintz = 2,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 4532,
               maxslope = 32,
               maxvelocity = 5,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "mini",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "flea_4.s3o",
               radardistance = 3555,
               selfdestructas = "DECOY_BLAST",
               sightdistance = 3663,
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
               [1]="custom:pinkflare",
               [2]="custom:rocketflare",
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
		minigoth = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.1,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     explosiongenerator = "custom:SMALL_PINK_BURN",
                     firestarter = 90,
                     name= "Annihilator Weapon",
                     noexplode = true,
                     laserflaresize = 6,
                     range = 1000,
                     reloadtime = 0.1,
                     rgbcolor = "1.000 0.000 0.976",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "annigun1",
                     thickness = 1.2,
                     tolerance = 500,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 900,
                     damage = {
                         default = 25,
                     }, -- close damage
             }, --close single weapon definitions

		minigoth_missile = {
                     areaofeffect = 48,
                     avoidfeature = true,
                     cegTag = "KBOTMISSILETRAIL",
--                     craterareaofeffect =  ,
                     explosiongenerator = "custom:KBOTMISSILEHIT",
                     firestarter = 70,
                     flighttime = 6,
                     metalpershot = 0,
                     model = "missile",
                     name= "Missiles",
                     range = 728,
                     reloadtime = 0.5,
                     smoketrail = false,
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rocklit1",
                     startvelocity = 350,
                     texture2 = "armsmoketrail",
                     tolerance = 9000,
                     tracks = true, 
                     turnrate = 50000,
                     turret  = true, 
                     weaponacceleration = 300,
                     weapontimer = 50,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 1050,
                     damage = {
                         default = 31,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "SUB",
                 def = "minigoth",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 def = "minigoth_missile",
                 onlytargetcategory = "SURFACE VTOL",
                 },
                 [3] = {
                 def = "minigoth_missile",
                 onlytargetcategory = "SURFACE VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
