-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  taln= {
               acceleration = 0.06,
	       airhoverfactor = 0, 		--add
	       airStrafe = false,     	  	--add	
               brakerate  = 1,
               buildcostenergy = 19001,
               buildcostmetal = 2014,
               builder = false,
               buildpic = "taln.png",
               buildtime  = 44398,
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
               mass = 1100,
               maxdamage = 7000,
               maxslope = 10,
               maxvelocity = 1.4,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               name = "Talon",
               noAutoFire = false,
               nochasecategory = "UNDERWATER",
               objectname = "taln.s3o",
               radardistance = 0,
--               scale = 1,
               selfdestructas = "AATOMIC_BLAST",
               sightdistance = 800,
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
                 def = "skycruiseranni",
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
