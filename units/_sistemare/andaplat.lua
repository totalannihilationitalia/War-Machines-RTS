-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andaplat= {
               acceleration = 0,
               brakerate  = 0,
               buildcostenergy = 26986,
               buildcostmetal = 3006,
               builder = true,
               buildpic = "CORPLAT.DDS",
               buildtime  = 20851,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND PLANT NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andaplat_dead",
               description = "Produces Level 2 Aircraft",
--               firestandorders = 1,
               energystorage = 200,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 6,
               footprintz = 6,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 3450,
               maxslope = 15,
               maxvelocity = 0,
--               metalmake = 1,
               metalStorage = 200,
--               minWaterDepth= 30,
--               mobilestandorders= 1,
               name = "Aircraft Plant",
               noAutoFire = false,
               objectname = "andaplat",
               radardistance = 500,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 312,
--               soundcategory= "CORE_SEAPLN_PLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
--               waterline = 33,
               workertime = 200,
               YardMap= "oooooooooooooooooooooooooooooooooooo",
-----------------------------------
--- BUILDLIST
-----------------------------------
               buildoptions = { 
			[1] = "andstr",
			[2] = "anddragon",
			[3] = "corhors",
			[4] = "andhawk",			
               },



-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Aircraft Plant Wreckage",
               category = "corpses",
               object = "andaplat_dead",
               footprintx = 7,
               footprintz = 7,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 1953,
               damage = 2016,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "90.0 14.3981628418 90.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features

},  --  Wreckage and heaps
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "seaplok2",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               select = {
                     [1] = "seaplsl2",
                        },
               unitcomplete = "untdone",
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
