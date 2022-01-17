-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andshield= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 2048,
               buildcostenergy = 62191,
               buildcostmetal = 3532,
               builder = false,
               buildpic = "andshield.png",
               buildtime  = 54139,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andshield_dead",
               description = "Plasma Deflector",
               energystorage = 1500,
               energyUse = 0,
               explodeas = "CRAWL_BLAST",
               footprintx = 4,
               footprintz = 4,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 3000,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Shield",
               noAutoFire = false,
--               norestrict = "1",
               objectname = "andshield.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "MINE_NUKE",
               sightdistance = 273,
--               soundcategory= "GATE",
               TEDClass = "SPECIAL", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "oooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Keeper Wreckage",
               category = "corpses",
               object = "ARMGATE_DEAD",
               featuredead = "andshield_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 2296,
               damage = 1800,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Keeper Heap",
               category = "heaps",
               object = "2X2D",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 918,
               damage = 900,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               cant = {
                     [1] = "cantdo4",
                      },
               ok = {
                     [1] = "drone1",
                    },
               select = {
                     [1] = "drone1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		repulsor = {
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     name= "PlasmaRepulsor",
                     range = 400,
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     weapontype = "Shield",
                     damage = {
                         default = 100,
                     }, -- close damage
		shield = {
		     alpha = 0.5,
   		energyuse = 600,
		force = 7,
		intercepttype = 1, --1 identifica la tipologia da respingere Cannon
		power = 6500,
		powerregen = 155,
		powerregenenergy = 562.5,
		radius = 400,
		repulser = true,
		smart = true,
		startingpower = 2500,
		visible = true,
		visiblehitframes = 70,
		badcolor = {
			[1] = 1,
			[2] = 0.2,
			[3] = 0.2,
		},
		goodcolor = {
			[1] = 0.2,
			[2] = 1,
			[3] = 0.2,
		},
	     }, -- close shield definitions
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "repulsor",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
