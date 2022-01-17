-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armpt= {
               acceleration = 0.096,
--               badTargetCategory = ANTIGATOR,
               brakerate  = 0.025,
               buildcostenergy = 985,
               buildcostmetal = 100,
               builder = false,
               buildpic = "icupt.png",
               buildtime  = 2062,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE WEAPON NOTSUB SHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armpt_dead",
--               defaultmissiontype = Standby,
               description = "Scout Boat/Light Anti-Air",
--               firestandorders = 1,
               energymake = 0.2,
               energystorage = 0,
               energyUse = 0.2,
               explodeas = "SMALL_UNITEX",
               footprintx = 4,
               footprintz = 4,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 224,
               maxvelocity = 5.29,
               metalStorage = 0,
               minWaterDepth= 6,
--               mobilestandorders= 1,
               movementclass = "BOAT4",
               name = "Skeeter",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icupt.s3o",
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 650,
--               soundcategory= "ARM_SHIP",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 644,
               workertime = 0,
               wpri_badtargetcategory = "ANTIGATOR",
               wspe_badtargetcategory = "ALL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Skeeter Wreckage",
               category = "corpses",
               object = "ARMPT_DEAD",
               featuredead = "armpt_heap",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 65,
               damage = 336,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Skeeter Heap",
               category = "heaps",
               object = "3X3A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 26,
               damage = 516,
               reclaimable = true,
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
      [[custom:azzurroflare]],
     },
  },
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
		armpt_laser = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.1,
                     burstrate = 0.2, -- lua: salvoDelay
--                     cegTag = "",
                     corethickness = 0.1,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     duration = 0.02,
                     energypershot = 5,
		     explosiongenerator = "custom:Gatorazzurro", -- SMALL_AZURE_BURN",
                     firestarter = 50,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "Laser",
                     noselfdamage = true,
                     laserflaresize = 5,
                     range = 220,
                     reloadtime = 0.9,
                     rgbcolor = "0 0.5 1",
                     soundhit = "lasrhit2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir1",
                     soundtrigger = "1",
                     targetmoveerror = 0.2,
                     thickness = 1,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 750,
                     damage = {
                         default = 55,
                     }, -- close damage
             }, --close single weapon definitions


}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "ANTIGATOR",
                 def = "armpt_laser",
               onlytargetcategory = "SURFACE",
                 },

}, -- close weapon usage

}, -- close unit data 
} -- close total
