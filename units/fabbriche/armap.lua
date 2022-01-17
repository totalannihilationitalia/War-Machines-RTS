-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armap= {
               acceleration = 0,
               activatewhenbuilt = false,
               brakerate  = 0,
               buildcostenergy = 1370,
               buildcostmetal = 850,
               builder = true,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 9,
               buildinggrounddecalsizey = 7,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icuap.png",
               buildtime  = 7240,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND PLANT NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armap_dead",
               description = "Produces Level 1 Aircraft",
--               firestandorders = 1,
               energystorage = 100,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 8,
               footprintz = 6,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 1850,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 100,
--               mobilestandorders= 1,
               name = "Aircraft Plant",
               noAutoFire = false,
               objectname = "icuap.s3o",
               radardistance = 500,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 292,
--               soundcategory= "AIRPLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 100,
               YardMap= "oooooooooooooooooooooooooooooooooooooooooooooooo",
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
			[1] = "armca",
			[2] = "armpeep",
			[3] = "armfig",
			[4] = "armthund",
			[5] = "armatlas",
			[6] = "armkam",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Aircraft Plant Wreckage",
               category = "corpses",
               object = "ARMAP_DEAD",
               featuredead = "armap_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 7,
               footprintz = 6,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 553,
               damage = 1110,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "90.0 14.3981628418 90.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Aircraft Plant Heap",
               category = "heaps",
               object = "6X6B",
               footprintx = 6,
               footprintz = 6,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 221,
               damage = 555,
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
               [1]="custom:YellowLight",
               [2]="custom:Nano",
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
