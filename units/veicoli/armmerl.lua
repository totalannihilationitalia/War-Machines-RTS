-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armmerl= {
               acceleration = 0.0198,
--               badTargetCategory = MOBILE,
               brakerate  = 0.0374,
               buildcostenergy = 6146,
               buildcostmetal = 862,
               builder = false,
               buildpic = "icumerl.png",
               buildtime  = 15592,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armmerl_dead",
               damagemodifier = 1,
--               defaultmissiontype = Standby,
               description = "Mobile Rocket Launcher",
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
               maxdamage = 1100,
               maxslope = 16,
               maxvelocity = 0.968,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Merl",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "ICUMERL.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 247,
--               soundcategory= "ARM_VEHICLE",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 520.3,
               workertime = 0,
               wpri_badtargetcategory = "MOBILE",
               leaveTracks = true,
               trackOffset = 15,
               trackStrength = 8,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 38,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Merl Wreckage",
               category = "corpses",
               object = "ARMMERL_DEAD",
               featuredead = "armmerl_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 560,
               damage = 1812,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Merl Heap",
               category = "heaps",
               object = "3X3F",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 224,
               damage = 906,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
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
                     [1] = "varmmove",
                    },
               select = {
                     [1] = "varmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		armtruck_rocket = {
                     areaofeffect = 90,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.5,
                     explosiongenerator = "custom:STARFIRE",
                     firestarter = 100,
                     flighttime = 10,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "rocket",
                     name= "Rocket",
                     noselfdamage = true,
                     range = 1215,
                     reloadtime = 16,
                     smoketrail = true,
                     soundhit = "xplomed4",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Rockhvy1",
                     tolerance = 4000,
                     turnrate = 24384,
                     weaponacceleration = 102.4,
                     weapontimer = 3.3,
                     weapontype = "StarburstLauncher",
                     weaponvelocity  = 380,
                     damage = {
                         default = 1200,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "armtruck_rocket",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
