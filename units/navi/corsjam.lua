-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corsjam= {
               acceleration = 0.096,
               activatewhenbuilt = true,
--               badTargetCategory = MOBILE,
               brakerate  = 0.022,
               buildcostenergy = 2254,
               buildcostmetal = 135,
               builder = false,
               buildpic = "nfasjam.png",
               buildtime  = 7025,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE NOTSUB SHIP NOWEAPON NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corsjam_dead",
--               defaultmissiontype = Standby,
               description = "Radar Jammer Ship",
               energymake = 20,
               energystorage = 0,
               energyUse = 20,
               explodeas = "SMALL_UNITEX",
               footprintx = 4,
               footprintz = 4,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 570,
               maxvelocity = 2.88,
               metalStorage = 0,
               minWaterDepth= 6,
--               mobilestandorders= 1,
               movementclass = "BOAT4",
               name = "Phantom",
               noAutoFire = false,
               nochasecategory = "MOBILE",
               objectname = "nfasjam.s3o",
               onoffable = true,
               radarDistanceJam = 900,
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 403,
--               soundcategory= "CORE_SJAM",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 512,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
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
                     [1] = "shcormov",
                    },
               select = {
                     [1] = "radjam2",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
