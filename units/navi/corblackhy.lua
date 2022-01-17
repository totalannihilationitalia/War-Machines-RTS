-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corblackhy= {
               acceleration = 0.026,
               activatewhenbuilt = true,
               brakerate  = 0.019,
--               buildangle = 16384,
               buildcostenergy = 252321,
               buildcostmetal = 34585,
               buildpic = "nfablackhy.png",
               buildtime  = 309264,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL WEAPON NOTSUB SHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corblackhy_dead",
               damagemodifier = 1,
--               defaultmissiontype = Standby,
               description = "Flagship",
--               firestandorders = 1,
               energymake = 175,
               energystorage = 1000,
               energyUse = 190,
               explodeas = "ATOMIC_BLAST",
               footprintx = 8,
               footprintz = 8,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 1640,
--               mass = 0 --definire massa,
               maxdamage = 77500,
               maxvelocity = 1.96,
               metalStorage = 100,
               minWaterDepth= 15,
--               mobilestandorders= 1,
               movementclass = "DBOAT6",
               name = "Black Hydra",
               noAutoFire = false,
               objectname = "nfa_nave002.s3o",
               radardistance = 1510,
--               scale = 100,
               seismicsignature = 0,
               selfdestructas = "ATOMIC_BLAST",
               sightdistance = 650,
--               soundcategory= "ARM_SHIP",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 260,
               waterline = 5,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Black Hydra Wreckage",
               category = "corpses",
               object = "CORBLACKHY_DEAD",
               featuredead = "corblackhy_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 6,
               footprintz = 18,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 22480,
               damage = 46500,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Black Hydra Heap",
               category = "heaps",
               object = "6X6A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 10066,
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
		hydra_prime = {
                     accuracy = 400,
                     areaofeffect = 128,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "BattleshipCannon",
                     noselfdamage = true,
                     range = 2450,
                     reloadtime = 0.5,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy1",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 600,
                     damage = {
                         default = 400,
                     }, -- close damage
             }, --close single weapon definitions

		hydra_gun = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.25,
--                     cegTag = "",
                     corethickness = 0.4,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 50,
                    explosiongenerator = "custom:SMALL_ARANCIO_BURN",  --LARGE_YELLOW_LASER_BURN",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HighEnergyLaser",
                     noselfdamage = true,
                     laserflaresize = 20,
                     range = 1150,
                     reloadtime = 1,
                     rgbcolor = "1 1 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Lasrmas2",
                     targetmoveerror = 0.2,
                     thickness = 4,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 900,
                     damage = {
                         default = 380,
                     }, -- close damage
             }, --close single weapon definitions

		hydramiss = {
                     areaofeffect = 64,
                     avoidfeature = true,
--                     burnblow = true,
                     canattackground = false,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.9,
                     explosiongenerator = "custom:FLASH2",
                     firestarter = 70,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "missile",
                     name= "RapidSamMissile",
                     noselfdamage = true,
                     range = 950,
                     reloadtime = 0.3,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Rocklit3",
                     startvelocity = 650,
                     tolerance = 8000,
                     tracks = true, 
                     turnrate = 72000,
                     turret  = true, 
                     weaponacceleration = 150,
                     weapontimer = 7,
                     weapontype = "Cannon",
                     weaponvelocity  = 950,
                     damage = {
                         default = 125,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "hydra_prime",
                 onlytargetcategory = "SURFACE",
                 },

                 [2] = {
                 def = "hydra_gun",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 300,
                 maindir = "0 0 1",
                 },

                 [3] = {
                 def = "hydramiss",
                 onlytargetcategory = "VTOL",
                 },

                [4] = {
                 def = "hydra_gun",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 300,
                 maindir = "0 0 1",
                 },

                [5] = {
                 def = "hydra_gun",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 300,
                 maindir = "0 0 1",
                 },

                [6] = {
                 def = "hydramiss",
                 onlytargetcategory = "VTOL",
                 },

}, -- close weapon usage

}, -- close unit data 
} -- close total
