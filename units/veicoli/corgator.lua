-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corgator= {
               acceleration = 0.055,
--               badTargetCategory = ANTIGATOR OGGETTISTATICI,
               brakerate  = 0.055,
               buildcostenergy = 1042,
               buildcostmetal = 118,
               builder = false,
               buildpic = "nfagator.png",
               buildtime  = 1761,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corgator_dead",
--               defaultmissiontype = Standby,
               description = "Light Tank",
--               firestandorders = 1,
               energymake = 0.5,
               energystorage = 0,
               energyUse = 0.5,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 693,
               maxslope = 10,
               maxvelocity = 3,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK2",
               name = "Instigator",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfagator.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 273,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 484,
               workertime = 0,
               wpri_badtargetcategory = "ANTIGATOR OGGETTISTATICI",
               leaveTracks = true,
               trackOffset = 5,
               trackStrength = 5,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 21,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Instigator Wreckage",
               category = "corpses",
               object = "CORGATOR_DEAD",
               featuredead = "corgator_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 77,
               damage = 450,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "22.0 10.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Instigator Heap",
               category = "heaps",
               object = "2X2F",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 31,
               damage = 225,
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
                     [1] = "tcormove",
                    },
               select = {
                     [1] = "tcorsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		gator_laserx = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.1,
--                     cegTag = "",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 0,
                     explosiongenerator = "custom:SMALL_ARANCIO_BURN",
                     firestarter = 50,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "Laser",
                     noselfdamage = true,
                     laserflaresize = 6,
                     range = 230,
                     reloadtime = 0.77,
                     rgbcolor = "1 0.2 0",
                     soundhit = "lasrhit2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrlit3",
                     soundtrigger = "1",
                     targetmoveerror = 0.15,
                     thickness = 2.5,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 1000,
                     damage = {
                         default = 75,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "gator_laserx",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
