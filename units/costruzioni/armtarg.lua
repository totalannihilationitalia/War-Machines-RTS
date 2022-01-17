-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armtarg= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 6802,
               buildcostmetal = 757,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 5,
               buildinggrounddecalsizey = 5,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icutarg.png",
               buildtime  = 8707,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armtarg_dead",
               description = "Enhanced Radar Targeting",
               energystorage = 0,
               energyUse = 150,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 4,
               footprintz = 4,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
               isTargetingUpgrade = true,
--               mass = 0 --definire massa,
               maxdamage = 1900,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Targeting Facility",
               noAutoFire = false,
               objectname = "ICUTARG.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 273,
--               soundcategory= "ARM_TARG",
               TEDClass = "SPECIAL", -- verificare se necessario
               turnrate = 0,
	       usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "oooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Targeting Facility Wreckage",
               category = "corpses",
               object = "ARMTARG_DEAD",
               featuredead = "armtarg_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 4,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 492,
               damage = 1140,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Targeting Facility Heap",
               category = "heaps",
               object = "4X4A",
               footprintx = 5,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 197,
               damage = 570,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
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
               activate = "Targon1",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "Targoff1",
               select = {
                     [1] = "Targsel1",
                        },
               underattack = "warning1",
               working = "Targsel1",
}, --close sound section
}, -- close unit data 
} -- close total
