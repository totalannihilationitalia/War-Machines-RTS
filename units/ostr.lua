-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  ostr = {
               acceleration = 0.03,
	       airhoverfactor = 0, 		--add
	       airStrafe = false,     	  	--add	
               brakerate  = 1,
               buildcostenergy = 53598,
               buildcostmetal = 4999,
               builder = false,
               buildpic = "OSTR.JPG",
               buildtime  = 179033,
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
--               cruiseAlt = 400,
--               defaultmissiontype = VTOL_standby,
               description = "Heavy Skycruiser",
--               firestandorders = 1,
               energymake = 0,
               energystorage = 10,
               energyUse = 5,
               explodeas = "AATOMIC_BLAST",
               footprintx = 5,
               footprintz = 5,
               hoverattack = true,		--add
--               maneuverleashlength  = 1280,
               mass = 30000,
               maxdamage = 5524,
               maxslope = 10,
               maxvelocity = 0.85,
               maxwaterdepth = 0,
               metalStorage = 10,
--               mobilestandorders= 1,
               name = "Ostraciser",
               noAutoFire = false,
               nochasecategory = "UNDERWATER",
               objectname = "nfaostr.s3o",
               radardistance = 0,
--               scale = 1,
               selfdestructas = "AATOMIC_BLAST",
               sightdistance = 1100,
--               soundcategory= "CORESKYCRU",
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
		flying_missile = {
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

		skycruiseranni = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.1,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     energypershot = 20,
                     explosiongenerator = "custom:PURPLELASER",
                     firestarter = 90,
                     name= "Annihilator Weapon",
                     range = 600,
                     reloadtime = 0.1,
                     soundhit = "xplolrg1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "annigun1",
                     targetmoveerror = 0.5,
                     tolerance = 500,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 900,
                     damage = {
                         default = 28,
                     }, -- close damage
             }, --close single weapon definitions


		core_total_annihilator = {
                     areaofeffect = 40,
                     avoidfeature = true,
                     beamtime = 2,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     energypershot = 100,
                     explosiongenerator = "custom:GREENLASER",
                     firestarter = 90,
                     impulsefactor = 0.5,
                     name= "Annihilator Weapon",
                     range = 900,
                     reloadtime = 8.0,
                     soundhit = "xplolrg1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "LASRLONG",
                     targetmoveerror = 0.5,
                     thickness = 4.1,
                     tolerance = 200,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 1000,
                     damage = {
                         default = 1425,
                     }, -- close damage
             }, --close single weapon definitions
}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "flying_missile",
                 onlytargetcategory = "VTOL", -- weapon 2
                 },
                 [2] = {
                 badtargetcategory = "NOTAIR",
                 def = "skycruiseranni",
                 onlytargetcategory = "SURFACE", -- weapon 2
                 },
                 [3] = {
                 badtargetcategory = "NOTAIR",
                 def = "skycruiseranni",
                 onlytargetcategory = "SURFACE", -- weapon 3
                 },
                 [4] = {
                 badtargetcategory = "NOTAIR",
                 def = "core_total_annihilator",
                 onlytargetcategory = "SURFACE", -- weapon 4
	         WeaponMainDir="0 0 0",
		 MaxAngleDif=180,
                 },
                 [5] = {
                 badtargetcategory = "NOTAIR",
                 def = "core_total_annihilator",
                 onlytargetcategory = "SURFACE", -- weapon 5
	  	 WeaponMainDir="0 0 0",
 		 MaxAngleDif=180,
                 },
	   }, -- close weapon usage

}, -- close unit data 
} -- close total

