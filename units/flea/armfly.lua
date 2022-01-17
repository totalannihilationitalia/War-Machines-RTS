-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  ARMFLY= {
               acceleration = 7.14,
--               badTargetCategory = VTOL,
               brakerate  = 0.585,
               buildcostenergy = 514,
               buildcostmetal = 24,
               builder = false,
               buildpic = "",
               buildtime  = 333,
               canAttack = true,
               canfly = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL WEAPON NOTSUB VTOL",
               collide = false,
               --collisionvolumeoffsets = "0 0 0",
               --collisionvolumescales = "8 10 8",
               --collisionvolumetype = "box",
               cruiseAlt = 110,
--               defaultmissiontype = Standby,
               description = "Fast Light Laser Fleaship",
--               firestandorders = 1,
               energymake = 0.4,
               energystorage = 0,
               energyUse = 0.4,
               explodeas = "noweapon",
               footprintx = 2,
               footprintz = 2,
--               maneuverleashlength  = 1280,
--               mass = 0 --definire massa,
               maxdamage = 72,
               maxslope = 0,
               maxvelocity = 8,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               name = "Fly",
               noAutoFire = false,
               nochasecategory = "VTOL",
		hoverattack = true,
		icontype = "air",
               objectname = "uflea_1.s3o",
               radardistance = 0,
--               scale = 1,
               selfdestructas = "noweapon",
               sightdistance = 133,
--               soundcategory= "ARM_KBOT",
--               standingfireorder = 2,
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
--sfxtypes = {
--  explosiongenerators = {
--               [1]="custom:pinkflareflea",
--               }, -- close effects list
--}, -- close section sfxtypes
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
			armfleabowl_weapon = {
				areaofeffect = 8,
				avoidfriendly = false,
				beamtime = 0.1,
				collidefriendly = false,
				corethickness = 0.1,
				craterboost = 0,
				cratermult = 0,
				cylindertargeting = 1,
				duration = 0.01,
				explosiongenerator = "custom:SMALL_PINK_BURN",
				heightmod = 1.5,
				impactonly = 1,
				impulseboost = 0,
				impulsefactor = 0,
				laserflaresize = 5,
                 		name= "Light Laser",
				noselfdamage = true,
				--paralyzer = true,
				--paralyzetime = 7,
				range = 360,
				reloadtime = 0.5,
				rgbcolor = "1 0 1",
				soundhitdry = "lashit",
           		          soundstart = "lasrfir3",
				soundtrigger = true,
				targetborder = 0.5,
				targetmoveerror = 0.3,
				thickness = 0.8,
				tolerance = 500, --10000,
				turret = true,
				weapontype = "BeamLaser",
				weaponvelocity = 900,
				damage = {
					default = 3,
				},
			},
		},

-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "SUB",
                 def = "armfleabowl_weapon",
                 onlytargetcategory = "SURFACE VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
