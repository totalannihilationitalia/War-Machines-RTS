-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corsonar= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 399,
               buildcostmetal = 20,
               builder = false,
               buildpic = "nfasonar.png",
               buildtime  = 900,
               canAttack = false,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corsonar_dead",
               description = "Locates Water Units",
               energymake = 1,
               energystorage = 0,
               energyUse = 1,
               explodeas = "SMALL_BUILDINGEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "radar",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 52,
               maxslope = 10,
               maxvelocity = 0,
               metalStorage = 0,
               minWaterDepth= 10,
               name = "Sonar Station",
               noAutoFire = false,
               objectname = "nfasonar.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 485,
               sonardistance = 1200,
--               soundcategory= "CORE_SONAR",
               TEDClass = "WATER", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "oooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Sonar Station Wreckage",
               category = "corpses",
               object = "CORSONAR_DEAD",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 13,
               damage = 31,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
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
               deactivate = "sonarde2",
               select = {
                     [1] = "sonar2",
                        },
               underattack = "warning1",
               },
                 maxAngleDif = 1,
               }, 
               }
