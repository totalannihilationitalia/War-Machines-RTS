-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  coracsub= {
               acceleration = 0.035,
               brakerate  = 0.212,
               buildcostenergy = 7911,
               buildcostmetal = 690,
               builddistance = 300,
               builder = true,
               buildpic = "nfaacsub.png",
               buildtime  = 17228,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL UNDERWATER MOBILE NOTLAND NOWEAPON NOTAIR",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "coracsub_dead",
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
               maxdamage = 370,
               maxvelocity = 2.07,
               metalmake = 0.3,
               metalStorage = 150,
               minWaterDepth= 20,
--               mobilestandorders= 1,
               movementclass = "UBOAT3",
               name = "Advanced Construction Sub",
               noAutoFire = false,
               objectname = "nfa_nave003.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 156,
--               soundcategory= "CORE_CSUB",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               terraformspeed = 900,
               turnrate = 364,
               waterline = 20,
               workertime = 300,
-----------------------------------
--- BUILDLIST
-----------------------------------
               buildoptions = { 
		[1] = "coruwmme",
		[2] = "coruwadves",
		[3] = "coruwadvms",
		[4] = "corsy",
		[5] = "corasy",
		[6] = "corfarad",
		[7] = "corfvipe",
		[8] = "corfflak",
		[9] = "corftoast",
               },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Construction Sub Wreckage",
               category = "corpses",
               object = "CORACSUB_DEAD",
               featuredead = "coracsub_heap",
               footprintx = 4,
               footprintz = 4,
               height = 20,
               blocking= false,
               hitdensity = 100,
               metal = 449,
               damage = 222,
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
               object = "4X4C",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 183,
               damage = 716,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "85.0 14.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
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
                     [1] = "sucormov",
                    },
               repair = "repair1",
               select = {
                     [1] = "sucorsel",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
}, -- close unit data 
} -- close total
