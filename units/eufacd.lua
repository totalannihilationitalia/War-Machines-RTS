-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufacd= {
               acceleration = 0.0605,
               brakerate  = 0.2068,
               buildcostenergy = 5263,
               buildcostmetal = 431,
               builddistance = 170,
               builder = true,
               buildpic = "da_fare.png",
               buildtime  = 4066,
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
               corpse = "eufacd_dead",
--               defaultmissiontype = Standby,
               description = "Tech Level 1",
               energymake = 20,
               energystorage = 100,
               energyUse = 20,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 1860,
               maxslope = 16,
               maxvelocity = 1.925,
               maxwaterdepth = 18,
               metalmake = 0.2,
               metalStorage = 100,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Construction Drone",
               noAutoFire = false,
               objectname = "eufacd.s3o",
	       pushResistant = true,
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
	       showNanoSpray = false,
               sightdistance = 289.9,
--               soundcategory= "ARM_CVEHICLE",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "CNSTR", -- verificare se necessario
               terraformspeed = 750,
               turnrate = 399,
               workertime = 250,
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
		[2]= "eufmstor",
		[3]= "eufestor",
		[4]= "eufmetex",
		[5] = "eufavp",
		[6] = "eufvp",
		[7] = "eufap",
		[8]= "euf_radar",
		[9] = "eufpathsmall",
		[10]= "eufsnpr",
		[11]= "eufpath",
		[12] = "armarch", ------ fare versione "small"
		[13]= "eufloony",
------------------- creare il jammer
------------------- creare il sonar
------------------- creare il torpedol
------------------  eventuali difese floating
		[14] = "eufblab", -------------------- non funziona sistemare ################
---------		[16] = "eufadvmetex", --------------- spostare in avanzato tech2
		[15]= "euf_fence_gate",
		[16]= "euf_fence_wall",
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
