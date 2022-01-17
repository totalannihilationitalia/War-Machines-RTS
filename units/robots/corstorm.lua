-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corstorm= {
               acceleration = 0.108,
--               badTargetCategory = VTOL OGGETTISTATICI,
               brakerate  = 0.188,
               buildcostenergy = 853,
               buildcostmetal = 81,
               builder = false,
               buildpic = "nfastorm.png",
               buildtime  = 1722,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corstorm_dead",
--               defaultmissiontype = Standby,
               description = "Rocket Kbot",
--               firestandorders = 1,
               energymake = 0.6,
               energystorage = 0,
               energyUse = 0.6,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 670,
               maxslope = 14,
               maxvelocity = 1.65,
               maxwaterdepth = 21,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Tempest",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfastorm.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 344.5,
--               soundcategory= "COR_KBOT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 1103,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL OGGETTISTATICI",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Storm Wreckage",
               category = "corpses",
               object = "CORSTORM_DEAD",
               featuredead = "corstorm_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 55,
               damage = 402,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "26 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Storm Heap",
               category = "heaps",
               object = "2X2C",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 22,
               damage = 201,
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
                     [1] = "kbcormov",
                    },
               select = {
                     [1] = "kbcorsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		core_kbot_rocket = {
                     areaofeffect = 48,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:VSMLMISSILE_EXPLOSION",
                     firestarter = 70,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "missile",
                     name= "Rockets",
                     noselfdamage = true,
                     range = 475,
                     reloadtime = 3.8,
                     smoketrail = true,
                     soundhit = "xplosml2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rocklit1",
                     startvelocity = 190,
                     texture2 = "coresmoketrail",
                     turret  = true, 
                     weaponacceleration = 120,
                     weapontimer = 2,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 190,
                     damage = {
                         default = 157,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "core_kbot_rocket",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
