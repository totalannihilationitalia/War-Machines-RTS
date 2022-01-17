-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armpeep= {
               acceleration = 0.6,
               brakerate  = 11.25,
               buildcostenergy = 1475,
               buildcostmetal = 30,
               builder = false,
               buildpic = "icupeep.png",
               buildtime  = 2585,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL MOBILE NOTLAND NOTSUB ANTIFLAME ANTIGATOR ANTIEMG ANTILASER VTOL NOWEAPON NOTSHIP",
               collide = false,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 180,
--               defaultmissiontype = VTOL_standby,
               description = "Scout Plane",
               energymake = 0.2,
               energystorage = 0,
               energyUse = 0.2,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "air",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 1280,
--               mass = 0 --definire massa,
               maxdamage = 80,
               maxslope = 10,
               maxvelocity = 13.8,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               name = "Peeper",
               noAutoFire = false,
               objectname = "icupeep.s3o",
               radardistance = 1140,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               selfdestructcountdown = 1,
               sightdistance = 865,
--               soundcategory= "ARM_VTOL",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "VTOL", -- verificare se necessario
               turnrate = 880,
               workertime = 0,
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
               cant = {
                     [1] = "cantdo4",
                      },
               ok = {
                     [1] = "vtolarmv",
                    },
               select = {
                     [1] = "vtolarac",
                        },
               underattack = "warning1",
               },
               }, 
               }
