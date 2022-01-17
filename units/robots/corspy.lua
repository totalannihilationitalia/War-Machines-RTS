-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corspy= {
               acceleration = 0.24,
               activatewhenbuilt = true,
--               amphibious = 1,
               brakerate  = 0.175,
               buildcostenergy = 11452,
               buildcostmetal = 156,
               builder = false,
               buildpic = "nfaspy.png",
               buildtime  = 22247,
               canGuard = false,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE ALL NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               cloakcost = 50,
               cloakcostmoving = 100,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corspy_dead",
--               defaultmissiontype = Standby,
               description = "Radar-Invisible Spy Kbot",
               energymake = 8,
               energystorage = 0,
               energyUse = 8,
               explodeas = "",
               footprintx = 2,
               footprintz = 2,
               icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 340,
               maxslope = 32,
               maxvelocity = 2.07,
               maxwaterdepth = 112,
               metalStorage = 0,
               mincloakdistance = 75,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Parasite",
               noAutoFire = false,
               objectname = "nfaspy.s3o",
               onoffable = true,
               seismicsignature = 2,
               selfdestructas = "SPYBOMBX",
               selfdestructcountdown = 1,
               sightdistance = 550,
--               soundcategory= "COR_KBOT",
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 1320,
               upright = true,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
		featuredefs = {
			dead = {
				blocking = false,
				category = "corpses",
				collisionvolumeoffsets = "0.979118347168 -0.453806965332 -0.796119689941",
				collisionvolumescales = "30.1392364502 18.4953460693 29.797164917",
				collisionvolumetype = "Box",
				damage = 192,
				description = "Spy Wreckage",
				energy = 0,
				featuredead = "corspy_heap",
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 40,
				hitdensity = 100,
				metal = 29,
				object = "corspy_dead",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
			heap = {
				blocking = false,
				category = "heaps",
				damage = 96,
				description = "Spy Heap",
				energy = 0,
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 4,
				hitdensity = 100,
				metal = 12,
				object = "2X2F",
		               collisionvolumescales = "35.0 4.0 6.0",
		               collisionvolumetype = "cylY",
				reclaimable = true,
				resurrectable = 0,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
		},
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
                     [1] = "kbcormov",
                    },
               select = {
                     [1] = "kbcorsel",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
