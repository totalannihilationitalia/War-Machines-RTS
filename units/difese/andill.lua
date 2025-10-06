-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andill= {
               activatewhenbuilt = true,
--               badTargetCategory = VTOL,
--               buildangle = 256,
               buildcostenergy = 12000,
               buildcostmetal = 3500,
               builder = false,
               buildpic = "andill.png",
               buildtime  = 100000,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               collisionvolumeoffsets = "0 0 0",
               collisionvolumescales = "29 25 75",
               collisionvolumetype = "Box",
               corpse = "andill_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Rapid-Firing Plasma Beam Defense Tower",
--               firestandorders = 1,
               energystorage = 2000,
               energyUse = 0,
               explodeas = "LARGE_BUILDING",
               footprintx = 3,
               footprintz = 5,
--               mass = 0 --definire massa,
               maxdamage = 2400,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Illuminator",
               noAutoFire = false,
               objectname = "andill.s3o",
               radardistance = 1480,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 460,
--               soundcategory= "ARM_ANNI",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               YardMap= "ooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
dead = {
               world = "All Worlds",
               description = "Illuminator Wreckage",
               category = "core_corpses",
               object = "armill_dead",
               featuredead = "armill_heap",
               featurereclamate = "smudge01",
               footprintx = 4,
               footprintz = 6,
               height = 20,
               hitdensity = 100,
               metal = 1000,
               damage = 1442,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
heap = {
               world = "All Worlds",
               description = "Illuminator Heap",
               category = "heaps",
               object = "4X4D",
               footprintx = 5,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 195,
               damage = 540,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "85.0 14.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:greenflare",
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
                     [1] = "anni",
                    },
               select = {
                     [1] = "anni",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		plasmabeam = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.15,
--                     beamweapon = true,
                     cegTag = "GREENCRAP",
                     corethickness = 0.2,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 3600,
                     explosiongenerator = "custom:LARGE_GREEN_LASER_BURN",
                     firestarter = 95,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "Plasma Beam",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 1480,
                     reloadtime = 0.7,
                     rgbcolor = "0 1 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Lasrmas2",
                     targetmoveerror = 0.2,
                     thickness = 3,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 1400,
                     damage = {
                         default = 600,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "plasmabeam",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
