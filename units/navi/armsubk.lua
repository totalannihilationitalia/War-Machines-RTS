-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armsubk= {
               acceleration = 0.034,
               activatewhenbuilt = true,
--               badTargetCategory = NOTSUB,
               brakerate  = 0.45,
               buildcostenergy = 9481,
               buildcostmetal = 1048,
               builder = false,
               buildpic = "icusubk.png",
               buildtime  = 17767,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "UNDERWATER ALL NOTLAND MOBILE WEAPON NOTAIR",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armsubk_dead",
--               defaultmissiontype = Standby,
               description = "Submarine Killer",
--               firestandorders = 1,
               energymake = 0.5,
               energystorage = 0,
               energyUse = 0.5,
               explodeas = "SMALL_UNITEX",
               footprintx = 3,
               footprintz = 3,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 895,
               maxvelocity = 3.1,
               metalStorage = 0,
               minWaterDepth= 20,
--               mobilestandorders= 1,
               movementclass = "UBOAT3",
               name = "Piranha",
               noAutoFire = false,
               nochasecategory = "NOTSUB",
               objectname = "icusubk.s3o",
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 390,
               sonardistance = 525,
--               soundcategory= "ARM_SUB",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "WATER", -- verificare se necessario
               turnrate = 298,
               upright = true,
               waterline = 15,
               workertime = 0,
               wpri_badtargetcategory = "NOTSUB",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Piranha Wreckage",
               category = "corpses",
               object = "ARMSUBK_DEAD",
               featuredead = "armsubk_heap",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 681,
               damage = 717,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Piranha Heap",
               category = "heaps",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 181,
               damage = 2016,
               reclaimable = true,
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
                     [1] = "suarmmov",
                    },
               select = {
                     [1] = "suarmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		armsmart_torpedo = {
                     areaofeffect = 16,
                     avoidfeature = true,
--                     burnblow = true,
--                     cegTag = "",
                     collidefriendly = false,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH2",
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "torpedo",
                     name= "AdvancedTorpedo",
                     noselfdamage = true,
                     range = 600,
                     reloadtime = 2,
                     soundhit = "xplodep1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "torpedo1",
                     startvelocity = 120,
                     tolerance = 32767,
                     tracks = true, 
                     turnrate = 12000,
                     turret  = false, 
                     waterweapon = true, 
                     weaponacceleration = 20,
                     weapontimer = 3,
                     weapontype = "TorpedoLauncher",
                     weaponvelocity  = 200,
                     damage = {
                         default = 250,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "NOTSUB",
                 def = "armsmart_torpedo",
--               onlytargetcategory = " ",
                 maxAngleDif = 150,
                 maindir = "0 0 1",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
