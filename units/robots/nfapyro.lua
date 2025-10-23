-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  nfapyro= {
               acceleration = 0.45,
--               badTargetCategory = ANTIFLAME,
               brakerate  = 0.65,
               buildcostenergy = 2783,
               buildcostmetal = 189,
               builder = false,
               buildpic = "nfapyro.png",
               buildtime  = 5027,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL ANTIFLAME NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "nfapyro_heap",
--               defaultmissiontype = Standby,
               description = "Fast Assault Kbot",
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
               mass = 200,
               maxdamage = 1000,
               maxslope = 17,
               maxvelocity = 2.75,
               maxwaterdepth = 25,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Pyro",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfapyro.s3o",
               seismicsignature = 0,
               selfdestructas = "nfapyro_BLAST",
               selfdestructcountdown = 1,
               sightdistance = 318,
--               soundcategory= "COR_KBOT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 1145,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "ANTIFLAME",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  heap = {
               world = "All Worlds",
               description = "Pyro Heap",
               category = "heaps",
               object = "2X2C",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 124,
               damage = 560,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close Dead Features
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:PILOT",
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
		flamethrower = {
                     areaofeffect = 48,
                     avoidfeature = true,
                     burst = 22, -- lua:salvoSize
                     burstrate = 0.01, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     firestarter = 100,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     Intensity = 0.6,
                     name= "FlameThrower",
                     noselfdamage = true,
                     range = 230,
                     reloadtime = 1.1,
                     rgbcolor = "1 0.95 0.9",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Flamhvy1",
                     soundtrigger = "0",
                     sprayangle = 1500,
                     tolerance = 2500,
                     turret  = true, 
                     weapontimer = 1.5,
                     weapontype = "Flame",
                     weaponvelocity  = 265,
                     damage = {
                         default = 12,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "flamethrower",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
