-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andhart= {
               acceleration = 0.18,
--               badTargetCategory = VTOL,
               brakerate  = 0.188,
               buildcostenergy = 897,
               buildcostmetal = 45,
               builder = false,
               buildpic = "dafare.png",
               buildtime  = 1420,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andscouter_dead",
--               defaultmissiontype = Standby,
               description = "Light Artillery Hovercraft",
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
               movementclass = "HOVER3",
               name = "Recluse",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "andhart.s3o",
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
               object = "andscouter_DEAD",
               featuredead = "andscouter_heap",
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
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
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
		andhart_weapon = {
                     accuracy = 250,
                     areaofeffect = 80,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH4",
                     hightrajectory = 1,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightArtillery",
                     noselfdamage = true,
                     range = 735,
                     reloadtime = 3,
                     soundhit = "TAWF113b",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "TAWF113a",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 370,
                     damage = {
                         default = 130,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "andhart_weapon",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 180,
                 maindir = "0 0 1",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
