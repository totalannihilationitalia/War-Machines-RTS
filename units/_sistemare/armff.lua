-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armff= {
               acceleration = 0.08,
               brakerate  = 0.08,
               buildcostenergy = 322607,
               buildcostmetal = 21564,
               builder = false,
               buildpic = "",
               buildtime  = 506213,
               canAttack = true,
               canfly = true,
--               canDGun = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
		category = "ALL MOBILE NOTSUB VTOL WEAPON",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 250,
--               defaultmissiontype = Standby,
               description = "Sky fortress",
--               firestandorders = 1,
               energymake = 55.0,
               energyUse = 53.9,
               explodeas = "BIG_UNITEX",
               footprintx = 6,
               footprintz = 7,
--               maneuverleashlength  = 500,
--               mass = 0 --definire massa,
               maxdamage = 29000,
               maxvelocity = 6,
--               mobilestandorders= 1,
               name = "Wyvern",
               noAutoFire = false,
               objectname = "ARMFF",
               selfdestructas = "BIG_UNITEX",
               sightdistance = 800,
--               soundcategory= "ARM_HOVER_BIG",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "VTOL", -- verificare se necessario
               turnrate = 120,
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
                     [1] = "hovlgok1",
                    },
               select = {
                     [1] = "hovlgsl1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		affsniper = {
                     areaofeffect = 25,
                     avoidfeature = true,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     edgeeffectiveness = 0.90,
                     energypershot = 500,
                     firestarter = 70,
                     model = "ion",
                     name= "Long distance protonic discharge",
                     range = 1000,
                     reloadtime = 5,
                     soundhit = "bigion2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "bigion1",
                     tolerance = 0,
                     tracks = true, 
                     turnrate = 24384,
                     turret  = true, 
                     weapontimer = 10,
                     weapontype = " ",
                     weaponvelocity  = 1000,
                     damage = {
                         default = 1000,
                     }, -- close damage
             }, --close single weapon definitions

		affmisiles = {
                     areaofeffect = 10,
                     avoidfeature = true,
                     burst = 6, -- lua:salvoSize
                     burstrate = .1, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     firestarter = 70,
                     flighttime = 30,
                     metalpershot = 0,
                     model = "missile",
                     name= "Charge concentrating missiles",
                     range = 700,
                     reloadtime = 1,
                     smoketrail = true,
                     soundhit = "xplosml2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rocklit1",
                     startvelocity = 250,
                     tolerance = 9,
                     tracks = true, 
                     turnrate = 63000,
                     weaponacceleration = 200,
                     weapontimer = 5,
                     weapontype = " ",
                     weaponvelocity  = 550,
                     damage = {
                         default = 100,
                     }, -- close damage
             }, --close single weapon definitions

		affrain = {
                     areaofeffect = 10,
                     avoidfeature = true,
                     burst = 30, -- lua:salvoSize
                     burstrate = .001, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     energypershot = 1,
                     model = "plasma",
                     name= "Plasma pulverizer",
                     range = 600,
                     reloadtime = 1,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "bombrel",
                     sprayangle = 20000,
                     tolerance = 500,
                     turret  = true, 
                     weapontimer = 3,
                     weapontype = " ",
                     weaponvelocity  = 400,
                     damage = {
                         default = 35,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "affsniper",
--               onlytargetcategory = " ",
                 },
                 [2] = {
                 def = "affmisiles",
--               onlytargetcategory = " ", -- weapon 2
                 },
                 [3] = {
                 def = "affrain",
--               onlytargetcategory = " ", -- weapon 3
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
