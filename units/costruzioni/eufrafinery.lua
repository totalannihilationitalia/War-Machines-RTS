-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufrafinery= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 4500,
               buildcostmetal = 900,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 4,
               buildinggrounddecalsizey = 4,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "eufrafinery.png",
               buildtime  = 7000,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufrafinery_dead",
               description = "Convert Livrium to metal (1000e x 50 m)",
               energystorage = 0,
               energyUse = 0,
               explodeas = "ESTOR_BUILDINGEX",
               footprintx = 7,
               footprintz = 7,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 1700,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "EUF Livrium Rafinery",
               noAutoFire = false,
               objectname = "eufrafinery.s3o",
               onoffable = true,			   
               seismicsignature = 0,
               selfdestructas = "ESTOR_BUILDING",
               sightdistance = 273,
--               soundcategory= "ARM_ESTOR",
               TEDClass = "ENERGY", -- verificare se necessario
               turnrate = 0,
	           usebuildinggrounddecal = fasle,
               workertime = 0,
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Livrium Rafinery Wreckage",
               category = "corpses",
               object = "eufrafinery_dead",
               featuredead = "eufrafinery_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 4,
               footprintz = 4,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 103,
               damage = 1020,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Livrium Rafinery Heap",
               category = "heaps",
               object = "4X4C",
               footprintx = 4,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 41,
               damage = 510,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "85.0 14.0 6.0",
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
               select = {
                     [1] = "storngy1",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
