-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  nfareap= {
               acceleration = 0.044,
--               badTargetCategory = VTOL,
               brakerate  = 0.066,
               buildcostenergy = 11348,
               buildcostmetal = 589,
               builder = false,
               buildpic = "nfareap.png",
               buildtime  = 13530,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "nfareap_dead",
--               defaultmissiontype = Standby,
               description = "Heavy Assault Tank",
--               firestandorders = 1,
               energymake = 0.8,
               energystorage = 0,
               energyUse = 0.8,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 4900,
               maxslope = 12,
               maxvelocity = 2.275,
               maxwaterdepth = 100,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HTANK3",
               name = "Reaper",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfareap.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 462,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 434,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               leaveTracks = true,
               trackOffset = 8,
               trackStrength = 8,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 33,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Reaper Wreckage",
               category = "corpses",
               object = "nfareap_DEAD",
               featuredead = "nfareap_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 350,
               damage = 2340,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Reaper Heap",
               category = "heaps",
               object = "3X3C",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 150,
               damage = 1170,
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
               [1]="custom:MEDIUMFLARE",
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
		core_reap = {
                     areaofeffect = 64,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH72",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "PlasmaCannon",
                     noselfdamage = true,
                     range = 410,
                     reloadtime = 0.7,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannon3",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 380,
                     damage = {
                         default = 97,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "core_reap",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
