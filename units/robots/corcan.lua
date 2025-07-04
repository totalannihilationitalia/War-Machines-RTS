-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corcan= {
               acceleration = 0.12,
--               badTargetCategory = ANTILASER,
               brakerate  = 0.188,
               buildcostenergy = 8722,
               buildcostmetal = 522,
               builder = false,
               buildpic = "nfacan.png",
               buildtime  = 11734,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "0.0 0.0 0.0",
               --collisionvolumescales = "28.0 27.0 25.0",
               --collisionvolumetype = "box",
               corpse = "corcan_dead",
--               defaultmissiontype = Standby,
               description = "Armored Assault Kbot",
--               firestandorders = 1,
               energymake = 0.8,
               energystorage = 0,
               energyUse = 0.8,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 4350,
               maxslope = 14,
               maxvelocity = 1.35,
               maxwaterdepth = 21,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Can",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfacan.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 350,
--               soundcategory= "COR_KBOT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 970,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "ANTILASER",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Can Wreckage",
               category = "corpses",
               object = "CORCAN_DEAD",
               featuredead = "corcan_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 339,
               damage = 2310,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Can Heap",
               category = "heaps",
               object = "2X2F",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 136,
               damage = 1155,
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
                     [1] = "kbcormov",
                    },
               select = {
                     [1] = "kbcorsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		core_canlaser = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.15,
--                     cegTag = "",
                     corethickness = 0.2,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 75,
                     explosiongenerator = "custom:SMALL_YELLOW_LASER_BURN",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HighEnergyLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 275,
                     reloadtime = 0.8,
                     rgbcolor = "1 1 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrhvy3",
                     targetmoveerror = 0.2,
                     thickness = 3,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 700,
                     damage = {
                         default = 275,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "core_canlaser",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
