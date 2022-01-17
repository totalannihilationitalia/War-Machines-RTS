-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufsab= {
               acceleration = 0.018,
--               badTargetCategory = NOTAIR,
               brakerate  = 0.018,
               buildcostenergy = 1190,
               buildcostmetal = 143,
               builder = false,
               buildpic = "eufsab.png",
               buildtime  = 2438,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufsab_dead",
--               defaultmissiontype = Standby,
               description = "Missile Tank",
--               firestandorders = 1,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
--               maneuverleashlength  = 650,
--               mass = 0 --definire massa,
               maxdamage = 850,
               maxslope = 15,
               maxvelocity = 1.55,
               maxwaterdepth = 12,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Sabre",
               noAutoFire = false,
               objectname = "eufsab.s3o",
               selfdestructas = "BIG_UNIT",
               sightdistance = 350,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 415,
               wpri_badtargetcategory = "NOTAIR",
               leaveTracks = true,
               trackOffset = -6,
               trackStrength = 5,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 32,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Wreckage",
               category = "corecorpses",
               object = "eufsab_dead",
               featuredead = "eufsab_heap",
               featurereclamate = "smudge01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               hitdensity = 100,
               metal = 114,
               damage = 680,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Heap",
               category = "heaps",
               object = "2X2D",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 129,
               damage = 120,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
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
		cortruck_missile = {
                     areaofeffect = 48,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH2",
                     firestarter = 70,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "missile",
                     name= "Missiles",
                     noselfdamage = true,
                     range = 600,
                     reloadtime = 2.5,
                     smoketrail = true,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rockhvy2",
                     startvelocity = 450,
                     texture2 = "coresmoketrail",
                     tolerance = 8000,
                     tracks = true, 
                     turnrate = 63000,
                     turret  = true, 
                     weaponacceleration = 109,
                     weapontimer = 5,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 545,
                     damage = {
                         default = 56,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "NOTAIR",
                 def = "cortruck_missile",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
