-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corkrog= {
               acceleration = 0.108,
--               badTargetCategory = ANTILASER,
               brakerate  = 0.238,
               buildcostenergy = 577039,
               buildcostmetal = 27182,
--               builder = false,
               buildpic = "nfakrog.png",
               buildtime  = 552145,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
		collisionvolumeoffsets = "0 -6 -5",
		collisionvolumescales = "105 160 105",
		collisionvolumetype = "CylY",
               corpse = "corkrog_dead",
--               damagemodifier = 1,
--               defaultmissiontype = Standby,
               description = "Experimental Assault Kbot",
--               firestandorders = 1,
               explodeas = "NUCLEAR_MISSILE",
               icontype = "krogoth",
               idleautoheal = 5,
               idletime = 1800,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
               mass = 10000,
               maxdamage = 133700,
               maxslope = 17,
               maxvelocity = 1.12,
               maxwaterdepth = 12,
--               mobilestandorders= 1,
	       movementclass = "VKBOT8",
               name = "Krogoth",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfakrog.s3o",
               seismicsignature = 0,
               selfdestructas = "CRBLMSSL",
               selfdestructcountdown = 10,
               sightdistance = 845,
--               soundcategory= "KROGOTH",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 380,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               wspe_badtargetcategory = "MOBILE",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Krogoth Wreckage",
               category = "corpses",
               object = "CORKROG_DEAD",
               featuredead = "corkrog_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 17668,
               damage = 57600,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "80.0 40.3981628418 100.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Krogoth Heap",
               category = "heaps",
               object = "3X3A",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 15067,
               damage = 28800,
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
               [1]="custom:berthaflare",
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

		atad = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.3,
--                     cegTag = "",
                     corethickness = 0.75,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 500,
                     explosiongenerator = "custom:FLASH3blue",
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "ATAD",
                     noselfdamage = true,
                     laserflaresize = 22,
                     range = 900,
                     reloadtime = 6,
                     rgbcolor = "0.2 0.2 1",
                     soundhit = "xplosml3",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "annigun1",
                     targetmoveerror = 0.3,
                     thickness = 3,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 1500,
                     damage = {
                         default = 5000,
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

		krogcrush = {
                     areaofeffect = 125,
                     avoidfeature = true,
--                     cegTag = "",
                     collidefriendly = false,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:KROGCRUSHE",
                     impulseboost = 0.234,
                     impulsefactor = 0.234,
                     Intensity = 0,
                     metalpershot = 0,
                     name= "KrogCrush",
                     noselfdamage = true,
                     range = 125,
                     reloadtime = 0.1,
                     rgbcolor = "0 0 0",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     thickness = 0,
                     tolerance = 100,
                     turret  = true, 
                     weapontimer = 0.1,
                     weapontype = "Cannon",
                     weaponvelocity  = 650,
                     damage = {
                         default = 1,
                     }, -- close damage
             }, --close single weapon definitions
}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "corkrog_fire",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 badtargetcategory = "VTOL",
                 def = "atad",
                 onlytargetcategory = "SURFACE",
                 },
                 [3] = {
                 badtargetcategory = "VTOL",
                 def = "corkrog_rocket",
                 onlytargetcategory = "SURFACE",
                 },
                 [4] = {
                 badtargetcategory = "VTOL",
                 def = "krogcrush",
                 onlytargetcategory = "SURFACE",
                 },
                 [5] = {
                 badtargetcategory = "VTOL",
                 def = "krogcrush",
                 onlytargetcategory = "SURFACE",
                 },

}, -- close weapon usage

}, -- close unit data 
} -- close total

