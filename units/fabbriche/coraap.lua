-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  coraap= {
               acceleration = 0,
               brakerate  = 0,
               buildcostenergy = 26571,
               buildcostmetal = 2979,
               builder = true,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 9,
               buildinggrounddecalsizey = 9,
               buildinggrounddecaltype = "Pavimentazione_nfa_aap.png",
               buildpic = "nfaaap.png",
               buildtime  = 20678,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOWEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "coraap_dead",
               description = "Produces Level 2 Aircraft",
--               firestandorders = 1,
               energystorage = 200,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 8,
               footprintz = 8,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 3520,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 200,
--               mobilestandorders= 1,
               name = "Advanced Aircraft Plant",
               noAutoFire = false,
               objectname = "nfaaap.s3o",
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 305.5,
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
			[1] = "coraca",
			[2] = "corape",
			[3] = "corhurc",
			[4] = "cortitan",
			[5] = "corvamp",
			[6] = "corawac",
			[7] = "corcrw",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Aircraft Plant Wreckage",
               category = "corpses",
               object = "CORAAP_DEAD",
               featuredead = "coraap_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 7,
               footprintz = 6,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 1936,
               damage = 2112,
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
               metal = 968,
               damage = 1056,
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
