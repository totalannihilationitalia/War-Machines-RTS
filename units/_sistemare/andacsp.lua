-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andacsp = {
              acceleration = 0.216,
               brakerate  = 0.45,
               buildcostenergy = 4084,
               buildcostmetal = 400,
               builddistance = 150,
               builder = true,
               buildpic = "andacsp.png",
               buildtime  = 9432,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "KBOT MOBILE ALL NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andcsp_dead",
--               defaultmissiontype = Standby,
               description = "All-Terrain Constructor Spider lvl2",
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
               maxdamage = 840,
               maxvelocity = 1.72,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TKBOT3",
               name = "Advanced Construction Spider",
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
               workertime = 140,
               wpri_badtargetcategory = "VTOL",

-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               buildoptions = { 
		[1]= "andfus",
		[2]= "andgant",
		[3]= "andaafus",
		[4]= "andametex",
		[5]= "andaestor",
--		inserire magazzino metallo avanzato
		[6]= "andarad",		
--		fatto in blender = inserire il dente drago avanzato
--		inserire l'intrusor detector
--		inserire il targetin facility
		[7]= "andshield",
		[8]= "anddfens",		
		[9]= "andill",
		[10]= "andchaos",
		[11]= "andernie",
--		inserire una bella antiaerea short
		[12]= "chemist",
--		inserire antimissile
		[13]= "andlaunch",
		[14]= "andangel",
--		inserire long cannon tipo vulcan
		[15]= "andhp",
		[16]= "medusa",
		[17]= "andahp",
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
