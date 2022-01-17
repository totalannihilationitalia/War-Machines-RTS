-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corcrus= {
               acceleration = 0.042,
               activatewhenbuilt = true,
--               badTargetCategory = SHIP,
               brakerate  = 0.062,
--               buildangle = 16384,
               buildcostenergy = 13551,
               buildcostmetal = 1794,
               builder = false,
               buildpic = "nfacrus.png",
               buildtime  = 19950,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE WEAPON SHIP NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corcrus_dead",
--               defaultmissiontype = Standby,
               description = "Cruiser",
--               firestandorders = 1,
               energymake = 2.2,
               energystorage = 0,
               energyUse = 2.2,
               explodeas = "BIG_UNITEX",
	       floater = true,
               footprintx = 5,
               footprintz = 5,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 4649,
               maxvelocity = 2.64,
               metalStorage = 0,
               minWaterDepth= 30,
--               mobilestandorders= 1,
               movementclass = "BOAT5",
               name = "Executioner",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfacrus.s3o",
--               scale = 0.5,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 533,
               sonardistance = 375,
--               soundcategory= "CORE_SHIP",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 448,
               workertime = 0,
               wspe_badtargetcategory = "NOTSUB",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Executioner Wreckage",
               category = "corpses",
               object = "CORCRUS_DEAD",
               featuredead = "corcrus_heap",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 1241,
               damage = 2789,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Executioner Heap",
               category = "heaps",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 476,
               damage = 2016,
               reclaimable = true,
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
                     [1] = "shcormov",
                    },
               select = {
                     [1] = "shcorsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		cor_crus = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.15,
--                     cegTag = "",
                     corethickness = 0.2,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 50,
                     explosiongenerator = "custom:SMALL_ARANCIO_BURN",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HighEnergyLaser",
                     noselfdamage = true,
                     range = 785,
                     reloadtime = 0.9,
                     rgbcolor = "1 1 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Lasrmas2",
                     targetmoveerror = 0.175,
                     thickness = 3,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 700,
                     damage = {
                         default = 180,
                     }, -- close damage
             }, --close single weapon definitions

		adv_decklaser = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.1,
--                     cegTag = "",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 10,
                     explosiongenerator = "custom:SMALL_RED_BURN",
                     firestarter = 30,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "L2DeckLaser",
                     noselfdamage = true,
                     laserflaresize = 12,
                     range = 450,
                     reloadtime = 0.4,
                     rgbcolor = "1 0 0",
                     soundhit = "lasrhit2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir3",
                     soundtrigger = "1",
                     targetmoveerror = 0.1,
                     thickness = 2.5,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 800,
                     damage = {
                         default = 60,
                     }, -- close damage
             }, --close single weapon definitions

		advdepthcharge = {
                     areaofeffect = 32,
                     avoidfeature = true,
--                     burnblow = true,
--                     cegTag = "",
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
 --                   soundhitdry = "",
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
                 def = "cor_crus",
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
