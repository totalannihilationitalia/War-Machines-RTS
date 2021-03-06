return {
	nfacom = {
		acceleration = 0.18000000715256,
		activatewhenbuilt = true,
		autoheal = 5,
		brakerate = 0.375,
		buildcostenergy = 25000,
		buildcostmetal = 2500,
		builddistance = 200,
		builder = true,
		buildpic = "nfacom.png",
		buildtime = 75000,
		cancapture = true,
		candgun = true,
		canmove = true,
		capturespeed = 900,
		category = "ALL WEAPON NOTSUB COMMANDER NOTSHIP NOTAIR SURFACE",
		cloakcost = 100,
		cloakcostmoving = 1000,
		collisionvolumeoffsets = "0 -1 0",
		collisionvolumescales = "36 44 26",
		collisionvolumetest = 1,
		collisionvolumetype = "Ell",
		commander = true,
		corpse = "DEAD",
		description = "NFA Commander",
		energymake = 25,
		explodeas = "COMMANDER_BLAST",
		footprintx = 2,
		footprintz = 2,
		hidedamage = true,
		icontype = "nfacommander",
		idleautoheal = 5 ,
		idletime = 1800 ,
		mass = 1000,
		maxdamage = 3000,
		maxslope = 20,
		maxvelocity = 1.25,
		maxwaterdepth = 35,
		metalmake = 1.5,
		mincloakdistance = 50,
		movementclass = "AKBOT2",
		name = "ICU Commander",
		nochasecategory = "ALL",
		objectname = "nfacom.S3O",
		radardistance = 700,
		reclaimable = false,
		seismicsignature = 0,
		selfdestructas = "COMMANDER_BLAST",
		selfdestructcountdown = 5,
		showplayername = true,
		sightdistance = 450,
		smoothanim = true,
		sonardistance = 300,
		terraformspeed = 1500,
		turnrate = 1148,
		upright = true,
		workertime = 300,
		buildoptions = {
			[1] = "corsolar",
			[2] = "corwin",
			[3] = "cormstor",
			[4] = "corestor",
			[5] = "cormex",
			[6] = "cormakr",
			[7] = "corlab",
			[8] = "corvp",
			[9] = "corap",
			[10] = "corsy",
			[11] = "coreyes",
			[12] = "corrad",
			[13] = "corsonar",
			[14] = "cordrag",
			[15] = "corllt",
			[16] = "cortl",
			[17] = "corrl",
			[18] = "corfrad",
			[19] = "corfrl",
			[20] = "corfllt",
		},
 sfxtypes = {
    explosiongenerators = {
      [[custom:arancioflare]],
      [[custom:Nano]],
    },
  },

		customparams = {
			paralyzemultiplier = 0.025000000372529,
			iscommander = true,
		},
		featuredefs = {
			dead = {
				blocking = true,
				collisionvolumeoffsets = "0 0 0",
				collisionvolumescales = "35 10 60",
				collisionvolumetype = "CylY",
				damage = 10000,
				description = "Commander Wreckage",
				energy = 0,
				featuredead = "HEAP",
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 20,
				hitdensity = 100,
				metal = 2500,
				object = "ARMCOM_DEAD",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
			},
			heap = {
				blocking = false,
				category = "heaps",
				damage = 5000,
				description = "Commander Debris",
				energy = 0,
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 4,
				hitdensity = 100,
				metal = 1250,
				object = "2X2F",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
		                collisionvolumescales = "35.0 4.0 6.0",
		                collisionvolumetype = "cylY",
			},
		},
		sounds = {
			build = "nanlath1",
			canceldestruct = "cancel2",
			capture = "capture1",
			cloak = "kloak1",
			repair = "repair1",
			uncloak = "kloak1un",
			underattack = "warning2",
			unitcomplete = "kcarmmov",
			working = "reclaim1",
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
				[1] = "kcarmmov",
			},
			select = {
				[1] = "kcarmsel",
			},
		},
		weapondefs = {
			arm_disintegrator = {
				areaofeffect = 36,
				avoidfriendly = false,
				commandfire = true,
				craterboost = 0,
				cratermult = 0,
				energypershot = 500,
				explosiongenerator = "custom:DGUNTRACE",
				firestarter = 100,
				impulseboost = 0,
				impulsefactor = 0,
				name = "Disintegrator",
				noexplode = true,
				noselfdamage = true,
				range = 250,
				reloadtime = 1,
				soundhit = "xplomas2",
				soundstart = "disigun1",
				soundtrigger = true,
				tolerance = 10000,
				turret = true,
				weapontimer = 4.1999998092651,
				weapontype = "DGun",
				weaponvelocity = 300,
				damage = {
					default = 99999,
				},
			},
			armcomlaser = {
				areaofeffect = 12,
				avoidfeature = false,
				beamtime = 0.1,
				corethickness = 0.1,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				cylindertargeting = 1,
				edgeeffectiveness = 0.99,
				explosiongenerator = "custom:SMALL_ARANCIO_BURN",
				firestarter = 70,
				impactonly = 1,
				impulseboost = 0,
				impulsefactor = 0,
				laserflaresize = 7,
				name = "J7Laser",
				noselfdamage = true,
				range = 300,
				reloadtime = 0.4,
				rgbcolor = "1 0.2 0",
				soundhitdry = "",
				soundhitwet = "sizzle",
				soundhitwetvolume = 0.5,
				soundstart = "lasrfir1",
				soundtrigger = 1,
				targetmoveerror = 0.05,
				thickness = 2,
				tolerance = 10000,
				turret = true,
				weapontype = "BeamLaser",
				weaponvelocity = 900,
				damage = {
					bombers = 180,
					default = 75,
					fighters = 110,
					subs = 5,
				},
			},
		},
		weapons = {
			[1] = {
				def = "ARMCOMLASER",
			},
			[3] = {
				def = "ARM_DISINTEGRATOR",
			},
		},
	},
}

