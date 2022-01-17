-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corasy= {
               acceleration = 0,
               brakerate  = 0,
               buildcostenergy = 10763,
               buildcostmetal = 3345,
               builder = true,
               buildpic = "nfaasy.png",
               buildtime  = 15696,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOWEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corasy_dead",
               description = "Produces Level 2 Ships",
--               firestandorders = 1,
               energystorage = 200,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 12,
               footprintz = 12,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 4416,
               maxvelocity = 0,
               metalmake = 1,
               metalStorage = 200,
               minWaterDepth= 30,
--               mobilestandorders= 1,
               name = "Advanced Shipyard",
               noAutoFire = false,
               objectname = "nfaasy.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 301.6,
--               soundcategory= "SHIPYARD",
--               standingfireorder = 2,
--               standingmoveorder = 0,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
               waterline = 22,
               workertime = 200,
               YardMap= "wCCCCCCCCCCwCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCwCCCCCCCCCCw",
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
			[1] = "coracsub",
			[2] = "corshark",
			[3] = "corssub",
			[4] = "corarch",
			[5] = "corcrus",
			[6] = "corbats",
			[7] = "corblackhy",
			[8] = "corcarry",
			[9] = "corsjam",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Shipyard Wreckage",
               category = "corpses",
               object = "CORASY_DEAD",
               footprintx = 12,
               footprintz = 12,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 2174,
               damage = 2650,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "90.0 14.3981628418 90.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:WhiteLight",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "pshpwork",
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
                     [1] = "pshpactv",
                        },
               unitcomplete = "untdone",
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
