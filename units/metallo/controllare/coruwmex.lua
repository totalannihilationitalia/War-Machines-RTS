-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  coruwmex= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 519,
               buildcostmetal = 56,
               builder = false,
               buildpic = "nfauwmex.png",
               buildtime  = 1887,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "coruwmex_dead",
               description = "Extracts Metal",
               energystorage = 0,
               energyUse = 2,
               explodeas = "SMALL_BUILDINGEX",
               ExtractsMetal = 0.001,
               footprintx = 3,
               footprintz = 3,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 185,
               maxslope = 20,
               maxvelocity = 0,
               metalStorage = 50,
               minWaterDepth= 15,
               name = "Underwater Metal Extractor",
               noAutoFire = false,
               objectname = "nfauwmex.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "",
               selfdestructcountdown = 1,
               sightdistance = 169,
--               soundcategory= "CORE_UWMEX",
               TEDClass = "METAL", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  coruwmex_dead = {
               world = "All Worlds",
               description = "Underwater Metal Extractor Wreckage",
               category = "corpses",
               object = "CORUWMEX_DEAD",
               featuredead = "coruwmex_heap",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 36,
               damage = 111,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  coruwmex_heap = {
               world = "All Worlds",
               description = "Underwater Metal Extractor Heap",
               category = "heaps",
               object = "3X3B",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 14,
               damage = 56,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
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
               activate = "waterex2",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "waterex2",
               select = {
                     [1] = "waterex2",
                        },
               underattack = "warning1",
               working = "waterex2",
}, --close sound section
}, -- close unit data 
} -- close total
