-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andtorreattacco_anim2 = {
               buildcostenergy = 1772,
               buildcostmetal = 723,
               builder = true,
               buildpic = "andtorreattacco.png",
               buildtime  = 7151,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOWEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
--               corpse = "andtorreattacco_dead",
               description = "Line of death",
--               firestandorders = 1,
               energystorage = 150,
               energyUse = 0,
               explodeas = "NUCLEAR_MISSILE",
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
               metalStorage = 150,
--               minWaterDepth= 0,
--               mobilestandorders= 1,
               name = "Gabriel",
               noAutoFire = false,
               objectname = "andtorreattacco.s3o",
               radardistance = 50,
               selfdestructas = "NUCLEAR_MISSILE",
               sightdistance = 280,
--               soundcategory= "ARM_HOVER_PLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
--               waterline = 5,
               workertime = 100,
               YardMap= "oocccccoo oocccccoo oocccccoo oocccccoo oocccccoo oocccccoo oocccccoo",
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               buildoptions = { 
			[1] = "andch",
			[2] = "andgaso",
			[3] = "andlipo",
			[4] = "andmisa",
			[5] = "andmiss",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "arm_corpses",
               object = "andtorreattacco_dead.s3o",
               featuredead = "andtorreattacco_heap",
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
--- NO EFFECTS
-----------------------------------------------------------
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
