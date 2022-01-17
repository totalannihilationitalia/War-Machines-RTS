-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armsptk= {
               acceleration = 0.18,
--               badTargetCategory = VTOL,
               brakerate  = 0.188,
               buildcostenergy = 4200,
               buildcostmetal = 375,
               builder = false,
               buildpic = "icusptk.png",
               buildtime  = 8775,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armsptk_dead",
--               defaultmissiontype = Standby,
               description = "All-Terrain Rocket Spider",
--               firestandorders = 1,
               energymake = 0.7,
               energystorage = 0,
               energyUse = 0.7,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
		icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 1000,
               maxdamage = 1050,
               maxvelocity = 1.72,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TKBOT3",
               name = "Recluse",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "ICUSPTK.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 440,
--               soundcategory= "ARM_COSPD",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 1122,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Recluse Wreckage",
               category = "corpses",
               object = "ARMSPTK_DEAD",
               featuredead = "armsptk_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 244,
               damage = 630,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -0.9 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Recluse Heap",
               category = "heaps",
               object = "3X3A",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 98,
               damage = 315,
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
               [1]="custom:rocketflare",
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
                     [1] = "spider2",
                    },
               select = {
                     [1] = "spider3",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		adv_rocket = {
                     areaofeffect = 72,
                     avoidfeature = true,
                     burst = 3, -- lua:salvoSize
                     burstrate = 0.3, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.5,
                     explosiongenerator = "custom:FLASH2",
                     firestarter = 70,
                     flighttime = 2,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "shipmissile",
                     name= "HeavyRocket",
                     noselfdamage = true,
                     range = 550,
                     reloadtime = 3,
                     smoketrail = true,
                     soundhit = "xplosml1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rockhvy3",
                     soundtrigger = "1",
                     startvelocity = 120,
                     targetmoveerror = 0.2,
                     texture2 = "armsmoketrail",
		     trajectoryheight = 1,
                     turnrate = 2000,
                     turret  = true, 
                     weaponacceleration = 80,
                     weapontimer = 6,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 395,
                     damage = {
                         default = 120,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "adv_rocket",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
