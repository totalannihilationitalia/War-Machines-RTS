-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corack= {
               acceleration = 0.204,
               brakerate  = 0.425,
               buildcostenergy = 4342,
               buildcostmetal = 319,
               builddistance = 150,
               builder = true,
               buildpic = "nfaack.png",
               buildtime  = 9709,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "KBOT MOBILE ALL NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corack_dead",
--               defaultmissiontype = Standby,
               description = "Tech Level 2",
               energymake = 14,
               energystorage = 100,
               energyUse = 14,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 900,
               maxslope = 20,
               maxvelocity = 1.1,
               maxwaterdepth = 25,
               metalmake = 0.14,
               metalStorage = 100,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Advanced Construction Kbot",
               noAutoFire = false,
               objectname = "nfaack.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 318.5,
--               soundcategory= "COR_CKBOT",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "CNSTR", -- verificare se necessario
               terraformspeed = 420,
               turnrate = 935,
               upright = true,
               workertime = 140,
-----------------------------------
--- BUILDLIST
-----------------------------------
               buildoptions = { 
		[1] = "corfus",
		[2] = "corgant",
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
		[26] = "corlab",
		[27] = "coralab",
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
               description = "Advanced Construction Kbot Wreckage",
               category = "corpses",
               object = "CORACK_DEAD",
               featuredead = "corack_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 207,
               damage = 540,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Advanced Construction Kbot Heap",
               category = "heaps",
               object = "2X2B",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 83,
               damage = 270,
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
               build = "nanlath2",
               capture = "capture2",
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
                     [1] = "kbcormov",
                    },
               repair = "repair2",
               select = {
                     [1] = "kbcorsel",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
}, -- close unit data 
} -- close total
