-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andahaa= {
               acceleration = 0.078,
               brakerate  = 0.125,
               buildcostenergy = 12477,
               buildcostmetal = 1129,
               builder = false,
               buildpic = "androck.png",
               buildtime  = 25000,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL HOVER MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
--               corpse = "armlatnk_dead",
--               defaultmissiontype = Standby,
               description = "Heavy Rocket Hovercraft",
--               firestandorders = 1,
               energystorage = 0,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 3500,
               maxslope = 16,
               maxvelocity = 1.8,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HOVER3",
               name = "Rocker",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "androck.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 390,
--               soundcategory= "ARM_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
--               TEDClass = "TANK", -- verificare se necessario
               turnrate = 550,
               upright = false,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Panther Wreckage",
               category = "corpses",
               object = "ARMLATNK_DEAD", -- SISTEMARE
               featuredead = "andlatnk_heap",
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
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
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
                     [1] = "tarmmove",
                    },
               select = {
                     [1] = "andselect",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
		weapondefs = {
			andahaa_missile = {
				areaofeffect = 16,
				canattackground = false,
				craterboost = 0,
				cratermult = 0,
				energypershot = 0,
				explosiongenerator = "custom:FLASH2",
				firestarter = 72,
				flighttime = 3,
				impulseboost = 0.12300000339746,
				impulsefactor = 0.12300000339746,
				metalpershot = 0,
				model = "missile",
				name = "AA2Missile",
				noselfdamage = true,
				projectiles = 2,
				proximitypriority = 1,
				range = 840,
				reloadtime = 0.85,
				smoketrail = true,
				soundhit = "packohit",
				soundstart = "packolau",
				soundtrigger = true,
				startvelocity = 800,
				texture2 = "armsmoketrail",
				toairweapon = true,
				tolerance = 9950,
				tracks = true,
				turnrate = 68000,
				turret = true,
				weaponacceleration = 200,
				weapontimer = 2,
				weapontype = "MissileLauncher",
				weaponvelocity = 1200,
				damage = {
					default = 75,
					subs = 5,
				},
			},
		},
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "SURFACE",
                 def = "andahaa_missile",
                 onlytargetcategory = "VTOL",
                 },
}, -- close weapon usage
}, -- close unit data 
} -- close total