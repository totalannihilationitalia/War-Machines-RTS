-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  euflong= {
               acceleration = 0.017,
               airsightdistance = 1000,
               brakerate  = 0.01,
               buildcostenergy = 4611,
               buildcostmetal = 567,
               builder = false,
               buildpic = "euflong.png",
               buildtime  = 8249,
               canmove = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "euflong_dead",
--               defaultmissiontype = Standby,
               description = "Flak Tank",
--               firestandorders = 1,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 502,
               maxslope = 15,
               maxvelocity = 1.083,
               maxwaterdepth = 12,
--               mobilestandorders= 1,
               movementclass = "HTANK3",
               name = "Longbow",
               noAutoFire = false,
               objectname = "euflong.s3o",
               selfdestructas = "SMALL_UNIT",
               sightdistance = 350,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 365,
               wpri_badtargetcategory = "VTOL",
               leaveTracks = true,
               trackOffset = 6,
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
               object = "euflong_dead",
               featuredead = "euflong_heap",
               featurereclamate = "smudge01",
               footprintx = 2,
               footprintz = 2,
               height = 21,
               hitdensity = 100,
               metal = 454,
               damage = 402,
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
		corcaber_gun = {
                     accuracy = 500,
                     areaofeffect = 120,
                     avoidfeature = true,
                     canattackground = false,
--                     burnblow = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     edgeeffectiveness = 0.90,
                     name= "Flak Gun",
                     range = 670,
                     reloadtime = 0.6,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "canlite2",
                     tolerance = 767,
                     turret  = true, 
                     weapontimer = 1,
                     weapontype = "Cannon",
                     weaponvelocity  = 1000,
                     damage = {
                         default = 75,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "NOTAIR",
                 def = "corcaber_gun",
                 onlytargetcategory = "VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
