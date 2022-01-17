-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andhartic= {
--               badTargetCategory = VTOL,
--               buildangle = 8192,
               buildcostenergy = 25025,
               buildcostmetal = 4285,
               builder = false,
               buildpic = "andhartic.png",
               buildtime  = 78071,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andhartic_dead",
               damagemodifier = 0.125,
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Energy weapon",
--               firestandorders = 1,
               energyUse = 0,
               explodeas = "BIG_UNITEX",
               footprintx = 3,
               footprintz = 3,
--               mass = 0 --definire massa,
               maxdamage = 1310,
               maxslope = 10,
               maxwaterdepth = 0,
               name = "Artic",
               noAutoFire = false,
               objectname = "andhartic.s3o",
               selfdestructas = "BIG_UNIT",
               sightdistance = 380,
--               soundcategory= "ARM_ANNI",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               YardMap= "ooo ooo ooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  andhartic_dead = {
               world = "all",
               description = "Wreckage",
               category = "arm_corpses",
               object = "andhartic_dead",
               featuredead = "andhartic_heap",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 12,
               blocking= true,
               hitdensity = 23,
               metal = 244,
               damage = 1500,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  andhartic_heap = {
               world = "all",
               description = "Metal Shards",
               category = "heaps",
               object = "3x3a",
               footprintx = 3,
               footprintz = 3,
               blocking = false,
               hitdensity= 4,
               metal = 101,
               damage = 800,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
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
                     [1] = "anni",
                    },
               select = {
                     [1] = "anni",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		core_lightlaser = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.12,
--                     cegTag = "",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 20,
                     explosiongenerator = "custom:SMALL_ARANCIO_BURN",
                     firestarter = 100,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 435,
                     reloadtime = 0.48,
                     rgbcolor = "1 0.2 0",
                     soundhit = "lasrhit2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir3",
                     soundtrigger = "1",
                     targetmoveerror = 0.1,
                     thickness = 2.5,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 2250,
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
--                 badtargetcategory = "ANTILASER",
                 def = "core_lightlaser",
                 onlytargetcategory = "SURFACE VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
