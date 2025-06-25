-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andca= {
               acceleration = 0.072,
               brakerate  = 1.875,
               buildcostenergy = 4320,
               buildcostmetal = 105,
               builddistance = 40,
               builder = true,
               buildpic = "andca.png",
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
               objectname = "andca.s3o",
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
		[1] = "andsolar",
		[2] = "andwind",
		[3] = "andmstor",
		[4] = "andestor",
		[5] = "andmexun",
		[6] = "andmex",
		[7] = "andahp",
		[8] = "andhp",
		[9] = "andlab",
		[10] = "andplat",
--		mettere le altre fabbriche
		[11] = "andrad", -- creare un radarino semplice
--		mettere un muro semplice tipo dente di drago
		[12] = "andlartic",
		[13] = "andartic",
		[14] = "andhartic",
		[15] = "andpopaa",
--		ricavare da cordfens = mettere un cannoncino
--		armpopaa = mettere un antiaerea media
--		mettere un jammer
-- 		mettere un advsolar
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
