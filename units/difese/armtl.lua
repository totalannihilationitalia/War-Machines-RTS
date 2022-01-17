-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armtl= {
               acceleration = 0,
               activatewhenbuilt = true,
--               badTargetCategory = HOVER NOTSHIP,
               brakerate  = 0,
--               buildangle = 16384,
               buildcostenergy = 2058,
               buildcostmetal = 302,
               builder = false,
               buildpic = "icutl.png",
               buildtime  = 4120,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armtl_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Torpedo Launcher",
--               firestandorders = 1,
               energymake = 0.1,
               energystorage = 0,
               energyUse = 0.1,
               explodeas = "MEDIUM_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 1450,
               maxvelocity = 0,
               metalStorage = 0,
               minWaterDepth= 10,
               name = "Harpoon",
               noAutoFire = false,
               objectname = "icutl.s3o",
               seismicsignature = 0,
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 455,
--               soundcategory= "ARM_SHIP",
--               standingfireorder = 2,
               TEDClass = "WATER", -- verificare se necessario
               turnrate = 0,
               waterline = 10,
               workertime = 0,
               wpri_badtargetcategory = "HOVER NOTSHIP",
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Harpoon Wreckage",
               category = "corpses",
               object = "ARMTL_DEAD",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 196,
               damage = 870,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
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
                     [1] = "sharmmov",
                    },
               select = {
                     [1] = "sharmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		coax_torpedo = {
                     areaofeffect = 16,
                     avoidfeature = true,
--                     burnblow = true,
--                     cegTag = "",
                     collidefriendly = false,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH2",
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "torpedo",
                     name= "Level1TorpedoLauncher",
                     noselfdamage = true,
                     range = 550,
                     reloadtime = 1.9,
                     soundhit = "xplodep2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "torpedo1",
                     startvelocity = 200,
                     tracks = true, 
                     turnrate = 2500,
                     turret  = true, 
                     waterweapon = true, 
                     weaponacceleration = 40,
                     weapontimer = 3,
                     weapontype = "TorpedoLauncher",
                     weaponvelocity  = 320,
                     damage = {
                         default = 280,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "HOVER NOTSHIP",
                 def = "coax_torpedo",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
