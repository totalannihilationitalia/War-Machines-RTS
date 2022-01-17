-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armmship= {
               acceleration = 0.024,
               activatewhenbuilt = true,
--               badTargetCategory = MOBILE,
               brakerate  = 0.028,
               buildcostenergy = 9804,
               buildcostmetal = 2648,
               builder = false,
               buildpic = "icumship.png",
               buildtime  = 22317,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE WEAPON NOTSUB SHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armmship_dead",
               damagemodifier = 0.5,
--               defaultmissiontype = Standby,
               description = "Cruise Missile Ship",
--               firestandorders = 1,
               energymake = 0.8,
               energystorage = 0,
               energyUse = 0.8,
               explodeas = "BIG_UNITEX",
               footprintx = 6,
               footprintz = 6,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 2200,
               maxvelocity = 2.88,
               metalStorage = 0,
               minWaterDepth= 12,
--               mobilestandorders= 1,
               movementclass = "BOAT5",
               name = "Ranger",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icumship.s3o",
               radardistance = 1400,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 318.5,
--               soundcategory= "ARM_SHIP",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 347,
               workertime = 0,
               wpri_badtargetcategory = "MOBILE",
               wspe_badtargetcategory = "ALL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Ranger Wreckage",
               category = "corpses",
               object = "ARMMSHIP_DEAD",
               featuredead = "armmship_heap",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 1721,
               damage = 1320,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Ranger Heap",
               category = "heaps",
               object = "4X4B",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 491,
               damage = 2016,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "85.0 14.0 6.0",
               collisionvolumetype = "cylY",
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
		armmship_rocket = {
                     areaofeffect = 96,
                     avoidfeature = true,
--                     burnblow = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASHSMALLUNIT",
                     firestarter = 100,
                     flighttime = 15,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "rocket",
                     name= "Rocket",
                     noselfdamage = true,
                     range = 1550,
                     reloadtime = 6,
                     smoketrail = true,
                     soundhit = "xplomed4",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Rockhvy1",
                     tolerance = 4000,
                     turnrate = 24384,
                     weaponacceleration = 80,
                     weapontimer = 5,
                     weapontype = "StarburstLauncher",
                     weaponvelocity  = 400,
                     damage = {
                         default = 800,
                     }, -- close damage
             }, --close single weapon definitions

			armmship_missile = {
				areaofeffect = 48,
				canattackground = false,
				craterboost = 0,
				cratermult = 0,
				explosiongenerator = "custom:FLASH2",
				firestarter = 70,
				flighttime = 3,
				impulseboost = 0.12300000339746,
				impulsefactor = 0.12300000339746,
				metalpershot = 0,
				model = "missile",
				name = "Missiles",
				noselfdamage = true,
				range = 760,
				reloadtime = 2,
				smoketrail = true,
				soundhit = "xplosml2",
				soundstart = "rocklit1",
				startvelocity = 650,
				texture2 = "armsmoketrail",
				toairweapon = true,
				tolerance = 9000,
				tracks = true,
				turnrate = 63000,
				turret = true,
				weaponacceleration = 141,
				weapontimer = 5,
				weapontype = "MissileLauncher",
				weaponvelocity = 850,
				damage = {
					default = 110,
					subs = 5,
				},
},
}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "MOBILE",
                 def = "armmship_rocket",
                 onlytargetcategory = "SURFACE",
                 },
                 [3] = {
                 def = "armmship_missile",
                 onlytargetcategory = "VTOL", -- weapon 3
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
