-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  Order_fork= {
               acceleration = 1,
			   airhoverfactor=0,			   
               autoheal = 4,
--               badTargetCategory = VTOL,
               brakerate  = 1,
               buildcostenergy = 13212,
               buildcostmetal = 4151,
               builder = false,
               buildpic = "da_fare.png",
               buildtime  = 33333,
               canAttack = true,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL VTOL NOTSHIP",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               cruiseAlt = 222,
--               defaultmissiontype = Standby,
               description = "Floating Spaceship",
               energymake = 0.4,
               energystorage = 0,
               energyUse = 0.4,
               explodeas = "noexplode",
               footprintx = 4,
               footprintz = 4,
			   hoverattack = true,
--               maneuverleashlength  = 1280,
--               mass = 0 --definire massa,
               maxdamage = 2000,
               maxslope = 0,
               maxvelocity = 1.25,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               name = "Spooning Fork",
               nochasecategory = "VTOL",
               objectname = "order_fork.s3o",
               radardistance = 0,
--               scale = 1,
               selfdestructas = "noexplode",
               sightdistance = 1500,
               sonardistance = 1800,
--               soundcategory= "ARM_KBOT",
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 1300,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:Firelanding",
               [2]="custom:Firelanding",
               [3]="custom:DGUNTRAIL",
               [4]="custom:FORKFLARE",
               [5]="custom:FORKFLARE",
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
                     [1] = "kbarmmov",
                    },
               select = {
                     [1] = "kbarmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		parabolt = {
                     areaofeffect = 16,
                     avoidfeature = true,
                     beamtime = 1,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     firestarter = 90,
                     name= "Lightning Beam",
                     laserflaresize = 12,
                     paralyzer = true,
                     range = 1360,
                     reloadtime = 5,
                     rgbcolor = "0.1 0.1 1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "PhoFir00",
                     thickness = 16,
                     tolerance = 5000,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 400,
                     damage = {
                         default = 5000,
                     }, -- close damage
             }, --close single weapon definitions

		tarabolt = {
                     areaofeffect = 16,
                     avoidfeature = true,
                     beamtime = 0.2,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     explosiongenerator = "custom:ANNILAHATORLASER;  //Noruas's FX added v8/",
                     firestarter = 90,
                     name= "Lightning Beam",
                     laserflaresize = 4,
                     range = 1360,
                     reloadtime = 1,
                     rgbcolor = "0.0 0.0 1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "PhoFir00",
                     thickness = 16,
                     tolerance = 5000,
                     turret  = true, 
                     waterweapon = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 400,
                     damage = {
                         default = 500,
                     }, -- close damage
             }, --close single weapon definitions

		crawl_blast = {
                     areaofeffect = 432,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.4,
                     explosiongenerator = "custom:FLASHNUKE360",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "CrawlingBomb",
                     range = 450,
                     reloadtime = 3.6,
                     soundhit = "xplonuk3",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "largegun",
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 250,
                     damage = {
                         default = 3000,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "parabolt",
--               onlytargetcategory = " ",
                 },
                 [2] = {
                 def = "tarabolt",
--               onlytargetcategory = " ", -- weapon 2
                 },
                 [3] = {
                 def = "crawl_blast",
--               onlytargetcategory = " ", -- weapon 3
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
