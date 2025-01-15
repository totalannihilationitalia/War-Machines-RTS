-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  nfacom_u4= {
               acceleration = 0.18,
               activatewhenbuilt = true,
--               amphibious = 1,
               autoheal = 5,
--               badTargetCategory = NOTAIR,
               brakerate  = 0.375,
               buildcostenergy = 25000,
               buildcostmetal = 2500,
               builddistance = 200,
               builder = true,
               buildpic = "CORCOM.DDS",
               buildtime  = 75000,
               canAttack = true,
--               cancapture = true,
--               canDGun = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               capturespeed = 900,
               category = "ALL WEAPON COMMANDER NOTSUB NOTSHIP NOTAIR SURFACE",
               cloakcost = 100,
               cloakcostmoving = 1000,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "nfacom_dead",
--               defaultmissiontype = Standby,
               description = "Commander",
--               firestandorders = 1,
               energymake = 25,
               energyUse = 0,
               explodeas = "COMMANDER_BLAST",
               footprintx = 2,
               footprintz = 2,
               hidedamage = true,
               icontype = "nfacommander",
               idleautoheal = 5,
               idletime = 1800,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
               mass = 1000,
               maxdamage = 15000,
               maxslope = 20,
               maxvelocity = 1.25,
               maxwaterdepth = 35,
               metalmake = 1.5,
               mincloakdistance = 50,
--               mobilestandorders= 1,
               movementclass = "AKBOT2",
               name = "NFA Commander LvL4",
               nochasecategory = "ALL",
--               norestrict = "1",
               objectname = "NFACOM.s3o",
               radardistance = 700,
               reclaimable = false,
               seismicsignature = 0,
               selfdestructas = "COMMANDER_BLAST",
               selfdestructcountdown = 5,
               showplayername = true,
               sightdistance = 450,
               sonardistance = 300,
--               soundcategory= "CORE_COM",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 0,
               TEDClass = "COMMANDER", -- verificare se necessario
               terraformspeed = 900,
               turnrate = 1133,
               upright = true,
               workertime = 300,
               wpri_badtargetcategory = "NOTAIR",
               wspe_badtargetcategory = "VTOL",
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
		buildoptions = {
			[1] = "corsolar",
			[2] = "corwin",
			[3] = "cormstor",
			[4] = "corestor",
			[5] = "cormex",
			[6] = "cormakr",
			[7] = "corlab",
			[8] = "corvp",
			[9] = "corap",
			[10] = "corsy",
			[11] = "coreyes",
			[12] = "corrad",
			[13] = "corsonar",
			[14] = "cordrag",
			[15] = "corllt",
			[16] = "cortl",
			[17] = "corrl",
			[18] = "corfrad",
			[19] = "corfrl",
			[20] = "corfllt",
		},



-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Commander Wreckage",
               category = "corpses",
               object = "nfacom_DEAD",
               featuredead = "nfacom_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 2500,
               damage = 10000,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Commander Debris",
               category = "heaps",
               object = "2X2C",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 1250,
               damage = 5000,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
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
--- CUSTOM PARAMETERS
-----------------------------------------------------------
		customparams = {
			paralyzemultiplier = 0.025000000372529,
			iscommander = true,
		},
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "nanlath2",
               capture = "capture2",
               cloak = "kloak2",
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
                     [1] = "kcormov",
                    },
               repair = "repair2",
               select = {
                     [1] = "kccorsel",
                        },
               unitcomplete = "kccorsel",
               uncloak = "kloak2un",
               underattack = "warning2",
               working = "reclaim1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		core_laserh1 = {
                     areaofeffect = 14,
                     avoidfeature = true,
                     beamtime = 0.15,
--                     cegTag = "",
                     corethickness = 0.2,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 50,
                     explosiongenerator = "custom:LARGE_YELLOW_LASER_BURN",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HighEnergyLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 620,
                     reloadtime = 1.2,
                     rgbcolor = "1 1 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Lasrmas2",
                     targetmoveerror = 0.2,
                     thickness = 3,
                     tolerance = 10000,
                     turret  = true, 
				weapontype = "BeamLaser",
                     weaponvelocity  = 2250,
                     damage = {
                         default = 261,
                     }, -- close damage
             }, --close single weapon definitions

		arm_disintegrator = {
                     areaofeffect = 36,
                     avoidfeature = true,
					 avoidfriendly = false,	
					 avoidground = false,					 
--                     beamweapon = true,
--                     cegTag = "",
                     commandfire = true,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 500,
                     explosiongenerator = "custom:DGUNTRACE",
                     firestarter = 100,
                     impulseboost = 0,
                     impulsefactor = 0,
                     name= "Disintegrator",
                     noexplode = true,
                     noselfdamage = true,
                     range = 280,
                     reloadtime = 1.4,
                     soundhit = "xplomas2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "disigun1",
                     soundtrigger = "1",
                     tolerance = 10000,
                     turret  = true, 
                     weapontimer = 4.2,
                     weapontype = "DGun",
                     weaponvelocity  = 300,
                     damage = {
                         default = 99999,
                     }, -- close damage
             }, --close single weapon definitions

		jumpstart = {
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     weapontype = " ",
                     damage = {
                         default = ,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "NOTAIR",
                 def = "core_laserh1",
--               onlytargetcategory = " ",
                 },
                 [3] = {
                 def = "arm_disintegrator",
--               onlytargetcategory = " ", -- weapon 3
                 },
                 [4] = {
                 def = "jumpstart",
--               onlytargetcategory = " ", -- weapon 4
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
