-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armeyes= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 800,
               buildcostmetal = 30,
               builder = false,
               buildpic = "icu_camera.png",
               buildtime  = 1500,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               cloakcost = 10,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armeyes_dead",
               description = "Perimeter Camera",
               energymake = 0,
               energystorage = 0,
               energyUse = 3,
               explodeas = "",
               footprintx = 1,
               footprintz = 1,
               icontype = "radar",
               idleautoheal = 5,
               idletime = 1800,
--               losemitheight = 250,
	       initcloaked = true,
--               mass = 0 --definire massa,
               maxdamage = 250,
               maxslope = 24,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               mincloakdistance = 36,
               name = "Dragon's Eye",
               noAutoFire = false,
               objectname = "icu_camera.s3o",
               onoffable = false,
               seismicsignature = 0,
               selfdestructas = "",
               sightdistance = 560,
	       stealth = true,
--               soundcategory= "MINE",
               TEDClass = "FORT", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               YardMap= "o",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Dragon's Eye Heap",
               category = "heaps",
               object = "1X1B",
               featurereclamate = "SMUDGE01",
               footprintx = 1,
               footprintz = 1,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 12,
               damage = 120,
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
                     [1] = "servsml6",
                    },
               select = {
                     [1] = "minesel1",
                        },
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
