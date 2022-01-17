-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corgate= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 2048,
               buildcostenergy = 63833,
               buildcostmetal = 3736,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 5,
               buildinggrounddecalsizey = 5,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfagate.png",
               buildtime  = 57166,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corgate_dead",
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
               maxdamage = 3200,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Overseer",
               noAutoFire = false,
--               norestrict = "1",
               objectname = "nfashield.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "MINE_NUKE",
               sightdistance = 273,
--               soundcategory= "GATE",
               TEDClass = "SPECIAL", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "oooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Overseer Wreckage",
               category = "corpses",
               object = "CORGATE_DEAD",
               featuredead = "corgate_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 2428,
               damage = 1920,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Overseer Heap",
               category = "heaps",
               object = "2X2E",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 971,
               damage = 960,
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
		intercepttype = 1,
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
