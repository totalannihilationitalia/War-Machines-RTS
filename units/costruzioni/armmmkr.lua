-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armmmkr= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 19350,
               buildcostmetal = 358,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 5,
               buildinggrounddecalsizey = 5,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icummkr.png",
               buildtime  = 34980,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armmmkr_dead",
               damagemodifier = 0.3,
               description = "Converts Energy to Metal",
               energystorage = 0,
               energyUse = 600,
               explodeas = "ATOMIC_BLASTSML",
               footprintx = 4,
               footprintz = 4,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
               makesMetal = 12,
--               mass = 0 --definire massa,
               maxdamage = 400,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Moho Metal Maker",
               noAutoFire = false,
               objectname = "icummkr.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "ATOMIC_BLAST",
               sightdistance = 273,
--               soundcategory= "ARM_MAKER",
               TEDClass = "METAL", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "oooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Moho Metal Maker Wreckage",
               category = "corpses",
               object = "ARMMMKR_DEAD",
               featuredead = "armmmkr_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 4,
               footprintz = 4,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 233,
               damage = 240,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Moho Metal Maker Heap",
               category = "heaps",
               object = "4X4C",
               footprintx = 4,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 93,
               damage = 120,
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
               activate = "metlon1",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "metloff1",
               select = {
                     [1] = "metlon1",
                        },
               underattack = "warning1",
               working = "metlrun1",
               },
               }, 
               }
