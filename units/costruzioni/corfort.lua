-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corfort= {
               acceleration = 0,
               brakerate  = 0,
--               buildangle = 0,
               buildcostenergy = 612,
               buildcostmetal = 23,
               builder = false,
               buildpic = "nfafort.png",
               buildtime  = 810,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corfort_death",
               description = "Perimeter Defense",
               energymake = 0,
               energystorage = 0,
               energyUse = 0,
               explodeas = "",
               footprintx = 2,
               footprintz = 2,
               idleautoheal = 5,
               idletime = 1800,
               isFeature= true,
--               mass = 0 --definire massa,
               maxdamage = 100,
               maxslope = 24,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Fortification Wall",
               noAutoFire = false,
               objectname = "nfafort.s3o",
               seismicsignature = 0,
               selfdestructas = "",
               sightdistance = 130,
--               soundcategory= "NONE",
               TEDClass = "FORT", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "ffff",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  death = {
               world = "allworld",
               description = "Fortification Wall",
               category = "dragonteeth",
               object = "nfafort.s3o",
               featuredead = "corfort_heap",
               featurereclamate = "smudge01",
               footprintx = 2,
               footprintz = 2,
               height = 55,
               blocking= true,
               hitdensity = 100,
               metal = 15,
               damage = 15000,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "greenworld",
               description = "Rubble",
               category = "rocks",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking = true,
               hitdensity= 100,
               metal = 7,
               damage = 5000,
               reclaimable = true,
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
}, --close sound section
}, -- close unit data 
} -- close total
