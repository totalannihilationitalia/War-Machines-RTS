-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corca= {
               acceleration = 0.06,
               brakerate  = 2.125,
               buildcostenergy = 4580,
               buildcostmetal = 110,
               builddistance = 40,
               builder = true,
               buildpic = "nfaca.png",
               buildtime  = 9286,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL MOBILE NOTLAND ANTIGATOR NOTSUB ANTIFLAME ANTIEMG ANTILASER VTOL NOWEAPON NOTSHIP",
               collide = false,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 120, --75
--               defaultmissiontype = VTOL_Standby,
               description = "Tech Level 1",
               energymake = 5,
               energystorage = 25,
               energyUse = 5,
               explodeas = "CA_EX",
               footprintx = 3,
               footprintz = 3,
               icontype = "air",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 1280,
--               mass = 0 --definire massa,
               maxdamage = 145,
               maxslope = 10,
               maxvelocity = 7.7,
               maxwaterdepth = 0,
               metalmake = 0.05,
               metalStorage = 25,
--               mobilestandorders= 1,
               name = "Construction Aircraft",
               noAutoFire = false,
               objectname = "nfaca.s3o",
               radardistance = 50,
--               scale = 0.8,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 351,
--               soundcategory= "CORE_CVTOL",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "CNSTR", -- verificare se necessario
               terraformspeed = 135,
               turnrate = 94,
               workertime = 45,
-----------------------------------
--- BUILDLIST
-----------------------------------
               buildoptions = { 
		[1] = "corsolar",
		[2] = "coradvsol",
		[3] = "corwin",
		[4] = "corgeo",
		[5] = "cormstor",
		[6] = "corestor",
		[7] = "cormex",
		[8] = "corexp",
		[9] = "cormakr",
		[10] = "coraap",
		[11] = "corlab",
		[12] = "corvp",
		[13] = "corap",
		[14] = "corsy",
		[15] = "cornanotc",
		[16] = "coreyes",
		[17] = "corrad",
		[18] = "cordrag",
		[19] = "cormaw",
		[20] = "corllt",
		[21] = "hllt",
		[22] = "corhlt",
		[23] = "corpun",
		[24] = "corrl",
		[25] = "madsam",
		[26] = "corjamt",
		[27] = "corsonar",
		[28] = "cortl",
		[29] = "corfrad",
		[30] = "corfrl",
		[31] = "corfhlt",
		[32] = "corfllt",
		[33] = "fhllt",
		[34] = "corfpun",
		[35] = "fmadsam",
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
