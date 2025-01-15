	-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armgmm = {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 16384,
               buildcostenergy = 24230,
               buildcostmetal = 1058,
               builder = false,
               buildpic = "icugmm.PNG",
               buildtime  = 41347,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               description = "Safe Geothermal Powerplant",
               energymake = 750,
               energystorage = 1500,
               explodeas = "BIG_BUILDINGEX",
               footprintx = 5,
               footprintz = 5,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 12500,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               name = "Prude",
               noAutoFire = false,
               objectname = "icugmm.s3o",
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 273,
--               soundcategory= "ARM_GEO",
               TEDClass = "METAL", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "ooooo ooooo ooGoo ooooo ooooo",
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
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
}, --close sound section
}, -- close unit data 
} -- close total
