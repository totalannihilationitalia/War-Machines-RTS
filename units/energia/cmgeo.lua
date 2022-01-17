-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  cmgeo= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 0,
               buildcostenergy = 24568,
               buildcostmetal = 1420,
               builder = false,
               buildpic = "nfacmgeo.png",
               buildtime  = 32078,
               category = "ALL NOTSUB NOWEAPON NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               description = "Hazardous Energy Source",
               energymake = 1250,
               energystorage = 2500,
               energyUse = 0,
               explodeas = "NUCLEAR_MISSILE",
               footprintx = 7,
               footprintz = 5,
               icontype = "energia",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 3720,
               maxslope = 20,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Moho Geothermal Powerplant",
               noAutoFire = false,
               objectname = "nfacmgeo.s3o",
               seismicsignature = 0,
               selfdestructas = "NUCLEAR_MISSILE",
               sightdistance = 273,
--               soundcategory= "CORE_GEO",
               TEDClass = "ENERGY", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "ooooooo ooooooo oGGoooo oGGoooo ooooooo",
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
