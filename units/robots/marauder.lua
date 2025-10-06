-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  marauder = {
               acceleration = 0.22,
               brakerate  = 0.238,
               buildcostenergy = 19534,
               buildcostmetal = 910,
               builder = false,
               buildpic = "MARAUDER.DDS",
               buildtime  = 28957,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "marauder_dead",
--               defaultmissiontype = Standby,
               description = "Amphibious Assault Mech",
--               firestandorders = 1,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
               idleautoheal = 5,
               idletime = 1800,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
               mass = 200000,
               maxdamage = 4000,
               maxslope = 17,
               maxvelocity = 3,
               maxwaterdepth = 32,
--               mobilestandorders= 1,
               movementclass = "ATANK3",
               name = "Marauder",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "MARAUDER",
               seismicsignature = 0,
               selfdestructas = "CRAWL_BLASTSML",
               sightdistance = 455,
--               soundcategory= "MAVERICK",
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
  marauder_dead = {
               world = "All Worlds",
               description = "Marauder Wreckage",
               category = "corpses",
               object = "marauder_dead",
               featuredead = "marauder_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 4,
               footprintz = 4,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 592,
               damage = 2400,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  marauder_heap = {
               world = "All Worlds",
               description = "Marauder Heap",
               category = "heaps",
               object = "3X3F",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 237,
               damage = 1200,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
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
		armmech_cannon = {
                     areaofeffect = 12,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH2",
                     firestarter = 5,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "MechPlasmaCannon",
                     noselfdamage = true,
                     range = 350,
                     reloadtime = 0.7,
                     soundhit = "XploMed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "KroGun1",
                     targetmoveerror = 0.15,
                     turret  = true, 
                     weapontimer = 2,
                     weapontype = " ",
                     weaponvelocity  = 600,
                     damage = {
                         default = 185,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "armmech_cannon",
                 onlytargetcategory = "SURFACE",
                 },
                 [3] = {
                 def = "armamph_missile",
                 onlytargetcategory = "VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
