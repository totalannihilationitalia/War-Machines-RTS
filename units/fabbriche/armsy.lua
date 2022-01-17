-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armsy= {
               acceleration = 0,
               brakerate  = 0,
               buildcostenergy = 775,
               buildcostmetal = 615,
               builder = true,
               buildpic = "icusy.png",
               buildtime  = 6050,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armsy_dead",
               description = "Produces Level 1 Ships",
--               firestandorders = 1,
               energystorage = 100,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 8,
               footprintz = 8,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 2990,
               maxvelocity = 0,
               metalmake = 0.5,
               metalStorage = 100,
               minWaterDepth= 30,
--               mobilestandorders= 1,
               name = "Shipyard",
               noAutoFire = false,
               objectname = "ICUSY.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 275.6,
--               soundcategory= "SHIPYARD",
--               standingfireorder = 2,
--               standingmoveorder = 0,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
               waterline = 1,
               workertime = 100,
               YardMap= "wCCCCCCwCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCwCCCCCCw",
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
			[1] = "armcs",
			[2] = "armsub",
			[3] = "armpt",
			[4] = "decade",
			[5] = "armroy",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Shipyard Wreckage",
               category = "corpses",
               object = "ARMSY_DEAD",
               footprintx = 7,
               footprintz = 7,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 400,
               damage = 1794,
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
               [1]="custom:YellowLight",
               [2]="custom:Nano",
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
