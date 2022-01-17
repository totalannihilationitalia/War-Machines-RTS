-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armcarry= {
               acceleration = 0.026,
               activatewhenbuilt = true,
--               badTargetCategory = NOTAIR,
               brakerate  = 0.024,
--               buildangle = 16384,
               buildcostenergy = 71257,
               buildcostmetal = 1572,
               builder = true,
               buildpic = "icucarry.png",
               buildtime  = 85394,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE NOTSUB NOWEAPON SHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armcarry_dead",
--               defaultmissiontype = Standby,
               description = "Aircraft Carrier with Anti-Nuke",
--               firestandorders = 1,
               energymake = 250,
               energystorage = 1500,
               energyUse = 25,
               explodeas = "CRAWL_BLAST",
               footprintx = 8,
               footprintz = 8,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
		isairbase = true,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 7640,
               maxvelocity = 2.76,
               metalStorage = 1500,
               minWaterDepth= 15,
--               mobilestandorders= 1,
               movementclass = "DBOAT6",
               name = "Colossus",
               noAutoFire = false,
               nochasecategory = "ALL",
               objectname = "icucarry.s3o",
               radardistance = 2950,
               seismicsignature = 0,
               selfdestructas = "CRAWL_BLAST",
               sightdistance = 1105,
               sonardistance = 760,
--               soundcategory= "ARM_SHIP",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 210,
               workertime = 1000,

-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
},  --  Wreckage and heaps
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
               cant = {
                     [1] = "cantdo4",
                      },
               ok = {
                     [1] = "sharmmov",
                    },
               select = {
                     [1] = "sharmsel",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
