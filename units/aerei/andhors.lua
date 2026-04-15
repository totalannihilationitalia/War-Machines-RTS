-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andhors= {
               acceleration = 0.025,
--               amphibious = 1,
               brakerate  = .25,
               buildcostenergy = 28234,
               buildcostmetal = 2334,
               builder = false,
               buildpic = "da_fare.png",
               buildtime  = 50584,
               canAttack = true,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL WEAPON VTOL NOTSUB",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 80,
--               defaultmissiontype = VTOL_standby,
               description = "Support Gun Ship",
--               firestandorders = 1,
               energymake = 20,
               energystorage = 0,
               energyUse = 12,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
			   hoverattack = true,			   
--               maneuverleashlength  = 1280,
--               mass = 0 --definire massa,
               maxdamage = 2394,
               maxslope = 10,
               maxvelocity = 8,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               name = "Flying Ray",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "corhors",
               radardistance = 1300,
               selfdestructas = "BIG_UNIT",
               sightdistance = 500,
--               soundcategory= "CORE_VTOL",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "VTOL", -- verificare se necessario
               turnrate = 350,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
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
                     [1] = "vtolcrmv",
                    },
               select = {
                     [1] = "vtolcrac",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		cor_circ = {
                     accuracy = 75,
                     areaofeffect = 80,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 200,
                     explosiongenerator = "custom:FLASH96",					 
                     name= "Plasma Cannon",
                     noselfdamage = true,					 
                     range = 1100,
                     reloadtime = 0.5,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy5",
                     soundtrigger = "1",
                     targetmoveerror = 0.2,					 
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 400,
                     damage = {
                         default = 100, -- era 200 31/03/2026
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "cor_circ",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
