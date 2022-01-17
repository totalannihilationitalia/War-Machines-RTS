-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armmanni= {
               acceleration = 0.0132,
--               badTargetCategory = ANTILASER,
               brakerate  = 0.1375,
               buildcostenergy = 12477,
               buildcostmetal = 1129,
               builder = false,
               buildpic = "icumanni.png",
               buildtime  = 25706,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armmanni_dead",
--               defaultmissiontype = Standby,
               description = "Mobile Tachyon Weapon",
--               firestandorders = 1,
               energymake = 5.2,
               energystorage = 0,
               energyUse = 5.2,
               explodeas = "ESTOR_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 2500,
               maxslope = 12,
               maxvelocity = 1.518,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Penetrator",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "ICUMANNI.s3o",
               seismicsignature = 0,
               selfdestructas = "ESTOR_BUILDING",
               sightdistance = 650,
--               soundcategory= "ARM_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 151,
               workertime = 0,
               wpri_badtargetcategory = "ANTILASER",
               leaveTracks = true,
               trackOffset = 16,
               trackStrength = 10,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 37,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Penetrator Wreckage",
               category = "corpses",
               object = "ARMMANNI_DEAD",
               featuredead = "armmanni_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 734,
               damage = 1800,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 40.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Penetrator Heap",
               category = "heaps",
               object = "3X3C",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 294,
               damage = 900,
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
                     [1] = "tarmmove",
                    },
               select = {
                     [1] = "tarmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		atam = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.3,
--                     cegTag = "",
                     corethickness = 0.3,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 1000,
                     explosiongenerator = "custom:FLASH3blue",
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "ATAM",
                     noselfdamage = true,
                     laserflaresize = 20,
                     range = 950,
                     reloadtime = 5.5,
                     rgbcolor = "0 0 1",
                     soundhit = "xplolrg1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "annigun1",
                     targetmoveerror = 0.3,
                     thickness = 5.5,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 1500,
                     damage = {
                         default = 2500,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "atam",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 180,
                 maindir = "0 0 1",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
