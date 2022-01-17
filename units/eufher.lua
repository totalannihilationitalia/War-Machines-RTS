-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufher= {
               acceleration = 0.011,
--               badTargetCategory = VTOL,
               brakerate  = 0.01,
               buildcostenergy = 1395,
               buildcostmetal = 222,
               builder = false,
               buildpic = "eufher.png",
               buildtime  = 2938,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufher_dead",
--               defaultmissiontype = Standby,
               description = "Assault Tank",
--               firestandorders = 1,
               energymake = 1,
               energyUse = 1,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
--               maneuverleashlength  = 650,
--               mass = 0 --definire massa,
               maxdamage = 2100,
               maxslope = 15,
               maxvelocity = 1.27,
               maxwaterdepth = 12,
--               mobilestandorders= 1,
               movementclass = "HTANK3",
               name = "Heretic",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "eufher.s3o",
               selfdestructas = "BIG_UNIT",
               sightdistance = 300,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 340,
               wpri_badtargetcategory = "VTOL",
               leaveTracks = true,
               trackOffset = 8,
               trackStrength = 10,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 40,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Wreckage",
               category = "corecorpses",
               object = "eufher_dead",
               featuredead = "eufher_heap",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 21,
               hitdensity = 100,
               metal = 178,
               damage = 880,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Heap",
               category = "heaps",
               object = "3X3F",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 220,
               damage = 1260,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:MEDIUMFLARE",
               }, -- close effects list
}, -- close section sfxtypes
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
		arm_bull = {
                     areaofeffect = 140,
                     avoidfeature = true,
--                     cegTag = ""
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH72",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "PlasmaCannon",
                     noselfdamage = true,
                     range = 460,
                     reloadtime = 1.12,
                     soundhit = "xplomed2",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannon3",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 300,
                     damage = {
                         default = 240,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "arm_bull",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage
}, -- close unit data 
} -- close total
