-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armfboy= {
               acceleration = 0.12,
               brakerate  = 0.125,
               buildcostenergy = 11193,
               buildcostmetal = 1418,
               builder = false,
               buildpic = "icufboy.png",
               buildtime  = 22397,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT WEAPON ALL NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armfboy_dead",
--               defaultmissiontype = Standby,
               description = "Heavy Plasma Kbot",
--               firestandorders = 1,
               energystorage = 0,
               energyUse = 5,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 7000,
               maxslope = 20,
               maxvelocity = 1,
               maxwaterdepth = 25,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HKBOT4",
               name = "Fatboy",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "ICUFBOY.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 510,
--               soundcategory= "ARM_FBOY",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 320,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Fatboy Wreckage",
               category = "corpses",
               object = "ARMFBOY_DEAD",
               featuredead = "armfboy_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 9,
               blocking= true,
               hitdensity = 100,
               metal = 1008,
               damage = 4200,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -3.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "all",
               description = "Fatboy Heap",
               category = "heaps",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               blocking = false,
               hitdensity= 100,
               metal = 403,
               damage = 2100,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:goliathflare",
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
                     [1] = "mavbot1",
                    },
               select = {
                     [1] = "capture2",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		arm_fatboy_notalaser = {
                     areaofeffect = 240,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.7,
                     energypershot = 0,
                     explosiongenerator = "custom:FLASH224",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HeavyPlasma",
                     noselfdamage = true,
                     range = 800,
                     reloadtime = 6.75,
                     soundhit = "bertha6",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "BERTHA1",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 290,
                     damage = {
                         default = 800,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "arm_fatboy_notalaser",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
