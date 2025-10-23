-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  icuflash= {
               acceleration = 0.06,
--               badTargetCategory = ANTIEMG,
               brakerate  = 0.065,
               buildcostenergy = 914,
               buildcostmetal = 109,
               builder = false,
               buildpic = "icuflash.png",
               buildtime  = 1963,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "icuflash_dead",
--               defaultmissiontype = Standby,
               description = "Fast Assault Tank",
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
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 570,
               maxslope = 10,
               maxvelocity = 3.6,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK2",
               name = "Flash",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icuflash.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 299,
--               soundcategory= "ARM_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 592,
               workertime = 0,
               wpri_badtargetcategory = "ANTIEMG",
               leaveTracks = true,
               trackOffset = 5,
               trackStrength = 4,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 22,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Flash Wreckage",
               category = "corpses",
               object = "icuflash_DEAD",
               featuredead = "icuflash_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 71,
               damage = 366,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Flash Heap",
               category = "heaps",
               object = "2X2C",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 28,
               damage = 183,
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
		emgx = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     burst = 3, -- lua:salvoSize
                     burstrate = 0.1, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:EMG_HIT",
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     Intensity = 0.7,
                     name= "flash",
                     noselfdamage = true,
                     range = 180,
                     reloadtime = 0.31,
                     rgbcolor = "1 0.95 0.4",
                     size = "1.75",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "flashemg",
                     sprayangle = 1180,
                     tolerance = 5000,
                     turret  = true, 
                     weapontimer = 0.1,
                     weapontype = "Cannon",
                     weaponvelocity  = 500,
                     damage = {
                         default = 11,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
--                 badtargetcategory = "ANTIEMG",
                 def = "emgx",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
