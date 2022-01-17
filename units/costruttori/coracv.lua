-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  coracv= {
               acceleration = 0.033,
               brakerate  = 0.1375,
               buildcostenergy = 5512,
               buildcostmetal = 452,
               builddistance = 150,
               builder = true,
               buildpic = "nfaacv.png",
               buildtime  = 12882,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL TANK MOBILE NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "coracv_dead",
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
               maxdamage = 1930,
               maxslope = 16,
               maxvelocity = 1.76,
               maxwaterdepth = 18,
               metalmake = 0.2,
               metalStorage = 100,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Advanced Construction Vehicle",
               noAutoFire = false,
               objectname = "nfaacv.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 295.1,
--               soundcategory= "CORE_CVEHICLE",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "CNSTR", -- verificare se necessario
               terraformspeed = 750,
               turnrate = 363,
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
		[1] = "corfus",
		[2] = "cafus",
		[3] = "cmgeo",
		[4] = "corbhmth",
		[5] = "cormoho",
		[6] = "cormexp",
		[7] = "cormmkr",
		[8] = "coruwadves",
		[9] = "coruwadvms",
		[10] = "corarad",
		[11] = "corshroud",
		[12] = "corfort",
		[13] = "corasp",
		[14] = "cortarg",
		[15] = "corsd",
		[16] = "corgate",
		[17] = "cortoast",
		[18] = "corvipe",
		[19] = "cordoom",
		[20] = "corflak",
		[21] = "screamer",
		[22] = "corfmd",
		[23] = "corsilo",
		[24] = "corint",
		[25] = "corbuzz",
		[26] = "corvp",
		[27] = "coravp",
		[28] = "corfarad",
		[29] = "corftoast",
		[30] = "corfvipe",
		[31] = "corfdoom",
		[32] = "corfflak",
		[33] = "corfscreamer",
               },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Construction Vehicle Wreckage",
               category = "corpses",
               object = "CORACV_DEAD",
               featuredead = "coracv_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 294,
               damage = 1158,
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
               metal = 118,
               damage = 579,
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
