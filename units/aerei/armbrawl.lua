-- made by DaRyL - www.warmachinesrts.com

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------

return {
	armbrawl = {
		acceleration = 0.24,
		bankscale = 1,
		bmcode = 1,
		brakerate = 0.441,
		buildcostenergy = 6000,
		buildcostmetal = 300,
		builder = false,
		buildpic = "icubraw.png",
		buildtime = 20000,
		canattack = true,
		canfly = true,
		canguard = true,
		canmove = true,
		canpatrol = true,
		canstop = 1,
		category = "ALL NOTLAND MOBILE WEAPON ANTIGATOR NOTSUB ANTIFLAME ANTIEMG ANTILASER VTOL NOTSHIP",
		collide = false,
		cruisealt = 100,
		defaultmissiontype = "VTOL_standby",
		description = "Gunship",
		energymake = 0.8,
		energystorage = 0,
		energyuse = 0.8,
		explodeas = "GUNSHIPEX",
		firestandorders = 1,
		footprintx = 3,
		footprintz = 3,
		hoverattack = true,
		icontype = "air",
		idleautoheal = 5,
		idletime = 1800,
		maneuverleashlength = 1280,
		mass = 294,
		maxdamage = 1150,
		maxslope = 10,
		maxvelocity = 5.3,
		maxwaterdepth = 0,
		metalstorage = 0,
		mobilestandorders = 1,
		name = "Brawler",
		noautofire = false,
		nochasecategory = "VTOL",
		objectname = "icubrawl.s3o",
		scale = 1,
		seismicsignature = 0,
		selfdestructas = "BIG_UNIT_VTOL",
		side = "ARM",
		sightdistance = 550,
		standingfireorder = 2,
		standingmoveorder = 1,
		steeringmode = 1,
		turninplaceanglelimit = 360,
		turninplacespeedlimit = 3.498,
		turnrate = 792,
		unitname = "armbrawl",
		workertime = 0,
		customparams = {
			buildpic = "ARMBRAWL.png",
		},
		sfxtypes = {
			explosiongenerators = {
				[1] = "custom:muendungsfeuer",
			},
		},
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:emgflare",
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
				[1] = "vtolarmv",
			},
			select = {
				[1] = "vtolarac",
			},
		},

-----------------------------------------------------------
--- WEAPONS
-----------------------------------------------------------

		weapondefs = {
			vtol_emg = {
				areaofeffect = 8,
                                avoidfeature = true,
				burst = 3,
				burstrate = 0.1,
			--	cegtag = "VTOL_EMGTRAIL",
				craterboost = 0,
				cratermult = 0,
				explosiongenerator = "custom:EMG_HIT",   -- "custom:armbrawl_explosion",
				impactonly = 1,
				impulseboost = 0.123,
				impulsefactor = 0.123,
				intensity = 0.8,
				name = "E.M.G.",
				noselfdamage = true,
				range = 380,
				reloadtime = 0.3,
				rgbcolor = "1 0.95 0.4",
				size = 2.5,
				soundstart = "brawlemg",
				sprayangle = 1024,
				tolerance = 6000,
				turret = false,
				weapontimer = 1,
				weapontype = "Cannon",
				weaponvelocity = 450,
				damage = {
					default = 12,
				},
			},
		},
		weapons = {
			[1] = {
				def = "VTOL_EMG",
				onlytargetcategory = "NOTAIR",
			},
		},
	},
}

