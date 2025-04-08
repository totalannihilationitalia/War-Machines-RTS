-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armhvytransp= {
               acceleration = 0,
               brakerate  = 0,
--               buildangle = 1024,
               buildcostenergy = 13761,
               buildcostmetal = 2729,
               builder = true,
               buildpic = "armhvytransp.bmp",
               buildtime  = 16224,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND PLANT NOTSUB NOWEAPON NOTSHIP NOTAIR",
               --collisionvolumeoffsets = "0 0 0",
               --collisionvolumescales = "110 136 110",
               --collisionvolumetype = "Box",
               corpse = "armalab_dead",
               description = "Trasport Units",
--               firestandorders = 1,
               energystorage = 200,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 6,
               footprintz = 6,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 3808,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 200,
--               mobilestandorders= 1,
               name = "Heavy Transporter",
               noAutoFire = false,
               objectname = "armhvytransp.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 350,
--               soundcategory= "KBOTPLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
               workertime = 200,
               YardMap= "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy",
               buildoptions = { 
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               },



-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  armalab_dead = {
               world = "All Worlds",
               description = "Advanced Kbot Lab Wreckage",
               category = "corpses",
               object = "ARMALAB_DEAD",
               featuredead = "armalab_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 6,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 1773,
               damage = 2285,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  armalab_heap = {
               world = "All Worlds",
               description = "Advanced Kbot Lab Heap",
               category = "heaps",
               object = "5X5A",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 887,
               damage = 1143,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:NUCKLEARMINI",
               [2]="custom:hvytranspLanding",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "plabwork",
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
                     [1] = "plabactv",
                        },
               unitcomplete = "untdone",
               underattack = "warning1",
}, --close sound section
}, -- close unit data 
} -- close total
