-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  demr= {
               acceleration = 0.03,
			   airhoverfactor=0,
               brakerate  = 1,
               buildcostenergy = 47644,
               buildcostmetal = 5264,
               builder = false,
               buildpic = "demr.png",
               buildtime  = 171754,
               canAttack = true,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "VTOL WEAPON NOTSUB",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 280,
--               defaultmissiontype = VTOL_standby,
               description = "Heavy Skycruiser",
--               firestandorders = 1,
               energymake = 0,
               energystorage = 10,
               energyUse = 5,
               explodeas = "AATOMIC_BLAST",
               footprintx = 5,
               footprintz = 5,
			   hoverattack = true,
--               maneuverleashlength  = 1280,
               mass = 300,
               maxdamage = 5230,
               maxslope = 10,
               maxvelocity = 0.8,
               maxwaterdepth = 0,
               metalStorage = 10,
--               mobilestandorders= 1,
               name = "Demarcator",
               noAutoFire = false,
               nochasecategory = "UNDERWATER",
               objectname = "demr.s3o",
               radardistance = 0,
--               scale = 1,
               selfdestructas = "AATOMIC_BLAST",
               sightdistance = 1100,
--               soundcategory= "ARMSKYCRU",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "VTOL", -- verificare se necessario
               turnrate = 200,
               upright = true,
               workertime = 0,
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		heavyflying_missile = {
                     areaofeffect = 96,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     explosiongenerator = "custom:popupcannon",
                     firestarter = 70,
                     metalpershot = 0,
                     model = "DEMR1",
                     name= "Missiles",
                     range = 900,
                     reloadtime = 2.8,
                     smoketrail = true,
                     soundhit = "WASP2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "WASP1",
                     startvelocity = 1000,
                     tolerance = 9000,
                     tracks = true, 
                     turnrate = 50000,
                     turret  = true, 
                     weaponacceleration = 200,
                     weapontimer = 10,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 1600,
                     damage = {
                         default = 221,
                     }, -- close damage
             }, --close single weapon definitions

		skycruiser_emg = {
                     accuracy = 700,
                     areaofeffect = 224,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0.25,
                     cratermult = 0.25,
                     edgeeffectiveness = 0.75,
                     energypershot = 100,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.5,
                     impulsefactor = 0.5,
                     name= "Sky Cruiser EMG",
                     noselfdamage = true,
                     range = 650,
                     reloadtime = 0.4,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannon3",
                     turret  = true, 
                     weapontimer = 14,
                     weapontype = "EmgCannon",
                     weaponvelocity  = 1100,
                     damage = {
                         default = 50,
                     }, -- close damage
             }, --close single weapon definitions
}, -- close weapon definition


-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "heavyflying_missile",
                 onlytargetcategory = "VTOL",
                 },
                 [2] = {
                 def = "skycruiser_emg",
                 onlytargetcategory = "SURFACE",-- weapon 2
                 },
                 [3] = {
                 def = "skycruiser_emg",
                 onlytargetcategory = "SURFACE",
                 },
                 [4] = {
                 badtargetcategory = "VTOL",
                 def = "heavyflying_missile",
                 onlytargetcategory = "SURFACE VTOL",-- weapon 4
                 },
                 [5] = {
                 badtargetcategory = "VTOL",
                 def = "heavyflying_missile",
                 onlytargetcategory = "SURFACE VTOL",-- weapon 5
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total


