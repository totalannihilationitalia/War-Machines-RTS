-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corlab= {
               acceleration = 0,
               brakerate  = 0,
--               buildangle = 1024,
               buildcostenergy = 1250,
               buildcostmetal = 580,
               builder = true,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 8,
               buildinggrounddecalsizey = 8,
               buildinggrounddecaltype = "Pavimentazione_nfa_lab.png",
               buildpic = "nfalab.png",
               buildtime  = 7000,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOWEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corlab_dead",
               description = "Produces Level 1 Kbots",
--               firestandorders = 1,
               energystorage = 100,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 6,
               footprintz = 6,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 2600,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 100,
--               mobilestandorders= 1,
               name = "Kbot Lab",
               noAutoFire = false,
               objectname = "nfarobotfact.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 287.3,
--               soundcategory= "KBOTPLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 100,
               YardMap= "occccooccccooccccooccccooccccoocccco",
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
			[1] = "corck",
			[2] = "nfaak",
			[3] = "nfastorm",
			[4] = "nfathud",
			[5] = "corcrash",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Kbot Lab Wreckage",
               category = "corpses",
               object = "CORLAB_DEAD",
               featuredead = "corlab_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 6,
               footprintz = 6,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 442,
               damage = 1560,
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
               object = "6X6B",
               footprintx = 6,
               footprintz = 6,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 177,
               damage = 780,
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
               [1]="custom:WhiteLight",
               [2]="custom:Nano",
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
