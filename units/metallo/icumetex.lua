-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  icumetex= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
               buildcostenergy = 521,
               buildcostmetal = 50,
               builder = false,
               buildpic = "icumetex.png",
               buildtime  = 1800,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "icumetex_dead",
               description = "Extracts Metal",
               energystorage = 0,
               energyUse = 3,
               explodeas = "TINY_BUILDINGEX",
               ExtractsMetal = 0.001,
               footprintx = 3,
               footprintz = 3,
	       iconType = "metal",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 170,
               maxslope = 20,
               maxvelocity = 0,
               maxwaterdepth = 20,
               metalStorage = 50,
               name = "ICU Metal Extractor",
               noAutoFire = false,
               objectname = "icumetex.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "TINY_BUILDINGEX",
               selfdestructcountdown = 1,
               sightdistance = 273,
--               soundcategory= "ARM_MEX",
               TEDClass = "METAL", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Metal Extractor Wreckage",
               category = "corpses",
               object = "ARMMEX_DEAD",
               featuredead = "icumetex_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 33,
               damage = 102,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Metal Extractor Heap",
               category = "heaps",
               object = "3X3B",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 13,
               damage = 51,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Close Features
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
               sounds = {
               activate = "mexrun1",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "mexoff1",
               ok = {
                     [1] = "servmed2",
                    },
               select = {
                     [1] = "mexon1",
                        },
               underattack = "warning1",
               working = "mexrun1",
               },
               }, 
               }
