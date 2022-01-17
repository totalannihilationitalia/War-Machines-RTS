-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  icuadvsol= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 4725,
               buildcostmetal = 343,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 5,
               buildinggrounddecalsizey = 5,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icuadvsol.png",
               buildtime  = 7945,
               category = "ALL NOTSUB NOWEAPON NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "icuadvsol_dead",
               damagemodifier = 0.9,
               description = "Produces Energy",
               energymake = 75,
               energystorage = 100,
               energyUse = 0,
               explodeas = "SMALL_BUILDINGEX",
               footprintx = 5,
               footprintz = 5,
               icontype = "energia",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 1020,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "ICU Advanced Solar Collector",
               noAutoFire = false,
               objectname = "ICUADVSOLAR.s3o",
               onoffable = false,
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 260,
--               soundcategory= "ARM_SOLAR",
               TEDClass = "ENERGY", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "oooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Advanced Solar Collector Wreckage",
               category = "corpses",
               object = "ICUADVSOL_DEAD",
               featuredead = "icuadvsol_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 4,
               footprintz = 4,
               height = 12,
               blocking= true,
               hitdensity = 100,
               metal = 223,
               damage = 612,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "all",
               description = "Advanced Solar Collector Heap",
               category = "heaps",
               object = "4X4A",
               footprintx = 4,
               footprintz = 4,
               blocking = false,
               hitdensity= 100,
               metal = 89,
               damage = 306,
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
               activate = "solar1",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "solar1",
               select = {
                     [1] = "solar1",
                        },
               underattack = "warning1",
               },
               }, 
               }
