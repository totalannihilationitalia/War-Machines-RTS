-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufkaat = {
               acceleration = 0.05,
               activatewhenbuilt = true,
--               badTargetCategory = NOTAIR,
               brakerate  = 0.02,
               buildcostenergy = 5135,
               buildcostmetal = 595,
               builder = false,
               buildpic = "eufkaat.pcx",
               buildtime  = 2,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "TANK WEAPON NOTAIR NOTSUB SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufkaat_dead",
--               defaultmissiontype = Standby,
               description = "Advanced Mobile Missile Launcher",
--               firestandorders = 1,
               energymake = 1.3,
               energystorage = 2,
               energyUse = 1.5,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 3250,
               maxslope = 16,
               maxvelocity = 2.0,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "KAAT",
               noAutoFire = false,
               objectname = "eufkaat.s3o",
               selfdestructas = "BIG_UNIT",
               sightdistance = 500,
--               soundcategory= "ARM_HOVER_BIG",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 684,
               workertime = 0,
               wpri_badtargetcategory = "NOTAIR",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "KAAT Wreckage",
               category = "core_corpses",
               object = "eufkaat_dead",
               featuredead = "eufkaat_heap",
               featurereclamate = "smudge01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 228,
               damage = 1478,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "KAAT Wreckage",
               category = "heaps",
               object = "2x2c",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 114,
               damage = 1478,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
               collisionvolumescales = "35.0 4.0 6.0",
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
                     [1] = "hovlgok1",
                    },
               select = {
                     [1] = "hovlgsl1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		super_missile = {
                     areaofeffect = 64,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:KARGMISSILE_EXPLOSION",
                     firestarter = 5,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "missile",
                     name= "KarganethMissiles",
                     noselfdamage = true,
                     range = 600,
                     reloadtime = 0.3,
                     smoketrail = true,
                     soundhit = "xplosml2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rocklit1",
                     startvelocity = 500,
                     tolerance = 15000,
                     tracks = true, 
		     trajectoryheight = 0.5,
                     turnrate = 65384,
                     turret  = true, 
                     weaponacceleration = 150,
                     weapontimer = 5,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 800,
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
                 def = "super_missile",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
