return {
	wmrtsbuilder = {
		acceleration = 1,
		bankscale = 1.5,
		bmcode = 1,
		brakerate = 0.4275,
		buildcostenergy = 31029,
		buildcostmetal = 2901,
		builddistance = 1000,
		builder = true,
		buildpic = "icuaca.png",
		buildtime = 27763,
		canfly = true,
		canguard = true,
		canmove = true,
		canpatrol = true,
		canreclaim = true,
		canstop = 1,
		category = "ALL NOTLAND MOBILE NOTSUB ANTIFLAME ANTIGATOR ANTIEMG ANTILASER VTOL NOWEAPON NOTSHIP",
		collide = false,
		corpse = "1_DEAD",
		cruisealt = 80,
		defaultmissiontype = "VTOL_standby",
		description = "the WMRTS features builder ",
		energymake = 10,
		energystorage = 50,
		energyuse = 0,
		explodeas = "CA_EX",
		footprintx = 2,
		footprintz = 2,
		hoverattack = true,
		icontype = "air",
		idleautoheal = 5,
		idletime = 1800,
		maneuverleashlength = 1280,
		mass = 2720,
		maxdamage = 2180,
		maxslope = 10,
		maxvelocity = 20,
		maxwaterdepth = 0,
		metalmake = 0.2,
		metalstorage = 50,
		mobilestandorders = 1,
		name = "WMRTS freatures builder",
		noautofire = false,
		nochasecategory = "SUB VTOL",
		objectname = "icuaca.s3o",
		radardistance = 50,
		scale = 0.8,
		seismicsignature = 0,
		selfdestructas = "BIG_UNIT_VTOL",
		side = "arm",
		sightdistance = 383.5,
		standingmoveorder = 1,
		steeringmode = 1,
		terraformspeed = 240,
		turninplaceanglelimit = 360,
		turninplacespeedlimit = 5.544,
		turnrate = 138,
		unitname = "armaca",
		workertime = 180,
		buildoptions = {
			[1] = "palma001",
			[2] = "palma002",
			[3] = "palma003",
			[4] = "palma004",
			[5] = "palma005",
			[6] = "palma006",
			[7] = "pino001",
			[8] = "pino002",
			[9] = "pino003",
			[10] = "pino004",
			[11] = "pino005",
			[12] = "pala001",
			[13] = "pala002",
			[14] = "pala003",
			[15] = "pala004",
			[16] = "pala005",
			[17] = "pala006",
			[18] = "pala008",
			[19] = "pala009",
			[20] = "pala010",
			[21] = "pala011",
--			[18] = "pala001_d",
--			[19] = "pala002_d",
--			[20] = "pala003_d",
--			[21] = "pala004_d",
			[22] = "pala005_d",
			[23] = "ruspa",
			[24] = "ruspa_camion",
			[25] = "ruspa_gru",
			[26] = "ruspa_rimorchio",
			[27] = "rock001",
			[28] = "rock002",
			[29] = "rock003",
			[30] = "rock004",
			[31] = "Station_one_tunnel",
			[32] = "Station_one_antenna_small",
			[33] = "eridlon_gate",
			[34] = "eridlon_gate_wall",
			[35] = "eridlon_semaforo",
			[36] = "euf_fence_gate",
			[37] = "euf_fence_wall",
			[38] = "armspazioporto",
			[39] = "station_one_cannon",
			[40] = "Station_one_scudi",
			[41] = "folsom_dam_fogna",
			[42] = "Station_one_antenna",
			[43] = "cumulo_1",
			[44] = "cumulo_2",
			[45] = "cumulo_3",
			[46] = "cumulo_4",
			[47] = "cumulo_5",
			[48] = "cumulo_6",
			[49] = "fabbrica_1",
			[50] = "fabbrica_3",
			[51] = "fabbrica_3_bis",
			[52] = "fabbrica_4",
			[53] = "lampione_sud",
			[54] = "lampione_dx",
			[55] = "car001",
			[56] = "car002",
			[57] = "car003",
			[58] = "therock001",
			[59] = "therock002",
			[60] = "therock003",
			[61] = "therock004",
			[62] = "therock005",
			[63] = "therock006",
			[64] = "therock007",
			[65] = "therock008",
			[66] = "stazione_radar_1",
			[67] = "stazione_controllo_1",
			[68] = "tank_1",
			[69] = "tank_2",
			[70] = "container_1",
			[71] = "treno_locomotiva",
			[72] = "treno_vagone_chiuso",
			[73] = "treno_vagone_aperto",
			[74] = "treno_vagone_container",
			[75] = "andwall",
			[76] = "euf_fence_wall",
			[77] = "crane",
			[78] = "andbarracs",
			[79] = "andhangar_close",
			[80] = "andmuos",
			[81] = "andtowercontrol",
			[82] = "livrium00",
			[83] = "livrium01",
			[84] = "livrium02",
			[85] = "livrium03",
			[86] = "livrium04",
			[87] = "andflag",
			[88] = "andtower",

		},
		featuredefs = {
			["1_dead"] = {
				blocking = true,
				category = "corpses",
				damage = 1308,
				description = "Advanced Construction Airplane Wreckage",
				footprintx = 2,
				footprintz = 2,
				height = 20,
				hitdensity = 100,
				metal = 2176,
				object = "ARMACA_DEAD",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
		},
		nanocolor = {
			[1] = 0.144,
			[2] = 0.544,
			[3] = 0.144,
		},
		sounds = {
			build = "nanlath1",
			canceldestruct = "cancel2",
			repair = "repair1",
			underattack = "warning1",
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
				[1] = "vtolarmv",
			},
			select = {
				[1] = "vtolarac",
			},
		},
	},
}
