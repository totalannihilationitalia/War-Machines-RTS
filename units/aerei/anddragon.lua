-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  anddragon= {
               acceleration = 0.09,
--               badTargetCategory = VTOL,
               brakerate  = 3,
               buildcostenergy = 22973,
               buildcostmetal = 1305,
               buildpic = "da_fare",
               buildtime  = 26500,
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
               cruiseAlt = 65,
--               defaultmissiontype = VTOL_standby,
               description = "Standoff Attack Missleboat",
--               firestandorders = 1,
               energymake = 10,
               energystorage = 0,
               energyUse = 200,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 4,
	       HoverAttack= true,
--               maneuverleashlength  = 1280,
--               mass = 0 --definire massa,
               maxdamage = 1150,
               maxslope = 10,
               maxvelocity = 5,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               name = "Dragon",
               noAutoFire = false,
               objectname = "anddragon.s3o",
               radardistance = 1000,
--               scale = 1,
               selfdestructas = "BIG_UNIT",
               sightdistance = 500,
--               soundcategory= "CORE_VTOL",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "VTOL", -- verificare se necessario
               turnrate = 350,
               upright = true,
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
		dragonfire = {
                     areaofeffect = 128,
                     avoidfeature = true,
                     burst = 4, -- lua:salvoSize
                     burstrate = .75, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     edgeeffectiveness = .25,
                     firestarter = 100,
                     flighttime = 1.75,
                     metalpershot = 0,
                     model = "armmhmsl",
                     name= "air-launch Starburst missle",
                     range = 770,
                     reloadtime = 8,
                     smoketrail = true,
                     soundhit = "DFhit",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "DFlnch",
                     sprayangle = 512,
                     startvelocity = 350,
                     tolerance = 6000,
                     tracks = false, 
                     turnrate = 20384,
                     weapontimer = .1,
                     weapontype = " ",
                     weaponvelocity  = 350,
                     damage = {
                         default = 225,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "dragonfire",
--               onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
