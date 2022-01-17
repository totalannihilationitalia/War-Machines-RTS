-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  tawf013= {
               acceleration = 0.0154,
--               badTargetCategory = VTOL,
               brakerate  = 0.0154,
               buildcostenergy = 2016,
               buildcostmetal = 142,
               builder = false,
               buildpic = "tawf013.png",
               buildtime  = 2998,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "tawf013_dead",
--               defaultmissiontype = Standby,
               description = "Light Artillery Vehicle",
--               firestandorders = 1,
               energymake = 1,
               energystorage = 0,
               energyUse = 1,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
               highTrajectory = 1,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 530,
               maxslope = 15,
               maxvelocity = 1.958,
               maxwaterdepth = 8,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Shellshocker",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icuarty.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 364,
--               soundcategory= "ARM_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 393.8,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               highTrajectory = 1,
               leaveTracks = true,
               trackOffset = 6,
               trackStrength = 5,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 30,
      customparams = {
          canareaattack = 1,
      },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Shellshocker Wreckage",
               category = "corpses",
               object = "TAWF013_DEAD",
               featuredead = "tawf013_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 24,
               blocking= true,
               hitdensity = 100,
               metal = 92,
               damage = 318,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Shellshocker Heap",
               category = "heaps",
               object = "3X3A",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 37,
               damage = 159,
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
		tawf113_weapon = {
                     accuracy = 250,
                     areaofeffect = 80,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH4",
                     hightrajectory = 1,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightArtillery",
                     noselfdamage = true,
                     range = 710,
                     reloadtime = 3,
                     soundhit = "TAWF113b",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "TAWF113a",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 370,
                     damage = {
                         default = 130,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "tawf113_weapon",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 180,
                 maindir = "0 0 1",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
