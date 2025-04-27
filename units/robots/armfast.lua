-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armfast= {
               acceleration = 0.36,
--               badTargetCategory = ANTIEMG,
               brakerate  = 0.375,
               buildcostenergy = 4382,
               buildcostmetal = 177,
               builder = false,
               buildpic = "icufast.png",
               buildtime  = 3960,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armfast_dead",
--               defaultmissiontype = Standby,
               description = "Fast Raider Kbot",
--               firestandorders = 1,
               energymake = 0.4,
               energystorage = 0,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 620,
               maxslope = 17,
               maxvelocity = 3.71,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Zipper",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "ICUFAST.s3o",
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 351,
--               soundcategory= "ARM_KBOT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 1430,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "ANTIEMG",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Zipper Wreckage",
               category = "corpses",
               object = "ARMFAST_DEAD",
               featuredead = "armfast_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 105,
               damage = 240,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Zipper Heap",
               category = "heaps",
               object = "2X2E",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 42,
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
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:emgflare",
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
                     [1] = "kbarmmov",
                    },
               select = {
                     [1] = "kbarmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		arm_fast = {
                     areaofeffect = 16,
                     avoidfeature = true,
                     burst = 5, -- lua:salvoSize
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
                     name= "EMGBurst",
                     noselfdamage = true,
                     range = 220,
                     reloadtime = 0.5,
                     rgbcolor = "1 0.95 0.4",
                     size = "1.5",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "fastemg",
                     turret  = true, 
                     weapontimer = 0.6,
                     weapontype = "LaserCannon",
                     weaponvelocity  = 500,
                     damage = {
                         default = 12,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "arm_fast",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
