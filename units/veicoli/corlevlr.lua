-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corlevlr= {
               acceleration = 0.0364,
--               badTargetCategory = VTOL OGGETTISTATICI,
               brakerate  = 0.3618,
               buildcostenergy = 2387,
               buildcostmetal = 210,
               builder = false,
               buildpic = "nfalevlr.png",
               buildtime  = 3009,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON ANTIGATOR ANTIEMG NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corlevlr_dead",
--               defaultmissiontype = Standby,
               description = "Riot Tank",
--               firestandorders = 1,
               energymake = 0.3,
               energystorage = 0,
               energyUse = 0.3,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 1275,
               maxslope = 17,
               maxvelocity = 1.4265,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK2",
               name = "Leveler",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfalevlr.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 286,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 366.2,
               workertime = 0,
               wpri_badtargetcategory = "VTOL OGGETTISTATICI",
               leaveTracks = true,
               trackOffset = 7,
               trackStrength = 6,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 30,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Leveler Wreckage",
               category = "corpses",
               object = "CORLEVLR_DEAD",
               featuredead = "corlevlr_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 190,
               damage = 765,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Leveler Heap",
               category = "heaps",
               object = "2X2B",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 76,
               damage = 383,
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
                     [1] = "tcormove",
                    },
               select = {
                     [1] = "tcorsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		corlevlr_weapon = {
                     areaofeffect = 144,
                     avoidfeature = true,
--                     burnblow = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.75,
                     explosiongenerator = "custom:FLASH64",
                     impulseboost = 0.55,
                     impulsefactor = 0.55,
                     name= "RiotCannon",
                     noselfdamage = true,
                     range = 315,
                     reloadtime = 1.8,
                     soundhit = "xplosml3",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "canlite3",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 550,
                     damage = {
                         default = 220,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "corlevlr_weapon",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
