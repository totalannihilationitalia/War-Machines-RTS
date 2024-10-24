-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  walker= {
               acceleration = 0.06,
--               badTargetCategory = VTOL,
               brakerate  = 0.19,
               buildcostenergy = 2631,
               buildcostmetal = 265,
               builder = false,
               buildpic = "",
               buildtime  = 3124,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ARM KBOT WEAPON NOTAIR NOTSUB SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "walker_dead",
--               defaultmissiontype = Standby,
               description = "Assault Kbot",
--               firestandorders = 1,
               energymake = 0.5,
               energystorage = 0,
               energyUse = 1,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 1489,
               maxslope = 17,
               maxvelocity = 1.3,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Walker",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "walker.s3o",
               radardistance = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 500,
--               soundcategory= "ARM_AMPHIB",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 700,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  walker_dead = {
               world = "all worlds",
               description = "Walker Wreckage",
               category = "arm_corpses",
               object = "WALKER_DEAD",
               featuredead = "walker_dead2",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 10,
               blocking= true,
               hitdensity = 23,
               metal = 206,
               damage = 800,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  walker_dead2 = {
               world = "all worlds",
               description = "Walker Wreckage",
               category = "arm_corpses",
               object = "WALKER_DEAD2",
               footprintx = 3,
               footprintz = 3,
               height = 10,
               blocking = true,
               hitdensity= 23,
               metal = 103,
               damage = 600,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:plasmaflare",
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
                     [1] = "amphok1",
                    },
               select = {
                     [1] = "amphsel1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		emg_walk = {
                     areaofeffect = 16,
                     avoidfeature = true,
                     burst = 10, -- lua:salvoSize
                     burstrate = 0.02, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     explosiongenerator = "custom:EMG_HIT",
                     name= "E.M.G.",
                     range = 370,
                     reloadtime = 0.5,
                     rgbcolor = "1 0.87 0.3",
                     size = "1.5",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "armsml2",
                     soundtrigger = "0",
                     sprayangle = 867,
                     tolerance = 3000,
                     turret  = true, 
                     weapontimer = 1,
                     weapontype = "Cannon",
                     weaponvelocity  = 350,
                     damage = {
                         default = 11,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "emg_walk",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
