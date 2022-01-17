-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armsd= {
               activatewhenbuilt = true,
--               buildangle = 4096,
               buildcostenergy = 6739,
               buildcostmetal = 661,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 5,
               buildinggrounddecalsizey = 5,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icusd.png",
               buildtime  = 11877,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armsd_dead",
               description = "Intrusion Countermeasure System",
               energyUse = 125,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 4,
               footprintz = 4,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 2400,
               maxslope = 36,
               maxwaterdepth = 0,
               name = "Tracer",
               objectname = "icusd.s3o",
               onoffable = true,
	       seismicdistance = 2000,
	       seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 240,
--               soundcategory= "ARM_TARG",
               TEDClass = "SPECIAL", -- verificare se necessario
	       usebuildinggrounddecal = true,
               YardMap= "oooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Tracer Wreckage",
               category = "corpses",
               object = "ARMSD_DEAD",
               featuredead = "armsd_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 4,
               footprintz = 4,
               height = 15,
               blocking= true,
               hitdensity = 100,
               metal = 566,
               damage = 1440,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Tracer Heap",
               category = "heaps",
               object = "4X4A",
               footprintx = 4,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 227,
               damage = 720,
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
               activate = "Targon1",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "Targoff1",
               select = {
                     [1] = "Targsel1",
                        },
               underattack = "warning1",
               working = "Targsel1",
}, --close sound section
}, -- close unit data 
} -- close total
