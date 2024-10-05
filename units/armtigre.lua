-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armtigre= {
               acceleration = 0.09,
               brakerate  = 0.01,
               buildcostenergy = 270000,
               buildcostmetal = 13000,
               builder = false,
               buildpic = "armtigre",
               buildtime  = 290000,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armtigre_dead",
--               defaultmissiontype = Standby,
               description = "Assault evol. Tank",
--               firestandorders = 1,
               energymake = 0.5,
               energystorage = 0,
               energyUse = 1.1,
               explodeas = "MECH_BLASTSML",
               footprintx = 4,
               footprintz = 4,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 20850,
               maxslope = 12,
               maxvelocity = 1.5,
               maxwaterdepth = 255,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HTANK4",
               name = "Tiger",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "icutigre.s3o",
               radardistance = 230,
	       explodeas = "MECH_BLASTSML",
               sightdistance = 400,
               sonardistance = 230,
--               soundcategory= "KROGOTH",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 350,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "arm_corpses",
               object = "armtigre_dead",
               featuredead = "armtigre_heap",
               featurereclamate = "smudge01",
               footprintx = 4,
               footprintz = 6,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 23591,
               damage = 23934,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Wreckage",
               category = "heaps",
               object = "4x4a",
               footprintx = 4,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 11795,
               damage = 11967,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:greenflare",
               [2]="custom:goliathflare",
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
                     [1] = "krogok1",
                    },
               select = {
                     [1] = "krogsel1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		corkrog_fire = {
                     areaofeffect = 112,
                     avoidfeature = true,
                     burst = 5, -- lua:salvoSize
                     burstrate = 0.04, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.5,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     Intensity = 4,
                     name= "GaussCannon",
                     noselfdamage = true,
                     range = 590,
                     reloadtime = 1.4,
                     rgbcolor = "1 0.75 0.25",
                     size = "4",
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "kroggie2",
                     sprayangle = 2750,
                     tolerance = 6000,
                     turret  = true, 
                     weapontimer = 2,
                     weapontype = "Cannon",
                     weaponvelocity  = 900,
                     damage = {
                         default = 325,
                     }, -- close damage
             }, --close single weapon definitions

		arm_laserh1 = {
                     areaofeffect = 14,
                     avoidfeature = true,
                     beamtime = 0.15,
                     cegTag = "GREENCRAP",
                     corethickness = 0.2,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     duration = 0.1,
                     energypershot = 75,
                     explosiongenerator = "custom:GreenLaser",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     Intensity = 1.0,
                     name= "HighEnergyLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 620,
                     reloadtime = 1.2,
                     rgbcolor = "0 1 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Lasrmas2",
                     targetmoveerror = 0.2,
                     thickness = 1.2,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 2250,
                     damage = {
                         default = 387,
                     }, -- close damage
             }, --close single weapon definitions

		corkrog_rocket = {
                     areaofeffect = 96,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:STARFIRE",
                     firestarter = 70,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "fmdmisl",
                     name= "HeavyRockets",
                     noselfdamage = true,
                     proximitypriority = -1,
                     range = 800,
                     reloadtime = 2.75,
                     smoketrail = true,
                     soundhit = "xplosml2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rocklit1",
                     startvelocity = 200,
                     texture2 = "coresmoketrail",
                     tolerance = 9000,
                     tracks = true, 
                     turnrate = 50000,
                     weaponacceleration = 230,
                     weapontimer = 2,
                     weapontype = "StarburstLauncher",
                     weaponvelocity  = 4000,
                     damage = {
                         default = 360,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "corkrog_fire",
               onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 def = "arm_laserh1",
               onlytargetcategory = "SURFACE", -- weapon 2
                 },
                 [3] = {
                 def = "corkrog_rocket",
               onlytargetcategory = "SURFACE", -- weapon 3
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
