-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  tank_2= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 600,
               buildcostmetal = 54,
               builder = false,
               buildpic = "tank_2.png",
               buildtime  = 1137,
               canAttack = false,
               category = "OGGETTISTATICI",
               collisionvolumeoffsets = "0 0 0",
               collisionvolumescales = "30 70 30",
               collisionvolumetype = "Box",
--               corpse = "dead",
               description = "A gas tank",
--               energymake = 4,
--               energystorage = 0,
--               energyUse = 4,
               explodeas = "SMALL_BUILDINGEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 3500,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Building",
               noAutoFire = false,
               objectname = "tank_2.s3o",
               onoffable = true,
               radardistance = 2100,
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
