-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armraz= {
               acceleration = 0.206,
               brakerate  = 0.262,
               buildcostenergy = 63286,
               buildcostmetal = 3577,
               builder = false,
               buildpic = "icuraz.png",
               buildtime  = 88566,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "0.0 -2.0 0.0",
               --collisionvolumescales = "38.0 58.0 26.0",
               --collisionvolumetype = "box",
               corpse = "armraz_dead",
--               defaultmissiontype = Standby,
               description = "Battle Mech",
--               firestandorders = 1,
               explodeas = "MECH_BLASTSML",
               footprintx = 2,
               footprintz = 2,
               icontype = "robots",
               idleautoheal = 5,
               idletime = 1800,
--               immunetoparalyzer = 1,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 10000,
               maxslope = 15,
               maxvelocity = 2.3,
               maxwaterdepth = 22,
--               mobilestandorders= 1,
               movementclass = "HKBOT4",
               name = "Razorback",
               noAutoFire = false,
               objectname = "icuraz.s3o",
               seismicsignature = 0,
               selfdestructas = "MECH_BLAST",
               sightdistance = 450,
--               soundcategory= "MAVERICK",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 668,
               upright = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Razorback Wreckage",
               category = "corpses",
               object = "ARMRAZ_DEAD",
               featuredead = "armraz_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 2325,
               damage = 1500,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "36.0 28.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Razorback Heap",
               category = "heaps",
               object = "3X3B",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 930,
               damage = 2000,
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
               [1]="custom:greenflare",
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
		mech_rapidlaser = {
                     accuracy = 32,
                     areaofeffect = 32,
                     avoidfeature = true,
                     beamtime = 0.14,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:Gatorgreen",
                     firestarter = 10,
                     impulseboost = 1,
                     impulsefactor = 1,
                     name= "MechRapidLaser",
                     noselfdamage = true,
                     proximitypriority = 1.5,
                     range = 475,
                     reloadtime = 0.15,
                     rgbcolor = "0 1 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasfirerb",
                     soundtrigger = "1",
                     thickness = 10,
                     tolerance = 20000,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 920,
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
                 def = "mech_rapidlaser",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
