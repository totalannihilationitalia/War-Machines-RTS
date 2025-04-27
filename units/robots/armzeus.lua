-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armzeus= {
               acceleration = 0.12,
               brakerate  = 0.25,
               buildcostenergy = 5668,
               buildcostmetal = 329,
               builder = false,
               buildpic = "icuzeus.png",
               buildtime  = 7252,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armzeus_dead",
--               defaultmissiontype = Standby,
               description = "Assault Kbot",
--               firestandorders = 1,
               energymake = 1.1,
               energystorage = 0,
               energyUse = 1.1,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 2975,
               maxslope = 15,
               maxvelocity = 1.58,
               maxwaterdepth = 23,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Zeus",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icuzeus.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 331.5,
--               soundcategory= "ARM_KBOT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 1056,
               upright = true,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Zeus Wreckage",
               category = "corpses",
               object = "ARMZEUS_DEAD",
               featuredead = "armzeus_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 214,
               damage = 1110,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Zeus Heap",
               category = "heaps",
               object = "2X2E",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 86,
               damage = 555,
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
		lightning = {
                     areaofeffect = 8,
                     avoidfeature = true,
		     beamttl = 10,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     duration = 10,
                     energypershot = 35,
                     explosiongenerator = "custom:ZEUS_FLASH",
                     firestarter = 50,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     Intensity = 12,
                     name= "LightningGun",
                     noselfdamage = true,
                     range = 320, --280
                     reloadtime = 1.7,
                     rgbcolor = "0.5 0.5 1",
                     soundhit = "xplomed3",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lghthvy1",
                     soundtrigger = "1",
                     targetmoveerror = 0.3,
		     texture1 = "lightning",
                     thickness = 10,
                     turret  = true, 
                     weapontype = "LightningCannon",
                     weaponvelocity  = 400,
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
                 badtargetcategory = "VTOL",
                 def = "lightning",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
