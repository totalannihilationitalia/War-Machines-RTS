-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andbrskr= {
               acceleration = 0.15,
               brakerate  = 0.3,
               buildcostenergy = 1972,
               buildcostmetal = 244,
               builder = false,
               buildpic = "andbrskr.png",
               buildtime  = 2918,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corbrskr_dead",
               damagemodifier = 0.3,
--               defaultmissiontype = Standby,
               description = "Battle Kbot",
--               firestandorders = 1,
               energymake = 0.3,
               energystorage = 0,
               energyUse = 0.3,
               explodeas = "SMALL_UNITEX",
               footprintx = 2,
               footprintz = 2,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 412,
               maxslope = 19,
               maxvelocity = 2.29,
               maxwaterdepth = 30,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "KBOT2",
               name = "Berserker",
               noAutoFire = false,
               objectname = "andbrskr.s3o",
               radardistance = 0,
               selfdestructas = "SMALL_UNIT",
               sightdistance = 275,
--               soundcategory= "CORAK",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 700,
               upright = true,
               workertime = 0,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  andbrskr_dead = {
               world = "All Worlds",
               description = "Berseker Wreckage",
               category = "arm_corpses",
               object = "andbrskr_dead",
               featuredead = "andbrskr_heap",
               featurereclamate = "smudge01",
               footprintx = 2,
               footprintz = 2,
               height = 25,
               blocking= true,
               hitdensity = 100,
               metal = 128,
               damage = 340,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  andbrskr_heap = {
               world = "All Worlds",
               description = "Berseker Wreckage",
               category = "heaps",
               object = "2x2d",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 77,
               damage = 390,
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
                     [1] = "servtny1",
                    },
               select = {
                     [1] = "servtny1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		corbrskr_weapon = {
                     areaofeffect = 28,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     model = "brskr_shell",
                     name= "Berserker Cannon",
                     range = 200,
                     reloadtime = 0.25,
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir1",
                     tolerance = 2000,
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 325,
                     damage = {
                         default = 50,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "corbrskr_weapon",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
