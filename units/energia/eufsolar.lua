-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufsolar= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 0,
               buildcostmetal = 145,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 6,
               buildinggrounddecalsizey = 6,
               buildinggrounddecaltype = "pavimento_piccolo_euf.png",
               buildpic = "eufsolar.png",
               buildtime  = 2845,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufsolar_dead",
               damagemodifier = 0.5,
               description = "Produces Energy",
               energymake = 0,
               energystorage = 50,
               energyUse = -20,
               explodeas = "SMALL_BUILDINGEX",
               footprintx = 4,
               footprintz = 4,
               icontype = "energia",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 306,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Solar Collector",
               noAutoFire = false,
               objectname = "eufsolar.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "SMALL_BUILDING",
               sightdistance = 273,
--               soundcategory= "ARM_SOLAR",
               TEDClass = "ENERGY", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "ooooooooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Solar Collector Wreckage",
               category = "corpses",
               object = "ARMSOLAR_DEAD",
               featuredead = "eufsolar_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 5,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 75,
               damage = 184,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Solar Collector Heap",
               category = "heaps",
               object = "5X5B",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 30,
               damage = 92,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
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
