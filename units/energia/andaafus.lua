-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andaafus= {
               acceleration = 0,
               activatewhenbuilt = false,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 64115,
               buildcostmetal = 9109,
               builder = false,
--               buildinggrounddecaldecayspeed= 0.01,
--               buildinggrounddecalsizex= 13,
--               buildinggrounddecalsizey = 9,
--               buildinggrounddecaltype = "Pavimentazione2.png",
               buildpic = "andaafus.png",
               buildtime  = 157529,
               category = "ALL NOTSUB NOWEAPON SPECIAL NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andaafus_dead",
               damagemodifier = 0.95,
               description = "Enhanced Energy Output / Storage",
               energymake = 5000,
               energystorage = 25000,
               energyUse = 0,
               explodeas = "NUCLEAR_MISSILE",
               footprintx = 7,
               footprintz = 5,
               icontype = "energia",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 9150,
               maxslope = 13,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Advanced Fusion Reactor",
               noAutoFire = false,
               objectname = "andaafus.s3o",
               onoffable = false,
               seismicsignature = 0,
               selfdestructas = "CRBLMSSL",
               sightdistance = 273,
--               soundcategory= "ARM_FUS",
               TEDClass = "ENERGY", -- verificare se necessario
               turnrate = 0,
--               usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "ooooooooooooooooooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Fusion Reactor Wreckage",
               category = "corpses",
               object = "AAFUS_DEAD",
               featuredead = "aafus_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 4,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 6441,
               damage = 16290,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Advanced Fusion Reactor Heap",
               category = "heaps",
               object = "4X4A",
               footprintx = 4,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 2576,
               damage = 8145,
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
                     [1] = "fusion1",
                        },
               underattack = "warning1",
               },
},
}
