-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corcs= {
               acceleration = 0.04,
               brakerate  = 0.04,
               buildcostenergy = 2375,
               buildcostmetal = 260,
               builddistance = 250,
               builder = true,
               buildpic = "nfacs.png",
               buildtime  = 5537,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE NOTSUB SHIP NOWEAPON NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corcs_dead",
--               defaultmissiontype = Standby,
               description = "Tech Level 1",
               energymake = 25,
               energystorage = 100,
               energyUse = 25,
               explodeas = "SMALL_UNITEX",
               footprintx = 4,
               footprintz = 4,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 1150,
               maxvelocity = 2.3,
               metalmake = 0.25,
               metalStorage = 100,
               minWaterDepth= 15,
--               mobilestandorders= 1,
               movementclass = "BOAT4",
               name = "Construction Ship",
               noAutoFire = false,
               objectname = "nfacs.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 286,
--               soundcategory= "CORE_CSHIP",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "CNSTR", -- verificare se necessario
               terraformspeed = 750,
               turnrate = 426,
               workertime = 250,
-----------------------------------
--- BUILDLIST
-----------------------------------
               buildoptions = { 
		[1] = "coruwmex",
		[2] = "coreyes",
		[3] = "corsy",
		[4] = "corasy",
		[5] = "corsonar",
		[6] = "cortl",
		[7] = "corfrad",
		[8] = "corfrl",
		[9] = "corfhlt",
		[10] = "corfllt",
		[11] = "fhllt",
		[12] = "corfpun",
		[13] = "fmadsam",
               },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Construction Ship Wreckage",
               category = "corpses",
               object = "CORCS_DEAD",
               featuredead = "corcs_heap",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 169,
               damage = 690,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Construction Ship Heap",
               category = "heaps",
               object = "5X5C",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 66,
               damage = 2016,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
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
               build = "nanlath2",
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
                     [1] = "shcormov",
                    },
               repair = "repair2",
               select = {
                     [1] = "shcorsel",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
}, -- close unit data 
} -- close total
