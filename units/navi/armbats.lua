-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armbats= {
               acceleration = 0.036,
--               badTargetCategory = VTOL,
               brakerate  = 0.031,
--               buildangle = 16384,
               buildcostenergy = 20731,
               buildcostmetal = 5181,
               builder = false,
               buildpic = "icubats.png",
               buildtime  = 58730,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE WEAPON NOTSUB SHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armbats_dead",
--               defaultmissiontype = Standby,
               description = "Battleship",
--               firestandorders = 1,
               energymake = 100,
               energystorage = 0,
               energyUse = 48,
               explodeas = "BIG_UNITEX",
               footprintx = 7,
               footprintz = 7,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 15810,
               maxvelocity = 2.88,
               metalStorage = 0,
               minWaterDepth= 15,
--               mobilestandorders= 1,
               movementclass = "DBOAT6",
               name = "Millennium",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icubats.s3o",
--               scale = 0.6,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 455,
--               soundcategory= "ARM_SHIP",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 310,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Millennium Wreckage",
               category = "corpses",
               object = "ARMBATS_DEAD",
               featuredead = "armbats_heap",
               footprintx = 6,
               footprintz = 6,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 3368,
               damage = 6486,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Millennium Heap",
               category = "heaps",
               object = "6X6D",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 1066,
               damage = 2016,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:POPUPFLAREFAST",
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
                     [1] = "sharmmov",
                    },
               select = {
                     [1] = "sharmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		arm_bats = {
                     accuracy = 350,
                     areaofeffect = 96,
                     avoidfeature = true,
--                     cegTag = ""
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "BattleshipCannon",
                     noselfdamage = true,
                     range = 1240,
                     reloadtime = 0.4,
                     soundhit = "xplomed2",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy1",
                     tolerance = 5000,
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 470,
                     damage = {
                         default = 300,
                     }, -- close damage
             }, --close single weapon definitions
}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "arm_bats",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 330,
                 maindir = "0 0 1",
                 },
                 [2] = {
                 badtargetcategory = "VTOL",
                 def = "arm_bats",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 270,
                 maindir = "0 0 1",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
