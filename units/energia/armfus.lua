-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armfus= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 19846,
               buildcostmetal = 4004,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 7,
               buildinggrounddecalsizey = 5,
               buildinggrounddecaltype = "Pavimentazione2.png",
               buildpic = "icufus.png",
               buildtime  = 70014,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armfus_dead",
               description = "Produces Energy / Storage",
               energymake = 1000,
               energystorage = 2500,
               energyUse = 0,
               explodeas = "ATOMIC_BLAST",
               footprintx = 5,
               footprintz = 4,
               hidedamage = true,
               icontype = "energia",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 4000,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Fusion Reactor",
               noAutoFire = false,
               objectname = "icufus.s3o",
               seismicsignature = 0,
               selfdestructas = "MINE_NUKE",
               sightdistance = 273,
--               soundcategory= "ARM_FUS",
               TEDClass = "ENERGY", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "oooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Fusion Reactor Wreckage",
               category = "corpses",
               object = "ARMFUS_DEAD",
               featuredead = "armfus_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 4,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 2603,
               damage = 2700,
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
               object = "4X4A",
               footprintx = 4,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 1041,
               damage = 1350,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "85.0 14.0 6.0",
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
               select = {
                     [1] = "fusion1",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
