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
--- NO EFFECTS
-----------------------------------------------------------
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
		arm_antiair = {
                     areaofeffect = 72,
                     avoidfeature = true,
                     canattackground = false,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     firestarter = 50,
                     metalpershot = 0,
                     model = "heatmis1",
                     name= "Fast Heat-seeking Missiles",
                     range = 1000,
                     reloadtime = 3,
                     smoketrail = true,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rockhvy2",
                     startvelocity = 700,
                     tolerance = 10000,
                     tracks = true, 
                     toairweapon = true,
                     turnrate = 90000,
                     turret  = true, 
                     weaponacceleration = 300,
                     weapontimer = 5,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 1080,
                     damage = {
                         default = 160,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
--                 badtargetcategory = "NOTAIR",
                 def = "arm_antiair",
		 onlytargetcategory = "VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
