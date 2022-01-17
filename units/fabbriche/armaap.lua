-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armaap= {
               acceleration = 0,
               brakerate  = 0,
               buildcostenergy = 26986,
               buildcostmetal = 3006,
               builder = true,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 9,
               buildinggrounddecalsizey = 7,
               buildinggrounddecaltype = "icuaap_pavimento.png",
               buildpic = "icuaap.png",
               buildtime  = 20851,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armaap_dead",
               description = "Produces Level 2 Aircraft",
--               firestandorders = 1,
               energystorage = 200,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 8,
               footprintz = 6,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 3360,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 200,
--               mobilestandorders= 1,
               name = "Advanced Aircraft Plant",
               noAutoFire = false,
               objectname = "icuaap.s3o",
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 312,
--               soundcategory= "AIRPLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 200,
               YardMap= "oooooooooooooooooooooooooooooooooooooooooooooooo",
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
			[1] = "armaca",
			[2] = "armbrawl",
			[3] = "armpnix",
			[4] = "armlance",
			[5] = "armhawk",
			[6] = "armawac",
			[7] = "armdfly",
			[8] = "blade",
			[9] = "armcybr",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Aircraft Plant Wreckage",
               category = "corpses",
               object = "ARMAAP_DEAD",
               featuredead = "armaap_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 7,
               footprintz = 6,
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
  heap = {
               world = "All Worlds",
               description = "Advanced Aircraft Plant Heap",
               category = "heaps",
               object = "6X6A",
               footprintx = 6,
               footprintz = 6,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 977,
               damage = 1008,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:Nano",
               [2]="custom:YellowLight",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "pairwork",
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
                     [1] = "pairactv",
                        },
               unitcomplete = "untdone",
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
