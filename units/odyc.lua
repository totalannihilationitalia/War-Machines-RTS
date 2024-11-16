-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  odyc= {
               acceleration = 0.06,
               activatewhenbuilt = true,
	       airhoverfactor = 0, 		--add
	       airStrafe = false,     	  	--add	
               brakerate  = 1,
               buildcostenergy = 36083,
               buildcostmetal = 3443,
               builder = false,
               buildpic = "odyc.png",
               buildtime  = 57045,
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
               description = "Radar/Sonar Skycruiser",
--               firestandorders = 1,
               energymake = 0,
               energystorage = 20,
               energyUse = 1,
               explodeas = "AATOMIC_BLAST",
               footprintx = 4,
               footprintz = 4,
               hoverattack = true,		--add
--               maneuverleashlength  = 1280,
               mass = 150,
               maxdamage = 4382,
               maxslope = 10,
               maxvelocity = 0.99,
               maxwaterdepth = 0,
               metalStorage = 10,
--               mobilestandorders= 1,
               name = "Odyssey",
               noAutoFire = false,
               nochasecategory = "UNDERWATER",
               objectname = "nfaodyc.s3o",
               onoffable = true,
               radardistance = 4000,
--               scale = 1,
               selfdestructas = "AATOMIC_BLAST",
               sightdistance = 800,
               sonardistance = 4000,
--               soundcategory= "ARMSKYCRU",
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
		lightskycruiser_emg = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     burst = 2, -- lua:salvoSize
                     burstrate = 0.1, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     explosiongenerator = "custom:EMGFLASH",
                     name= "E.M.G.",
                     range = 600,
                     reloadtime = 0.2,
                     rgbcolor = "1 0.87 0.3",
                     size = "1.5",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "armsml2",
                     soundtrigger = "0",
                     sprayangle = 424,
                     tolerance = 11000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weapontimer = 1,
                     weapontype = " ",
                     weaponvelocity  = 700,
                     damage = {
                         default = 15,
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
                 def = "lightskycruiser_emg",
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
