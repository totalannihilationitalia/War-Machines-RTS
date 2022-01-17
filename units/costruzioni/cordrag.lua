-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  cordrag= {
               acceleration = 0,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 150,
               buildcostmetal = 10,
               builder = false,
               buildpic = "nfadrag.png",
               buildtime  = 255,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "cordrag_death",
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
               maxslope = 64,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Dragon's Teeth",
               noAutoFire = false,
               objectname = "CORDRAG",
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
               description = "Dragon's Teeth",
               category = "dragonteeth",
               object = "nfadrag.s3o",
               featuredead = "cordrag_heap",
               featurereclamate = "smudge01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 5,
               damage = 2500,
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
               blocking = false,
               hitdensity= 100,
               metal = 2,
               damage = 500,
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
