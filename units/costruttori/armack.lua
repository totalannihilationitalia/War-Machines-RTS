-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armack= {
               acceleration = 0.216,
               brakerate  = 0.45,
               buildcostenergy = 4084,
               buildcostmetal = 290,
               builddistance = 150,
               builder = true,
               buildpic = "icuack.png",
               buildtime  = 9432,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "KBOT MOBILE ALL NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armack_dead",
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
               maxdamage = 840,
               maxslope = 20,
               maxvelocity = 1.15,
               maxwaterdepth = 25,
               metalmake = 0.14,
               metalStorage = 100,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Advanced Construction Kbot",
               noAutoFire = false,
               objectname = "ICUACK.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 323.7,
--               soundcategory= "ARM_CKBOT",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "CNSTR", -- verificare se necessario
               terraformspeed = 420,
               turnrate = 990,
               upright = true,
               workertime = 140,
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
			[1] = "armfus",
			[2] = "armshltx",
			[3] = "amgeo",
			[4] = "armgmm",
			[5] = "armmoho",
			[6] = "armmmkr",
			[7] = "armuwadves",
			[8] = "armuwadvms",
			[9] = "armarad",
			[10] = "armveil",
			[11] = "armfort",
			[12] = "armasp",
			[13] = "armtarg",
			[14] = "armsd",
			[15] = "armgate",
			[16] = "armamb",
			[17] = "armpb",
			[18] = "armanni",
			[19] = "armflak",
			[20] = "mercury",
			[21] = "armamd",
			[22] = "armsilo",
			[23] = "armbrtha",
			[24] = "armvulc",
			[25] = "armlab",
			[26] = "armalab",
			[27] = "advmoho",
			[28] = "armfarad",
			[29] = "armfamb",
			[30] = "armfanni",
			[31] = "armfflak",
			[32] = "armfmercury",
		},
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
 sfxtypes = {
    explosiongenerators = {
      [[custom:Nano]],
    },
  },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Construction Kbot Wreckage",
               category = "corpses",
               object = "ARMACK_DEAD",
               featuredead = "armack_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 189,
               damage = 504,
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
               metal = 76,
               damage = 252,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
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
