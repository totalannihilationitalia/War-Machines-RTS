-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufshat= {
               acceleration = 0.023,
--               badTargetCategory = NOTAIR,
               brakerate  = 0.014,
               buildcostenergy = 2437,
               buildcostmetal = 286,
               builder = false,
               buildpic = "eufshat.png",
               buildtime  = 5991,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufshat_dead",
--               defaultmissiontype = Standby,
               description = "Heavy Missile Vehicle",
--               firestandorders = 1,
               energymake = 0.5,
               energyUse = 0.5,
               explodeas = "BIG_UNITEX",
               footprintx = 4,
               footprintz = 4,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 1120,
               maxslope = 16,
               maxvelocity = 1.25,
               maxwaterdepth = 12,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Shatterer",
               noAutoFire = false,
               objectname = "eufshat.s3o",
               selfdestructas = "BIG_UNIT",
               sightdistance = 385,
--               soundcategory= "CORE_VEHICLE",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 435,
               wpri_badtargetcategory = "NOTAIR",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Wreckage",
               category = "corecorpses",
               object = "eufshat_dead",
               featuredead = "eufshat_heap",
               featurereclamate = "smudge01",
               footprintx = 4,
               footprintz = 4,
               height = 23,
               hitdensity = 100,
               metal = 229,
               damage = 896,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Heap",
               category = "heaps",
               object = "2X2D",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 129,
               damage = 120,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
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
		shatter_missile = {
                     areaofeffect = 48,
                     avoidfeature = true,
                     canattackground = false,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.4,
                     explosiongenerator = "custom:VEHHVYROCKET_EXPLOSION",
                     firestarter = 70, --20
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "missile",
                     name= "Heavy Missiles",
                     noselfdamage = true,
                     range = 650,
                     reloadtime = 0.5,
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
                     turnrate = 30000,
                     turret  = true, 
                     weaponacceleration = 70,
                     weapontimer = 5,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 520,
                     damage = {
                         default = 65,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "NOTAIR",
                 def = "shatter_missile",
                 onlytargetcategory = "VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
