-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  cafus= {
               acceleration = 0,
               activatewhenbuilt = false,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 44730,
               buildcostmetal = 9107,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 7,
               buildinggrounddecalsizey = 7,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfaafus.png",
               buildtime  = 158390,
               category = "ALL NOTSUB NOWEAPON SPECIAL NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "cafus_dead",
               damagemodifier = 0.95,
               description = "Enhanced Energy Output / Storage",
               energymake = 3000,
               energystorage = 25000,
               energyUse = 0,
               explodeas = "NUCLEAR_MISSILE",
               footprintx = 6,
               footprintz = 6,
               icontype = "energia",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 8500,
               maxslope = 13,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Advanced Fusion Reactor",
               noAutoFire = false,
               objectname = "nfafusion.s3o",
               onoffable = false,
               seismicsignature = 0,
               selfdestructas = "CRBLMSSL",
               sightdistance = 273,
--               soundcategory= "CORE_FUS",
               TEDClass = "ENERGY", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               usebuildinggrounddecal = true,
               YardMap= "oooooooooooooooooooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Advanced Fusion Reactor Wreckage",
               category = "corpses",
               object = "CAFUS_DEAD",
               featuredead = "cafus_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 4,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 6440,
               damage = 17100,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Advanced Fusion Reactor Heap",
               category = "heaps",
               object = "4X4A",
               footprintx = 5,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 2576,
               damage = 8550,
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
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               select = {
                     [1] = "fusion2",
                        },
               underattack = "warning1",
               },
               }, 
               }
