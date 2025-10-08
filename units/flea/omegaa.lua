-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  omegaa= {
               activatewhenbuilt = false,
--               buildangle = 4096,
               buildcostenergy = 1185025,
               buildcostmetal = 62685,
               builder = false,
               buildpic = "",
               buildtime  = 2832943,
               canAttack = true,
--               canstop = 1,
               category = "ARM SPECIAL WEAPON LEVEL3 NOTAIR NOTSUB SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Omega Energy weapon AA",
--               firestandorders = 1,
               energymake = 0,
               energystorage = 20000,
               energyUse = 0,
               explodeas = "ATOMIC_BLAST",
               footprintx = 6,
               footprintz = 6,
--               mass = 0 --definire massa,
               maxdamage = 5210,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Omega Weapon",
               noAutoFire = true,
               objectname = "omegaa.s3o",
               radardistance = 2750,
               selfdestructas = "CRAWL_BLASTSML",
               sightdistance = 500,
--               soundcategory= "ARM_ANNI",
--               standingfireorder = 0,
               TEDClass = "FORT", -- verificare se necessario
               workertime = 0,
               YardMap= "oooooooooooooooooooooooooooooooooooo",
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:arancioflare",
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
                     [1] = "anni",
                    },
               select = {
                     [1] = "anni",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		omega_weapon_aria = {
                     accuracy = 0,
                     areaofeffect = 50,
                     avoidfeature = true,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
				     canattackground = false,
                     duration = 2,
                     energypershot = 0,
                     explosiongenerator = "custom:SMALL_ARANCIO_BURN",					 
                     firestarter = 100,
                     name= "The Omega Weapon",
                     range = 1000,
                     reloadtime = 0.5,
                     rgbcolor = "1 0.6 0",					 
                     soundhit = "XPLONUK4",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "annigun1",
                     tolerance = 0,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 2000,
                     damage = {
                         default = 7500,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "omega_weapon_aria",
                 onlytargetcategory = "VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
