-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  aseadragon= {
               acceleration = 0.028,
               activatewhenbuilt = true,
               brakerate  = 0.021,
--               buildangle = 16384,
               buildcostenergy = 238406,
               buildcostmetal = 32122,
               buildpic = "icuseadragon.png",
               buildtime  = 299523,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL WEAPON NOTSUB SHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "aseadragon_dead",
               damagemodifier = 1,
--               defaultmissiontype = Standby,
               description = "Flagship",
--               firestandorders = 1,
               energymake = 150,
               energystorage = 1000,
               energyUse = 150,
               explodeas = "ATOMIC_BLAST",
               footprintx = 8,
               footprintz = 8,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 71250,
               maxvelocity = 2.3,
               metalStorage = 100,
               minWaterDepth= 15,
--               mobilestandorders= 1,
               movementclass = "DBOAT6",
               name = "Epoch",
               noAutoFire = false,
               objectname = "icuseadragon.s3o",
               radardistance = 1530,
--               scale = 10,
               seismicsignature = 0,
               selfdestructas = "ATOMIC_BLAST",
               sightdistance = 689,
--               soundcategory= "ARM_SHIP",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 272,
               waterline = 5,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Epoch Wreckage",
               category = "corpses",
               object = "ASEADRAGON_DEAD",
               featuredead = "aseadragon_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 6,
               footprintz = 18,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 20879,
               damage = 42750,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Epoch Heap",
               category = "heaps",
               object = "6X6A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 5066,
               damage = 20016,
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
		seadragprime = {
                     accuracy = 350,
                     areaofeffect = 64,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH4",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "BattleshipCannon",
                     noselfdamage = true,
                     range = 2450,
                     reloadtime = 0.53,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy1",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 600,
                     damage = {
                         default = 250,
                     }, -- close damage
             }, --close single weapon definitions

		arm_batsaftx = {
                     accuracy = 350,
                     areaofeffect = 96,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASHSMALLUNIT",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "BattleShipCannon",
                     noselfdamage = true,
                     range = 1300,
                     reloadtime = 1.2,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
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

		seadragonflak = {
                     accuracy = 1000,
                     areaofeffect = 128,
                     avoidfeature = true,
--                     burnblow = true,
                     canattackground = false,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.85,
                     explosiongenerator = "custom:FLASHSMALLBUILDINGEX",
                     impulseboost = 0,
                     impulsefactor = 0,
                     name= "FlakCannon",
                     noselfdamage = true,
                     range = 775,
                     reloadtime = 0.55,
                     soundhit = "flakhit",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "flakfire",
                     turret  = true, 
                     weapontimer = 1,
                     weapontype = "Cannon",
                     weaponvelocity  = 1550,
                     damage = {
                         default = 1000,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "seadragprime",
                 onlytargetcategory = "SURFACE",
                 },

                 [2] = {
                 def = "arm_batsaftx",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 320,
                 maindir = "0 0 1",
                 },

                 [3] = {
                 def = "seadragprime",
                 onlytargetcategory = "SURFACE",
                  maxAngleDif = 240,
                 MainDir = "0 0 1",
                 },

                 [4] = {
                 def = "arm_batsaftx",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 180,
                 maindir = "-4 0 1",
                 },

                 [5] = {
                 def = "arm_batsaftx",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 180,
                 maindir = "4 0 1",
                 },

                 [6] = {
                 def = "seadragonflak",
                 onlytargetcategory = "VTOL",
                 maxAngleDif = 200,
                 maindir = "1 0 0",
                 },

                [7] = {
                 def = "seadragonflak",
                 onlytargetcategory = "VTOL",
                 maxAngleDif = 200,
                 maindir = "-1 0 0",
                 },

}, -- close weapon usage

}, -- close unit data 
} -- close total
