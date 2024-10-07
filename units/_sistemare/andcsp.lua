-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andcsp = {
               acceleration = 0.18,
--               badTargetCategory = VTOL,
               brakerate  = 0.188,
               buildcostenergy = 1622,
               buildcostmetal = 113,
               builddistance = 150,
               builder = true,
               buildpic = "andcsp.png",
               buildtime  = 3551,
	       canAttack = false,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andcsp_dead",
--               defaultmissiontype = Standby,
               description = "All-Terrain Constructor Spider",
--               firestandorders = 1,
               energymake = 7,
               energystorage = 50,
               energyUse = 7,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
		icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 650,
               maxvelocity = 1.72,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TKBOT3",
               name = "Construction Spider",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "andcsp.s3o",
	       pushResistant = true,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
	       showNanoSpray = false,
               sightdistance = 440,
--               soundcategory= "ARM_COSPD",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 1122,
               workertime = 90,
               wpri_badtargetcategory = "VTOL",

-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               buildoptions = { 
		[1] = "andsolar",
		[2]= "andadvsolar",
		[3]= "andwind",
		[4] = "andmstor",
		[5] = "andestor",
		[6] = "andmexun",
		[7] = "andmex",
		[8] = "andalab",
		[9] = "andlab",
		[10] = "andhp",
		[11] = "andplat",
--		mettere le altre fabbriche
		[12] = "andrad", -- creare un radarino semplice
--		mettere un muro semplice tipo dente di drago
		[13] = "andlartic",
		[14] = "andartic",
		[15] = "andhartic",
		[16] = "andpopaa",
--		ricavare da cordfens = mettere un cannoncino
--		armpopaa = mettere un antiaerea media
--		mettere un jammer
               },

-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Recluse Wreckage",
               category = "corpses",
               object = "andcsp_dead",
               featuredead = "andcsp_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 244,
               damage = 630,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Recluse Heap",
               category = "heaps",
               object = "3X3A",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 98,
               damage = 315,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
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
                     [1] = "spider2",
                    },
               select = {
                     [1] = "spider3",
                        },
               underattack = "warning1",
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
                 badtargetcategory = "VTOL",
                 def = "buildlaser",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
