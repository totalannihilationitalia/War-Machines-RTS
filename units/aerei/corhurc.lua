-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corhurc= {
               acceleration = 0.06,
--               badTargetCategory = MOBILE,
               brakerate  = 0.625,
               buildcostenergy = 14365,
               buildcostmetal = 313,
               builder = false,
               buildpic = "nfahurc.png",
               buildtime  = 28461,
               canAttack = true,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE WEAPON ANTIGATOR VTOL ANTIFLAME ANTIEMG ANTILASER NOTSUB NOTSHIP",
               collide = false,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 220,
--               defaultmissiontype = VTOL_standby,
               description = "Heavy Strategic Bomber",
--               firestandorders = 1,
               energymake = 0.6,
               energystorage = 0,
               energyUse = 0.6,
               explodeas = "BIG_UNITEX",
               footprintx = 4,
               footprintz = 4,
               icontype = "air",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 1380,
--               mass = 0 --definire massa,
               maxdamage = 1371,
               maxslope = 10,
               maxvelocity = 9.03,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               name = "Hurricane",
               noAutoFire = true,
               nochasecategory = "VTOL",
               objectname = "nfahurc.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 221,
--               soundcategory= "CORE_VTOL",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "VTOL", -- verificare se necessario
               turnrate = 220,
               workertime = 0,
               wpri_badtargetcategory = "MOBILE",
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
		coradvbomb = {
                     areaofeffect = 180,
                     avoidfeature = true,
		     burst = 5,
		     burstrate = 0.2,
--                     cegTag = "",
                     collidefriendly = false,
                     commandfire = true,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.7,
                     explosiongenerator = "custom:CORE_BIGBOMB_EXPLOSION",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "bomb",
                     name= "AdvancedBombs",
                     noselfdamage = true,
                     range = 1280,
                     reloadtime = 0.14,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "bombrel",
                     weapontype = "AircraftBomb",
                     damage = {
                         default = 337,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "MOBILE",
                 def = "coradvbomb",
--               onlytargetcategory = " ",
                 },
                 badtargetcategory = "ALL",
}, -- close weapon usage

}, -- close unit data 
} -- close total
