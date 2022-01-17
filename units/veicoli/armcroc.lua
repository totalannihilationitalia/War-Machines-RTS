-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armcroc= {
               acceleration = 0.0528,
--               amphibious = 1,
--               badTargetCategory = VTOL,
               brakerate  = 0.0209,
               buildcostenergy = 11512,
               buildcostmetal = 467,
               builder = false,
               buildpic = "icucroc.png",
               buildtime  = 13367,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armcroc_dead",
--               defaultmissiontype = Standby,
               description = "Heavy Amphibious Tank",
--               firestandorders = 1,
               energymake = 0.5,
               energystorage = 0,
               energyUse = 0.5,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 3360,
               maxslope = 12,
               maxvelocity = 2,
               maxwaterdepth = 255,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "ATANK3",
               name = "Triton",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icucroc.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 372,
--               soundcategory= "ARM_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 433,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               leaveTracks = true,
               trackOffset = 6,
               trackStrength = 5,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 42,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Triton Wreckage",
               category = "corpses",
               object = "ARMCROC_DEAD",
               featuredead = "armcroc_heap",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= false,
               hitdensity = 100,
               metal = 238,
               damage = 984,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "36 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Triton Heap",
               category = "heaps",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 119,
               damage = 984,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "35.0 4.0 6.0",
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
		arm_triton = {
                     areaofeffect = 96,
                     avoidfeature = true,
--                     cegTag = ""
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH64",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "PlasmaCannon",
                     noselfdamage = true,
                     range = 480,
                     reloadtime = 1.5,
                     soundhit = "xplomed4",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannon2",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 290,
                     damage = {
                         default = 174,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "arm_triton",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
