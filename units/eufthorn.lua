-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufthorn= {
               acceleration = 0.02,
--               badTargetCategory = VTOL,
               brakerate  = 0.01,
               buildcostenergy = 1014,
               buildcostmetal = 120,
               builder = false,
               buildpic = "eufthorn.png",
               buildtime  = 1866,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufthorn_dead",
--               defaultmissiontype = Standby,
               description = "Laser Tank",
--               firestandorders = 1,
               energymake = 0.5,
               energyUse = 0.5,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
--               maneuverleashlength  = 640,
               mass = 200,
               maxdamage = 655,
               maxslope = 10,
               maxvelocity = 1.84,
               maxwaterdepth = 12,
--               mobilestandorders= 1,
               movementclass = "TANK2",
               name = "Thorn",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "eufthor.s3o",
               selfdestructas = "SMALL_UNIT",
               sightdistance = 300,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 456,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Wreckage",
               category = "corecorpses",
               object = "eufthorn_dead",
               featuredead = "eufthorn_heap",
               featurereclamate = "smudge01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               hitdensity = 100,
               metal = 98,
               damage = 551,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Heap",
               category = "heaps",
               object = "2X2D",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 129,
               damage = 120,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS  --************************************************************************sistemare colore effetto
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
		armcomlaser = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.1,
--                     beamweapon = true,
--                     cegTag = "",
                     corethickness = 0.1,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.99,
                     explosiongenerator = "custom:Gatorazzurro",
                     firestarter = 70,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "J7Laser",
                     noselfdamage = true,
                     laserflaresize = 7,
                     range = 300,
                     reloadtime = 0.4,
                     rgbcolor = "0 0.5 1",
                     soundhit = "lasrhit2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir1",
                     soundtrigger = "1",
                     targetmoveerror = 0.05,
                     thickness = 2,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 900,
                     damage = {
                         default = 75,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "armcomlaser",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
