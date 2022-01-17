-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corcv= {
               acceleration = 0.0572,
               brakerate  = 0.1782,
               buildcostenergy = 1979,
               buildcostmetal = 134,
               builddistance = 130,
               builder = true,
               buildpic = "nfacv.png",
               buildtime  = 4160,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL TANK MOBILE NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corcv_dead",
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
               maxdamage = 1290,
               maxslope = 16,
               maxvelocity = 1.815,
               maxwaterdepth = 19,
               metalmake = 0.1,
               metalStorage = 50,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Construction Vehicle",
               noAutoFire = false,
               objectname = "nfacv.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 260,
--               soundcategory= "CORE_CVEHICLE",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               terraformspeed = 270,
               turnrate = 421,
               workertime = 90,
               leaveTracks = true,
               trackOffset = 3,
               trackStrength = 6,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 32,
-----------------------------------
--- BUILDLIST
-----------------------------------
               buildoptions = { 
		[1] = "corsolar",
		[2] = "coradvsol",
		[3] = "corwin",
		[4] = "corgeo",
		[5] = "cormstor",
		[6] = "corestor",
		[7] = "cormex",
		[8] = "corexp",
		[9] = "cormakr",
		[10] = "coravp",
		[11] = "corlab",
		[12] = "corvp",
		[13] = "corap",
		[14] = "corsy",
		[15] = "cornanotc",
		[16] = "coreyes",
		[17] = "corrad",
		[18] = "cordrag",
		[19] = "cormaw",
		[20] = "corllt",
		[21] = "hllt",
		[22] = "corhlt",
		[23] = "corpun",
		[24] = "corrl",
		[25] = "madsam",
		[26] = "corjamt",
		[27] = "corsonar",
		[28] = "cortl",
		[29] = "corfrad",
		[30] = "corfrl",
		[31] = "corfhlt",
		[32] = "corfllt",
		[33] = "fhllt",
		[34] = "corfpun",
		[35] = "fmadsam",
               },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Construction Vehicle Wreckage",
               category = "corpses",
               object = "CORCV_DEAD",
               featuredead = "corcv_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 87,
               damage = 774,
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
               object = "3X3D",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 35,
               damage = 387,
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
               build = "nanlath2",
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
                     [1] = "vcormove",
                    },
               repair = "repair2",
               select = {
                     [1] = "vcorsel",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
}, -- close unit data 
} -- close total
