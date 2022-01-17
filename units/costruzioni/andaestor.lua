-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andaestor= {
--               buildangle = 7822,
               buildcostenergy = 10032,
               buildcostmetal = 790,
               builder = false,
               buildpic = "andaestor.png",
               buildtime  = 20416,
               category = "ALL NOTSUB NOWEAPON NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andaestor_dead",
               description = "Increases Energy Storage (40000)",
               energystorage = 40000,
               energyUse = 0,
               explodeas = "ATOMIC_BLAST",
               footprintx = 5,
               footprintz = 5,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 11400,
               maxslope = 20,
               maxwaterdepth = 9999,
               metalStorage = 0,
               name = "Hardened Energy Storage",
               noAutoFire = false,
               objectname = "andaestor.s3o",
               seismicsignature = 0,
               selfdestructas = "MINE_NUKE",
               sightdistance = 192,
--               soundcategory= "CORE_ESTOR",
               TEDClass = "ENERGY", -- verificare se necessario
               workertime = 0,
               YardMap= "ooooooooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Advanced Energy Storage Wreckage",
               category = "corpses",
               object = "CORUWADVES_DEAD",
               featuredead = "andaestor_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 5,
               height = 9,
               blocking= true,
               hitdensity = 100,
               metal = 514,
               damage = 4560,
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
               object = "5X5A",
               footprintx = 5,
               footprintz = 5,
               blocking = false,
               hitdensity= 100,
               metal = 206,
               damage = 2280,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
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
                     [1] = "storngy2",
                        },
               underattack = "warning1",
               },
               }, 
               }
