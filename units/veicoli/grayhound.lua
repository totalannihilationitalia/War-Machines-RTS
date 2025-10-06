-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  grayhound = {
               acceleration = 0.015,
               brakerate  = .04,
               buildcostenergy = 6935,
               buildcostmetal = 793,
               builder = false,
               buildpic = "da_fare.png",
               buildtime  = 13013,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "grayhound_dead",
               damagemodifier = 0.75,
--               defaultmissiontype = Standby,
               description = "Prototype Field/Command Tank",
--               firestandorders = 1,
               energymake = 6.0,
               energystorage = 0,
               energyUse = 6.0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 3000,
               maxslope = 10,
               maxvelocity = 1.1,
               maxwaterdepth = 12,
               metalmake = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HTANK3",
               name = "Greyhound",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "euf_grayhound.s3o",
               onoffable = true,
               radardistance = 1200,
               selfdestructas = "ESTOR_BUILDING",
               sightdistance = 460,
--               soundcategory= "ARM_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 305,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  grayhound_dead = {
               world = "All Worlds",
               description = "Grayhound Wreckage",
               category = "arm_corpses",
               object = "grayhound_dead",
               featuredead = "grayhound_dead2",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               hitdensity = 100,
               metal = 453,
               damage = 1624,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  grayhound_dead2 = {
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:redflare",
               [2]="custom:plasmaflare",
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
                     [1] = "tarmmove",
                    },
               select = {
                     [1] = "tarmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		mass_driver = {

                     areaofeffect = 1,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 200,					 
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "Massdriver MDC-80",
                     noselfdamage = true,
                     range = 596,
                     reloadtime = 3,
                     soundhit = "xplosml",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy",
                     turret  = true, 
                     tolerance = 500,					 
                     weapontype = "Cannon",
                     weaponvelocity  = 825,
                     damage = {
                         default = 160,
                     }, -- close damage
             }, --close single weapon definitions

		arm_lightlaser = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.12,
--                     beamweapon = true,
                     cegTag = "BLUCRAP",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 20,
                     explosiongenerator = "custom:Gatorazzurro",
                     firestarter = 30,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 430,
                     reloadtime = 0.48,
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
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 2250,
                     damage = {
                         default = 75,
                     }, -- close damage
             }, --close single weapon definitions

		corkrog_rocket = {
                     areaofeffect = 96,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:STARFIRE",
                     firestarter = 70,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "fmdmisl",
                     name= "HeavyRockets",
                     noselfdamage = true,
                     proximitypriority = -1,
                     range = 800,
                     reloadtime = 2.75,
                     smoketrail = true,
                     soundhit = "xplosml2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rocklit1",
                     startvelocity = 200,
                     texture2 = "coresmoketrail",
                     tolerance = 9000,
                     tracks = true, 
                     turnrate = 50000,
                     weaponacceleration = 230,
                     weapontimer = 2,
                     weapontype = "StarburstLauncher",
                     weaponvelocity  = 4000,
                     damage = {
                         default = 360,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",				 
                 def = "mass_driver",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 badtargetcategory = "VTOL",
                 def = "arm_lightlaser",
                 onlytargetcategory = "SURFACE VTOL", -- weapon 2
                 },
                 [3] = {
                 def = "corkrog_rocket",
                 onlytargetcategory = "SURFACE", -- weapon 3
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
