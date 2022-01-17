-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armuwadves= {
--               buildangle = 8192,
               buildcostenergy = 10094,
               buildcostmetal = 773,
               builder = false,
               buildpic = "icuuwadves.png",
               buildtime  = 20302,
               category = "ALL NOTSUB NOWEAPON NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armuwadves_dead",
               description = "Increases Energy Storage (40000)",
               energystorage = 40000,
               energyUse = 0,
               explodeas = "ATOMIC_BLAST",
               footprintx = 4,
               footprintz = 4,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 10500,
               maxslope = 20,
               maxwaterdepth = 9999,
               metalStorage = 0,
               name = "Hardened Energy Storage",
               noAutoFire = false,
               objectname = "icuuwadves.s3o",
               seismicsignature = 0,
               selfdestructas = "MINE_NUKE",
               sightdistance = 169,
--               soundcategory= "ARM_ESTOR",
               TEDClass = "ENERGY", -- verificare se necessario
               workertime = 0,
               YardMap= "oooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Advanced Energy Storage Wreckage",
               category = "corpses",
               object = "ARMUWADVES_DEAD",
               featuredead = "armuwadves_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 4,
               footprintz = 4,
               height = 9,
               blocking= true,
               hitdensity = 100,
               metal = 502,
               damage = 4200,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "all",
               description = "Advanced Energy Storage Heap",
               category = "heaps",
               object = "4X4A",
               footprintx = 4,
               footprintz = 4,
               blocking = false,
               hitdensity= 100,
               metal = 201,
               damage = 2100,
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
                     [1] = "storngy1",
                        },
               underattack = "warning1",
               },
               }, 
               }
