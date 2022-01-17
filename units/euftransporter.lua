-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  euftransporter= {
               acceleration = 0.04,
               brakerate  = 1,
		blocking = false,
               buildcostenergy = 1239,
               buildcostmetal = 64,
               builder = false,
               buildpic = "icuatlas.png",
               buildtime  = 3850,
               canfly = true,
               canGuard = true,
--               canload = 1,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL MOBILE WEAPON NOTLAND ANTIGATOR NOTSUB ANTIFLAME ANTIEMG ANTILASER VTOL NOTSHIP",
               collide = true,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 700,
--               defaultmissiontype = VTOL_standby,
               description = "Air Transport",
--               firestandorders = 0,
               energymake = 0.6,
               energystorage = 0,
               energyUse = 0.6,
               explodeas = "SMALL_UNITEX",
               footprintx = 3,
               footprintz = 3,
               icontype = "air",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 1280,
--               mass = 0 --definire massa,
               maxdamage = 240,
               maxslope = 10,
               maxvelocity = 8.25,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 0,
               name = "Atlas",
               noAutoFire = false,
		nochasecategory = "VTOL",

               objectname = "icuatlas.s3o",
--               scale = 0.8,
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 125,
--               soundcategory= "ARM_VTOL",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "VTOL", -- verificare se necessario
               transportmass = 70000,
--               transmaxunits = 1,
               transportCapacity = 1,
               transportSize= 3,
               turnrate = 200,
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
