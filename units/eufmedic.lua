-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufmedic= {
               acceleration = 0.1,
               brakerate  = 0.06,
               buildcostenergy = 3801,
               buildcostmetal = 111,
               builddistance = 70,
               builder = true,
               buildpic = "eufmedic.pcx",
               buildtime  = 2489,
               canAttack = false,
--               cancapture = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armmedic_dead",
--               defaultmissiontype = Standby,
               description = "Repairing BodyGuard",
               energymake = 4.0,
               energystorage = 40,
               energyUse = 3.4,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 281,
               maxslope = 28,
               maxvelocity = 1.7,
               maxwaterdepth = 101,
               metalmake = 0.1,
               metalStorage = 10,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Anabolic Medic",
               noAutoFire = false,
--               norestrict = "1",
               objectname = "ARMMedic",
               radardistance = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 250,
--               soundcategory= "ARM_MICRON",
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 1400,
               upright = true,
               workertime = 90,
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               buildoptions = { 
               },


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
               activate = "mcroact",
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
                     [1] = "alienno",
                      },
               deactivate = "mcrodeact",
               ok = {
                     [1] = "mcrook1",
                    },
               repair = "mcrorepair",
               select = {
                     [1] = "mcrosel1",
                        },
               underattack = "mcroattack",
}, --close sound section
}, -- close unit data 
} -- close total
