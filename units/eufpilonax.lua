-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufpilonax= {
               acceleration = 0.018,
--               badTargetCategory = VTOL,
               brakerate  = 0.03,
               buildcostenergy = 12650,
               buildcostmetal = 1080,
               builder = false,
               buildpic = "eufpilonax.png",
               buildtime  = 16012,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufpilonax_dead",
--               defaultmissiontype = Standby,
               description = "Very Heavy artillery Tank",
--               firestandorders = 1,
               energystorage = 0,
               energyUse = 0,
               explodeas = "ATOMIC_BLAST",
               footprintx = 3,
               footprintz = 3,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 8000,
               maxslope = 12,
               maxvelocity = 0.49,
               maxwaterdepth = 20,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "HTANK4",
               name = "PILONAX",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "eufpilonax.s3o",
               radardistance = 1000,
               selfdestructas = "CRAWL_BLASTSML",
               sightdistance = 650,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 190,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Pilonax wreckage",
               object = "eufpilonax_dead",
               featuredead = "eufpilonax_heap",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 298,
               damage = 412,
               seqnamereclamate = "tree1reclamate",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Wreckage",
               object = "3x3d",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 48,
               damage = 98,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
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
		arm_archgun = {
                     areaofeffect = 50,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     energypershot = 0,
                     name= "Plasma Cannon",
                     range = 1000,
                     reloadtime = 0.15,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy5",
                     soundtrigger = "1",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 400,
                     damage = {
                         default = 150,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "arm_archgun",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
