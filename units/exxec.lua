-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  exxec= {
               acceleration = 0.1,
--               badTargetCategory = VTOL,
               brakerate  = 0.25,
               buildcostenergy = 5311,
               buildcostmetal = 475,
               builder = false,
               buildpic = "exxec.png",
               buildtime  = 8500,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "exxec_dead",
--               defaultmissiontype = Standby,
               description = "heavy assault K-bot",
--               firestandorders = 1,
               energystorage = 0,
               energyUse = 0.5,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "robots",
--               maneuverleashlength  = 640,
               mass = 3000, -- come SUMO 
               maxdamage = 1700,
               maxslope = 17,
               maxvelocity = 0.95,
               maxwaterdepth = 25,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Exxec",
               noAutoFire = false,
               objectname = "exxec.s3o",
               radardistance = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 350,
--               soundcategory= "ARM_KBOT",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 700,
               workertime = 500,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "arm_corpses",
               object = "exxec_dead",
               featuredead = "exxec_heap",
               featurereclamate = "smudge01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               hitdensity = 100,
               metal = 220,
               damage = 250,
               seqnamereclamate = "tree1reclamate",
	       collisionvolumeoffsets = "2.61597442627 -2.06350430908 0.245178222656",
               collisionvolumescales = "30.2125091553 18 30",
	       collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
				blocking = false,
				category = "heaps",
				damage = 174,
				description = "Exxec Heap",
				energy = 0,
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 4,
				hitdensity = 100,
				metal = 30,
				object = "2X2A",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
		                collisionvolumescales = "35.0 4.0 6.0",
		                collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:arancioflare",
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
                     [1] = "kbarmmov",
                    },
               select = {
                     [1] = "kbarmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		arm_exxec = {
                     areaofeffect = 8,
                     avoidfeature = true,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     energypershot = 17,
                     firestarter = 30,
                     name= "Annihilator Weapon",
                     range = 275,
                     reloadtime = 0.38,
                     rgbcolor = "1 0.6 0",
                     soundhit = "xplolrg1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "annigun1",
                     soundtrigger = "1",
                     tolerance = 500,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 800,
                     damage = {
                         default = 50,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "arm_exxec",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
