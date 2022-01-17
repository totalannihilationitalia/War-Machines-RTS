-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  nfadecom= {
               acceleration = 0.18,
               activatewhenbuilt = true,
               autoheal = 5,
--               badTargetCategory = ANTILASER,
               brakerate  = 0.375,
               buildcostenergy = 12085,
               buildcostmetal = 705,
               builddistance = 120,
               builder = true,
               buildpic = "nfacom.png",
               buildtime  = 26941,
               canAttack = true,
--               canDGun = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               cloakcost = 30,
               cloakcostmoving = 180,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
--               defaultmissiontype = Standby,
               description = "Decoy Commander",
--               firestandorders = 1,
               energymake = 15,
               energystorage = 50,
               explodeas = "DECOY_COMMANDER_BLAST",
               footprintx = 2,
               footprintz = 2,
               hidedamage = true,
               icontype = "nfacommander",
               idleautoheal = 5,
               idletime = 1800,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
               mass = 1000,
               maxdamage = 3000,
               maxslope = 20,
               maxvelocity = 1.25,
               maxwaterdepth = 35,
               metalmake = 0.5,
               metalStorage = 50,
               mincloakdistance = 50,
--               mobilestandorders= 1,
               movementclass = "AKBOT2",
               name = "NFA Commander",
               nochasecategory = "VTOL",
--               norestrict = "1",
               objectname = "NFACOM.s3o",
               radardistance = 50,
               reclaimable = false,
               seismicsignature = 0,
               selfdestructas = "DECOY_COMMANDER_BLAST",
               showplayername = true,
               sightdistance = 377,
--               soundcategory= "COR_CKBOT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 0,
               TEDClass = "COMMANDER", -- verificare se necessario
               terraformspeed = 450,
               turnrate = 1133,
               upright = true,
               workertime = 150,
               wpri_badtargetcategory = "ANTILASER",
               wspe_badtargetcategory = "VTOL",
               buildoptions = { 
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               },



-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:Nano",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "nanlath2",
               capture = "capture2",
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
                     [1] = "kbcormov",
                    },
               repair = "repair2",
               select = {
                     [1] = "kbcorsel",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		core_lightlaser = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.12,
--                     cegTag = "",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 20,
                     explosiongenerator = "custom:SMALL_ARANCIO_BURN",
                     firestarter = 100,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 435,
                     reloadtime = 0.48,
                     rgbcolor = "1 0.2 0",
                     soundhit = "lasrhit2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir3",
                     soundtrigger = "1",
                     targetmoveerror = 0.1,
                     thickness = 2.5,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 2250,
                     damage = {
                         default = 75,
                     }, -- close damage
             }, --close single weapon definitions

		decoy_disintegrator = {
                     areaofeffect = 32,
                     avoidfeature = true,
--                     beamweapon = true,
--                     cegTag = "",
                     commandfire = true,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 50,
                     explosiongenerator = "custom:DGUNTRACE",
                     impulseboost = 0,
                     impulsefactor = 0,
                     name= "Disintegrator",
                     noexplode = true,
                     noselfdamage = true,
                     range = 250,
                     reloadtime = 1.5,
                     soundhit = "xplomas2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "disigun1",
                     soundtrigger = "1",
                     tolerance = 10000,
                     turret  = true, 
                     weapontimer = 4.2,
                     weapontype = "DGun",
                     weaponvelocity  = 300,
                     damage = {
                         default = 99999,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "ANTILASER",
                 def = "core_lightlaser",
--               onlytargetcategory = " ",
                 },
                 [3] = {
                 def = "decoy_disintegrator",
--               onlytargetcategory = " ", -- weapon 3
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
