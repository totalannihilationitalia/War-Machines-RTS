-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  cortarg= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 7058,
               buildcostmetal = 749,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 5,
               buildinggrounddecalsizey = 5,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfatarg.png",
               buildtime  = 10898,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "cortarg_dead",
               description = "Enhanced Radar Targeting",
               energystorage = 0,
               energyUse = 150,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 5,
               footprintz = 4,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
               isTargetingUpgrade = true,
--               mass = 0 --definire massa,
               maxdamage = 1800,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Targeting Facility",
               noAutoFire = false,
               objectname = "nfatarg.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 273,
--               soundcategory= "CORE_TARG",
               TEDClass = "SPECIAL", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "oooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Targeting Facility Wreckage",
               category = "corpses",
               object = "CORTARG_DEAD",
               featuredead = "cortarg_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 4,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 487,
               damage = 1080,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Targeting Facility Heap",
               category = "heaps",
               object = "4X4D",
               footprintx = 5,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 195,
               damage = 540,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "85.0 14.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Close Features
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
               sounds = {
               activate = "Targon2",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "Targoff2",
               select = {
                     [1] = "Targsel2",
                        },
               underattack = "warning1",
               working = "Targsel2",
               },
               }, 
               }
