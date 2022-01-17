-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  icufurie= {
               acceleration = 0.09,
               brakerate  = 0.20,
               buildcostenergy = 116664,
               buildcostmetal = 29489,
               builder = false,
               buildpic = "icufurie.png",
               buildtime  = 302193,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT NOTAIR NOTSUB SURFACE",
               cloakcost = 100,
               cloakcostmoving = 1000,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "icufurie_dead",
--               defaultmissiontype = Standby,
               description = "Experimental Kbot",
--               firestandorders = 1,
               energymake = 1.1,
               energystorage = 0,
               energyUse = 1.1,
               explodeas = "MECH_BLASTSML",
               footprintx = 3,
               footprintz = 3,
               idleautoheal = 30,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 20489,
               maxslope = 17,
               maxvelocity = 0.8,
               maxwaterdepth = 12,
               metalStorage = 0,
               mincloakdistance = 5,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Arm Furie",
               noAutoFire = false,
               objectname = "icufurie.s3o",
               radardistance = 0,
               selfdestructas = "MECH_BLAST",
               sightdistance = 700,
--               soundcategory= "KROGOTH",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 560,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Furie Wreckage",
               category = "arm_corpses",
               object = "arm_furie_dead",
               featuredead = "furie_heap",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 9000,
               damage = 23934,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "40.0 30 60.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Furie Wreckage",
               category = "heaps",
               object = "3x3a",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 4500,
               damage = 11967,
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
               [1]="custom:POPUPFLAREFAST",
               [2]="custom:azzurroflare",
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
		furie_head = {
                     areaofeffect = 8,
                     avoidfeature = true,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     energypershot = 100,
                     firestarter = 90,
                     name= "Annihilator Weapon2",
                     range = 600,
                     reloadtime = 9,
                     rgbcolor = "0 0.5 1",
                     soundhit = "xplolrg1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrhvy2",
                     tolerance = 500,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 2000,
                     damage = {
                         default = 13500,
                     }, -- close damage
             }, --close single weapon definitions

		furie_fire = {
                     areaofeffect = 8,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     name= "Gauss Cannon2",
                     range = 650,
                     reloadtime = .1,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannon3",
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 450,
                     damage = {
                         default = 100,
                     }, -- close damage
             }, --close single weapon definitions

		furie_rocket = {
                     areaofeffect = 80,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     firestarter = 70,
                     flighttime = 15,
                     metalpershot = 0,
                     model = "fmdmisl",
                     name= "Heavy Rockets2",
                     range = 650,
                     reloadtime = 1.1,
                     smoketrail = true,
                     soundhit = "xplosml2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rocklit1",
                     startvelocity = 250,
                     tolerance = 9000,
                     tracks = true, 
                     turnrate = 63000,
                     weaponacceleration = 200,
                     weapontimer = 5,
                     weapontype = "StarburstLauncher",
                     weaponvelocity  = 550,
                     damage = {
                         default = 131,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "furie_head",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 badtargetcategory = "VTOL",
                 def = "furie_fire",
                 onlytargetcategory = "SURFACE", -- weapon 2
                 },
                 [3] = {
                 badtargetcategory = "VTOL",
                 def = "furie_rocket",
                 onlytargetcategory = "SURFACE", -- weapon 3
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
