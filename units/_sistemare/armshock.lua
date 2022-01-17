-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armshock= {
               acceleration = 0.023,
--               badTargetCategory = NOWEAPON,
               brakerate  = 0.1,
               buildcostenergy = 54739,
               buildcostmetal = 3120,
               builder = false,
               buildpic = "ARMSHOCK.DDS",
               buildtime  = 101218,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armshock_dead",
--               defaultmissiontype = Standby,
               description = "All-Terrain Heavy Plasma Cannon",
--               firestandorders = 1,
               explodeas = "SHOCKER",
               footprintx = 3,
               footprintz = 3,
               highTrajectory = 2,
               idleautoheal = 5,
               idletime = 1800,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
               mass = 200000,
               maxdamage = 18000,
               maxslope = 17,
               maxvelocity = 1.1,
               maxwaterdepth = 0,
--               mobilestandorders= 1,
               movementclass = "HTKBOT4",
               name = "Vanguard",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "ARMSHOCK",
               seismicsignature = 0,
               selfdestructas = "SHOCKER",
               sightdistance = 625,
--               soundcategory= "ARM_KBOT",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 0,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 231,
               wpri_badtargetcategory = "NOWEAPON",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Vanguard Wreckage",
               category = "corpses",
               object = "ARMSHOCK_DEAD",
               featuredead = "armshock_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 2028,
               damage = 3000,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Vanguard Heap",
               category = "heaps",
               object = "4X4D",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 811,
               damage = 3015,
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
                     [1] = "kbarmmov",
                    },
               select = {
                     [1] = "kbarmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		shocker = {
                     areaofeffect = 256,
                     avoidfeature = true,
--                     cegTag = "",
                     collidefriendly = false,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.5,
                     explosiongenerator = "custom:FLASHSMALLBUILDING",
                     impulseboost = 1,
                     impulsefactor = 0.123,
                     name= "ShockerHeavyCannon",
                     noselfdamage = true,
                     range = 1425,
                     reloadtime = 4,
                     size = "5",
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy5",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 610,
                     damage = {
                         default = 900,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "NOWEAPON",
                 def = "shocker",
                 onlytargetcategory = "NOTAIR",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
