-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andmex= {
               activatewhenbuilt = true,
               buildcostenergy = 514,
               buildcostmetal = 51,
               builder = false,
               buildpic = "andmex.png",
               buildtime  = 1874,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andmex_dead",
               description = "Extracts metal",
--               firestandorders = 1,
               energystorage = 0,
               energyUse = 3,
               explodeas = "SMALL_BUILDINGEX",
               ExtractsMetal = 0.00175,
               footprintx = 3,
               footprintz = 3,
--               mass = 0 --definire massa,
               maxdamage = 200,
               maxslope = 20,
               maxwaterdepth = 20,
               metalStorage = 50,
               name = "Metal Extractor",
               noAutoFire = false,
               objectname = "andmex.s3o",
               onoffable = true,
               radardistance = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 273,
--               soundcategory= "COR_MEX",
--               standingfireorder = 2,
               TEDClass = "METAL", -- verificare se necessario
               workertime = 0,
               wpri_badtargetcategory = "WATER",
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Wreckage",
               category = "corcorpses",
               object = "andmex_dead",
               featuredead = "andmex_heap",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 9,
               blocking= true,
               hitdensity = 23,
               metal = 128,
               damage = 4234,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  heap = {
               world = "all",
               description = "Metal Shards",
               category = "heaps",
               object = "3x3c",
               footprintx = 3,
               footprintz = 3,
               blocking = false,
               hitdensity= 4,
               metal = 51,
               damage = 34,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
               collisionvolumescales = "55.0 4.0 6.0",
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
               activate = "mexrun2",
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
               deactivate = "mexoff2",
               ok = {
                     [1] = "servmed2",
                    },
               select = {
                     [1] = "mexon2",
                        },
               underattack = "warning1",
               working = "mexrun2",
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
                 badtargetcategory = "ANTILASER",
                 def = "core_lightlaser",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
