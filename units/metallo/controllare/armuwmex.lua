-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armuwmex= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 674,
               buildcostmetal = 55,
               builder = false,
               buildpic = "icuuwmex.png",
               buildtime  = 1875,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armuwmex_dead",
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
               maxdamage = 180,
               maxslope = 24,
               maxvelocity = 0,
               metalStorage = 50,
               minWaterDepth= 15,
               name = "Underwater Metal Extractor",
               noAutoFire = false,
               objectname = "icuuwmex.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "",
               selfdestructcountdown = 1,
               sightdistance = 182,
--               soundcategory= "ARM_UWMEX",
               TEDClass = "METAL", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  armuwmex_dead = {
               world = "All Worlds",
               description = "Underwater Metal Extractor Wreckage",
               category = "corpses",
               object = "ARMUWMEX_DEAD",
               featuredead = "armuwmex_heap",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 36,
               damage = 108,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  armuwmex_heap = {
               world = "All Worlds",
               description = "Underwater Metal Extractor Heap",
               category = "heaps",
               object = "3X3D",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 14,
               damage = 54,
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
               activate = "waterex1",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "waterex1",
               select = {
                     [1] = "waterex1",
                        },
               underattack = "warning1",
               working = "waterex1",
}, --close sound section
}, -- close unit data 
} -- close total
