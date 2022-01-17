-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corgol= {
               acceleration = 0.0242,
               brakerate  = 0.0495,
               buildcostenergy = 19892,
               buildcostmetal = 1567,
               builder = false,
               buildpic = "nfagol.png",
               buildtime  = 26125,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corgol_dead",
--               defaultmissiontype = Standby,
               description = "Very Heavy Assault Tank",
--               firestandorders = 1,
               energymake = 0.5,
               energystorage = 0,
               energyUse = 0.5,
               explodeas = "BIG_UNITEX",
               footprintx = 4,
               footprintz = 4,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 7000,
               maxslope = 12,
               maxvelocity = 1.35,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HTANK4",
               name = "Goliath",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfa_hvytank.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 495,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 220,
               workertime = 0,
               leaveTracks = true,
               trackOffset = 8,
               trackStrength = 10,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 49,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Goliath Wreckage",
               category = "corpses",
               object = "CORGOL_DEAD",
               featuredead = "corgol_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 4,
               footprintz = 4,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 894,
               damage = 3900,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "35.0 14.3981628418 36.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Goliath Heap",
               category = "heaps",
               object = "4X4C",
               footprintx = 4,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 378,
               damage = 1950,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "85.0 14.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:goliathflare",
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
		cor_gol = {
                     areaofeffect = 292,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HeavyCannon",
                     noselfdamage = true,
                     range = 750,
                     reloadtime = 3,
                     soundhit = "xplomed4",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy2",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 310,
                     damage = {
                         default = 900,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "cor_gol",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
