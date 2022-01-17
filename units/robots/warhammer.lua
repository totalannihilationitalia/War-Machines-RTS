-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  warhammer= {
               acceleration = 0.25,
--               badTargetCategory = VTOL,
               brakerate  = 0.4,
               buildcostenergy = 66000,
               buildcostmetal = 3700,
               buildpic = "warhammer.png",
               buildtime  = 58000,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "warhammer_dead",
--               defaultmissiontype = Standby,
               description = "Assault / Heavy Weapons Battlemech",
--               firestandorders = 1,
               energymake = 0,
               energystorage = 0,
               energyUse = 100,
               explodeas = "MECH_BLASTSML",
               footprintx = 3,
               footprintz = 3,
		icontype = "robots",
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 4000,
               maxslope = 17,
               maxvelocity = 1.3,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HKBOT4",
               name = "Warhammer WHM-6K",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "warhammer.s3o",
               radardistance = 900,
               selfdestructas = "CRAWL_BLAST",
               sightdistance = 700,
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 512,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Warhammer Wreckage",
               category = "arm_corpses",
               object = "warhammer_dead",
               featuredead = "warhammer_heap",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 1500,
               damage = 7000,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Warhammer Wreckage",
               category = "heaps",
               object = "2x2b",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 700,
               damage = 4225,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:greenflare",
               [2]="custom:redflare",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- NO UNITS SOUND
-----------------------------------------------------------
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		warhammer_weapon = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.2,
--                     beamweapon = true,
--                     cegTag = "",
                     corethickness = 0.2,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 125,
                     explosiongenerator = "custom:Gatorgreen",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HighEnergyLaser",
                     noselfdamage = true,
                     laserflaresize = 15,
                     range = 950,
                     reloadtime = 1.1,
                     rgbcolor = "0 0.7 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Lasrmas2",
                     targetmoveerror = 0.2,
                     thickness = 3,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 700,
                     damage = {
                         default = 300,
                     }, -- close damage
             }, --close single weapon definitions

		arm_laser = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.18,
--                     beamweapon = true,
                     burstrate = 0.2, -- lua: salvoDelay
                     cegTag = "PINKCRAP",
                     corethickness = 0.3,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     duration = 0.02,
                     energypershot = 2,
                     explosiongenerator = "custom:PINKFLASH",
                     firestarter = 50,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     Intensity = 0.8,
                     name= "Laser",
                     noselfdamage = true,
                     laserflaresize = 5,
                     range = 750,
                     reloadtime = 0.95,
                     rgbcolor = "1 1 0.4",
                     soundhit = "lasrhit2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir1",
                     soundtrigger = "1",
                     targetmoveerror = 0.2,
                     thickness = 1,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 800,
                     damage = {
                         default = 35,
                     }, -- close damage
             }, --close single weapon definitions

		corcoug_rockets = {
                     areaofeffect = 40,
                     avoidfeature = true,
                     burst = 1, -- lua:salvoSize
                     burstrate = 0, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     firestarter = 70,
                     metalpershot = 17,
                     model = "corcoug_missile",
                     name= "Cougar-Rockets",
                     range = 850,
                     reloadtime = 0.9,
                     smoketrail = true,
                     soundhit = "TAWF114b",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "TAWF114a",
                     sprayangle = 3742,
                     startvelocity = 378,
                     tolerance = 100,
                     tracks = true, 
                     turret  = true, 
                     weaponacceleration = 287,
                     weapontimer = 5,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 845,
                     damage = {
                         default = 20,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "warhammer_weapon",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
		 badtargetcategory = "VTOL",
                 def = "arm_laser",
                 onlytargetcategory = "SURFACE", -- weapon 2
                 },
                 [3] = {
		 badtargetcategory = "NOTAIR",
                 def = "corcoug_rockets",
                 onlytargetcategory = "SURFACE", -- weapon 3
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
