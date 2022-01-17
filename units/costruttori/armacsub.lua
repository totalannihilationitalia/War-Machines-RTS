-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armacsub= {
               acceleration = 0.038,
               brakerate  = 0.25,
               buildcostenergy = 7568,
               buildcostmetal = 695,
               builddistance = 300,
               builder = true,
               buildpic = "icuacsub.png",
               buildtime  = 16565,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "UNDERWATER ALL NOTLAND MOBILE NOWEAPON NOTAIR",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armacsub_dead",
--               defaultmissiontype = Standby,
               description = "Tech Level 2",
               energymake = 30,
               energystorage = 150,
               energyUse = 30,
               explodeas = "SMALL_UNITEX",
               footprintx = 3,
               footprintz = 3,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 360,
               maxvelocity = 2.3,
               metalmake = 0.3,
               metalStorage = 150,
               minWaterDepth= 20,
--               mobilestandorders= 1,
               movementclass = "UBOAT3",
               name = "Advanced Construction Sub",
               noAutoFire = false,
               objectname = "icuacsub.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 156,
--               soundcategory= "ARM_CSUB",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               terraformspeed = 900,
               turnrate = 382,
               waterline = 25,
               workertime = 300,
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
		[1] = "armuwmme",
		[2] = "armsy",
		[3] = "armasy",
		[4] = "armfarad",
		[5] = "armfamb",
		[6] = "armfanni",
		[7] = "armfflak",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Construction Sub Wreckage",
               category = "corpses",
               object = "ARMACSUB_DEAD",
               featuredead = "armacsub_heap",
               footprintx = 4,
               footprintz = 4,
               height = 20,
               blocking= false,
               hitdensity = 100,
               metal = 452,
               damage = 216,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Advanced Construction Sub Heap",
               category = "heaps",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 207,
               damage = 2016,
               reclaimable = true,
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
               [1]="custom:Nano",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "nanlath1",
               capture = "capture1",
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
                     [1] = "suarmmov",
                    },
               repair = "repair1",
               select = {
                     [1] = "suarmsel",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
}, -- close unit data 
} -- close total
