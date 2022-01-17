-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corvoyr= {
               acceleration = 0.049,
               activatewhenbuilt = true,
               brakerate  = 0.015,
               buildcostenergy = 1283,
               buildcostmetal = 93,
               builder = false,
               buildpic = "nfavoyr.png",
               buildtime  = 3945,
               canAttack = false,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE ALL NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corvoyr_dead",
--               defaultmissiontype = Standby,
               description = "Radar Kbot",
               energymake = 8,
               energystorage = 0,
               energyUse = 20,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
               losemitheight = 80,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 350,
               maxslope = 16,
               maxvelocity = 1.5,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Voyeur",
               noAutoFire = false,
               objectname = "nfa_radar_bot.s3o",
               onoffable = true,
               radardistance = 2200,
               radaremitheight = 80,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 925,
--               soundcategory= "CORE_KRADAR",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 583,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Voyeur Wreckage",
               category = "corpses",
               object = "CORVOYR_DEAD",
               featuredead = "corvoyr_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 60,
               damage = 210,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Voyeur Heap",
               category = "heaps",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 24,
               damage = 105,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
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
                     [1] = "ckradsel",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
