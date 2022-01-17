-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andfury= {
--               badTargetCategory = NOTAIR,
--               buildangle = 9814,
               buildcostenergy = 20154,
               buildcostmetal = 3601,
               builder = false,
               buildpic = "",
               buildtime  = 40358,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andfury_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Rapid Anti-Air Flakker",
--               firestandorders = 1,
               energystorage = 0,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 2,
               footprintz = 2,
--               mass = 0 --definire massa,
               maxdamage = 2574,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Fury",
               noAutoFire = false,
               objectname = "andfury",
               radardistance = 0,
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 400,
--               soundcategory= "GUARD",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               workertime = 0,
               wpri_badtargetcategory = "NOTAIR",
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Wreckage",
               object = "andfury_dead",
               featuredead = "andfury_heap",
               featurereclamate = "smudge01",
               footprintx = 2,
               footprintz = 2,
               height = 10,
               blocking= true,
               hitdensity = 23,
               metal = 214,
               damage = 4545,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  heap = {
               world = "all",
               description = "Metal Shards",
               category = "heaps",
               object = "2x2b",
               footprintx = 3,
               footprintz = 3,
               blocking = false,
               hitdensity= 4,
               metal = 198,
               damage = 34,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
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
               cloak = "kloak1",
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
                     [1] = "twrturn3",
                    },
               select = {
                     [1] = "twrturn3",
                        },
               uncloak = "kloak1un",
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
		weapondefs = {
			armflak_gun = {
				accuracy = 1000,
				areaofeffect = 192,
				avoidfriendly = false,
				burnblow = true,
				canattackground = false,
				collidefriendly = false,
				color = 1,
				craterboost = 0,
				cratermult = 0,
				cylindertargetting = 1,
				edgeeffectiveness = 0.85000002384186,
				explosiongenerator = "custom:FLASH3",
				gravityaffected = "true",
				impulseboost = 0,
				impulsefactor = 0,
				mygravity = 0.01,
				name = "FlakCannon",
				noselfdamage = true,
				predictboost = 1,
				range = 775,
				reloadtime = 0.55000001192093,
				soundhit = "flakhit",
				soundstart = "flakfire",
				toairweapon = true,
				turret = true,
				weapontimer = 1,
				weapontype = "Cannon",
				weaponvelocity = 2450,
				damage = {
					["else"] = 10,
					bombers = 250,
					commanders = 10,
					crawlingbombs = 10,
					default = 1000,
					fighters = 500,
					heavyunits = 10,
					mines = 10,
					nanos = 10,
					subs = 10,
					vtol = 250,
				},
			},
		},
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
		weapons = {
			[1] = {
				badtargetcategory = "NOTAIR",
				def = "ARMFLAK_GUN",
				onlytargetcategory = "VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
