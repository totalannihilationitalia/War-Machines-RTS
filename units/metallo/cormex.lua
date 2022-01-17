-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  cormex= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 2048,
               buildcostenergy = 514,
               buildcostmetal = 51,
               builder = false,
               buildpic = "nfamex.png",
               buildtime  = 1874,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "cormex_dead",
               damagemodifier = 0.4,
               description = "Extracts Metal",
               energystorage = 0,
               energyUse = 3,
               explodeas = "SMALL_BUILDINGEX",
               ExtractsMetal = 0.001,
               footprintx = 3,
               footprintz = 3,
	       iconType = "metal",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 175,
               maxslope = 20,
               maxvelocity = 0,
               maxwaterdepth = 20,
               metalStorage = 50,
               name = "NFA Metal Extractor",
               noAutoFire = false,
               objectname = "CORMEX.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "TINY_BUILDINGEX",
               selfdestructcountdown = 1,
               sightdistance = 273,
--               soundcategory= "COR_MEX",
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
               object = "CORMEX_DEAD",
               featuredead = "cormex_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 33,
               damage = 105,
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
               object = "3X3E",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 13,
               damage = 53,
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
               activate = "mexrun2",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               cant = {
                     [1] = "cantdo4",
                      },
               deactivate = "mexoff2",
               ok = {
                     [1] = "servmed2",
                    },
               select = {
                     [1] = "mexon2",
                        },
               underattack = "warning1",
               working = "mexrun2",
               },
               }, 
               }
