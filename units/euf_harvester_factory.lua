-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  euf_harvester_factory= {
--               acceleration = 0.067,
--               badTargetCategory = ANTILASER,
--               brakerate  = 0.09,
--               buildangle = 16384,
               buildcostenergy = 4639,
               buildcostmetal = 919,
               builder = false,
               buildpic = "euf_harvester_factory.png",
               buildtime  = 14538,
               canAttack = false,
               canGuard = true,
--               canload = 1,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE WEAPON NOTSUB SHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armtship_dead",
--               defaultmissiontype = Standby,
               description = "Harvester Factory",
--               firestandorders = 1,
               energymake = 0.3,
               energystorage = 0,
               energyUse = 0.3,
               explodeas = "BIG_UNITEX",
               footprintx = 23,
               footprintz = 23,
--               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
	 	loadingRadius = 700,
		levelGround = true,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 11010,
--               maxvelocity = 3.34,
               metalStorage = 0,
--               minWaterDepth= 12,
--               mobilestandorders= 1,
--               movementclass = "BOAT5",
               name = "Harvester factory",
               noAutoFire = false,
               nochasecategory = "ALL",
               objectname = "euf_harvester_factory.S3O",
--               scale = 0.5,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 500,
--               soundcategory= "ARM_SHIP",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               transportCapacity = 40,
               transportSize= 4,
--               turnrate = 361,
               workertime = 0,
               wpri_badtargetcategory = "ANTILASER",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  armtship_dead = {
               world = "All Worlds",
               description = "Hulk Wreckage",
               category = "corpses",
               object = "ARMTSHIP_DEAD",
               featuredead = "armtship_heap",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 597,
               damage = 6606,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  armtship_heap = {
               world = "All Worlds",
               description = "Hulk Heap",
               category = "heaps",
               object = "5X5A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 209,
               damage = 2016,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
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
                     [1] = "sharmmov",
                    },
               select = {
                     [1] = "sharmsel",
                        },
               underattack = "warning1",
}, --close sound section
                 badtargetcategory = "ANTILASER",
}, -- close unit data 
} -- close total
