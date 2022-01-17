-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  amgeo= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 0,
               buildcostenergy = 24852,
               buildcostmetal = 1520,
               builder = false,
               buildpic = "icuamgeo.png",
               buildtime  = 33152,
               category = "ALL NOTSUB NOWEAPON NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               description = "Hazardous Energy Source",
               energymake = 1250,
               energystorage = 2500,
               energyUse = 0,
               explodeas = "NUCLEAR_MISSILE",
               footprintx = 5,
               footprintz = 8,
               icontype = "energia",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 3240,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Moho Geothermal Powerplant",
               noAutoFire = false,
               objectname = "icugeo.s3o",
               seismicsignature = 0,
               selfdestructas = "NUCLEAR_MISSILE",
               sightdistance = 273,
--               soundcategory= "ARM_GEO",
               TEDClass = "ENERGY", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "ooooo ooooo ooooo ooooo ooooo oGGGo oGGGo ooooo",
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
