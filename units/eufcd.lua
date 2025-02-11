-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufcd= {
               acceleration = 0.0605,
               brakerate  = 0.2068,
               buildcostenergy = 1802,
               buildcostmetal = 128,
               builddistance = 170,
               builder = true,
               buildpic = "",
               buildtime  = 5213,
	       canAttack = false,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL TANK MOBILE NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufcd_dead",
--               defaultmissiontype = Standby,
               description = "Tech Level 1",
               energymake = 8.5,
               energystorage = 50,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 905,
               maxslope = 16,
               maxvelocity = 1.925,
               maxwaterdepth = 18,
               metalmake = 0.3,
               metalStorage = 50,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Construction Drone",
               noAutoFire = false,
               objectname = "eufcd.s3o",
	       pushResistant = true,
               radardistance = 50,
               selfdestructas = "BIG_UNIT",
	       showNanoSpray = false,
               sightdistance = 253,
--               soundcategory= "ARM_CVEHICLE",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "CNSTR", -- verificare se necessario
               turnrate = 435,
               workertime = 90,
               leaveTracks = true,
               trackOffset = 12,
               trackStrength = 6,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 35,
               buildoptions = { 
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
		[1]= "eufsolar",
		[2]= "eufmetex",
		[3]= "euf_fence_gate",
		[4]= "euf_fence_wall",
		[5]= "eufmstor",
		[6]= "eufestor",
		[7]= "eufloony",
		[8]= "eufsnpr",
		[9]= "eufpath",
		[10]= "euf_radar",
		[11] = "eufpathsmall",
		[12] = "eufap",
		[13] = "eufavp",
		[14] = "eufblab",
		[15] = "armarch",
		[16] = "eufadvmetex",
               },

-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
		[1]="custom:Nano",
               [2]="custom:linkbeam",
               }, -- close effects list
}, -- close section sfxtypes
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
                     [1] = "varmmove",
                    },
               repair = "repair1",
               select = {
                     [1] = "varmsel",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		buildlaser = {
                     areaofeffect = 1,
                     avoidfeature = true,
                     beamtime = 0.06,
		     beamTTL=2,
                     burst = 30, -- lua:salvoSize
                     burstrate = 0.01, -- lua: salvoDelay
--                     cegTag = "",
		     collideFirebase = true, -- era false
                     collidefriendly = true,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:oldskool_build",
                     impulseboost = 0,
                     impulsefactor = 0,
                     Intensity = 5,
		     laserFlareSize = 5,
                     name= "MG",
                     range = 200,
                     reloadtime = 0,
                     rgbcolor = "1, 1, 0",
                     size = "1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     thickness = 5,
                     tolerance = 10, --3000
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 256,
                     damage = {
                         default = 0.0000000001,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "buildlaser",
                 onlytargetcategory = "VOID",
                 },
}, -- close weapon usage
}, -- close unit data 
} -- close total
