-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andahp_nocostr= {
               buildcostenergy = 14000,
               buildcostmetal = 3607,
               builder = true,
               buildpic = "andahp.png",
               buildtime  = 18492,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOWEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andahp_nocostr_dead",
               description = "Builds Level 2 Hovercraft",
--               firestandorders = 1,
               energystorage = 300,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 12,
               footprintz = 9,
               icontype = "factory",
--               mass = 0 --definire massa,
               maxdamage = 5205,
               maxwaterdepth = 0,
               metalStorage = 300,
--               minWaterDepth= 30,
--               mobilestandorders= 1,
               name = "Adv. Hovercraft Platform",
               noAutoFire = false,
               objectname = "andahp.s3o",
               radardistance = 50,
               radarDistanceJam = 60,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 290,
--               soundcategory= "CORE_HOVER_PLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               waterline = 5,
               workertime = 200,
               YardMap= "wCCCCCCCCCCw CCCCCCCCCCCC CCCCCCCCCCCC CCCCCCCCCCCC CCCCCCCCCCCC CCCCCCCCCCCC CCCCCCCCCCCC CCCCCCCCCCCC wCCCCCCCCCCw",
-----------------------------------
--- BUILDLIST
-----------------------------------
               buildoptions = { 
			[1] = "androck",
			[2] = "andtanko",
			[3] = "andtesla",
		},


-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "arm_corpses",
               object = "andahp_dead",
               featuredead = "andahp_nocostr_heap",
               featurereclamate = "smudge01",
               footprintx = 10,
               footprintz = 8,
               height = 20,
               hitdensity = 100,
               metal = 3206,
               damage = 3804,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "90.0 14.3981628418 90.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Advance vehicle factory heap",
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
               build = "hoverok2",
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
                     [1] = "hoversl2",
                        },
               unitcomplete = "untdone",
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
