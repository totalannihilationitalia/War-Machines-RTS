-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armfortgv= {
               activatewhenbuilt = true,
--               buildangle = 0,
               buildcostenergy = 4432,
               buildcostmetal = 980,
               builder = false,
               buildpic = "ARMFORTGV.bmp",
               buildtime  = 5705,
               category = "NOWEAPON NOTAIR NOTSUB NOTSHIP SURFACE",
               cloakcost = 200,
	       usePieceCollisionVolumes = true,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               description = "Electric Gate",
               energymake = 0.8,
               energystorage = 0,
               energyUse = 0.8,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 1,
               footprintz = 10,
               hidedamage = true,
--               mass = 0 --definire massa,
               maxdamage = 1263,
               maxslope = 12,
               maxwaterdepth = 0,
               metalStorage = 0,
               mincloakdistance = 1,
               name = "Fortification Gate",
               noAutoFire = false,
               objectname = "ARMFORTGV",
               onoffable = true,
               radardistance = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 100,
--               soundcategory= "ARM_ESTOR",
               TEDClass = "FORT", -- verificare se necessario
               workertime = 0,
--               YardMap= "oo oo cc cc cc cc cc cc oo oo",
               YardMap= "o o c c c c c c o o",
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
