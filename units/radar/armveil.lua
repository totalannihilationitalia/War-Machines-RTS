-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armveil= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 17501,
               buildcostmetal = 119,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 4,
               buildinggrounddecalsizey = 4,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icuveil.png",
               buildtime  = 9080,
               canAttack = false,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armveil_dead",
               description = "Long-Range Jamming Tower",
               energymake = 0,
               energystorage = 0,
               energyUse = 125,
               explodeas = "SMALL_BUILDINGEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "radar",
               idleautoheal = 5,
               idletime = 1800,
               losemitheight = 250, -- verificare se necessario che è un jammer
--               mass = 0 --definire massa,
               maxdamage = 750,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Veil",
               noAutoFire = false,
               objectname = "icuveil.s3o",
               onoffable = true,
               radarDistanceJam = 760,
               radaremitheight = 250, -- verificare se necessario che è un jammer
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 155,
--               soundcategory= "ARM_JAM",
               TEDClass = "SPECIAL", -- verificare se necessario
               turnrate = 0,
	       usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "oooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Veil Wreckage",
               category = "corpses",
               object = "ARMVEIL_DEAD",
               featuredead = "armveil_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 77,
               damage = 450,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Veil Heap",
               category = "heaps",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 31,
               damage = 225,
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
                     [1] = "kbarmmov",
                    },
               select = {
                     [1] = "radjam1",
                        },
               underattack = "warning1",
}, --close sound section
                 maxAngleDif = 1,
}, -- close unit data 
} -- close total
