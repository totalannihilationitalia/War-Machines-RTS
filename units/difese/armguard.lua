-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armguard= {
               acceleration = 0,
--               badTargetCategory = VTOL,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 11687,
               buildcostmetal = 1645,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 4,
               buildinggrounddecalsizey = 4,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icuguard.png",
               buildtime  = 21377,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armguard_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Medium Range Plasma Battery",
--               firestandorders = 1,
               energystorage = 200,
               energyUse = 0,
               explodeas = "MEDIUM_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
               highTrajectory = 2,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 2760,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Guardian",
               noAutoFire = false,
               nochasecategory = "MOBILE",
               objectname = "icu_plascannon.s3o",
               seismicsignature = 0,
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 455,
--               soundcategory= "GUARD",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Guardian Wreckage",
               category = "corpses",
               object = "ARMGUARD_DEAD",
               featuredead = "armguard_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 1069,
               damage = 1656,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Guardian Heap",
               category = "heaps",
               object = "3X3D",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 428,
               damage = 828,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
               collisionvolumetype = "cylY",
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
               cloak = "kloak1",
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
                     [1] = "twrturn3",
                    },
               select = {
                     [1] = "twrturn3",
                        },
               uncloak = "kloak1un",
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		armfixed_gun = {
                     accuracy = 75,
                     areaofeffect = 128,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.25,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "PlasmaCannon",
                     noselfdamage = true,
                     range = 1220,
                     reloadtime = 3.25,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy5",
                     targetmoveerror = 0.2,
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 450,
                     damage = {
                         default = 263,
                     }, -- close damage
             }, --close single weapon definitions

		armfixed_gun_high = {
                     accuracy = 75,
                     areaofeffect = 192,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.5,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 2,
                     name= "PlasmaCannon",
                     noselfdamage = true,
                     proximitypriority = -2,
                     range = 1220,
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
                         default = 461,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "armfixed_gun",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 230,
                 maindir = "0 1 0",
                 },
                 [2] = {
                 badtargetcategory = "VTOL",
                 def = "armfixed_gun_high",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
