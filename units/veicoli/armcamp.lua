-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armcamp= {
               acceleration = 0.02,
--               badTargetCategory = VTOL,
               brakerate  = 0.0495,
               buildcostenergy = 22000,
               buildcostmetal = 1700,
               builder = false,
               buildpic = "icucampbell.png",
               buildtime  = 32000,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armcamp_dead",
--               defaultmissiontype = Standby,
               description = "Heavy Assault Tank",
--               firestandorders = 1,
               energymake = 0.8,
               energystorage = 0,
               energyUse = 0.6,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
	       icontype = "veicoli",
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 6500,
               maxslope = 22,
               maxvelocity = 1.3,
               maxwaterdepth = 10,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HTANK4",
               name = "M1A4 Campbell",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icuCAMPbell.s3o",
               radardistance = 0,
               selfdestructas = "BIG_UNITEX",
               sightdistance = 400,
--               soundcategory= "KROGOTH",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 200,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Campbell Wreckage",
               category = "arm_corpses",
               object = "ARMCAMP_dead",
               featuredead = "armcamp_heap",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 4,
               height = 15,
               blocking= true,
               hitdensity = 90,
               metal = 1000,
               damage = 11968,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "36.0 14.3981628418 40.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Campbell Wreckage",
               category = "heaps",
               object = "3x3f",
               footprintx = 3,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 90,
               metal = 500,
               damage = 5984,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
               collisionvolumescales = "55.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:azzurroflare",
               [2]="custom:goliathflare",
               }, -- close effects list
}, -- close section sfxtypes
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
                     [1] = "krogok1",
                    },
               select = {
                     [1] = "krogsel1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		cor_gol = {
                     areaofeffect = 292,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HeavyCannon",
                     noselfdamage = true,
                     range = 750, 
                     reloadtime = 3,
                     soundhit = "xplomed4",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy2",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 310,
                     damage = {
                         default = 900,
                     }, -- close damage
             }, --close single weapon definitions

		arm_lightlaser = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.12,
--                     beamweapon = true,
                     cegTag = "BLUCRAP",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 20,
                     explosiongenerator = "custom:Gatorazzurro",
                     firestarter = 30,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 430,
                     reloadtime = 0.48,
                     rgbcolor = "0 0.5 1",
                     soundhit = "lasrhit2",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir3",
                     soundtrigger = "1",
                     targetmoveerror = 0.1,
                     thickness = 2.5,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 2250,
                     damage = {
                         default = 75,
                     }, -- close damage
             }, --close single weapon definitions

		campbell_rocket = {
                     areaofeffect = 90,
                     avoidfeature = true,
--                     cegTag = ""
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.5,
                     explosiongenerator = "custom:STARFIRE",
                     firestarter = 100,
                     flighttime = 10,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "rocket",
                     name= "Rocket",
                     noselfdamage = true,
                     range = 800,
                     reloadtime = 40,
                     smoketrail = true,
                     soundhit = "xplomed4",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Rockhvy1",
                     tolerance = 4000,
                     turnrate = 24384,
                     weaponacceleration = 102.4,
                     weapontimer = 3.3,
                     weapontype = "StarburstLauncher",
                     weaponvelocity  = 380,
                     damage = {
                         default = 1200,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "cor_gol",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 badtargetcategory = "VTOL",
                 def = "arm_lightlaser",
                 onlytargetcategory = "SURFACE", -- weapon 2
                 },
                 [3] = {
                 badtargetcategory = "VTOL",
                 def = "campbell_rocket",
                 onlytargetcategory = "SURFACE", -- weapon 3
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
