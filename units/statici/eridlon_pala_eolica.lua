-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eridlon_pala_eolica= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
               buildcostenergy = 162,
               buildcostmetal = 35,
               builder = false,
               buildpic = "armwing.png",
               buildtime  = 1603,
               category = "OGGETTISTATICI",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               description = "Produces Energy",
               energystorage = 0,
               energyUse = 0,
               explodeas = "SMALL_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 3000,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Wind Generator",
               noAutoFire = false,
               objectname = "eridlon_pala_eolica.s3o",
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 273,
--               soundcategory= "ARM_WIND",
               TEDClass = "ENERGY", -- verificare se necessario
               turnrate = 0,
               windGenerator = 2500,
               workertime = 0,
               YardMap= "ooooooooo",
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
                     [1] = "windgen1",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
