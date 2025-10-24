-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armlab= {
               acceleration = 0,
               brakerate  = 0,
--               buildangle = 1024,
               buildcostenergy = 1130,
               buildcostmetal = 605,
               builder = true,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 9,
               buildinggrounddecalsizey = 9,
               buildinggrounddecaltype = "Pavimentazione.png",
               buildpic = "ICULAB.png",
               buildtime  = 6760,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armlab_dead",
               description = "Produces Level 1 Kbots",
--               firestandorders = 1,
               energystorage = 100,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 9,
               footprintz = 9,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 2690,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 100,
--               mobilestandorders= 1,
               name = "Kbot Lab",
               noAutoFire = false,
               objectname = "armlab.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 289,
--               soundcategory= "KBOTPLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 100,
               YardMap= "occcccccoocccccccoocccccccoocccccccoocccccccoocccccccoocccccccoocccccccooccccccco",
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
			[1] = "icuck",
			[2] = "icupatroller",
			[3] = "icurock",
			[4] = "icuinv",
			[5] = "armjeth",
			[6] = "icuwar",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Kbot Lab Wreckage",
               category = "corpses",
               object = "ARMLAB_DEAD",
               featuredead = "armlab_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 6,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 458,
               damage = 1614,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "90.0 14.3981628418 90.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Kbot Lab Heap",
               category = "heaps",
               object = "5X5B",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 183,
               damage = 807,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:Nano",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "plabwork",
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
                     [1] = "plabactv",
                        },
               unitcomplete = "untdone",
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
