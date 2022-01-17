-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  tawf114= {
               acceleration = 0.0209,
--               badTargetCategory = VTOL,
               brakerate  = 0.0198,
               buildcostenergy = 20701,
               buildcostmetal = 939,
               builder = false,
               buildpic = "nfabanisher.png",
               buildtime  = 23129,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK WEAPON NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "tawf114_dead",
--               defaultmissiontype = Standby,
               description = "Heavy Missile Tank",
--               firestandorders = 1,
               energymake = 1.1,
               energystorage = 22,
               energyUse = 1.1,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 2250,
               maxslope = 20,
               maxvelocity = 1.905,
               maxwaterdepth = 20,
               metalStorage = 4,
--               mobilestandorders= 1,
               movementclass = "HTANK4",
               name = "Banisher",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfa_rocket_vehycle_tex.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 546,
--               soundcategory= "CORE_VEHICLE",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 375.1,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               leaveTracks = true,
               trackOffset = 8,
               trackStrength = 10,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 42,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Banisher Wreckage",
               category = "corpses",
               object = "TAWF114_DEAD",
               featuredead = "tawf114_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 30,
               blocking= true,
               hitdensity = 100,
               metal = 510,
               damage = 1350,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Banisher Heap",
               category = "heaps",
               object = "3X3A",
               footprintx = 3,
               footprintz = 3,
               height = 5,
               blocking = false,
               hitdensity= 100,
               metal = 244,
               damage = 675,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
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
               [1]="custom:plasmaflare",
               [2]="custom:rocketflare",
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
                     [1] = "vcormove",
                    },
               select = {
                     [1] = "vcorsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		tawf_banisher = {
                     areaofeffect = 128,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.4,
                     explosiongenerator = "custom:VEHHVYROCKET_EXPLOSION",
                     firestarter = 20,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "TAWF114a",
                     name= "Banisher",
                     noselfdamage = true,
                     range = 800,
                     reloadtime = 7.5,
                     smoketrail = true,
                     soundhit = "TAWF114b",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "TAWF114a",
                     startvelocity = 400,
                     tolerance = 9000,
                     tracks = true, 
		     trajectoryheight = 0.5,
                     turnrate = 22000,
                     turret  = true, 
                     weaponacceleration = 70,
                     weapontimer = 5,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 400,
                     damage = {
                         default = 1000,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "tawf_banisher",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 270,
                 maindir = "0 0 1",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
