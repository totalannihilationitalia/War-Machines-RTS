-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  coralab= {
               acceleration = 0,
               brakerate  = 0,
--               buildangle = 1024,
               buildcostenergy = 15232,
               buildcostmetal = 2681,
               builder = true,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 12,
               buildinggrounddecalsizey = 11,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfaalab.png",
               buildtime  = 16819,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOWEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "coralab_dead",
               description = "Produces Level 2 Kbots",
--               firestandorders = 1,
               energystorage = 200,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 7,
               footprintz = 6,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 4072,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 200,
--               mobilestandorders= 1,
               name = "Advanced Kbot Lab",
               noAutoFire = false,
               objectname = "nfa_advance_robot_plant.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 288.6,
--               soundcategory= "KBOTPLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 200,
               YardMap= "ooooooooooooooocccccoccccccccccccccccccccc",
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
			[1] = "corack",
			[2] = "nfapyro",
			[3] = "corcan",
			[4] = "corsumo",
			[5] = "cormort",
			[6] = "corhrk",
			[7] = "coraak",
			[8] = "corvoyr",
			[9] = "corspy",
			[10] = "corspec",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Kbot Lab Wreckage",
               category = "corpses",
               object = "CORALAB_DEAD",
               featuredead = "coralab_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 6,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 1743,
               damage = 2443,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "90.0 14.3981628418 90.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Advanced Kbot Lab Heap",
               category = "heaps",
               object = "5X5A",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 872,
               damage = 1222,
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
               [1]="custom:WhiteLight",
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
