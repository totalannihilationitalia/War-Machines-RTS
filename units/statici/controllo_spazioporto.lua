-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  controllo_spazioporto= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 600,
               buildcostmetal = 54,
               builder = false,
               buildpic = "controllo_spazioporto.png",
               buildtime  = 1137,
               canAttack = false,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               description = "Capture this to take control of objects",
               energymake = 0,
               energystorage = 0,
               energyUse = 0,
               explodeas = "SMALL_BUILDINGEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "building",
               idleautoheal = 0,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 81,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Tower Control",
               noAutoFire = false,
               objectname = "controllo_spazioporto.s3o",
               onoffable = false,
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 680,
--               soundcategory= "ARM_RADAR",
               TEDClass = "SPECIAL", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "oooo",
-----------------------------------------------------------
--- NO EFFECTS
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
}, --close sound section
                 maxAngleDif = 1,
}, -- close unit data 
} -- close total
