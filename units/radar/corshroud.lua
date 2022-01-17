-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corshroud= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 18304,
               buildcostmetal = 124,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 3,
               buildinggrounddecalsizey = 3,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfashroud.png",
               buildtime  = 9392,
               canAttack = false,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corshroud_dead",
               description = "Long-Range Jamming Tower",
               energymake = 0,
               energystorage = 0,
               energyUse = 125,
               explodeas = "SMALL_BUILDINGEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "radar",
               idleautoheal = 5,
               idletime = 1800,
               losemitheight = 250, 250, -- verificare se serve che è un radar jammer
--               mass = 0 --definire massa,
               maxdamage = 800,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Shroud",
               noAutoFire = false,
               objectname = "nfa_jammer.s3o",
               onoffable = true,
               radarDistanceJam = 700,
               radaremitheight = 250, -- verificare se serve che è un radar jammer
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 155,
--               soundcategory= "CORE_JAM",
               TEDClass = "SPECIAL", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "oooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Shroud Wreckage",
               category = "corpses",
               object = "CORSHROUD_DEAD",
               featuredead = "corshroud_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 81,
               damage = 480,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Shroud Heap",
               category = "heaps",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 32,
               damage = 240,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Close Features
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
                     [1] = "kbcormov",
                    },
               select = {
                     [1] = "radjam2",
                        },
               underattack = "warning1",
               },
                 maxAngleDif = 1,
               }, 
               }
