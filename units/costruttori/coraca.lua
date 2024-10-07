-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  coraca= {
               acceleration = 0.066,
               brakerate  = 0.4, --1.875
               buildcostenergy = 8824,
               buildcostmetal = 231,
               builddistance = 60,
               builder = true,
               buildpic = "nfaaca.png",
               buildtime  = 18001,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE ANTIGATOR NOTSUB ANTIFLAME ANTIEMG ANTILASER VTOL NOWEAPON NOTSHIP",
               collide = false,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 120, --70
--               defaultmissiontype = VTOL_Standby,
               description = "Tech Level 2",
               energymake = 10,
               energystorage = 50,
               energyUse = 10,
               explodeas = "CA_EX",
               footprintx = 2,
               footprintz = 2,
               icontype = "air",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 1280,
--               mass = 0 --definire massa,
               maxdamage = 185,
               maxslope = 10,
               maxvelocity = 8.05,
               maxwaterdepth = 0,
               metalmake = 0.1,
               metalStorage = 50,
--               mobilestandorders= 1,
               name = "Advanced Construction Aircraft",
               noAutoFire = false,
               objectname = "nfaaca.s3o",
               radardistance = 50,
--               scale = 0.8,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 383.5,
--               soundcategory= "CORE_CVTOL",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "CNSTR", -- verificare se necessario
               turnrate = 121,
               workertime = 80,
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
			[1] = "corfus",
			[2] = "cmgeo",
			[3] = "corbhmth",
			[4] = "cormoho",
			[5] = "cormexp",
			[6] = "cormmkr",
			[7] = "coruwadves",
			[8] = "coruwadvms",
			[9] = "corarad",
			[10] = "corshroud",
			[11] = "corfort",
			[12] = "corasp",
			[13] = "cortarg",
			[14] = "corsd",
			[15] = "corgate",
			[16] = "cortoast",
			[17] = "corvipe",
			[18] = "cordoom",
			[19] = "corflak",
			[20] = "screamer",
			[21] = "corfmd",
			[22] = "corsilo",
			[23] = "corint",
			[24] = "corbuzz",
			[25] = "corap",
			[26] = "coraap",
			[27] = "nfafff",
			[28] = "corfarad",
			[29] = "corftoast",
			[30] = "corfvipe",
			[31] = "corfdoom",
			[32] = "corfflak",
			[33] = "corfscreamer",
		},
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "nanlath2",
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
                     [1] = "vtolcrmv",
                    },
               repair = "repair2",
               select = {
                     [1] = "vtolcrac",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
}, -- close unit data 
} -- close total
