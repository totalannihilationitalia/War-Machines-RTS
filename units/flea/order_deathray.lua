-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
	order_deathray = {
		acceleration = 1.2,
		brakerate = 0.4,
		buildcostenergy = 1280,
		buildcostmetal = 58,
		buildpic = "nfablade.png",
		buildtime = 1333,
		canattack = true,
		canfly = true,
		canguard = true,
		canmove = true,
		category = "ALL WEAPON SURFACE NOTSUB",
		collide = false,
		cruisealt = 40, --22
		defaultmissiontype = "VTOL_standby",
		description = "Floating Deathray",
		energymake = 2,
		energystorage = 0,
		energyuse = 0.4,
		explodeas = "Order_Deathrayexplode", -----------verificare esplosione
		firestandorders = 1,
		footprintx = 3,
		footprintz = 3,
		hoverattack = true,
		icontype = "air",
		idleautoheal = 5,
		idletime = 1800,
		maneuverleashlength = 75,
		mass = 54,
		maxdamage = 1337,
		maxslope = 10,
		maxvelocity = 1.65,
		maxwaterdepth = 0,
		metalstorage = 0,
		mobilestandorders = 1,
		name = "Flying DeathLaser",
		noautofire = false,
		nochasecategory = "COMMANDER SUB VTOL",
		objectname = "uflea_3.s3o",
		scale = 1,
		seismicsignature = 0,
		selfdestructas = "Order_Deathrayexplode",  -----------verificare esplosione
		side = "NFA",
		sightdistance = 433,
		standingfireorder = 2,
		standingmoveorder = 1,
		steeringmode = 2,
		turninplaceanglelimit = 360,
		turninplacespeedlimit = 6.831,
		turnrate = 1300,
		unitname = "bladew",
		upright = true,
		usesmoothmesh = 0,
		workertime = 0,
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:redflare",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------

		sounds = {
			canceldestruct = "cancel2",
			underattack = "warning1",
			cant = {
				[1] = "cantdo4",
			},
			count = {
				[1] = "count6",
				[2] = "count5",
				[3] = "count4",
				[4] = "count3",
				[5] = "count2",
				[6] = "count1",
			},
			ok = {
				[1] = "vtolcrmv",
			},
			select = {
				[1] = "vtolcrac",
			},
		},
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		deathlaser = {
                     areaofeffect = 24,
                     avoidfeature = true,
                     beamtime = 0.40,
--                     cegTag = "BLUCRAP",
                     corethickness = 0.32,
--                     craterareaofeffect =  ,
                     craterboost = 1,
                     cratermult = 1,
                     duration = 0.31,
                     edgeeffectiveness = 0.99,
                     energypershot = 0,
--                     explosiongenerator = "custom:ZIPPERDICKER_EFFECT",
                     explosiongenerator = "custom:Gator",
                     firestarter = 70,
                     impulseboost = 0,
                     impulsefactor = 1,
                     name= "DeathLaser",
                     noexplode = true,
                     noselfdamage = true,
                     laserflaresize = 6,
                     paralyzer = false,
                     range = 350, --350
                     reloadtime = 1.25,
                     rgbcolor = "0.7 0.2 0.2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir3",
                     soundtrigger = "1",
                     targetmoveerror = 0.05,
                     thickness = 3.25,
                     tolerance = 10000,
                     turret  = true, 
                     waterweapon = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 900,
                     damage = {
                         default = 200, --133
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition

-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
		weapons = {
			[1] = {
				def = "deathlaser",
				maindir = "0 0 1",
				maxangledif = 90,
				onlytargetcategory = "NOTAIR",
			},
		},
	},
}
