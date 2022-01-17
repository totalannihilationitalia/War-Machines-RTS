-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufrld= {
               acceleration = 0.015,
--               badTargetCategory = VTOL,
               brakerate  = 0.009,
               buildcostenergy = 3409,
               buildcostmetal = 365,
               builder = false,
               buildpic = "eufrld.png",
               buildtime  = 7631,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufrld_dead",
--               defaultmissiontype = Standby,
               description = "Heavy Support Vehicle",
--               firestandorders = 1,
               energymake = 1,
               energyUse = 1,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 1400,
               maxslope = 15,
               maxvelocity = 1.125,
               maxwaterdepth = 12,
--               mobilestandorders= 1,
               movementclass = "HTANK3",
               name = "Loader",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "eufrld.s3o",
               selfdestructas = "BIG_UNIT",
               sightdistance = 450,
--               soundcategory= "CORE_VEHICLE",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 334,
               wpri_badtargetcategory = "VTOL",
               leaveTracks = true,
               trackOffset = 8,
               trackStrength = 10,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 40,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Wreckage",
               category = "corecorpses",
               object = "eufrld_dead",
               featuredead = "eufrld_heap",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 22,
               hitdensity = 100,
               metal = 292,
               damage = 1120,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Heap",
               category = "heaps",
               object = "3X3F",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 220,
               damage = 1260,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS -- ******************************************************************** sistemare effetto
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
		gauss = {
                     accuracy = 32,
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.1,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 75,
                     explosiongenerator = "custom:GatorYellow",
                     firestarter = 10,
                     impulseboost = 1,
                     impulsefactor = 1,
                     name= "EufPathLaser",
                     noselfdamage = true,
                     proximitypriority = 1.5,
                     range = 650,
                     reloadtime = 1.79,
                     rgbcolor = "1 1 0.8",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasfirerb",
                     soundtrigger = "1",
                     thickness = 2,
                     tolerance = 20000,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 550,
                     damage = {
                         default = 170,
                     }, -- close damage
             }, --close single weapon definitions

		eufrld_vlaunch = {
                     areaofeffect = 60,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.5,
                     explosiongenerator = "custom:STARFIRE",
                     firestarter = 100,
                     flighttime = 10,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "corkbmissl1",
                     name= "HeavyRockets",
                     noselfdamage = true,
                     range = 1210,
                     reloadtime = 7,
                     smoketrail = true,
                     soundhit = "xplomed4",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Rockhvy1",
                     turnrate = 28384,
                     weaponacceleration = 100,
                     weapontimer = 3,
                     weapontype = "StarburstLauncher",
                     weaponvelocity  = 800,
                     damage = {
                         default = 750,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "gauss",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 badtargetcategory = "VTOL",
                 def = "eufrld_vlaunch",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
