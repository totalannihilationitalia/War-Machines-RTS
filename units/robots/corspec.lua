-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corspec = {
               acceleration = 0.1,
               activatewhenbuilt = true,
--               badTargetCategory = MOBILE,
               brakerate  = 0.12,
               buildcostenergy = 1453,
               buildcostmetal = 70,
               builder = false,
               buildpic = "nfaspec.png",
               buildtime  = 5439,
               canAttack = false,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE ALL NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corspec_dead",
--               defaultmissiontype = Standby,
               description = "Radar Jammer Kbot",
               energymake = 8,
               energystorage = 0,
               energyUse = 100,
               explodeas = "BIG_UNITEX",
               footprintx = 1,
               footprintz = 1,
               icontype = "robots",
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 310,
               maxslope = 32,
               maxvelocity = 1.3,
               maxwaterdepth = 112,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Spectre",
               noAutoFire = false,
               nochasecategory = "MOBILE",
               objectname = "nfa_jammingrobot.s3o",
               onoffable = true,
               radardistance = 0,
               radarDistanceJam = 450,
               selfdestructas = "BIG_UNIT",
               sightdistance = 250,
--               soundcategory= "CORE_JAM",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 945,
               upright = true,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Spectre Wreckage",
               category = "corpses",
               object = "CORSPEC_DEAD",
               featuredead = "corspec_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 56,
               damage = 248,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 27",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Spectre Heap",
               category = "heaps",
               object = "2X2B",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 28,
               damage = 248,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
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
                     [1] = "kbcormov",
                    },
               select = {
                     [1] = "radjam2",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
