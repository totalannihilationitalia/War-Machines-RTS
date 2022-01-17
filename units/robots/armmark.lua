-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armmark= {
               acceleration = 0.045,
               activatewhenbuilt = true,
               brakerate  = 0.018,
               buildcostenergy = 1152,
               buildcostmetal = 95,
               builder = false,
               buildpic = "icumark.png",
               buildtime  = 3800,
               canAttack = false,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE ALL NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armmark_dead",
--               defaultmissiontype = Standby,
               description = "Radar Kbot",
               energymake = 8,
               energystorage = 0,
               energyUse = 20,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "robots",
               losemitheight = 80,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 320,
               maxslope = 16,
               maxvelocity = 1.35,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Marky",
               noAutoFire = false,
               objectname = "icuradmob.s3o",
               onoffable = true,
               radardistance = 2200,
               radaremitheight = 80,
               selfdestructas = "BIG_UNIT",
               sightdistance = 900,
               sonardistance = 0,
--               soundcategory= "ARM_KRADAR",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 505,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Marky Wreckage",
               category = "corpses",
               object = "ARMMARK_DEAD",
               featuredead = "armmark_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 76,
               damage = 256,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
				collisionvolumeoffsets = "0.0 -1.4425585791 1.2922744751",
				collisionvolumescales = "29.0 14.3981628418 30.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Marky Heap",
               category = "heaps",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 38,
               damage = 256,
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
                     [1] = "kbarmmov",
                    },
               select = {
                     [1] = "akradsel",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
