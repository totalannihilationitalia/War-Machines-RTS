-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armfarad= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 17830,
               buildcostmetal = 525,
               builder = false,
               buildpic = "icufarad.png",
               buildtime  = 11800,
               canAttack = false,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armfarad_dead",
               description = "Long-Range Radar",
               energystorage = 0,
               energyUse = 18,
               explodeas = "SMALL_BUILDINGEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "radar",
               idleautoheal = 5,
               idletime = 1800,
               losemitheight = 250,
--               mass = 0 --definire massa,
               maxdamage = 320,
               maxslope = 10,
               maxvelocity = 0,
               minWaterDepth= 10,
               metalStorage = 0,
               name = "Advanced Radar Tower",
               noAutoFire = false,
               objectname = "icufarad.s3o",
               onoffable = true,
               radardistance = 3500,
               radaremitheight = 250,
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 820,
--               soundcategory= "ARM_ADVRADAR",
               TEDClass = "SPECIAL", -- verificare se necessario
               turnrate = 0,
               waterline = 4,
               YardMap= "oooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Radar Tower Wreckage",
               category = "corpses",
               object = "ARMARAD_DEAD",
               featuredead = "armfarad_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 341,
               damage = 192,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Advanced Radar Tower Heap",
               category = "heaps",
               object = "2X2C",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 136,
               damage = 96,
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
               activate = "radadvn1",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "radadde1",
               select = {
                     [1] = "radadvn1",
                        },
               underattack = "warning1",
               working = "radar2",
}, --close sound section
}, -- close unit data 
} -- close total
