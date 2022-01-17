-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armmoho= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 2048,
               buildcostenergy = 7214,
               buildcostmetal = 582,
               builder = false,
               buildpic = "icumoho.png",
               buildtime  = 14938,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armmoho_dead",
               description = "Advanced Metal Extractor / Storage",
               energystorage = 0,
               energyUse = 25,
               explodeas = "SMALL_BUILDINGEX",
               ExtractsMetal = 0.004,
               footprintx = 5,
               footprintz = 5,
               icontype = "metal",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 2500,
               maxslope = 20,
               maxvelocity = 0,
               maxwaterdepth = 20,
               metalStorage = 1000,
               name = "Moho Mine",
               noAutoFire = false,
               objectname = "icumoho.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 273,
--               soundcategory= "ARM_MOHO",
               TEDClass = "METAL", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "ooooooooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Moho Mine Wreckage",
               category = "corpses",
               object = "ARMMOHO_DEAD",
               featuredead = "armmoho_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 5,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 378,
               damage = 1500,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "60.0 14.3981628418 60.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Moho Mine Heap",
               category = "heaps",
               object = "5X5A",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 151,
               damage = 750,
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
               activate = "mohorun1",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "mohooff1",
               ok = {
                     [1] = "twractv2",
                    },
               select = {
                     [1] = "mohoon1",
                        },
               underattack = "warning1",
               working = "mohorun1",
               },
               }, 
               }
