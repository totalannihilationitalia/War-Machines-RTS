-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufbomb= {
               acceleration = 0.004,
--               badTargetCategory = VTOL,
               brakerate  = 0.012,
               buildcostenergy = 66789,
               buildcostmetal = 4987,
               builder = false,
               buildpic = "eufbomb.png",
               buildtime  = 132786,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufbomb_dead",
--               defaultmissiontype = Standby,
               description = "Medium Range Plasma Tank",
--               firestandorders = 1,
               energymake = 2,
               energyUse = 2,
               explodeas = "BIG_UNITEX",
               footprintx = 4,
               footprintz = 4,
	       icontype = "veicoli",
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 1600,
               maxslope = 12,
               maxvelocity = 0.54,
               maxwaterdepth = 14,
--               mobilestandorders= 1,
               movementclass = "HTANK4",
               name = "Bombarder X-5",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "eufbomb.s3o",
               selfdestructas = "ATOMIC_BLAST",
               sightdistance = 600,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 182,
               wpri_badtargetcategory = "VTOL",
               leaveTracks = true,
               trackOffset = 8,
               trackStrength = 10,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 49,
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
                     [1] = "tcormove",
                    },
               select = {
                     [1] = "tcorsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		core_intimidator = {
                     accuracy = 335,
                     areaofeffect = 224,
                     avoidfeature = true,
                     cegTag = "vulcanfx",
--                     craterareaofeffect =  ,
                     craterboost = 0.25,
                     cratermult = 0.25,
                     energypershot = 3000,
                     explosiongenerator = "custom:FLASHBIGBUILDING",
                     impulseboost = 0.5,
                     impulsefactor = 0.5,
                     name= "IntimidatorCannon",
                     noselfdamage = true,
                     range = 3100,
                     reloadtime = 13.5,
                     rgbcolor = "1 0.8 0.5",
                     size = "5",
                     soundhit = "xplonuk1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "xplonuk3",
                     tolerance = 500,
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 1150,
                     damage = {
                         default = 800,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "core_intimidator",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
