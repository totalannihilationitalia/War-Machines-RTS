-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armsnipe= {
               acceleration = 0.12,
               brakerate  = 0.188,
               buildcostenergy = 14727,
               buildcostmetal = 535,
               builder = false,
               buildpic = "icusnipe.png",
               buildtime  = 19137,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSHIP NOTAIR SURFACE",
               cloakcost = 75,
               cloakcostmoving = 200,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armsnipe_dead",
--               defaultmissiontype = Standby,
               description = "Sniper Kbot",
--               firestandorders = 1,
               energymake = 0.9,
               energystorage = 0,
               energyUse = 0.9,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               idleautoheal = 5,
               idletime = 1800,
               icontype = "robots",
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 520,
               maxslope = 14,
               maxvelocity = 1.26,
               maxwaterdepth = 22,
               metalStorage = 0,
               mincloakdistance = 80,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Sharpshooter",
               objectname = "ICUSNIPE.s3o",
               radarDistanceJam = 10,
               selfdestructas = "BIG_UNIT",
               sightdistance = 455,
--               soundcategory= "ARM_KBOT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 1338,
               upright = true,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Sharpshooter Wreckage",
               category = "corpses",
               object = "ARMSNIPE_DEAD",
               featuredead = "armsnipe_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 322,
               damage = 240,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1 0",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Sharpshooter Heap",
               category = "heaps",
               object = "2X2D",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 129,
               damage = 120,
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
               [1]="custom:snipeflare",
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
		armsnipe_weapon = {
                     areaofeffect = 16,
                     avoidfeature = true,
--                     beamweapon = true,
--                     cegTag = "",
                     collidefriendly = false,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     duration = 0.0025,
                     energypershot = 500,
                     explosiongenerator = "custom:SNIPELASER",
                     impactonly = true,
                     impulseboost = 0.234,
                     impulsefactor = 0.234,
                     Intensity = 0.75,
                     name= "SniperWeapon",
                     noselfdamage = true,
                     range = 900,
                     reloadtime = 10,
                     rgbcolor = "1 1 0",
                     soundhit = "xplolrg2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "sniper2",
                     thickness = 0.5,
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 3000,
                     damage = {
                         default = 2500,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "armsnipe_weapon",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
