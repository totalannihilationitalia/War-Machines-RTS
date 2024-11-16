-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  orcl= {
               acceleration = 0.06,
	       airhoverfactor = 0, 		--add
	       airStrafe = false,     	  	--add	
               activatewhenbuilt = true,
               brakerate  = 1,
               buildcostenergy = 38023,
               buildcostmetal = 3511,
               builder = false,
               buildpic = "orcl.png",
               buildtime  = 59993,
               canAttack = true,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
	       category = "ALL WEAPON VTOL NOTSUB",
		collisionvolumeoffsets = "0 9 -10",
		collisionvolumescales = "40 40 200",
		collisionvolumetype = "Box",
               cruiseAlt = 280,
--               defaultmissiontype = VTOL_standby,
               description = "Radar/Sonar Skycruiser",
--               firestandorders = 1,
               energymake = 1,
               energystorage = 20,
               energyUse = 66,
               explodeas = "AATOMIC_BLAST",
               footprintx = 4,
               footprintz = 4,
               hoverattack = true,		--add
--               maneuverleashlength  = 1280,
               mass = 150,
               maxdamage = 4415,
               maxslope = 10,
               maxvelocity = 0.99,
               maxwaterdepth = 0,
               metalStorage = 10,
--               mobilestandorders= 1,
               name = "Oracle",
               noAutoFire = false,
               nochasecategory = "UNDERWATER",
               objectname = "orcl.s3o",
               onoffable = true,
               radardistance = 4000,
--               scale = 1,
               selfdestructas = "AATOMIC_BLAST",
               sightdistance = 800,
               sonardistance = 4000,
--               soundcategory= "CORESKYCRU",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "VTOL", -- verificare se necessario
               turnrate = 175,
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
		lightskycruiseranni = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.1,
--                     beamweapon = true,
                     cegTag = "BLUCRAP",
--                     craterareaofeffect =  ,
                     energypershot = 10,
                     explosiongenerator = "custom:Gatorazzurro",  -- explosiongenerator = "custom:PURPLELASER",
                     firestarter = 90,
                     name= "Annihilator Weapon",
                     range = 655,
                     reloadtime = 0.1,
                     rgbcolor = "0 0.5 1",
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
                         default = 13,
                     }, -- close damage
             }, --close single weapon definitions

		heavyflying_missile = {
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

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "lightskycruiseranni",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 badtargetcategory = "NOTAIR",
                 def = "heavyflying_missile",
                 onlytargetcategory = "VTOL", -- weapon 2
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
