-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corck= {
               acceleration = 0.228,
               brakerate  = 0.475,
               buildcostenergy = 1622,
               buildcostmetal = 113,
               builddistance = 130,
               builder = true,
               buildpic = "nfack.png",
               buildtime  = 3551,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "KBOT MOBILE ALL NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corck_dead",
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
               maxdamage = 590,
               maxslope = 20,
               maxvelocity = 1.15,
               maxwaterdepth = 25,
               metalmake = 0.07,
               metalStorage = 50,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Construction Kbot",
               noAutoFire = false,
               objectname = "nfack.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 299,
--               soundcategory= "COR_CKBOT",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "CNSTR", -- verificare se necessario
               terraformspeed = 270,
               turnrate = 1045,
               upright = true,
               workertime = 90,
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
		[10] = "coralab",
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
               description = "Construction Kbot Wreckage",
               category = "corpses",
               object = "CORCK_DEAD",
               featuredead = "corck_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 73,
               damage = 354,
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
               object = "2X2F",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 29,
               damage = 177,
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
