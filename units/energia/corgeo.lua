-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corgeo= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 12375,
               buildcostmetal = 505,
               builder = false,
               buildpic = "nfageo.png",
               buildtime  = 12875,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corgeo_dead",
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
               maxdamage = 1850,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Geothermal Powerplant",
               noAutoFire = false,
               objectname = "nfageo.s3o",
               seismicsignature = 0,
               selfdestructas = "ESTOR_BUILDING",
               sightdistance = 273,
--               soundcategory= "CORE_GEO",
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
               object = "CORGEO_DEAD",
               featuredead = "corgeo_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 4,
               footprintz = 4,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 328,
               damage = 1110,
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
               metal = 131,
               damage = 555,
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
                     [1] = "geothrm2",
                        },
               underattack = "warning1",
               },
               }, 
               }
