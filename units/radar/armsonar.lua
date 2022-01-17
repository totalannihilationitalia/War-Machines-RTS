-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armsonar= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 403,
               buildcostmetal = 20,
               builder = false,
               buildpic = "icusonar.png",
               buildtime  = 912,
               canAttack = false,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armsonar_dead",
               description = "Locates Water Units",
               energystorage = 0,
               energyUse = 10,
               explodeas = "SMALL_BUILDINGEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "radar",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 50,
               maxslope = 10,
               maxvelocity = 0,
               metalStorage = 0,
               minWaterDepth= 10,
               name = "Sonar Station",
               noAutoFire = false,
               objectname = "icusonar.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 515,
               sonardistance = 1200,
--               soundcategory= "ARM_SONAR",
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
               object = "ARMSONAR_DEAD",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 13,
               damage = 30,
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
               activate = "sonar1",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "sonarde1",
               select = {
                     [1] = "sonar1",
                        },
               underattack = "warning1",
               },
                 maxAngleDif = 1,
               }, 
               }
