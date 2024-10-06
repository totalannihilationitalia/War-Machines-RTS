-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  icugant= {
--               buildangle = 4096,
               buildcostenergy = 60000,
               buildcostmetal = 8000,
               builder = true,
               buildpic = "armgant",
               buildtime  = 68000,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOWEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armgant_dead",
               description = "Builds Tiger",
--               firestandorders = 1,
               energystorage = 1400,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 9,
               footprintz = 8,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 16000,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 800,
--               mobilestandorders= 1,
               name = "Tiger Gantry",
               noAutoFire = false,
               objectname = "icugant.s3o",
               radardistance = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 273,
--               soundcategory= "CORE_GANTRY",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               workertime = 600,
               YardMap= "ooooooooo occccccco occccccco occccccco occccccco occccccco occccccco occccccco",
-----------------------------------
--- BUILDLIST
-----------------------------------
               buildoptions = { 
			[1] = "armshock",
			[2] = "armtigre",
               },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "corpses",
               object = "armgant_dead",
               featuredead = "armgant_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 10,
               footprintz = 9,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 5270,
               damage = 2440,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Wreckage",
               category = "heaps",
               object = "7X7B",
               footprintx = 10,
               footprintz = 9,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 2635,
               damage = 1220,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:GantWhiteLight",
               [2]="custom:YellowLight",
               [3]="custom:WhiteLight",
               [4]="custom:Nano",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               activate = "gantok2",
               build = "gantok2",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "gantok2",
               repair = "lathelrg",
               select = {
                     [1] = "gantsel1",
                        },
               unitcomplete = "gantok1",
               underattack = "warning1",
               working = "build",
}, --close sound section
}, -- close unit data 
} -- close total
