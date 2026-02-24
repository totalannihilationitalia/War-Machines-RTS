-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  icufff= {
--               buildangle = 5768,
               buildcostenergy = 21941,
               buildcostmetal = 5284,
               builder = true,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 12,
               buildinggrounddecalsizey = 12,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icufff.png",
               buildtime  = 80132,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOWEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "0 5 0",
               --collisionvolumescales = "155 55 155",
               --collisionvolumetype = "box",
               corpse = "icufff_dead",
               description = "Builds sky cruisers",
--               firestandorders = 1,
               energystorage = 500,
               energyUse = 0,
               explodeas = "LARGE_BUILDING",
               footprintx = 10,
               footprintz = 10,
--               mass = 0,
               maxdamage = 4802,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 100,
--               mobilestandorders= 1,
               name = "Anti-gravity hangar",
               noAutoFire = false,
               objectname = "icufff.s3o",
               radardistance = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 510,
--               soundcategory= "ARM_GANTRY",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               usebuildinggrounddecal = true,
               workertime = 400,
               YardMap= "oooooooooo oyyyyyyyyo oyyyyyyyyo oyyyyyyyyo oyyyyyyyyo oyyyyyyyyo oyyyyyyyyo oyyyyyyyyo oyyyyyyyyo oooooooooo",
               buildoptions = { 
--			[1] = "armff",
			[1] = "cirr",
			[2] = "orcl",
			[3] = "demr",
               },



-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Anti-gravity hangar Wreckage",
               category = "corpses",
               object = "icufff_dead",
               featuredead = "icufff_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 6,
               footprintz = 6,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 1754,
               damage = 2578,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
	       collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
	       collisionvolumescales = "90.0 14.3981628418 90.5845489502",
	       collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Anti-gravity hangar Heap",
               category = "heaps",
               object = "6X6D",
               footprintx = 6,
               footprintz = 6,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 877,
               damage = 1289,
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
