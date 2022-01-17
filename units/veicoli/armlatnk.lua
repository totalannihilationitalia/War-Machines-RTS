-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armlatnk= {
               acceleration = 0.125,
               brakerate  = 0.125,
               buildcostenergy = 7000,
               buildcostmetal = 307,
               builder = false,
               buildpic = "ARMLATNK.png",
               buildtime  = 7534,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armlatnk_dead",
--               defaultmissiontype = Standby,
               description = "Lightning Tank",
--               firestandorders = 1,
               energymake = 1.5,
               energystorage = 0,
               energyUse = 1.5,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 950,
               maxslope = 10,
               maxvelocity = 3.326,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK2",
               name = "Panther",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icultank.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 390,
--               soundcategory= "ARM_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 550,
               workertime = 0,
               leaveTracks = true,
               trackOffset = 6,
               trackStrength = 5,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 30,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Panther Wreckage",
               category = "corpses",
               object = "ARMLATNK_DEAD",
               featuredead = "armlatnk_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 200,
               damage = 720,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Panther Heap",
               category = "heaps",
               object = "2X2D",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 80,
               damage = 360,
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
               [1]="custom:azzurroflare",
               [2]="custom:rocketflare",
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
                     [1] = "tarmmove",
                    },
               select = {
                     [1] = "tarmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		armlatnk_weapon = {
                     areaofeffect = 8,
                     avoidfeature = true,
--                     beamweapon = true,
                      cegTag = "BLUCRAP",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     duration = 10,
                     energypershot = 5,
                     explosiongenerator = "custom:Gatorazzurro",
--                     explosiongenerator = "custom:LIGHTNING_FLASH",
                     firestarter = 50,
                     impactonly = true,
                     impulseboost = 0.234,
                     impulsefactor = 0.234,
                     name= "LightningGun",
                     noselfdamage = true,
                     range = 320,
                     reloadtime = 1.4,
		     rgbcolor = "0 0.5 1",
                     soundhit = "lashit",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lghthvy1",
                     soundtrigger = "1",
                     turret  = true, 
                     weapontype = "LightningCannon",
                     weaponvelocity  = 400,
                     damage = {
                         default = 227,
                     }, -- close damage
             }, --close single weapon definitions

		armamph_missile = {
                     areaofeffect = 48,
                     avoidfeature = true,
                     canattackground = false,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH2",
                     firestarter = 70,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "missile",
                     name= "Missiles",
                     noselfdamage = true,
                     range = 600,
                     reloadtime = 2,
                     smoketrail = true,
                     soundhit = "xplosml2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rocklit1",
                     startvelocity = 650,
                     texture2 = "armsmoketrail",
                     tolerance = 9000,
                     tracks = true, 
                     turnrate = 48000,
                     turret  = true, 
                     weaponacceleration = 141,
                     weapontimer = 5,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 850,
                     damage = {
                         default = 85,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL", 
                 def = "armlatnk_weapon",
                 onlytargetcategory = "SURFACE",
                 },
                 [3] = {
                 def = "armamph_missile",
                 onlytargetcategory = "VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
