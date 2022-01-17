-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armpincer= {
               acceleration = 0.011,
--               badTargetCategory = VTOL,
               brakerate  = 0.011,
               buildcostenergy = 1921,
               buildcostmetal = 187,
               builder = false,
               buildpic = "icupincer.png",
               buildtime  = 2613,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK PHIB WEAPON NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armpincer_dead",
--               defaultmissiontype = Standby,
               description = "Light Amphibious Tank",
--               firestandorders = 1,
               energymake = 0.5,
               energystorage = 0,
               energyUse = 0.5,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 650,
               mass = 200,
               maxdamage = 1148,
               maxslope = 5,
               maxvelocity = 2.25,
               maxwaterdepth = 125,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "ATANK3",
               name = "Pincer",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icupincer.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 240,
--               soundcategory= "ARM_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 398,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               leaveTracks = true,
               trackOffset = 3,
               trackStrength = 6,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 30,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Pincer Wreckage",
               category = "corpses",
               object = "ARMPINCER_DEAD",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 9,
               blocking= true,
               hitdensity = 100,
               metal = 122,
               damage = 689,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:plasmaflare",
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
                     [1] = "tarmmove",
                    },
               select = {
                     [1] = "tarmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		arm_pincer_gauss = {
                     areaofeffect = 8,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:LIGHT_PLASMA",
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "PincerCannon",
                     noselfdamage = true,
                     range = 305,
                     reloadtime = 1.5,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy1",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 450,
                     damage = {
                         default = 116,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "arm_pincer_gauss",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
