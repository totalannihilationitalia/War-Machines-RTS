-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andkill= {
               acceleration = 0.206,
               brakerate  = 0.262,
               buildcostenergy = 63286,
               buildcostmetal = 3577,
               builder = false,
               buildpic = "da_fare.png",
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
               corpse = "andkill_dead",
--               defaultmissiontype = Standby,
               description = "Killer Mech",
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
               maxslope = 16,
               maxvelocity = 2.3,
               maxwaterdepth = 22,
--               mobilestandorders= 1,
               movementclass = "HKBOT4",
               name = "Killer",
               noAutoFire = false,
               objectname = "andkill.s3o",
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
               description = "KillerMech Wreckage",
               category = "corpses",
               object = "andkill_dead",
               featuredead = "andkill_heap",
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
               description = "KillerMech Heap",
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
               [1]="custom:POPUPFLAREFAST",
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
		corfixed_gun = {
                     accuracy = 75,
                     areaofeffect = 140,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.25,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "PlasmaCannon",
                     noselfdamage = true,
                     range = 1245,
                     reloadtime = 3.55,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy5",
                     targetmoveerror = 0.2,
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 450,
                     damage = {
                         default = 289,
                     }, -- close damage
             }, --close single weapon definitions
}, -- close weapon definition		 
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "corfixed_gun",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
