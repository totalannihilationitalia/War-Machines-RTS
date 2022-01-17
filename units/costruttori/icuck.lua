-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  icuck= {
               acceleration = 0.24,
               brakerate  = 0.5,
               buildcostenergy = 1521,
               buildcostmetal = 102,
               builddistance = 150,
               builder = true,
               buildpic = "icuck.png",
               buildtime  = 3453,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "KBOT MOBILE ALL NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "icuck_dead",
--               defaultmissiontype = Standby,
               description = "Tech Level 1",
               energymake = 7,
               energystorage = 50,
               energyUse = 7,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 540,
               maxslope = 20,
               maxvelocity = 1.2,
               maxwaterdepth = 25,
               metalmake = 0.07,
               metalStorage = 50,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Construction Kbot",
               noAutoFire = false,
               objectname = "icuck.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 305,
--               soundcategory= "ARM_CKBOT",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               terraformspeed = 270,
               turnrate = 1100,
               upright = true,
               workertime = 90,
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
			[1] = "armsolar",
			[2] = "icuadvsol",
			[3] = "icuwind",
			[4] = "armgeo",
			[5] = "armmstor",
			[6] = "icuestor",
			[7] = "icumetex",
			[8] = "armamex",
			[9] = "armmakr",
			[10] = "armalab",
			[11] = "armlab",
			[12] = "armvp",
			[13] = "armap",
			[14] = "armsy",
			[15] = "armeyes",
			[16] = "armrad",
			[17] = "armdrag",
			[18] = "iculighlturr",
			[19] = "tawf001",
			[20] = "armhlt",
			[21] = "armguard",
			[22] = "armrl",
			[23] = "packo",
			[24] = "armjamt",
			[25] = "armsonar",
			[26] = "armtl",
			[27] = "armfrad",
			[28] = "armfrl",
			[29] = "armfllt",
			[30] = "armfhlt",
			[31] = "armfhllt",
			[32] = "armfguard",
			[33] = "fpacko",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Construction Kbot Wreckage",
               category = "corpses",
               object = "ARMCK_DEAD",
               featuredead = "icuck_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 66,
               damage = 324,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Construction Kbot Heap",
               category = "heaps",
               object = "2X2D",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 26,
               damage = 162,
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
                     [1] = "kbarmmov",
                    },
               repair = "repair1",
               select = {
                     [1] = "kbarmsel",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
}, -- close unit data 
} -- close total
