-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armfav= {
               acceleration = 0.12,
--               badTargetCategory = ANTIGATOR,
               brakerate  = 0.165,
               buildcostenergy = 342,
               buildcostmetal = 29,
               builder = false,
               buildpic = "icufav.png",
               buildtime  = 912,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armfav_dead",
--               defaultmissiontype = Standby,
               description = "Light Scout Vehicle",
--               firestandorders = 1,
               energymake = 0.2,
               energystorage = 0,
               energyUse = 0.2,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 80,
               maxslope = 26,
               maxvelocity = 6.4,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK2",
               name = "Jeffy",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "ARMFAV.s3o",
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 585,
--               soundcategory= "ARM_VEHICLE",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 1144,
               workertime = 0,
               wpri_badtargetcategory = "ANTIGATOR",
               leaveTracks = true,
               trackOffset = -3,
               trackStrength = 3,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 25,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Jeffy Wreckage",
               category = "corpses",
               object = "ARMFAV_DEAD",
               featuredead = "armfav_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 15,
               damage = 111,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Jeffy Heap",
               category = "heaps",
               object = "2X2F",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 6,
               damage = 56,
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
                     [1] = "varmmove",
                    },
               select = {
                     [1] = "varmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		arm_laser = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.18,
--                     beamweapon = true,
                     burstrate = 0.2, -- lua: salvoDelay
                     cegTag = "PINKCRAP",
                     corethickness = 0.3,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     duration = 0.02,
                     energypershot = 2,
                     explosiongenerator = "custom:PINKFLASH",
                     firestarter = 50,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     Intensity = 0.8,
                     name= "Laser",
                     noselfdamage = true,
                     laserflaresize = 5,
                     range = 180,
                     reloadtime = 0.95,
                     rgbcolor = "1 1 0.4",
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
                     weapontype = "BeamLaser",  -- sistemare e rendere LaserCannon
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
--               badtargetcategory = "ANTIGATOR",
                 def = "arm_laser",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
