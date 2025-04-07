-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  euf_fence_gate= {
               activatewhenbuilt = true,
--               buildangle = 0,
               buildcostenergy = 4432,
               buildcostmetal = 980,
               builder = true,
               buildpic = "euf_fence_gate.png",
               buildtime  = 5705,
               category = "ARM NOWEAPON NOTAIR NOTSUB NOTSHIP SURFACE",
--	       useFootPrintCollisionVolume = true,
	       usePieceCollisionVolumes = true,
--               collisionvolumeoffsets = "0 -10 0",
--               collisionvolumescales = "29 10 160", -- larghezza altezza lunghezza 
--              collisionvolumetype = "Box",
               description = "Electric Gate",
               energystorage = 0,
               energyUse = 0.8,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 5,
               footprintz = 10,
               hidedamage = true,
--               mass = 0 --definire massa,
               maxdamage = 1263,
               maxslope = 12,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Fortification Gate",
               noAutoFire = false,
               objectname = "euf_fence_gate.s3o",
               onoffable = true,
               radardistance = 0,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 100,
--               soundcategory= "ARM_ESTOR",
--               script = "Gate.lua",
               TEDClass = "PLANT", -- verificare se necessario
               workertime = 0,
               YardMap= "ooooo ccccc ccccc ccccc ccccc ccccc ccccc ccccc ccccc ooooo",
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
