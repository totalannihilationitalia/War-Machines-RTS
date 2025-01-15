-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andch= {
               acceleration = 0.055,
--               badTargetCategory = ANTIGATOR OGGETTISTATICI,
               brakerate  = 0.055,
               buildcostenergy = 1400,
               buildcostmetal = 110,
               builddistance = 190,
               builder = true,
               buildpic = "andch.png",
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
               corpse = "andch_dead",
--               defaultmissiontype = Standby,
               description = "Light Hovercraft Constructor",
--               firestandorders = 1,
               energymake = 10,
               energystorage = 50,
               energyUse = 10,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
	       icontype = "hover",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 600,
               maxslope = 10,
               maxvelocity = 3,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HOVER3",
               name = "Construction Hovercraft",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "andch.s3o",
--	       pushResistant = true,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               showNanoSpray = false,
               sightdistance = 305,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               terraformspeed = 270,
               turnrate = 484,
               workertime = 90,
               wpri_badtargetcategory = "ANTIGATOR OGGETTISTATICI",
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               buildoptions = { 
		[1] = "andsolar",
		[2]= "andwind",
		[3] = "andmstor",
		[4] = "andestor",
		[5] = "andmexun",
		[6] = "andmex",
		[7] = "andahp",
		[8] = "andhp",
		[9] = "andlab",
		[10] = "andplat",
--		mettere le altre fabbriche
		[11] = "andrad", -- creare un radarino semplice
--		mettere un muro semplice tipo dente di drago
		[12] = "andlartic",
		[13] = "andartic",
		[14] = "andhartic",
		[15] = "andpopaa",
--		ricavare da cordfens = mettere un cannoncino
--		armpopaa = mettere un antiaerea media
--		mettere un jammer
-- 		mettere un advsolar
               },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Lipo Wreckage",
               category = "corpses",
               object = "and_smallhover_dead.s3o",
               featuredead = "andlipo_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 77,
               damage = 450,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "25.0 14.3981628418 30.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Heap",
               category = "heaps",
               object = "2X2F",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 31,
               damage = 225,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "35.0 4.0 6.0",
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
                     [1] = "tcormove",
                    },
               select = {
                     [1] = "tcorsel",
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
