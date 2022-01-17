-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armgeo= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 2048,
               buildcostenergy = 12568,
               buildcostmetal = 520,
               builder = false,
               buildpic = "icugeo.png",
               buildtime  = 13078,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armgeo_dead",
               description = "Produces Energy / Storage",
               energymake = 300,
               energystorage = 1000,
               energyUse = 0,
               explodeas = "ESTOR_BUILDING",
               footprintx = 4,
               footprintz = 4,
               icontype = "energia",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 1750,
               maxslope = 20,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Geothermal Powerplant",
               noAutoFire = false,
               objectname = "icugeoterm.s3o",
               seismicsignature = 0,
               selfdestructas = "ESTOR_BUILDING",
               sightdistance = 273,
--               soundcategory= "ARM_GEO",
               TEDClass = "ENERGY", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "oooo oGGo oGGo oooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Geothermal Powerplant Wreckage",
               category = "corpses",
               object = "ARMGEO_DEAD",
               featuredead = "armgeo_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 4,
               footprintz = 4,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 338,
               damage = 1050,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Geothermal Powerplant Heap",
               category = "heaps",
               object = "4X4B",
               footprintx = 4,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 135,
               damage = 525,
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
                     [1] = "geothrm1",
                        },
               underattack = "warning1",
               },
               }, 
               }
