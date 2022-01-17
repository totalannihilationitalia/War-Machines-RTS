-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eridlon_gate_wall= {
               activatewhenbuilt = true,
--               buildangle = 0,
               buildcostenergy = 10000,
               buildcostmetal = 980,
               builder = false,
               buildpic = "ARMFORTGV.bmp",
               buildtime  = 5705,
               category = "OGGETTISTATICI",
               cloakcost = 200,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               description = "Eridlon Gate",
               energystorage = 0,
               energyUse = 0.8,
               explodeas = "LARGE_BUILDING",
               footprintx = 2,
               footprintz = 2,
               hidedamage = true,
--               mass = 0 --definire massa,
               maxdamage = 6000,
               maxslope = 12,
               maxwaterdepth = 0,
               metalStorage = 0,
               mincloakdistance = 1,
               name = "Fortification Gate",
               noAutoFire = false,
               objectname = "eridlon_gate_wall.s3o",
               radardistance = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 100,
--               soundcategory= "ARM_ESTOR",
               TEDClass = "FORT", -- verificare se necessario
               workertime = 0,
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
                     [1] = "storngy1",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
