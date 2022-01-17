-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  folsom_dam_fogna = {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 600,
               buildcostmetal = 54,
               builder = false,
               buildpic = "folsom_dam_fogna.png",
               buildtime  = 1137,
               canAttack = false,
               category = "OGGETTISTATICI",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "dead",
               description = "Sewage Outfalls",
--               energymake = 4,
--               energystorage = 0,
--               energyUse = 4,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 3000,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Sewage Outfalls",
               noAutoFire = false,
               objectname = "folsom_dam_fogna.s3o",
               onoffable = true,
--               radardistance = 2100,
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
--               sightdistance = 680,
--               soundcategory= "ARM_RADAR",
               TEDClass = "SPECIAL", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "oooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Sewage Outfalls Wreckage",
               category = "corpses",
               object = "folsom_dam_fogna.s3o",
               featuredead = "heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 35,
               damage = 1500,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Sewage Outfalls Heap",
               category = "heaps",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 14,
               damage = 25,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Close Features
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
               sounds = {
               activate = "radar1",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "radarde1",
               select = {
                     [1] = "radar1",
                        },
               underattack = "warning1",
               working = "radar1",
               },
                 maxAngleDif = 1,
               }, 
               }
