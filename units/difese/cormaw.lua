-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  cormaw= {
               acceleration = 1e-13,
--               buildangle = 8192,
               buildcostenergy = 1412,
               buildcostmetal = 273,
               builder = false,
               buildpic = "nfamaw.png",
               buildtime  = 4419,
               canAttack = true,
               canmove = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "cormaw_dead",
               damagemodifier = 0.1,
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Pop-up Flamethrower Turret",
--               firestandorders = 1,
               energymake = 0,
               energystorage = 15,
               energyUse = 0,
               explodeas = "MEDIUM_BUILDINGEX",
               footprintx = 2,
               footprintz = 2,
               hidedamage = true,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
               mass = 1e+10,
               maxdamage = 1100,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 0,
               movementclass = "VKBOT5",
               name = "Dragon's Maw",
               noAutoFire = false,
               nochasecategory = "MOBILE",
               objectname = "dragon_fence_tower.s3o",
               radarDistanceJam = 8,
               seismicsignature = 0,
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 422,
--               soundcategory= "LLT",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               turnrate = 1e-13,
               upright = true,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Dragon's Maw Wreckage",
               category = "corpses",
               object = "CORDRAG",
               featuredead = "cormaw_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 177,
               damage = 600,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "greenworld",
               description = "Rubble",
               category = "rocks",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking = false,
               hitdensity= 100,
               metal = 2,
               damage = 500,
               reclaimable = true,
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
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
                     [1] = "servmed2",
                    },
               select = {
                     [1] = "servmed2",
                        },
               uncloak = "kloak1un",
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		dmaw = {
                     areaofeffect = 64,
                     avoidfeature = true,
                     burst = 12, -- lua:salvoSize
                     burstrate = 0.01, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     firestarter = 100,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     Intensity = 0.9,
                     name= "FlameThrower",
                     noselfdamage = true,
                     proximitypriority = 3,
                     range = 410,
                     reloadtime = 0.7,
                     rgbcolor = "1 0.95 0.9",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Flamhvy1",
                     soundtrigger = "0",
                     sprayangle = 9600,
                     targetmoveerror = 0.001,
                     tolerance = 2500,
                     turret  = true, 
                     weapontimer = 1,
                     weapontype = "Flame",
                     weaponvelocity  = 300,
                     damage = {
                         default = 25,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "dmaw",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
