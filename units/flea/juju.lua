-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  juju= {
               acceleration = 0.15,
--               badTargetCategory = NOTAIR,
               brakerate  = 0.31,
               buildcostenergy = 27321,
               buildcostmetal = 2157,
               builder = false,
               buildpic = "",
               buildtime  = 23087,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "juju_dead",
--               defaultmissiontype = Standby,
               description = "Spider Hunter",
--               firestandorders = 1,
               energymake = 10,
               energystorage = 0,
               energyUse = 2.0,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 235000,
               maxslope = 18,
               maxvelocity = 1.60,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Arachno Killer",
               noAutoFire = false,
               objectname = "flea_juju.s3o",
               radardistance = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 1200,
--               soundcategory= "MAVERICK",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 485,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "NOTAIR",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  juju_dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "arm_corpses",
               object = "juju_dead",
               featuredead = "juju_heap",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 31,
               blocking= true,
               hitdensity = 105,
               metal = 289,
               damage = 152,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  juju_heap = {
               world = "All Worlds",
               description = "Wreckage",
               category = "heaps",
               object = "3x3a",
               footprintx = 3,
               footprintz = 3,
               height = 2,
               blocking = false,
               hitdensity= 105,
               metal = 143,
               damage = 54,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
               },  -- Close heap
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
                     [1] = "mavbok1",
                    },
               select = {
                     [1] = "mavbsel1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		julaser = {
                     areaofeffect = 100,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     edgeeffectiveness = .985,
                     energypershot = 30,
                     firestarter = 20,
                     model = "ASshot",
                     name= "Anti spider gun",
                     range = 1350,
                     reloadtime = .5,
                     soundhit = "cantdo2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "majorlaser",
                     soundtrigger = "1",
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 700,
                     damage = {
                         default = 155,
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
                 def = "julaser",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 def = "corkrog_rocket",
                 onlytargetcategory = "SURFACE", -- weapon 2
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
