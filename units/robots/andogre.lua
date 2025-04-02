-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andogre= {
               acceleration = 0.007,
               activatewhenbuilt = true,
--               amphibious = 1,
               brakerate  = 0.05,
               buildcostenergy = 33562,
               buildcostmetal = 2020,
               builder = false,
               buildpic = "",
               buildtime  = 50975,
               canAttack = true,
--               canDGun = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andogre_dead",
--               defaultmissiontype = Standby,
               description = "Heavy Amphibious Kbot",
--               firestandorders = 1,
               energymake = 2.8,
               energystorage = 100,
               energyUse = 2.8,
               explodeas = "BIG_UNIT",
               footprintx = 3,
               footprintz = 3,
               icontype = "robots",
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 14000,
               maxslope = 15,
               maxvelocity = 1.25,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Ogre",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "andogre.s3o",
               radardistance = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 510,
               sonardistance = 120,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 186,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  andogre_dead = {
               world = "All Worlds",
               description = "Ogre Wreckage",
               category = "cor_corpses",
               object = "andogre_dead",
               featuredead = "andogre_heap",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 623,
               damage = 1982,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "50.0 25 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  andogre_heap = {
               world = "All Worlds",
               description = "Ogre Wreckage",
               category = "heaps",
               object = "3x3e",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 327,
               damage = 2682,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
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
		core_laserh1 = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.15,
--                     cegTag = "",
                     corethickness = 0.3,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 75,
                     explosiongenerator = "custom:LARGE_YELLOW_LASER_BURN",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HighEnergyLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 650,
                     reloadtime = 0.55,
                     rgbcolor = "1 1 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrhvy3",
                     targetmoveerror = 0.25,
                     thickness = 3,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 800,
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
                 def = "core_laserh1",
                 onlytargetcategory = "SURFACE",
                 },

}, -- close weapon usage

}, -- close unit data 
} -- close total
