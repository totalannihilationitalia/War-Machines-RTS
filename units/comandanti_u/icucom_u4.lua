-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  icucom_u4= {
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
               buildpic = "icucom.png",
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
               category = "ALL WEAPON NOTSUB COMMANDER NOTSHIP NOTAIR SURFACE",
               cloakcost = 100,
               cloakcostmoving = 1000,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armcom_dead",
--               defaultmissiontype = Standby,
               description = "International Combat Union Commander",
--               firestandorders = 1,
               energymake = 25,
               energyUse = 0,
               explodeas = "COMMANDER_BLAST",
               footprintx = 2,
               footprintz = 2,
               hidedamage = true,
               icontype = "icucommander",
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
               name = "ICU Commander LvL4",
               nochasecategory = "ALL",
--               norestrict = "1",
               objectname = "icucom.S3O",
               radardistance = 700,
               reclaimable = false,
               seismicsignature = 0,
               selfdestructas = "COMMANDER_BLAST",
               selfdestructcountdown = 5,
               showplayername = true,
               sightdistance = 450,
               sonardistance = 300,
--               soundcategory= "ARM_COM",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 0,
               TEDClass = "COMMANDER", -- verificare se necessario
               terraformspeed = 900,
               turnrate = 1148,
               upright = true,
               workertime = 300,
               wpri_badtargetcategory = "NOTAIR",
               wspe_badtargetcategory = "VTOL",

-----------------------------------
--- BUILDLIST
-----------------------------------
		buildoptions = {
			[1] = "armsolar",
			[2] = "icuwind",
			[3] = "armmstor",
			[4] = "icuestor",
			[5] = "icumetex",
			[6] = "armmakr",
			[7] = "armlab",
			[8] = "armvp",
			[9] = "armap",
			[10] = "armsy",
			[11] = "armeyes",
			[12] = "armrad",
			[13] = "armsonar",
			[14] = "armdrag",
			[15] = "iculighlturr",
			[16] = "armtl",
			[17] = "armrl",
		},



-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               description = "Commander Wreckage",
               object = "ARMCOM_DEAD",
               featuredead = "armcom_heap",
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
               object = "2X2F",
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
               [1]="custom:greenflare",
               [2]="custom:Nano",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "nanlath1",
               capture = "capture1",
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
                     [1] = "kcarmmov",
                    },
               repair = "repair1",
               select = {
                     [1] = "kcarmsel",
                        },
               unitcomplete = "kcarmmov",
               uncloak = "kloak1un",
               underattack = "warning2",
               working = "reclaim1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		arm_laserh1 = {
                     areaofeffect = 14,
                     avoidfeature = true,
                     beamtime = 0.15,
                     cegTag = "GREENCRAP",
                     corethickness = 0.2,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     duration = 0.1,
                     energypershot = 75,
                     explosiongenerator = "custom:GreenLaser",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     Intensity = 1.0,
                     name= "HighEnergyLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 620,
                     reloadtime = 1.2,
                     rgbcolor = "0 1 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Lasrmas2",
                     targetmoveerror = 0.2,
                     thickness = 1.2,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 2250,
                     damage = {
                         default = 387,
                     }, -- close damage
             }, --close single weapon definitions

		arm_disintegrator = {
                     areaofeffect = 36,
                     avoidfeature = true,
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
                     range = 250,
                     reloadtime = 1,
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
                 [3] = {
                 def = "arm_laserh1",
--               onlytargetcategory = " ", -- weapon 3
                 },
                 [4] = {
                 def = "jumpstart",
--               onlytargetcategory = " ", -- weapon 4
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
