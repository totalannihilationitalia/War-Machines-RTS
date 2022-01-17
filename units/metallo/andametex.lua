-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andametex = {
               activatewhenbuilt = true,
--               buildangle = 2048,
               buildcostenergy = 27000,
               buildcostmetal = 2100,
               builder = false,
               buildpic = "andametex.png",
               buildtime  = 39640,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
------------ creare corpo
--               corpse = "andametex_dead",
               description = "Advanced Moho Metal Extractor",
               energymake = 0,
               energystorage = 0,
               energyUse = 50,
               explodeas = "LARGE_BUILDINGEX",
			ExtractsMetal=0.0100,
               footprintx = 6,
               footprintz = 6,
	       iconType = "metal",
--               mass = 0 --definire massa,
               maxdamage = 3000,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Advanced Moho Mine",
               noAutoFire = false,
               objectname = "andametex.s3o",
               onoffable = true,
               radardistance = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 210,
--               soundcategory= "CORE_MOHO",
               TEDClass = "METAL", -- verificare se necessario
               workertime = 0,
               YardMap= "ooooooooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "core_corpses",
               object = "advmoho_dead",
               featuredead = "advmoho_heap",
               featurereclamate = "smudge01",
               footprintx = 5,
               footprintz = 5,
               height = 6,
               blocking= true,
               hitdensity = 100,
               metal = 1025,
               damage = 1000,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "60.0 14.3981628418 60.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Wreckage",
               category = "heaps",
               object = "3x3f",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 350,
               damage = 416,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
               collisionvolumescales = "55.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Close Features
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
               sounds = {
               activate = "mohorun2",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "mohooff2",
               ok = {
                     [1] = "twractv3",
                    },
               select = {
                     [1] = "mohoon2",
                        },
               underattack = "warning1",
               working = "mohorun2",
               },
               }, 
               }
