-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  nfavrad = {
               acceleration = 0.03,
               activatewhenbuilt = true,
               brakerate  = 0.012,
               buildcostenergy = 1209,
               buildcostmetal = 86,
               builder = false,
               buildpic = "nfavrad.png",
               buildtime  = 4223,
               canAttack = false,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "nfavrad_dead",
--               defaultmissiontype = Standby,
               description = "Radar Vehicle",
               energymake = 8,
               energystorage = 0,
               energyUse = 20,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
	       icontype = "veicoli",
               losemitheight = 80,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 510,
               maxslope = 16,
               maxvelocity = 1.25,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Informer",
               noAutoFire = false,
               objectname = "nfavrad.s3o",
               onoffable = true,
               radardistance = 2200,
               radaremitheight = 80,
               selfdestructas = "BIG_UNIT",
               sightdistance = 900,
               sonardistance = 0,
--               soundcategory= "CORE_VRADAR",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 210,
               workertime = 0,
               leaveTracks = true,
               trackOffset = 0,
               trackStrength = 10,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 23,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Informer Wreckage",
               category = "corpses",
               object = "nfavrad_DEAD",
               featuredead = "nfavrad_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 64,
               damage = 546,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Informer Heap",
               category = "heaps",
               object = "2X2F",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 48,
               damage = 273,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "35.0 4.0 6.0",
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
                     [1] = "vcormove",
                    },
               select = {
                     [1] = "cvradsel",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
