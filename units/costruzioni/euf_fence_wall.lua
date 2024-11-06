-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  euf_fence_wall= {
               activatewhenbuilt = true,
--               buildangle = 0,
               buildcostenergy = 300,
               buildcostmetal = 140,
               builder = false,
               buildpic = "euf_fence_wall.png",
               buildtime  = 1600,
               category = "NOWEAPON NOTAIR NOTSUB NOTSHIP SURFACE",
               collisionvolumeoffsets = "0 0 0",
               collisionvolumescales = "29 12 75",
               collisionvolumetype = "Box",
               corpse = "euf_fence_wall_dead",
               description = "Electric Gate",
               energystorage = 0,
               energyUse = 0.8,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 1,
               footprintz = 5,
               hidedamage = true,
               isFeature= true,
--               mass = 0 --definire massa,
               maxdamage = 1263,
               maxslope = 12,
               maxwaterdepth = 0,
               metalStorage = 0,
               mincloakdistance = 1,
               name = "Fortification Gate",
               noAutoFire = false,
               objectname = "euf_fence_wall.s3o",
               radardistance = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 100,
--               soundcategory= "ARM_ESTOR",
               TEDClass = "FORT", -- verificare se necessario
               workertime = 0,
               YardMap= "ooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Fence",
               category = "dragonteeth",
               object = "euf_fence_wall.s3o",
               featuredead = "euf_fence_wall_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 1,
               footprintz = 5,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 77,
               damage = 450,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumeoffsets = "0 0 0",
               collisionvolumescales = "29 12 100",
               collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Heap",
               category = "heaps",
               object = "2X2F",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 31,
               damage = 225,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumeoffsets = "0 -2.0 0",
               collisionvolumescales = "29 5 30",
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
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               select = {
                     [1] = "storngy1",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
