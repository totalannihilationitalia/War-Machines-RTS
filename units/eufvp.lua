-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufvp = {
               buildcostenergy = 1200,
               buildcostmetal = 650,
               builder = true,
               buildpic = "eufvp",
               buildtime  = 6930,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOWEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufvp_dead",
               description = "Builds 1 lvl tanks",
--               firestandorders = 1,
               energystorage = 150,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 7,
               footprintz = 7,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 2580,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 150,
--               minWaterDepth= 0,
--               mobilestandorders= 1,
               name = "Tank Plant",
               noAutoFire = false,
               objectname = "eufvp",
               radardistance = 50,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 270,
--               soundcategory= "ARM_HOVER_PLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
--               waterline = 5,
               workertime = 100,
               YardMap= "occccco occccco occccco occccco occccco occccco occccco",
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               buildoptions = { 
			[1] = "eufcd",
			[2] = "eufthorn",
			[3] = "eufsab",
--			[4] = "andmisa",
--			[5] = "andmiss",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "arm_corpses",
               object = "eufvp_dead",
               featuredead = "eufvp_heap",
               featurereclamate = "smudge01",
               footprintx = 7,
               footprintz = 7,
               height = 24,
               hitdensity = 100,
               metal = 520,
               damage = 2064,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "90.0 14.3981628418 90.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Wreckage",
               category = "heaps",
	       collisionvolumeoffsets = "0 0 0",
	       collisionvolumescales = "114 10 129",
               collisionvolumetype = "box",
               object = "7X7B",
               footprintx = 9,
               footprintz = 9,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 2040,
               damage = 4800,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
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
               build = "pvehwork",
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
                     [1] = "pvehactv",
                        },
               unitcomplete = "untdone",
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
