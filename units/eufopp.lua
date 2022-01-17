-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufopp= {
               acceleration = 0.015,
--               badTargetCategory = VTOL,
               brakerate  = 0.012,
               buildcostenergy = 1316,
               buildcostmetal = 158,
               builder = false,
               buildpic = "eufopp.png",
               buildtime  = 2174,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufopp_dead",
--               defaultmissiontype = Standby,
               description = "Support Tank",
--               firestandorders = 1,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
--               maneuverleashlength  = 650,
--               mass = 0 --definire massa,
               maxdamage = 1900,
               maxslope = 15,
               maxvelocity = 1.5,
               maxwaterdepth = 12,
--               mobilestandorders= 1,
               movementclass = "HTANK3",
               name = "Oppressor",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "eufopp.s3o",
               selfdestructas = "SMALL_UNIT",
               sightdistance = 300,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 450,
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
               object = "eufopp_dead",
               featuredead = "eufopp_heap",
               featurereclamate = "smudge01",
               footprintx = 2,
               footprintz = 2,
               height = 21,
               hitdensity = 100,
               metal = 126,
               damage = 720,
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
		core_lightcannon = {
                     areaofeffect = 48,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:LIGHT_PLASMA",
                     firestarter = 100,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightCannon",
                     noselfdamage = true,
                     range = 350,
                     reloadtime = 1.19,
                     soundhit = "xplosml3",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "canlite3",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 225,
                     damage = {
                         default = 97,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "core_lightcannon",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
