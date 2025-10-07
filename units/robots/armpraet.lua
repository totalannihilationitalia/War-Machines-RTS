-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  ARMPRAET= {
               acceleration = 0.09,
               activatewhenbuilt = true,
               brakerate  = 0.99,
               buildcostenergy = 577039,
               buildcostmetal = 27182,
               builder = false,
               buildpic = "andpraetorian.png",
               buildtime  = 552145,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
			   collisionvolumeoffsets = "0 100 -5",
			   collisionvolumescales = "90 200 90",
			   collisionvolumetype = "CylY",
--               defaultmissiontype = Standby,
               description = "Experimental ICU BioMech",
--               firestandorders = 1,
               energymake = 1.1,
               energyUse = 1.1,
               explodeas = "NUCLEAR_MISSILE",
               footprintx = 4,
               footprintz = 4,
               icontype = "krogoth",
               idleautoheal = 10,
               idletime = 30,
--               maneuverleashlength  = 640,
               mass = 200000,
               maxdamage = 80000,
               maxslope = 36,
               maxvelocity = 1.12,
               maxwaterdepth = 1200,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Praetorian",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "andpraetorian.s3o",
               onoffable = true,
               radardistance = 1200,
               seismicsignature = 5000,
               selfdestructas = "CRBLMSSL",
               selfdestructcountdown = 10,
               sightdistance = 1000,
               sonardistance = 1200,
--               soundcategory= "KROGOTH",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 225,
               upright = true,
               workertime = 0,
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
                     [1] = "krogok1",
                    },
               select = {
                     [1] = "krogsel1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		armpraetorian_fire = {
                     areaofeffect = 112,
                     avoidfeature = true,
                     burst = 3, -- lua:salvoSize
                     burstrate = 0.04, -- lua: salvoDelay
                     cegTag = "Praetweapon1",
--                     craterareaofeffect =  ,
                     craterboost = 1,
                     cratermult = 1,
                     edgeeffectiveness = 0.5,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0,
                     impulsefactor = 1,
                     Intensity = 4,
                     name= "GaussxxCannon",
                     noselfdamage = true,
                     range = 990,
                     reloadtime = 9,
                     rgbcolor = "0.1 0.75 0.15",
                     size = "0.01",
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "kroggie2",
                     sprayangle = 2750,
                     tolerance = 6000,
                     turret  = true, 
                     weapontimer = 2,
                     weapontype = "Cannon",
                     weaponvelocity  = 600,
                     damage = {
                         default = 8550,
                     }, -- close damage
             }, --close single weapon definitions

		particleaccelerator = {
                     areaofeffect = 60,
                     avoidfeature = true,
                     beamtime = 1.5, 
					 beamDecay = 0.1,
--                     burnblow = true,
--                     cegTag = "",
                     corethickness = 0.4,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 666.6666667,
                     explosiongenerator = "custom:PARTACCEL",
                     firestarter = 20,
                     impulseboost = 0,
                     name= "Particle accelerator",
                     noexplode = true,
                     laserflaresize = 6,
  				 	 largebeamlaser=true,
					 pulseSpeed = 2,
                     range = 1600,
                     reloadtime = 4,
                     rgbcolor = "0 1 0",
                     soundhit = "lasbladehit",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "accel",
                     soundtrigger = "1",
					 scrollSpeed = 10,
                     targetmoveerror = 0.4,
					 texture1="Type4Beam",
					 texture2="NULL",
					 texture3="NULL",
					 texture4="EMG",
                     thickness = 20,
                     tolerance = 1500,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 1500,
                     damage = {
                         default = 4000,
                     }, -- close damage
             }, --close single weapon definitions

		corkrog_rocket = {
                     areaofeffect = 96,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:STARFIRE",
                     firestarter = 70,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "fmdmisl",
                     name= "HeavyRockets",
                     noselfdamage = true,
                     proximitypriority = -1,
                     range = 800,
                     reloadtime = 2.75,
                     smoketrail = true,
                     soundhit = "xplosml2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rocklit1",
                     startvelocity = 200,
                     texture2 = "coresmoketrail",
                     tolerance = 9000,
                     tracks = true, 
                     turnrate = 50000,
                     weaponacceleration = 230,
                     weapontimer = 2,
                     weapontype = "StarburstLauncher",
                     weaponvelocity  = 4000,
                     damage = {
                         default = 360,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "armpraetorian_fire",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 badtargetcategory = "VTOL",				 
                 def = "particleaccelerator",
                 onlytargetcategory = "SURFACE VTOL",
                 },
                 [3] = {
                 def = "corkrog_rocket",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
