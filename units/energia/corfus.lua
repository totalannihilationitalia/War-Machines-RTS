-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corfus= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 16384,
               buildcostenergy = 25292,
               buildcostmetal = 4203,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 5,
               buildinggrounddecalsizey = 5,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfafus.png",
               buildtime  = 75424,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corfus_dead",
               description = "Produces Energy / Storage",
               energymake = 1100,
               energystorage = 2500,
               energyUse = 0,
               explodeas = "ATOMIC_BLAST",
               footprintx = 5,
               footprintz = 5,
               hidedamage = true,
               icontype = "energia",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 4500,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 1,
               metalStorage = 0,
               name = "Fusion Reactor",
               noAutoFire = false,
               objectname = "nfa_basic_fusion.s3o",
               seismicsignature = 0,
               selfdestructas = "MINE_NUKE",
               sightdistance = 273,
--               soundcategory= "CORE_FUS",
               TEDClass = "ENERGY", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "ooooooooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Fusion Reactor Wreckage",
               category = "corpses",
               object = "CORFUS_DEAD",
               featuredead = "corfus_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 5,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 2927,
               damage = 5100,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Fusion Reactor Heap",
               category = "heaps",
               object = "5X5D",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 1171,
               damage = 2550,
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
                     [1] = "fusion2",
                        },
               underattack = "warning1",
               },
               }, 
               }
