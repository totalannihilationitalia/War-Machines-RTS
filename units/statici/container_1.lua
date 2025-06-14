-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  container_1= {
               acceleration = 0.0605,
               brakerate  = 0.2068,
               buildcostenergy = 1802,
               buildcostmetal = 128,
               builddistance = 150,
               builder = true,
               buildpic = "container_1.png",
               buildtime  = 4066,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE OGGETTISTATICI",
               collisionvolumeoffsets = "0 20 0",
               collisionvolumescales = "60 50 150",
               collisionvolumetype = "Box",
               corpse = "artefatto_sporco_dead",
--               defaultmissiontype = Standby,
               description = "EUF Container",
               energymake = 0,
               energystorage = 0,
               energyUse = 0,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 6,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 2000,
               maxslope = 16,
               maxvelocity = 0.0004,
               maxwaterdepth = 18,
               metalmake = 0,
               metalStorage = 200, -- era 50 08/04/2025 molix
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Livrium Container",
               noAutoFire = false,
               objectname = "container_1.s3o",
	       pushResistant = true,
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 253,
--               soundcategory= "ARM_CVEHICLE",
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "CNSTR", -- verificare se necessario
               terraformspeed = 270,
               turnrate = 435,
               workertime = 90,
               leaveTracks = true,
               trackOffset = 12,
               trackStrength = 6,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 35,
-----------------------------------
--- BUILDLIST
-----------------------------------
               buildoptions = { 
               },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "unknown artifact Wreckage",
               category = "corpses",
               object = "ARMCV_DEAD",
               featuredead = "armcv_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 83,
               damage = 744,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "unknown artifact Heap",
               category = "heaps",
               object = "3X3C",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 33,
               damage = 372,
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
               [1]="custom:Nano",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "nanlath1",
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
               repair = "repair1",
               select = {
                     [1] = "varmsel",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
}, -- close unit data 
} -- close total
