-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  cormexp= {
               acceleration = 0,
               activatewhenbuilt = true,
--               badTargetCategory = ANTILASER,
               brakerate  = 0,
--               buildangle = 2048,
               buildcostenergy = 12121,
               buildcostmetal = 2219,
               builder = false,
               buildpic = "nfamexp.png",
               buildtime  = 32500,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "cormexp_dead",
               damagemodifier = 0.3,
               description = "Convertible Metal Extractor",
--               firestandorders = 1,
               energystorage = 0,
               energyUse = 12,
               explodeas = "SMALL_BUILDINGEX",
               ExtractsMetal = 0.0035,
               footprintx = 5,
               footprintz = 5,
	       iconType = "metal",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 2000,
               maxslope = 20,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 500,
               name = "Moho Exploiter",
               noAutoFire = false,
               nochasecategory = "MOBILE",
               objectname = "cormexp.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 676,
--               soundcategory= "CORE_MOHO",
--               standingfireorder = 2,
               TEDClass = "METAL", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               wpri_badtargetcategory = "ANTILASER",
               YardMap= "ooooooooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Moho Exploiter Wreckage",
               category = "corpses",
               object = "CORMEXP_DEAD",
               featuredead = "cormexp_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 5,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 1442,
               damage = 1200,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Moho Exploiter Heap",
               category = "heaps",
               object = "5X5A",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 577,
               damage = 600,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:rocketflare",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               activate = "mohorun2",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "mohooff2",
               ok = {
                     [1] = "twractv3",
                    },
               select = {
                     [1] = "mohoon2",
                        },
               underattack = "warning1",
               working = "mohorun2",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		corsumo_weapon = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.15,
--                     cegTag = "",
                     corethickness = 0.3,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 75,
                     explosiongenerator = "custom:LARGE_YELLOW_LASER_BURN",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HighEnergyLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 650,
                     reloadtime = 0.55,
                     rgbcolor = "1 1 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrhvy3",
                     targetmoveerror = 0.25,
                     thickness = 3,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 800,
                     damage = {
                         default = 275,
                     }, -- close damage
             }, --close single weapon definitions

		cormexp_rocket = {
                     areaofeffect = 128,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH96",
                     firestarter = 70,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "missile",
                     name= "RocketBattery",
                     noselfdamage = true,
                     range = 650,
                     reloadtime = 0.2,
                     smoketrail = true,
                     soundhit = "xplosml2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rocklit1",
                     startvelocity = 450,
                     turret  = true, 
                     weaponacceleration = 150,
                     weapontimer = 5,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 750,
                     damage = {
                         default = 375,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "ANTILASER",
                 def = "corsumo_weapon",
--               onlytargetcategory = " ",
                 },
                 [2] = {
                 badtargetcategory = "VTOL",
                 def = "cormexp_rocket",
--               onlytargetcategory = " ", -- weapon 2
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
