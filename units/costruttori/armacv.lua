-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armacv= {
               acceleration = 0.0363,
               brakerate  = 0.1518,
               buildcostenergy = 5263,
               buildcostmetal = 431,
               builddistance = 150,
               builder = true,
               buildpic = "icuacv.png",
               buildtime  = 12397,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL TANK MOBILE NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armacv_dead",
--               defaultmissiontype = Standby,
               description = "Tech Level 3",
               energymake = 20,
               energystorage = 100,
               energyUse = 20,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
               icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 1860,
               maxslope = 16,
               maxvelocity = 1.87,
               maxwaterdepth = 18,
               metalmake = 0.2,
               metalStorage = 100,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Advanced Construction Vehicle",
               noAutoFire = false,
               objectname = "icuacv.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 289.9,
--               soundcategory= "ARM_CVEHICLE",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "CNSTR", -- verificare se necessario
               terraformspeed = 750,
               turnrate = 399,
               workertime = 250,
               leaveTracks = true,
               trackOffset = 0,
               trackStrength = 6,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 34,
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
		[1] = "armfus",
		[2] = "icugant",
		[3] = "aafus",
		[4] = "amgeo",
		[5] = "armgmm",
		[6] = "armmoho",
		[7] = "armmmkr",
		[8] = "armuwadves",
		[9] = "armuwadvms",
		[10] = "armarad",
		[11] = "armveil",
		[12] = "armfort",
		[13] = "armasp",
		[14] = "armtarg",
		[15] = "armsd",
		[16] = "armgate",
		[17] = "armamb",
		[18] = "armpb",
		[19] = "armanni",
		[20] = "armflak",
		[21] = "mercury",
		[22] = "armamd",
		[23] = "armsilo",
		[24] = "armbrtha",
		[25] = "armvulc",
		[26] = "armvp",
		[27] = "armavp",
		[28] = "advmoho",
		[29] = "armfarad",
		[30] = "armfamb",
		[31] = "armfanni",
		[32] = "armfflak",
		[33] = "armfmercury",
		},


-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Construction Vehicle Wreckage",
               category = "corpses",
               object = "ARMACV_DEAD",
               featuredead = "armacv_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 280,
               damage = 1116,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Advanced Construction Vehicle Heap",
               category = "heaps",
               object = "3X3A",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 112,
               damage = 558,
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
