-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  nfakarg= {
               acceleration = 0.096,
               brakerate  = 0.238,
               buildcostenergy = 63286,
               buildcostmetal = 3577,
               builder = false,
               buildpic = "nfakarg.png",
               buildtime  = 88609,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT WEAPON ALL NOTSTRUCTURE NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "nfakarg_dead",
--               defaultmissiontype = Standby,
               description = "All-Terrain Assault Mech",
--               firestandorders = 1,
               explodeas = "MECH_BLASTSML",
               footprintx = 4,
               footprintz = 4,
		icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 10000,
               maxslope = 160,
               maxvelocity = 1.5,
               maxwaterdepth = 12,
--               mobilestandorders= 1,
               movementclass = "HTKBOT4",
               name = "Karganeth",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfakarg.s3o",
               seismicsignature = 0,
               selfdestructas = "MECH_BLAST",
               sightdistance = 455,
--               soundcategory= "MAVERICK",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 528,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Karganeth Wreckage",
               category = "corpses",
               object = "nfakarg_DEAD",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 1014,
               damage = 1200,
               reclaimable = true,
               energy = 0,
				collisionvolumeoffsets = "0.0 0 1.2922744751",
				collisionvolumescales = "35 14.3981628418 40",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:plasmaflare",
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
                     [1] = "mavbok1",
                    },
               select = {
                     [1] = "mavbsel1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		super_missile = {
                     areaofeffect = 64,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:KARGMISSILE_EXPLOSION",
                     firestarter = 5,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     model = "missile",
                     name= "KarganethMissiles",
                     noselfdamage = true,
                     range = 600,
                     reloadtime = 0.3,
                     smoketrail = true,
                     soundhit = "xplosml2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rocklit1",
                     startvelocity = 500,
                     tolerance = 15000,
                     tracks = true, 
                     turnrate = 65384,
                     turret  = true, 
                     weaponacceleration = 150,
                     weapontimer = 5,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 800,
                     damage = {
                         default = 120,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "super_missile",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
