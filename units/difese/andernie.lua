-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andernie = {
--               buildangle = 4096,
               buildcostenergy = 84680,
               buildcostmetal = 7384,
               builder = false,
               buildpic = "da_fare.png",
               buildtime  = 89185,
               canAttack = true,
--               canstop = 1,
               category = "NOTAIR NOTSUB SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Long Range Plasma and Anti Air Cannon",
--               firestandorders = 1,
               energymake = 0,
               energystorage = 0,
               energyUse = 0,
               explodeas = "ATOMIC_BLAST",
               footprintx = 3,
               footprintz = 3,
--               mass = 0 --definire massa,
               maxdamage = 2250,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Ernie",
               noAutoFire = true,
               objectname = "andernie",
               radardistance = 0,
               selfdestructas = "ATOMIC_BLAST",
               sightdistance = 240,
--               soundcategory= "ARM_BRTHA",
--               standingfireorder = 0,
               TEDClass = "FORT", -- verificare se necessario
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:MEDIUMFLARE",
               }, -- close effects list
}, -- close section sfxtypes
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
                     [1] = "Servlrg3",
                    },
               select = {
                     [1] = "Servlrg3",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		armpb_weapon = {
                     areaofeffect = 24,
                     avoidfeature = true,
--                     burnblow = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH2nd",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "GaussCannon",
                     noselfdamage = true,
                     range = 730,
                     reloadtime = 1.625,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy1",
                     targetmoveerror = 0.2,
                     tolerance = 8000,
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 800,
                     damage = {
                         default = 675,
                     }, -- close damage
             }, --close single weapon definitions

		armrl_missile = {
                     areaofeffect = 48,
                     avoidfeature = true,
                     burst = 4, -- lua:salvoSize					 
                     canattackground = false,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH2",
                     firestarter = 70,
                     flighttime = 1.5,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "missile",
                     name= "Missiles",
                     noselfdamage = true,
                     range = 765,
                     reloadtime = 1.7,
                     smoketrail = true,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rockhvy2",
                     startvelocity = 400,
                     texture2 = "armsmoketrail",
                     tolerance = 10000,
                     tracks = true, 
                     turnrate = 63000,
                     turret  = true, 
                     weaponacceleration = 150,
                     weapontimer = 5,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 750,
                     damage = {
                         default = 113,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "armpb_weapon",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 def = "armrl_missile",
                 onlytargetcategory = "VTOL", -- weapon 2
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
