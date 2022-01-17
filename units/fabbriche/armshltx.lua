-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armshltx= {
               acceleration = 0,
               brakerate  = 0,
               buildcostenergy = 54540,
               buildcostmetal = 7396,
               builder = true,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 12,
               buildinggrounddecalsizey = 12,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icushltx.png",
               buildtime  = 61380,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTSUB NOWEAPON NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armshltx_dead",
               description = "Produces Level 3 Units",
--               firestandorders = 1,
               energystorage = 1400,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 11,
               footprintz = 11,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 14400,
               maxslope = 18,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 800,
--               mobilestandorders= 1,
               name = "Experimental Gantry",
               noAutoFire = false,
               objectname = "icushltx.s3o",
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 273,
--               soundcategory= "CORE_GANTRY",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 600,
               YardMap= "ooooooooooo ooooooooooo oocccccccoo oocccccccoo oocccccccoo oocccccccoo oocccccccoo oocccccccoo oocccccccoo oocccccccoo  oocccccccoo",
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
			[1] = "armraz",
			[2] = "warhammer",
			[3] = "icufurie",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Experimental Gantry Wreckage",
               category = "corpses",
               object = "ARMSHLT_DEAD",
               featuredead = "armshltx_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 9,
               footprintz = 9,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 4807,
               damage = 8640,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "90.0 14.3981628418 90.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Experimental Gantry Heap",
               category = "heaps",
	       collisionvolumeoffsets = "0 0 0",
	       collisionvolumescales = "114 10 129",
               collisionvolumetype = "box",
               object = "7X7B",
               footprintx = 9,
               footprintz = 9,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 1923,
               damage = 4320,
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
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               activate = "gantok2",
               build = "gantok2",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "gantok2",
               repair = "lathelrg",
               select = {
                     [1] = "gantsel1",
                        },
               unitcomplete = "gantok1",
               underattack = "warning1",
               working = "build",
}, --close sound section
}, -- close unit data 
} -- close total
