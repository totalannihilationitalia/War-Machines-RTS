-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  coruwadvms= {
--               buildangle = 6093,
               buildcostenergy = 10400,
               buildcostmetal = 710,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 5,
               buildinggrounddecalsizey = 5,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfauwadvms.png",
               buildtime  = 20524,
               category = "ALL NOTSUB NOWEAPON NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "coruwadvms_dead",
               description = "Increases Metal Storage (10000)",
               energystorage = 0,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 4,
               footprintz = 4,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 10050,
               maxslope = 20,
               maxwaterdepth = 9999,
               metalStorage = 10000,
               name = "Hardened Metal Storage",
               noAutoFire = false,
               objectname = "nfauwadvms.s3o",
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 182,
--               soundcategory= "CORE_MSTOR",
               TEDClass = "METAL", -- verificare se necessario
               usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "oooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Advanced Metal Storage Wreckage",
               category = "corpses",
               object = "CORUWADVMS_DEAD",
               featuredead = "coruwadvms_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 4,
               footprintz = 4,
               height = 9,
               blocking= true,
               hitdensity = 100,
               metal = 462,
               damage = 4020,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "all",
               description = "Advanced Metal Storage Heap",
               category = "heaps",
               object = "4X4A",
               footprintx = 4,
               footprintz = 4,
               blocking = false,
               hitdensity= 100,
               metal = 185,
               damage = 2010,
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
                     [1] = "stormtl2",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
