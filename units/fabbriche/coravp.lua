-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  coravp= {
               acceleration = 0,
               brakerate  = 0,
--               buildangle = 1024,
               buildcostenergy = 14784,
               buildcostmetal = 2647,
               builder = true,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 10,
               buildinggrounddecalsizey = 8,
               buildinggrounddecaltype = "Pavimentazione_nfa_vp.png",
               buildpic = "nfaavp.png",
               buildtime  = 18492,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOWEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "coravp_dead",
               description = "Produces Level 2 Vehicles",
--               firestandorders = 1,
               energystorage = 200,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 9,
               footprintz = 7,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 4628,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 200,
--               mobilestandorders= 1,
               name = "Advanced Vehicle Plant",
               noAutoFire = false,
               objectname = "nfa_adv_vehicle_tex.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 286,
--               soundcategory= "TANKPLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 200,
               YardMap= "oooooooooooooooooooocccccoooocccccoooocccccoooocccccoooocccccoo",
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
			[1] = "coracv",
			[2] = "corseal",
			[3] = "correap",
			[4] = "corparrow",
			[5] = "corgol",
			[6] = "tawf114",
			[7] = "cormart",
			[8] = "corvroc",
			[9] = "corsent",
			[10] = "cormabm",
			[11] = "coreter",
			[12] = "corvrad",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Vehicle Plant Wreckage",
               category = "corpses",
               object = "CORAVP_DEAD",
               featuredead = "coravp_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 6,
               footprintz = 6,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 1721,
               damage = 2777,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "90.0 14.3981628418 90.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Advanced Vehicle Plant Heap",
               category = "heaps",
               object = "6X6C",
               footprintx = 6,
               footprintz = 6,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 860,
               damage = 1389,
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
