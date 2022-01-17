-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armca= {
               acceleration = 0.072,
               brakerate  = 1.875,
               buildcostenergy = 4320,
               buildcostmetal = 105,
               builddistance = 40,
               builder = true,
               buildpic = "icuca.png",
               buildtime  = 8844,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL MOBILE NOTLAND NOTSUB ANTIFLAME ANTIGATOR ANTIEMG ANTILASER VTOL NOWEAPON NOTSHIP",
               collide = false,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 120, --70
--               defaultmissiontype = VTOL_standby,
               description = "Tech Level 1",
               energymake = 5,
               energystorage = 25,
               energyUse = 5,
               explodeas = "CA_EX",
               footprintx = 2,
               footprintz = 2,
               icontype = "air",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 1280,
--               mass = 0 --definire massa,
               maxdamage = 140,
               maxslope = 10,
               maxvelocity = 7.94,
               maxwaterdepth = 0,
               metalmake = 0.05,
               metalStorage = 25,
--               mobilestandorders= 1,
               name = "Construction Aircraft",
               noAutoFire = false,
               objectname = "ICUCA.s3o",
--               scale = 0.8,
               seismicsignature = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 390,
--               soundcategory= "ARM_CVTOL",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "VTOL", -- verificare se necessario
               terraformspeed = 135,
               turnrate = 110,
               workertime = 45,
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
		[1] = "armsolar",
		[2] = "icuadvsol",
		[3] = "icuwind",
		[4] = "armgeo",
		[5] = "armmstor",
		[6] = "icuestor",
		[7] = "icumetex",
		[8] = "armamex",
		[9] = "armmakr",
		[10] = "armaap",
		[11] = "armlab",
		[12] = "armvp",
		[13] = "armap",
		[14] = "armsy",
		[15] = "armeyes",
		[16] = "armrad",
		[17] = "armdrag",
		[18] = "iculighlturr",
		[19] = "tawf001",
		[20] = "armhlt",
		[21] = "armguard",
		[22] = "armrl",
		[23] = "packo",
		[24] = "armjamt",
		[25] = "armsonar",
		[26] = "armtl",
		[27] = "armfrad",
		[28] = "armfrl",
		[29] = "armfllt",
		[30] = "armfhlt",
		[31] = "armfhllt",
		[32] = "armfguard",
		[33] = "fpacko",
		},



-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "nanlath1",
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
                     [1] = "vtolarmv",
                    },
               repair = "repair1",
               select = {
                     [1] = "vtolarac",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
}, -- close unit data 
} -- close total
