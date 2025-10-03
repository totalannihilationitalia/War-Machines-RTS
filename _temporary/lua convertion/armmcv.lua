-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  ARMMCV= {
               acceleration = 0.09,
               activatewhenbuilt = true,
--               amphibious = 1,
--               badTargetCategory = VTOL,
               brakerate  = 0.08,
               buildcostenergy = 1880879,
               buildcostmetal = 85522,
               builder = false,
               buildpic = "armmcv.DDS",
               buildtime  = 449292,
               canAttack = true,
               canGuard = true,
--               canload = 1,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armmcv_dead",
               damagemodifier = 0.2,
--               defaultmissiontype = Standby,
               description = "Mobile Command Vehicle",
--               firestandorders = 1,
               energymake = 0.5,
               energystorage = 0,
               energyUse = 0.5,
               explodeas = "NUCLEAR_BLAST",
               footprintx = 7,
               footprintz = 7,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 213625,
               maxslope = 12,
               maxvelocity = 0.9,
               maxwaterdepth = 255,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HTANK4",
               name = "Empyrrean",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "andmcv.s3o",
               onoffable = true,
               radardistance = 1500,
               selfdestructas = "NUCLEAR_BLAST",
               sightdistance = 2400,
--               soundcategory= "ARM_BIGTANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               transportCapacity = 255,
               transportSize= 4,
               turnrate = 128,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               wspe_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  armmcv_dead = {
               world = "All Worlds;",
               description = "Wreckage;",
               category = "corpses;",
               object = "armmcv_dead;",
               featuredead = "armmcv_heap;",
               featurereclamate = "SMUDGE01;",
               footprintx = 7;,
               footprintz = 7;,
               height = 15;,
               hitdensity = 100;,
               metal = 42761;,
               damage = 5100;,
               seqnamereclamate = "TREE1RECLAMATE;",
               energy = 0;,
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  armmcv_heap; = {
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:POPUPFLAREFAST",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		empyrrean_plasma = {
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     weapontype = " ",
                     damage = {
                         default = ,
                     }, -- close damage
             }, --close single weapon definitions

		aakflak = {
                     accuracy = 1000,
                     areaofeffect = 128,
                     avoidfeature = true,
--                     burnblow = true,
                     canattackground = false,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.85,
                     impulseboost = 0,
                     impulsefactor = 0,
                     name= "FlakCannon",
                     noselfdamage = true,
                     range = 680,
                     reloadtime = 5.5,
                     size = "1.4",
                     soundhit = "flakhit",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "flakfire",
                     turret  = true, 
                     weapontimer = 1,
                     weapontype = " ",
                     weaponvelocity  = 1500,
                     damage = {
                         default = 1000,
                     }, -- close damage
             }, --close single weapon definitions

		repulsor = {
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     name= "PlasmaRepulsor",
                     range = 400,
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     weapontype = " ",
                     damage = {
                         default = 100,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "empyrrean_plasma",
--               onlytargetcategory = " ",
                 },
                 [2] = {
                 badtargetcategory = "ALL",
                 def = "aakflak",
--               onlytargetcategory = " ", -- weapon 2
                 },
                 [3] = {
--                 badtargetcategory = "sistemare",
                 def = "repulsor",
--               onlytargetcategory = " ", -- weapon 3
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
