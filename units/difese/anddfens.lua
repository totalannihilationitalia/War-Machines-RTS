-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  anddfens= {
--               badTargetCategory = VTOL,
--               buildangle = 8192,
               buildcostenergy = 11327,
               buildcostmetal = 2463,
               builder = false,
               buildpic = "",
               buildtime  = 16765,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "cordfens_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Defensive-Fusillade Energy Nullifying System",
--               firestandorders = 1,
               energystorage = 250,
               energyUse = 0,
               explodeas = "MEDIUM_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
--               mass = 0 --definire massa,
               maxdamage = 3862,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "D-FENS",
               noAutoFire = false,
               objectname = "anddfens.s3o",
               radardistance = 0,
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 400,
--               soundcategory= "COR_KBOT",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               YardMap= "oooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  cordfens_dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "core_corpses",
               object = "cordfens_dead",
               featuredead = "cordfens_heap",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 5,
               blocking= true,
               hitdensity = 100,
               metal = 1510,
               damage = 2532,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  cordfens_heap = {
               world = "All Worlds",
               description = "Wreckage",
               category = "heaps",
               object = "3x3b",
               footprintx = 3,
               footprintz = 3,
               height = 5,
               blocking = false,
               hitdensity= 100,
               metal = 650,
               damage = 1876,
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
               [1]="custom:MEDIUMFLARE",
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
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		anddfens_cannon = {
                     accuracy = 400,
                     areaofeffect = 152,
                     avoidfeature = true,
--                     cegTag = ""
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.25,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "PopupCannon",
                     noselfdamage = true,
                     range = 1320,
                     reloadtime = 1.8,
                     soundhit = "xplomed2",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy5",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 450,
                     damage = {
                         default = 345,
                     }, -- close damage
             }, --close single weapon definitions

		anddfens_cannon_high = {
                     accuracy = 400,
                     areaofeffect = 224,
                     avoidfeature = true,
--                     cegTag = ""
--                     craterareaofeffect =  ,
                     craterboost = 0.123,
                     cratermult = 0.123,
                     edgeeffectiveness = 0.5,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 2,
                     name= "PopupCannon",
                     noselfdamage = true,
                     proximitypriority = -2,
                     range = 1320,
                     reloadtime = 7,
                     soundhit = "xplomed2",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy5",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 440,
                     damage = {
                         default = 865,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "anddfens_cannon",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
