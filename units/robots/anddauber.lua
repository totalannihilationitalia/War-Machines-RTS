-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  anddauber= {
               acceleration = 0.11,
--               badTargetCategory = VTOL,
               brakerate  = 0.183105469,
               buildcostenergy = 4265,
               buildcostmetal = 285,
               builder = false,
               buildpic = "",
               buildtime  = 8427,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "coredauber_dead",
--               defaultmissiontype = Standby,
               description = "Heavy Laser Escort",
--               firestandorders = 1,
               energymake = 1,
               energystorage = 0,
               energyUse = 2,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 795,
               maxslope = 14,
               maxvelocity = 1.075,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Dauber",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "anddauber.s3o",
               radardistance = 0,
               selfdestructas = "BIG_UNITEX",
               sightdistance = 245,
--               soundcategory= "COR_KBOT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 999,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  coredauber_dead = {
               world = "All Worlds",
               description = "Dauber Wreckage",
               category = "arm_corpses",
               object = "CoreDauber_dead",
               featurereclamate = "smudge01",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               hitdensity = 100,
               metal = 148,
               damage = 20000,
               seqnamereclamate = "tree1reclamate",
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
                     [1] = "kbcormov",
                    },
               select = {
                     [1] = "kbcorsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		core_lightlaser = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.12,
--                     cegTag = "",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 20,
                     explosiongenerator = "custom:SMALL_ARANCIO_BURN",
                     firestarter = 100,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 435,
                     reloadtime = 0.48,
                     rgbcolor = "1 0.2 0",
                     soundhit = "lasrhit2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir3",
                     soundtrigger = "1",
                     targetmoveerror = 0.1,
                     thickness = 2.5,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 2250,
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
                 badtargetcategory = "VTOL",
                 def = "core_lightlaser",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
