-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armamex= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 6092,
               buildcostenergy = 2081,
               buildcostmetal = 159,
               builder = false,
               buildpic = "icuamex.png",
               buildtime  = 2611,
               category = "ALL NOTSUB NOWEAPON NOTAIR SURFACE",
               cloakcost = 10,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armamex_dead",
               description = "Stealthy Cloakable Metal Extractor",
               energystorage = 0,
               energyUse = 5,
               explodeas = "TWILIGHT",
               ExtractsMetal = 0.0009,
               footprintx = 3,
               footprintz = 3,
	       iconType = "metal",
               idleautoheal = 5,
               idletime = 1800,
	       initcloaked = true,
--               mass = 0 --definire massa,
               maxdamage = 1450,
               maxslope = 20,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 75,
               mincloakdistance = 48,
               name = "Twilight",
               noAutoFire = false,
               objectname = "icuamex.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "TWILIGHT",
               selfdestructcountdown = 1,
               sightdistance = 286,
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
               world = "all",
               description = "Twilight Wreckage",
               category = "corpses",
               object = "ARMAMEX_DEAD",
               featuredead = "armamex_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 9,
               blocking= true,
               hitdensity = 100,
               metal = 103,
               damage = 870,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "35.0 14.3981628418 35.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "all",
               description = "Twilight Heap",
               category = "heaps",
               object = "3X3A",
               footprintx = 3,
               footprintz = 3,
               blocking = false,
               hitdensity= 100,
               metal = 41,
               damage = 435,
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
