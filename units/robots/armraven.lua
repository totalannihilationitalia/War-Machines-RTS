-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armraven= {
               acceleration = 0.108,
               brakerate  = 0.188,
               buildcostenergy = 75625,
               buildcostmetal = 4551,
               builder = false,
               buildpic = "nfaraven.png",
               buildtime  = 126522,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL ANTIGATOR NOTSUB ANTIEMG NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armraven_dead",
--               defaultmissiontype = Standby,
               description = "Heavy Rocket Kbot",
--               firestandorders = 1,
               explodeas = "MECH_BLAST",
               footprintx = 4,
               footprintz = 4,
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 5500,
               maxslope = 20,
               maxvelocity = 1.6,
               maxwaterdepth = 12,
--               mobilestandorders= 1,
               movementclass = "HKBOT4",
               name = "Catapult",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfaraven.s3o",
               seismicsignature = 0,
               selfdestructas = "MECH_BLAST",
               sightdistance = 700,
--               soundcategory= "MAVERICK",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 979,
               upright = true,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Catapult Wreckage",
               category = "corpses",
               object = "ARMRAVEN_DEAD",
               featuredead = "armraven_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 2958,
               damage = 3300,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "55.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Catapult Heap",
               category = "heaps",
               object = "3X3C",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 1183,
               damage = 1650,
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
                     [1] = "mavbok1",
                    },
               select = {
                     [1] = "mavbsel1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		exp_heavyrocket = {
                     accuracy = 300,
                     areaofeffect = 96,
                     avoidfeature = true,
                     burst = 20, -- lua:salvoSize
                     burstrate = 0.12, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.5,
                     explosiongenerator = "custom:MEDMISSILE_EXPLOSION",
                     firestarter = 70,
                     flighttime = 3,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "exphvyrock",
                     name= "RavenCatapultRockets",
                     noselfdamage = true,
                     proximitypriority = -1,
                     range = 1350,
                     reloadtime = 15,
                     smoketrail = true,
                     soundhit = "rockhit",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rapidrocket3",
                     sprayangle = 1200,
                     startvelocity = 200,
                     texture2 = "coresmoketrail",
                     trajectoryheight = 1,
                     turnrate = 0,
                     turret  = true, 
                     weaponacceleration = 120,
                     weapontimer = 6,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 510,
                     damage = {
                         default = 450,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "exp_heavyrocket",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
