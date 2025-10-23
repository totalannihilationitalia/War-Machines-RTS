-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  icuseer= {
               acceleration = 0.0418,
               activatewhenbuilt = true,
               brakerate  = 0.0165,
               buildcostenergy = 1941,
               buildcostmetal = 115,
               builder = false,
               buildpic = "icuseer.png",
               buildtime  = 6186,
               canAttack = false,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "icuseer_dead",
--               defaultmissiontype = Standby,
               description = "Radar Vehicle",
               energymake = 8,
               energystorage = 0,
               energyUse = 20,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
               losemitheight = 80,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 880,
               maxslope = 16,
               maxvelocity = 2.024,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Seer",
               noAutoFire = false,
               objectname = "icuseer.s3o",
               onoffable = true,
               radardistance = 2300,
               radaremitheight = 80,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 900,
--               soundcategory= "ARM_VRADAR",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 605,
               workertime = 0,
               leaveTracks = true,
               trackOffset = 5,
               trackStrength = 5,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 25,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Seer Wreckage",
               category = "corpses",
               object = "icuseer_DEAD",
               featuredead = "icuseer_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 80,
               damage = 528,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Seer Heap",
               category = "heaps",
               object = "3X3E",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 48,
               damage = 264,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
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
               select = {
                     [1] = "avradsel",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
