-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armcs= {
               acceleration = 0.05,
               brakerate  = 0.05,
               buildcostenergy = 2130,
               buildcostmetal = 255,
               builddistance = 250,
               builder = true,
               buildpic = "icucs.png",
               buildtime  = 5121,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE NOTSUB NOWEAPON SHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armcs_dead",
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
               maxdamage = 1105,
               maxvelocity = 2.53,
               metalmake = 0.25,
               metalStorage = 100,
               minWaterDepth= 15,
--               mobilestandorders= 1,
               movementclass = "BOAT4",
               name = "Construction Ship",
               noAutoFire = false,
               objectname = "icucs.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 291.2,
--               soundcategory= "ARM_CSHIP",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               terraformspeed = 750,
               turnrate = 448,
               workertime = 250,
-----------------------------------
--- BUILDLIST
-----------------------------------
               buildoptions = { 
		[1] = "armuwmex",
		[2] = "armsy",
		[3] = "armasy",
		[4] = "armsonar",
		[5] = "armtl",
		[6] = "armfrad",
		[7] = "armfrl",
		[8] = "armfllt",
		[9] = "armfhlt",
		[10] = "armfhllt",
		[11] = "armfguard",
		[12] = "fpacko",
               },



-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Construction Ship Wreckage",
               category = "corpses",
               object = "ARMCS_DEAD",
               featuredead = "armcs_heap",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 166,
               damage = 663,
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
               object = "5X5A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 59,
               damage = 716,
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
                     [1] = "sharmmov",
                    },
               repair = "repair1",
               select = {
                     [1] = "sharmsel",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
}, -- close unit data 
} -- close total
