-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  ruspa_builder= {
               acceleration = 0.0605,
               brakerate  = 0.2068,
               buildcostenergy = 1802,
               buildcostmetal = 128,
               builddistance = 150,
               builder = true,
               buildpic = "ruspa_builder.png",
               buildtime  = 4066,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL TANK MOBILE NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armcv_dead",
--               defaultmissiontype = Standby,
               description = "Tech Level 1",
               energymake = 10,
               energystorage = 50,
               energyUse = 10,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
               icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 1240,
               maxslope = 16,
               maxvelocity = 1.925,
               maxwaterdepth = 18,
               metalmake = 0.1,
               metalStorage = 50,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Construction Vehicle",
               noAutoFire = false,
               objectname = "ruspa_builder.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 253,
--               soundcategory= "ARM_CVEHICLE",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "CNSTR", -- verificare se necessario
               terraformspeed = 270,
               turnrate = 435,
               workertime = 90,
               leaveTracks = true,
               trackOffset = 12,
               trackStrength = 6,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 35,
-----------------------------------
--- BUILDLIST
-----------------------------------
               buildoptions = { 
		[1] = "controllo_spazioporto",
		[2] = "eufhq",
               },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Construction Vehicle Wreckage",
               category = "corpses",
               object = "ARMCV_DEAD",
               featuredead = "armcv_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 83,
               damage = 744,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Construction Vehicle Heap",
               category = "heaps",
               object = "3X3C",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 33,
               damage = 372,
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
               [1]="custom:Nano",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "nanlath1",
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
                     [1] = "varmmove",
                    },
               repair = "repair1",
               select = {
                     [1] = "varmsel",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
}, -- close unit data 
} -- close total
