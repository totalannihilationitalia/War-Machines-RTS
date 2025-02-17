-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andmisa_noai= {
               acceleration = 0.0396,
--               badTargetCategory = ALL,
               brakerate  = 0.0165,
               buildcostenergy = 2027,
               buildcostmetal = 140,
               builder = false,
               buildpic = "andmisa_noai.png",
               buildtime  = 2945,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andmisa_dead",
--               defaultmissiontype = Standby,
               description = "Light Missile hovercraft",
--               firestandorders = 1,
               energymake = 0.5,
               energystorage = 0,
               energyUse = 0.5,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 690,
               maxslope = 16,
               maxvelocity = 1.6,
               maxwaterdepth = 12,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HOVER3",
               name = "Misa",
               noAutoFire = false,
               nochasecategory = "ALL",
               objectname = "andmisa.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 620,
--               soundcategory= "ARM_VEHICLE",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 497,
               workertime = 0,
               wpri_badtargetcategory = "NOTAIR",
               wspe_badtargetcategory = "NOTAIR",

-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Samson Wreckage",
               category = "corpses",
               object = "and_smallhover_dead.s3o",
               featuredead = "andmisa_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 123,
               damage = 639,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "25.0 14.3981628418 30.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Samson Heap",
               category = "heaps",
               object = "2x2F",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 49,
               damage = 320,
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
               [1]="custom:rocketflare",
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
                     [1] = "varmmove",
                    },
               select = {
                     [1] = "varmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		armtruck_missile = {
                     areaofeffect = 48,
                     avoidfeature = true,
                     burst = 2, -- lua:salvoSize
                     burstrate = 0.25, -- lua: salvoDelay
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH2",
                     firestarter = 70,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "missile",
                     name= "Missiles",
                     noselfdamage = true,
                     range = 600,
                     reloadtime = 3.34,
                     smoketrail = true,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rockhvy2",
                     soundtrigger = "1",
                     startvelocity = 450,
                     texture2 = "armsmoketrail",
                     tolerance = 8000,
                     tracks = true, 
                     turnrate = 63000,
                     turret  = true, 
                     weaponacceleration = 108,
                     weapontimer = 5,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 540,
                     damage = {
                         default = 38,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "NOTAIR",
                 def = "armtruck_missile",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
