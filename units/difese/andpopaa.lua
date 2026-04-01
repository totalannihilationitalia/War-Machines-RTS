-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andpopaa= {
--               badTargetCategory = VTOL,
--               buildangle = 8192,
               buildcostenergy = 11788,
               buildcostmetal = 735,
               builder = false,
               buildpic = "andpopaa.png",
               buildtime  = 20800,
--               canAttack = true,
--               canstop = 1,
		category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andpopaa_dead",
               damagemodifier = 0.25,
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Pop-up Anti-Air Missile Launcher",
--               firestandorders = 1,
               energystorage = 0,
               energyUse = 0,
               explodeas = "lARGE_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
			   highTrajectory = 2,
--               mass = 0 --definire massa,
               maxdamage = 1600,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Controller",
               noAutoFire = false,
               objectname = "andpopaa.s3o",
               radardistance = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 360,
--               soundcategory= "GUARD",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  andpopaa_dead = {
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
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
