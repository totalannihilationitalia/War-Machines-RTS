-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  bigb= {
               acceleration = 2.25,
--               amphibious = 1,
               brakerate  = 0.15,
               buildcostenergy = 63286,
               buildcostmetal = 3700,
               builder = false,
               buildpic = "",
               buildtime  = 88566,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTAIR SURFACE",
               cloakcost = 1,
               cloakcostmoving = 1,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "ebigb_dead",
--               defaultmissiontype = Standby,
               description = "encryp family",
--               firestandorders = 1,
               energymake = 0,
               energystorage = 0,
               energyUse = 10,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 8,
               footprintz = 7,
--               maneuverleashlength  = 650,
--               mass = 0 --definire massa,
               maxdamage = 2917,
               maxslope = 30,
               maxvelocity = 3.60,
               maxwaterdepth = 255,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HKBOT4",
               name = "encryplone",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "bigb.s3o",
               radardistance = 0,
               selfdestructas = "LARGE_BUILDINGEX",
               sightdistance = 500,
--               soundcategory= "ARM_HOVER_SM",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 450,
               upright = true,
               workertime = 0,
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
                     [1] = "hovsmok1",
                    },
               select = {
                     [1] = "hovsmsl1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		banthaar_fire = {
                     areaofeffect = 125,
                     avoidfeature = true,
                     burst = 1, -- lua:salvoSize
                     burstrate = 0, -- lua: salvoDelay					 
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     firestarter = 70,
					 maneuverability = 0,
                     model = "BPulse.s3o",
                     name= "Anti-Tank Pulse Cannon",
                     range = 598,
                     reloadtime = .6,
                     smoketrail = false,					 
                     soundhit = "lasrmas1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrhvy1",
                     startvelocity = 378,					 
                     texture2 = "andsmoketrail",
                     tolerance = 500,
					 tracks = false,					 
                     turret  = true, 
					 weaponacceleration = 0,					 
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 465,
                     damage = {
                         default = 217,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "banthaar_fire",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
