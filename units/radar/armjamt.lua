-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armjamt= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 4382,
               buildcostenergy = 7945,
               buildcostmetal = 226,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 3,
               buildinggrounddecalsizey = 3,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icujamt.png",
               buildtime  = 9955,
               canAttack = false,
               category = "ALL NOTSUB NOWEAPON SPECIAL NOTAIR SURFACE",
               cloakcost = 25,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armjamt_dead",
               description = "Cloakable Jammer Tower",
               energymake = 0,
               energystorage = 0,
               energyUse = 40,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "radar",
               idleautoheal = 5,
               idletime = 1800,
               losemitheight = 250, -- verificare se necessario è un jammer
--               mass = 0 --definire massa,
               maxdamage = 712,
               maxslope = 32,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               mincloakdistance = 35,
               name = "Sneaky Pete",
               noAutoFire = false,
               objectname = "icujamt.s3o",
               onoffable = true,
               radarDistanceJam = 500,
               radaremitheight = 250, -- verificare se necessario è un jammer
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 195,
--               soundcategory= "ARM_JAM",
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
               world = "all",
               description = "Sneaky Pete Wreckage",
               category = "corpses",
               object = "ARMJAMT_DEAD",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 3,
               blocking= true,
               hitdensity = 100,
               metal = 147,
               damage = 427,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
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
               cant = {
                     [1] = "cantdo4",
                      },
               ok = {
                     [1] = "kbarmmov",
                    },
               select = {
                     [1] = "radjam1",
                        },
               underattack = "warning1",
}, --close sound section
                 maxAngleDif = 1,
}, -- close unit data 
} -- close total
