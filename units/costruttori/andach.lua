-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andach= {
               acceleration = 0.055,
--               badTargetCategory = ANTIGATOR OGGETTISTATICI,
               brakerate  = 0.055,
               buildcostenergy = 4000,
               buildcostmetal = 285,
               builddistance = 190,
               builder = true,
               buildpic = "andach.png",
               buildtime  = 12882,
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
               description = "Hovercraft Constructor",
--               firestandorders = 1,
               energymake = 14,
               energystorage = 100,
               energyUse = 14,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
	       icontype = "hover",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 1930,
               maxslope = 10,
               maxvelocity = 3,
               maxwaterdepth = 12,
               metalmake = 0.14,
               metalStorage = 100,
--               mobilestandorders= 1,
               movementclass = "HOVER3",
               name = "Adv. Construction Hovercraft",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "andach.s3o",
               radardistance = 50,
--	       pushResistant = true,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               showNanoSpray = false,
               sightdistance = 330,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               terraformspeed = 420,
               turnrate = 484,
               workertime = 140,
               wpri_badtargetcategory = "ANTIGATOR OGGETTISTATICI",
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               buildoptions = { 
		[1]= "andfus",
		[2]= "andaafus",
		[3]= "andametex",
		[4]= "andaestor",
--		inserire magazzino metallo avanzato
		[5]= "andarad",		
--		fatto in blender = inserire il dente drago avanzato
--		inserire l'intrusor detector
--		inserire il targetin facility
		[6]= "andshield",
		[7]= "anddfens",		
		[8]= "andill",
		[9]= "andchaos",
		[10]= "andernie",
--		inserire una bella antiaerea short
		[11]= "chemist",
--		inserire antimissile
		[12]= "andlaunch",
		[13]= "andangel",
--		inserire long cannon tipo vulcan
		[14]= "andhp",
		[15]= "medusa",
		[16]= "andahp",
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
--		[1]="custom:Nano",
               [2]="custom:linkbeam",
               [3]="custom:linkbeam",
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
		buildlaser2 = {
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
                 [2] = {
                 badtargetcategory = "VTOL",
                 def = "buildlaser2",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
