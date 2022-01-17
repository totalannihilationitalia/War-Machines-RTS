-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  ARMJAM= {
               acceleration = 0.035,
               activatewhenbuilt = true,
--               badTargetCategory = MOBILE,
               brakerate  = 0.012,
               buildcostenergy = 1621,
               buildcostmetal = 97,
               builder = false,
               buildpic = "icujam.png",
               buildtime  = 5933,
               canAttack = false,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armjam_dead",
--               defaultmissiontype = Standby,
               description = "Radar Jammer Vehicle",
               energymake = 16,
               energystorage = 0,
               energyUse = 100,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
	       icontype = "veicoli",
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 460,
               maxslope = 16,
               maxvelocity = 1.2,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Jammer",
               noAutoFire = false,
               nochasecategory = "MOBILE",
               objectname = "ICUJAM.s3o",
               onoffable = true,
               radardistance = 0,
               radarDistanceJam = 450,
               selfdestructas = "BIG_UNIT",
               sightdistance = 300,
--               soundcategory= "ARM_VJAM",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 505,
               workertime = 0,
               leaveTracks = true,
               trackOffset = 8,
               trackStrength = 10,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 22,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Jammer Wreckage",
               category = "corpses",
               object = "ARMJAM_DEAD",
               featuredead = "armjam_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 78,
               damage = 368,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Jammer Heap",
               category = "heaps",
               object = "3X3B",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 39,
               damage = 368,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
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
                     [1] = "radjam1",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
