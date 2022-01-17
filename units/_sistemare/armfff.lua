-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armfff= {
--               buildangle = 5768,
               buildcostenergy = 21941,
               buildcostmetal = 5284,
               builder = true,
               buildpic = "",
               buildtime  = 80132,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "0 5 0",
               --collisionvolumescales = "155 55 155",
               --collisionvolumetype = "box",
               corpse = "armfff_dead",
               description = "Builds sky cruisers",
--               firestandorders = 1,
               energystorage = 500,
               energyUse = 0,
               explodeas = "LARGE_BUILDING",
               footprintx = 10,
               footprintz = 10,
--               mass = 0 --definire massa,
               maxdamage = 4802,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 100,
--               mobilestandorders= 1,
               name = "Anti-gravity hangar",
               noAutoFire = false,
               objectname = "ARMFFF",
               radardistance = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 510,
--               soundcategory= "ARM_GANTRY",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               workertime = 400,
               YardMap= "oooooooooo oyyyyyyyyo oyyyyyyyyo oyyyyyyyyo oyyyyyyyyo oyyyyyyyyo oyyyyyyyyo oyyyyyyyyo oyyyyyyyyo oooooooooo",
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
--			[1] = "armff",
			[1] = "cirr",
			[2] = "demr",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  armfff_dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "arm_corpses",
               object = "ARMFFF_dead",
               featurereclamate = "smudge01",
               footprintx = 6,
               footprintz = 6,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 5009,
               damage = 6931,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
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
