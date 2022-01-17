-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  coruwmme= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 32768,
               buildcostenergy = 10076,
               buildcostmetal = 846,
               builder = false,
               buildpic = "nfauwmme.png",
               buildtime  = 34783,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "coruwmme_dead",
               damagemodifier = 0.35,
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
               maxdamage = 2072,
               maxslope = 24,
               maxvelocity = 0,
               metalStorage = 1000,
               minWaterDepth= 15,
               name = "Underwater Moho Mine",
               noAutoFire = false,
               objectname = "nfauwmme.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 169,
--               soundcategory= "CORE_UWMEX",
               TEDClass = "METAL", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "ooooooooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  coruwmme_dead = {
               world = "All Worlds",
               description = "Underwater Moho Mine Wreckage",
               category = "corpses",
               object = "CORUWMME_DEAD",
               featuredead = "coruwmme_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 5,
               height = 150,
               blocking= true,
               hitdensity = 100,
               metal = 550,
               damage = 1243,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  coruwmme_heap = {
               world = "All Worlds",
               description = "Underwater Moho Mine Heap",
               category = "heaps",
               object = "5X5C",
               footprintx = 5,
               footprintz = 5,
               height = 5,
               blocking = false,
               hitdensity= 100,
               metal = 220,
               damage = 622,
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
