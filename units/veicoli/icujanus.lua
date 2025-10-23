-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  icujanus= {
               acceleration = 0.0198,
--               badTargetCategory = VTOL,
               brakerate  = 0.055,
               buildcostenergy = 2361,
               buildcostmetal = 226,
               builder = false,
               buildpic = "icujanus.png",
               buildtime  = 3545,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "icujanus_dead",
--               defaultmissiontype = Standby,
               description = "Twin Medium Rocket Launcher",
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
               maxdamage = 880,
               maxslope = 10,
               maxvelocity = 1.958,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK2",
               name = "Janus",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icujanus.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 325,
--               soundcategory= "ARM_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 338.8,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               leaveTracks = true,
               trackOffset = 3,
               trackStrength = 6,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 24,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Janus Wreckage",
               category = "corpses",
               object = "icujanus_DEAD",
               featuredead = "icujanus_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 147,
               damage = 528,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Janus Heap",
               category = "heaps",
               object = "2X2C",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 59,
               damage = 264,
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
               [1]="custom:plasmaflare",
               [2]="custom:rocketflare",
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
		janus_rocket = {
                     areaofeffect = 128,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:VEHROCKET_EXPLOSION",
                     firestarter = 70,
                     impulseboost = 0.75,
                     impulsefactor = 0.75,
                     model = "megamisl",
                     name= "HeavyRocket",
                     noselfdamage = true,
                     range = 380,
                     reloadtime = 7.5,
                     smoketrail = true,
                     soundhit = "xplosml2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rocklit1",
                     startvelocity = 190,
                     texture2 = "armsmoketrail",
                     tracks = true, 
		     trajectoryheight = 0.5,
                     turnrate = 22000,
                     turret  = true, 
                     weaponacceleration = 100,
                     weapontimer = 3,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 190,
                     damage = {
                         default = 330,
                     }, -- close damage
             }, --close single weapon definitions
}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "janus_rocket",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 badtargetcategory = "VTOL",
                 def = "janus_rocket",
                 onlytargetcategory = "SURFACE",
		 slaveto = 1,
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
