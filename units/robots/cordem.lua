-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  CORDEM= {
               acceleration = 0.1,
               brakerate  = 0.15,
               buildcostenergy = 156664,
               buildcostmetal = 10489,
               builder = false,
               buildpic = "",
               buildtime  = 350143,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "cordem_dead",
               damagemodifier = .5,
--               defaultmissiontype = Standby,
               description = "Experimental Kbot",
--               firestandorders = 1,
               energymake = 0.4,
               energystorage = 0,
               energyUse = 0.4,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 19500,
               maxslope = 14,
               maxvelocity = 1.3,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Archdemon",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "anddem.s3o",
               radardistance = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 480,
--               soundcategory= "KROGOTH",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 590,
               upright = true,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  cordem_dead = {
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
                     [1] = "krogok1",
                    },
               select = {
                     [1] = "krogsel1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		dem_weapon = {
                     accuracy = 500,
                     areaofeffect = 64,
                     avoidfeature = true,
--                     burnblow = true,
                     burst = 6, -- lua:salvoSize
                     burstrate = .01, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     edgeeffectiveness = 0.5,
                     firestarter = 95,
                     name= "FlameThrower",
                     noexplode = true,
                     range = 500,
                     reloadtime = 0.03,
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "flamhvy1",
                     sprayangle = 3000,
                     tolerance = 4500,
                     turret  = true, 
                     weapontimer = 1.7,
                     weapontype = "Flame",
                     weaponvelocity  = 300,
                     damage = {
                         default = 21,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "dem_weapon",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
