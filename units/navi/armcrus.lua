-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armcrus= {
               acceleration = 0.048,
               activatewhenbuilt = true,
--               badTargetCategory = SHIP,
               brakerate  = 0.062,
--               buildangle = 16384,
               buildcostenergy = 13608,
               buildcostmetal = 1719,
               builder = false,
               buildpic = "icucrus.png",
               buildtime  = 19789,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE WEAPON NOTSUB SHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armcrus_dead",
--               defaultmissiontype = Standby,
               description = "Cruiser",
--               firestandorders = 1,
               energymake = 2.6,
               energystorage = 0,
               energyUse = 2.5,
               explodeas = "BIG_UNITEX",
               footprintx = 5,
               footprintz = 5,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 4506,
               maxvelocity = 2.88,
               metalStorage = 0,
               minWaterDepth= 30,
--               mobilestandorders= 1,
               movementclass = "BOAT5",
               name = "Conqueror",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icucrus.s3o",
--               scale = 0.5,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 572,
               sonardistance = 375,
--               soundcategory= "ARM_SHIP",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 454,
               workertime = 0,
               wspe_badtargetcategory = "NOTSUB",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Conqueror Wreckage",
               category = "corpses",
               object = "ARMCRUS_DEAD",
               featuredead = "armcrus_heap",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 1272,
               damage = 2704,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Conqueror Heap",
               category = "heaps",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 466,
               damage = 2016,
               reclaimable = true,
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
               [1]="custom:azzurroflare",
               [2]="custom:POPUPFLAREFAST",
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
                     [1] = "sharmmov",
                    },
               select = {
                     [1] = "sharmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		arm_crus = {
                     areaofeffect = 16,
                     avoidfeature = true,
--                     cegTag = ""
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH1",
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "CruiserCannon",
                     noselfdamage = true,
                     range = 740,
                     reloadtime = 1.2,
                     soundhit = "xplomed2",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy1",
                     targetmoveerror = 0.1,
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 550,
                     damage = {
                         default = 220,
                     }, -- close damage
             }, --close single weapon definitions

		adv_decklaser = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.1,
                     cegTag = "BLUCRAP",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 10,
                     explosiongenerator = "custom:Gatorazzurro",
                     firestarter = 30,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "L2DeckLaser",
                     noselfdamage = true,
                     laserflaresize = 12,
                     range = 450,
                     reloadtime = 0.4,
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
                     weaponvelocity  = 800,
                     damage = {
                         default = 60,
                     }, -- close damage
             }, --close single weapon definitions

		advdepthcharge = {
                     areaofeffect = 32,
                     avoidfeature = true,
                     burnblow = true,
--                     cegTag = ""
                     collidefriendly = false,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.8,
                     explosiongenerator = "custom:FLASH4",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "DEPTHCHARGE",
                     name= "CruiserDepthCharge",
                     noselfdamage = true,
                     range = 500,
                     reloadtime = 3,
                     soundhit = "xplodep2",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "torpedo1",
                     startvelocity = 110,
                     tolerance = 32767,
                     tracks = true, 
                     turnrate = 9800,
                     turret  = false, 
                     waterweapon = true, 
                     weaponacceleration = 15,
                     weapontimer = 10,
                     weapontype = "TorpedoLauncher",
                     weaponvelocity  = 200,
                     damage = {
                         default = 220,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "arm_crus",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 badtargetcategory = "ANTILASER",
                 def = "adv_decklaser",
                 onlytargetcategory = "SURFACE", -- weapon 2
                 },
                 [3] = {
--                 badtargetcategory = "sistemare",
                 def = "advdepthcharge",
--               onlytargetcategory = " ", -- weapon 3
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
