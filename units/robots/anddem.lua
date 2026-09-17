-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  anddem= {
               acceleration = 0.1,
               brakerate  = 0.15,
               buildcostenergy = 70000,
               buildcostmetal = 4500,
               builder = false,
               buildpic = "anddem.png",
               buildtime  = 95000,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "anddem_dead",
--               defaultmissiontype = Standby,
               description = "Experimental Kbot",
--               firestandorders = 1,
               energymake = 0.4,
               energystorage = 0,
               energyUse = 0.4,
               explodeas = "MECH_BLASTSML",
               footprintx = 4,
               footprintz = 4,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 25000,
               maxslope = 16,   
               maxvelocity = 1.3,
               maxwaterdepth = 22,			   
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HKBOT4",
               name = "Archdemon",
               noAutoFire = false,
--               nochasecategory = "VTOL",
               objectname = "anddem.s3o",
               radardistance = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 520,
--               soundcategory= "KROGOTH",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 590,
               upright = true,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Archdemon Wreckage",
               category = "corpses",
               object = "anddem_dead",
               featuredead = "anddem_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 3000	,
               damage = 1500,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "36.0 28.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Archdemon Heap",
               category = "heaps",
               object = "3X3B",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 930,
               damage = 2000,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
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
                     [1] = "krogok1",
                    },
               select = {
                     [1] = "krogsel1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		dem_weapon = {
                     accuracy = 500,
                     areaofeffect = 64,
                     avoidfeature = false,
--                     burnblow = true,
                     burst = 6, -- lua:salvoSize
                     burstrate = .01, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     edgeeffectiveness = 0.5,
                     firestarter = 95,
                     name= "FlameThrower",
                     noexplode = true,
                     range = 650,
                     reloadtime = 0.03,
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "flamhvy1",
                     sprayangle = 3000,
                     tolerance = 4500,
                     turret  = true, 
                     weapontimer = 1.7,
                     weapontype = "Flame",
                     weaponvelocity  = 300,
                     damage = {
                         default = 21,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "dem_weapon",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
