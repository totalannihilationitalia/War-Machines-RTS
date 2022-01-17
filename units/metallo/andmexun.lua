-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andmexun= {
               activatewhenbuilt = true,
               buildcostenergy = 514,
               buildcostmetal = 51,
               builder = false,
               buildpic = "",
               buildtime  = 3460,
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
               energyUse = 5,
               explodeas = "SMALL_BUILDINGEX",
               ExtractsMetal = 0.001,
               footprintx = 3,
               footprintz = 3,
--               mass = 0 --definire massa,
               maxdamage = 200,
               maxslope = 20,
               maxwaterdepth = 0,
               metalStorage = 75,
               name = "Metal Extractor",
               noAutoFire = false,
               objectname = "andmexun.s3o",
               onoffable = true,
               radardistance = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 455,
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

}, -- close unit data 
} -- close total
