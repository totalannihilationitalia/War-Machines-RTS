return {
	corveng = {
		acceleration = 0.89843,
		airsightdistance = 700,
		bankscale = 1,
		bmcode = 1,
		brakerate = 0.065,
		buildcostenergy = 2025,
		buildcostmetal = 90,
		buildpic = "nfaveng.png",
		buildtime = 3333,
		canattack = true,
		canfly = true,
		canguard = true,
		canmove = true,
		canpatrol = true,
		canstop = 1,
		category = "ALL MOBILE WEAPON ANTIGATOR VTOL ANTIFLAME ANTIEMG ANTILASER NOTLAND NOTSUB NOTSHIP",
		collide = false,
		cruisealt = 110,
		defaultmissiontype = "VTOL_standby",
		description = "Fighter",
		energymake = 0.08,
		energystorage = 0,
		energyuse = 0.8,
		explodeas = "SMALL_UNITEX",
		firestandorders = 1,
		footprintx = 2,
		footprintz = 2,
		icontype = "air",
		idleautoheal = 5,
		idletime = 1800,
		maneuverleashlength = 1280,
		mass = 85,
		maxdamage = 200,
		maxslope = 10,
		maxvelocity = 10,
		maxwaterdepth = 255,
		metalstorage = 0,
		mobilestandorders = 1,
		moverate1 = 8,
		name = "Avenger",
		noautofire = false,
		nochasecategory = "NOTAIR SUB",
		objectname = "nfa_fight008.s3o",
		seismicsignature = 0,
		selfdestructas = "SMALL_UNIT",
		side = "NFA",
		sightdistance = 500,
		standingfireorder = 2,
		standingmoveorder = 1,
		steeringmode = 1,
		turninplaceanglelimit = 140,
		turninplacespeedlimit = 6.6,
		turnrate = 839,
		unitname = "corveng",
		unitrestricted = 200,

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
		weapondefs = {
			corvtol_missile_a2a = {
				areaofeffect = 35,
				collidefriendly = false,
				craterboost = 0,
				cratermult = 0,
				explosiongenerator = "custom:FLASH2",
				firestarter = 70,
				impulseboost = 0.123,
				impulsefactor = 0.123,
				metalpershot = 0,
				model = "missile",
				name = "GuidedMissiles",
				noselfdamage = true,
				range = 500,
				reloadtime = 0.6,
				smoketrail = true,
				soundhitdry = "xplosml2",
				soundstart = "Rocklit3",
				startvelocity = 600,
				texture2 = "coresmoketrail",
				tolerance = 8000,
				tracks = true,
				turnrate = 24000,
				weaponacceleration = 150,
				weapontimer = 5,
				weapontype = "MissileLauncher",
				weaponvelocity = 750,
				damage = {
					bombers = 120,
					default = 5,
					fighters = 40,
					flak_resistant = 60,
					unclassed_air = 60,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "TINYVTOL",
				def = "CORVTOL_MISSILE_A2A",
			        onlytargetcategory = "VTOL SURFACE",
			},
		},
	},
}
