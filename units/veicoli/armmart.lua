-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armmart= {
               acceleration = 0.0184,
--               badTargetCategory = NOTLAND,
               brakerate  = 0.1232,
               buildcostenergy = 3840,
               buildcostmetal = 254,
               builder = false,
               buildpic = "icumart.png",
               buildtime  = 5530,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armmart_dead",
--               defaultmissiontype = Standby,
               description = "Mobile Artillery",
--               firestandorders = 1,
               energymake = 0.4,
               energystorage = 0,
               energyUse = 0.4,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 600,
               maxslope = 12,
               maxvelocity = 1.81,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Luger",
               noAutoFire = false,
               nochasecategory = "NOTLAND",
               objectname = "icumart.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 286,
--               soundcategory= "ARM_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 402,
               workertime = 0,
               wpri_badtargetcategory = "NOTLAND",
               leaveTracks = true,
               trackOffset = -8,
               trackStrength = 8,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 35,
      customparams = {
          canareaattack = 1,
      },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Luger Wreckage",
               category = "corpses",
               object = "ARMMART_DEAD",
               featuredead = "armmart_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 198,
               damage = 360,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Luger Heap",
               category = "heaps",
               object = "2X2E",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 79,
               damage = 180,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
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
		arm_artillery = {
                     accuracy = 900,
                     areaofeffect = 120,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.5,
                     explosiongenerator = "custom:FLASH4",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "PlasmaCannon",
                     noselfdamage = true,
                     range = 1150,
                     reloadtime = 2.25,
                     soundhit = "xplomed4",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy2",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 335,
                     damage = {
                         default = 165,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "NOTLAND",
                 def = "arm_artillery",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 180,
                 maindir = "0 0 1",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
