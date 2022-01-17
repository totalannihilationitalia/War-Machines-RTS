-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armuwmme= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 32768,
               buildcostenergy = 9164,
               buildcostmetal = 601,
               builder = false,
               buildpic = "icuuwmme.png",
               buildtime  = 35370,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armuwmme_dead",
               description = "Advanced Metal Extractor / Storage",
               energystorage = 0,
               energyUse = 25,
               explodeas = "SMALL_BUILDINGEX",
               ExtractsMetal = 0.004,
               footprintx = 5,
               footprintz = 5,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 2053,
               maxslope = 24,
               maxvelocity = 0,
               metalStorage = 1000,
               minWaterDepth= 15,
               name = "Underwater Moho Mine",
               noAutoFire = false,
               objectname = "icuuwmme.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 182,
--               soundcategory= "ARM_UWMEX",
               TEDClass = "METAL", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "ooooooooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  armuwmme_dead = {
               world = "All Worlds",
               description = "Underwater Moho Mine Wreckage",
               category = "corpses",
               object = "ARMUWMME_DEAD",
               featuredead = "armuwmme_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 5,
               height = 140,
               blocking= true,
               hitdensity = 100,
               metal = 391,
               damage = 1232,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  armuwmme_heap = {
               world = "All Worlds",
               description = "Underwater Moho Mine Heap",
               category = "heaps",
               object = "5X5C",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 156,
               damage = 616,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
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
