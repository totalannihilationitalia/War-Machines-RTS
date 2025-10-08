-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  interceptor= {
               acceleration = 0.75,
               activatewhenbuilt = true,
               brakerate  = 0.15,
               buildcostenergy = 1400,
               buildcostmetal = 800,
               builder = false,
               buildpic = "",
               buildtime  = 30000,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "interceptor_dead",
--               defaultmissiontype = Standby,
               description = "Medium Laser-Artillery Mech",
--               firestandorders = 1,
               energymake = 0,
               energystorage = 0,
               energyUse = 10,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 4,
               footprintz = 3,
--               maneuverleashlength  = 650,
--               mass = 0 --definire massa,
               maxdamage = 1700,
               maxslope = 30,
               maxvelocity = 1.20,
               maxwaterdepth = 80,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HKBOT4",
               name = "Interceptor",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "interceptor.s3o",
               onoffable = true,
               radardistance = 0,
               radarDistanceJam = 500,
               selfdestructas = "LARGE_BUILDINGEX",
               sightdistance = 200,
--               soundcategory= "ARM_AMPHIB",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 450,
               upright = true,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  interceptor_dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "arm_corpses",
               object = "Interceptor_dead",
               featuredead = "interceptor_heap",
               featurereclamate = "smudge03",
               footprintx = 5,
               footprintz = 5,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 243,
               damage = 582,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
               energy = 374,
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  interceptor_heap = {
               world = "All Worlds",
               description = "Wreckage",
               category = "heaps",
               object = "5x5d",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 157,
               damage = 42,
               reclaimable = true,
               featurereclamate = "smudge03",
               seqnamereclamate = "tree1reclamate",
               energy = 132,
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:MEDIUMFLARE",
               [2]="custom:andplasmaflare",			   
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
                     [1] = "amphok1",
                    },
               select = {
                     [1] = "amphsel1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		armmav_weapon = {
                     areaofeffect = 8,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     explosiongenerator = "custom:FLASH1",
                     impactonly = true,
                     name= "GaussCannon",
                     noselfdamage = true,
                     range = 365,
                     reloadtime = 0.945,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Mavgun2",
                     tolerance = 4000,
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 500,
                     damage = {
                         default = 280,
                     }, -- close damage
             }, --close single weapon definitions

		arm_lightlaser = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.12,
--                     beamweapon = true,
                     cegTag = "BLUCRAP",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 20,
                     explosiongenerator = "custom:Gatorazzurro",
                     firestarter = 30,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 430,
                     reloadtime = 0.48,
                     rgbcolor = "0 0.5 1",
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
                     weapontype = "LaserCannon",
                     weaponvelocity  = 2250,
                     damage = {
                         default = 75,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "armmav_weapon",
               onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 def = "arm_lightlaser",
                 onlytargetcategory = "SURFACE", -- weapon 2
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
