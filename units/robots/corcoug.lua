-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corcoug= {
               acceleration = 0.08,
               brakerate  = 0.18,
               buildcostenergy = 24535,
               buildcostmetal = 1730,
               builder = false,
               buildpic = "nfacougar.png",
               buildtime  = 56042,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT WEAPON NOTAIR NOTSUB SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corcoug_dead",
--               defaultmissiontype = Standby,
               description = "Heavy Assault Mech",
--               firestandorders = 1,
               energymake = 1.5,
               energystorage = 0,
               energyUse = 1.5,
               explodeas = "CRAWL_BLAST",
               footprintx = 3,
               footprintz = 3,
               icontype = "robots",
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 4000,
               maxslope = 18,
               maxvelocity = 1.46,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HKBOT4",
               name = "Cougar",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfacougar.s3o",
               radardistance = 0,
               selfdestructas = "CRAWL_BLAST",
               sightdistance = 655,
--               soundcategory= "MAVERICK",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 450,
               upright = true,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Cougar Wreckage",
               category = "corpses",
               object = "corcoug_dead",
               featuredead = "corcoug_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 2325,
               damage = 1500,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "36.0 28.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Cougar Heap",
               category = "heaps",
               object = "3X3B",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 930,
               damage = 2000,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
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
                     [1] = "mavbok1",
                    },
               select = {
                     [1] = "mavbsel1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		atam = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.3,
--                     cegTag = "",
                     corethickness = 0.3,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 1000,
                     explosiongenerator = "custom:FLASH3blue",
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "ATAM",
                     noselfdamage = true,
                     laserflaresize = 20,
                     range = 950,
                     reloadtime = 5.5,
                     rgbcolor = "0 0 1",
                     soundhit = "xplolrg1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "annigun1",
                     targetmoveerror = 0.3,
                     thickness = 5.5,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 1500,
                     damage = {
                         default = 2500,
                     }, -- close damage
             }, --close single weapon definitions

		corcoug_rockets = {
                     areaofeffect = 40,
                     avoidfeature = true,
                     burst = 1, -- lua:salvoSize
                     burstrate = 0, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     firestarter = 70,
                     metalpershot = 17,
                     model = "corcoug_missile",
                     name= "Cougar-Rockets",
                     range = 850,
                     reloadtime = 0.9,
                     smoketrail = true,
                     soundhit = "TAWF114b",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "TAWF114a",
                     sprayangle = 3742,
                     startvelocity = 378,
                     tolerance = 10,
                     tracks = true, 
                     turret  = true, 
                     weaponacceleration = 287,
                     weapontimer = 5,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 845,
                     damage = {
                         default = 20,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [2] = {
                 badtargetcategory = "VTOL",
                 def = "atam",
                 onlytargetcategory = "SURFACE",
                 },
                 [3] = {
                 badtargetcategory = "VTOL",
                 def = "corcoug_rockets",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
