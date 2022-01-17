-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corcarry= {
               acceleration = 0.025,
               activatewhenbuilt = true,
--               badTargetCategory = NOTAIR,
               brakerate  = 0.023,
--               buildangle = 16384,
               buildcostenergy = 74715,
               buildcostmetal = 1579,
               builder = true,
               buildpic = "nfacarry.png",
               buildtime  = 85271,
               canattack = false,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE NOTSUB SHIP NOWEAPON NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corcarry_dead",
--               defaultmissiontype = Standby,
               description = "Aircraft Carrier with Anti-Nuke",
--               firestandorders = 1,
               energymake = 250,
               energystorage = 1500,
               energyUse = 25,
               explodeas = "CRAWL_BLAST",
               footprintx = 8,
               footprintz = 8,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 7950,
               maxvelocity = 2.64,
               metalStorage = 1500,
               minWaterDepth= 15,
--               mobilestandorders= 1,
               movementclass = "DBOAT6",
               name = "Hive",
               noAutoFire = false,
               nochasecategory = "ALL",
               objectname = "nfacarry.s3o",
               radardistance = 2700,
               seismicsignature = 0,
               selfdestructas = "CRAWL_BLAST",
               sightdistance = 1040,
               sonardistance = 740,
--               soundcategory= "CORE_SHIP",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 210,
               workertime = 1000,
               wpri_badtargetcategory = "NOTAIR",
               buildoptions = { 
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               },



-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Hive Wreckage",
               category = "corpses",
               object = "CORCARRY_DEAD",
               featuredead = "corcarry_heap",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 1026,
               damage = 4770,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Hive Heap",
               category = "heaps",
               object = "3X3A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 266,
               damage = 2016,
               reclaimable = true,
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
		fmd_rocket = {
                     areaofeffect = 420,
                     avoidfeature = true,
--                     cegTag = "",
                     collidefriendly = false,
                     coverage = 2000,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 7500,
                     explosiongenerator = "custom:FLASH4",
                     firestarter = 100,
                     flighttime = 120,
                     interceptor = 1,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 150,
                     model = "fmdmisl",
                     name= "Rocket",
                     noselfdamage = true,
                     range = 72000,
                     reloadtime = 90,
                     smoketrail = true,
                     soundhit = "xplomed4",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Rockhvy1",
                     stockpile = true,
                     stockpiletime = 90,
                     tolerance = 4000,
                     tracks = true, 
                     turnrate = 99000,
                     weaponacceleration = 75,
                     weapontimer = 5,
                     weapontype = "StarburstLauncher",
                     weaponvelocity  = 3000,
                     damage = {
                         default = 1500,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "NOTAIR",
                 def = "fmd_rocket",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
