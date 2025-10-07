-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufflakker= {
--               badTargetCategory = NOTAIR,
--               buildangle = 8192,
               buildcostenergy = 17425,
               buildcostmetal = 1069,
               builder = false,
               buildpic = "arm_flakker.DDS",
               buildtime  = 28508,
               canAttack = true,
               canGuard = true,
--               canstop = 1,
               category = "ARM STRATEGIC WEAPON NOTAIR NOTSUB",
               --collisionvolumeoffsets = "0 0 0",
               --collisionvolumescales = "39 69 39",
               --collisionvolumetype = "CylY",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Anti-Air Flak Gun",
--               firestandorders = 1,
               energystorage = 0,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
               icontype = "building",
               losemitheight = 64,
--               mass = 0 --definire massa,
               maxdamage = 2286,
               maxslope = 10,
               maxwaterdepth = 22,
               metalStorage = 0,
               name = "Flakker",
               objectname = "arm_flakker.3do",
               radardistance = 0,
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 500,
--               soundcategory= "GUARD",
--               standingfireorder = 2,
               TEDClass = "DEFENSIVE", -- verificare se necessario
               workertime = 0,
               wpri_badtargetcategory = "NOTAIR",
               YardMap= "ooo ooo ooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------			   
		featuredefs = {
			dead = {
				blocking = true,
				category = "corpses",
				collisionvolumeoffsets = "-3.8550491333 -3.09570312496e-05 3.13596343994",
				collisionvolumescales = "30.5327911377 31.4515380859 37.50050354",
				collisionvolumetype = "Box",
				damage = 945,
				description = "Flakker Wreckage",
				energy = 0,
				featuredead = "HEAP",
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 20,
				hitdensity = 100,
				metal = 500,
				object = "arm_flakker_dead",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
			heap = {
				blocking = false,
				category = "heaps",
				damage = 473,
				description = "Flakker Heap",
				energy = 0,
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 4,
				hitdensity = 100,
				metal = 200,
				object = "2X2C",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
		},			   		   
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:FLAKFLARE",
               }, -- close effects list
}, -- close section sfxtypes
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
                     avoidfeature = true,
--                     burnblow = true,
                     canattackground = false,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.85,
                     explosiongenerator = "custom:FLASH3",
                     impulseboost = 0,
                     impulsefactor = 0,
                     name= "FlakCannon",
                     noselfdamage = true,
                     range = 775,
                     reloadtime = 0.55,
                     soundhit = "flakhit",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "flakfire",
                     turret  = true, 
                     weapontimer = 1,
                     weapontype = "Cannon",
                     weaponvelocity  = 1550,
                     damage = {
                         default = 1000,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "armflak_gun",
                 onlytargetcategory = "VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
