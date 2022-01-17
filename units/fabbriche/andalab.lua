-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andalab = {
               acceleration = 0,
               brakerate  = 0,
               buildcostenergy = 1772,
               buildcostmetal = 723,
               builder = true,
               buildpic = "andincubator2.png",
               buildtime  = 7151,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andalab_dead",
               description = "Teleport units",
--               firestandorders = 1,
               energymake = 300,
               energystorage = 150,
               energyUse = -200,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 9,
               footprintz = 7,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 2800,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
	       metalmake = 10,
	       makesMetal = 0.1,
               metalStorage = 150,
--               minWaterDepth= 0,
--               mobilestandorders= 1,
               name = "Teleport units",
               noAutoFire = false,
               objectname = "andalab.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 280,
--               soundcategory= "ARM_HOVER_PLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
--               waterline = 5,
               workertime = 100,
               YardMap= "oocccccoo oocccccoo oocccccoo oocccccoo oocccccoo oocccccoo oocccccoo",
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               buildoptions = { 
			[1] = "walker",
			[2] = "corogre",
			[3] = "aexxec",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "arm_corpses",
               object = "andincubator2_dead.s3o",
               featuredead = "andhp_heap",
               featurereclamate = "smudge01",
               footprintx = 10,
               footprintz = 8,
               height = 20,
               hitdensity = 100,
               metal = 3206,
               damage = 3804,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "90.0 14.3981628418 90.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Advance vehicle factory heap",
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
               metal = 2040,
               damage = 4800,
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
               [1]="custom:fleanuklearmini",
               [2]="custom:fleafireLanding",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "hoverok1",
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
                     [1] = "hoversl1",
                        },
               unitcomplete = "untdone",
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
