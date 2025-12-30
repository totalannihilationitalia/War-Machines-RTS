-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  cirr= {
               acceleration = 0.06,
	       airhoverfactor = 0, 		--add
	       airStrafe = false,     	  	--add	
               brakerate  = 1,
               buildcostenergy = 19946,
               buildcostmetal = 1961,
               builder = false,
               buildpic = "cirr.png",
               buildtime  = 43453,
               canAttack = true,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
	       category = "ALL WEAPON VTOL NOTSUB",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 280,
--               defaultmissiontype = VTOL_standby,
               description = "Light Skycruiser",
--               firestandorders = 1,
               energymake = 0,
               energystorage = 0,
               energyUse = 1,
               explodeas = "AATOMIC_BLAST",
               footprintx = 3,
               footprintz = 3,
               hoverattack = true,		--add
--               maneuverleashlength  = 1280,
               mass = 30000,
               maxdamage = 7000,
               maxslope = 10,
               maxvelocity = 1.5,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               name = "Cirrus",
               noAutoFire = false,
               nochasecategory = "UNDERWATER",
               objectname = "cirr.s3o",
               radardistance = 0,
--               scale = 1,
               selfdestructas = "AATOMIC_BLAST",
               sightdistance = 800,
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
                     weapontype = "BeamLaser",
                     weaponvelocity  = 1100,
                     damage = {
                         default = 50,
                     }, -- close damage
             }, --close single weapon definitions

		flying_missile = {
                     areaofeffect = 96,
                     avoidfeature = true,
                     canattackground = false,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     explosiongenerator = "custom:popupcannon",
                     firestarter = 70,
                     metalpershot = 0,
                     model = "DEMR1",
                     name= "Missiles",
                     range = 900,
                     reloadtime = 5.6,
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

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "skycruiser_emg",
               onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 badtargetcategory = "NOTAIR",
                 def = "flying_missile",
                 onlytargetcategory = "VTOL", -- weapon 2
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
