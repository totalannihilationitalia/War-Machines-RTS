-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corfav= {
               acceleration = 0.11,
--               badTargetCategory = ANTIGATOR OGGETTISTATICI,
               brakerate  = 0.145,
               buildcostenergy = 256,
               buildcostmetal = 24,
               builder = false,
               buildpic = "nfafav.png",
               buildtime  = 1104,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corfav_dead",
--               defaultmissiontype = Standby,
               description = "Light Scout Vehicle",
--               firestandorders = 1,
               energymake = 0.3,
               energystorage = 0,
               energyUse = 0.3,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 95,
               maxslope = 26,
               maxvelocity = 4.89,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK2",
               name = "Weasel",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfafav.s3o",
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 535,
--               soundcategory= "CORE_VEHICLE",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 1097,
               workertime = 0,
               wpri_badtargetcategory = "ANTIGATOR OGGETTISTATICI",
               leaveTracks = true,
               trackOffset = -3,
               trackStrength = 3,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 27,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Weasel Wreckage",
               category = "corpses",
               object = "CORFAV_DEAD",
               featuredead = "corfav_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= false,
               hitdensity = 100,
               metal = 16,
               damage = 132,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Weasel Heap",
               category = "heaps",
               object = "2X2B",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 6,
               damage = 66,
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
		core_laser = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.18,
                     burstrate = 0.2, -- lua: salvoDelay
--                     cegTag = "",
                     corethickness = 0.1,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     duration = 0.02,
                     energypershot = 5,
                     explosiongenerator = "custom:SMALL_ARANCIO_BURN",
                     firestarter = 50,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "Laser",
                     noselfdamage = true,
                     laserflaresize = 5,
                     range = 180,
                     reloadtime = 1,
                     rgbcolor = "1 1 0",
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
                     weapontype = "BeamLaser",
                     weaponvelocity  = 800,
                     damage = {
                         default = 35,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "core_laser",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
