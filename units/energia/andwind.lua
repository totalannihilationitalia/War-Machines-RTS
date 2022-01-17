-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andwind= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
               buildcostenergy = 162,
               buildcostmetal = 35,
               builder = false,
               buildpic = "andwind.png",
               buildtime  = 1603,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "icuwind_dead",
               description = "Produces Energy",
               energystorage = 0,
               energyUse = 0,
               explodeas = "SMALL_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
               icontype = "energia",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 176,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "AND Wind Generator",
               noAutoFire = false,
               objectname = "andwind.s3o",
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 273,
--               soundcategory= "ARM_WIND",
               TEDClass = "ENERGY", -- verificare se necessario
               turnrate = 0,
               windGenerator = 25,
               workertime = 0,
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Wind Generator Wreckage",
               category = "corpses",
               object = "icuwind_DEAD",
               featuredead = "icuwind_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 4,
               footprintz = 4,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 23,
               damage = 106,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Wind Generator Heap",
               category = "heaps",
               object = "4X4A",
               footprintx = 4,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 9,
               damage = 53,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "85.0 14.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Close Features
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
                     [1] = "windgen1",
                        },
               underattack = "warning1",
               },
               }, 
               }
