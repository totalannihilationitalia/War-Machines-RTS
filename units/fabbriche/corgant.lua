-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corgant= {
               acceleration = 0,
               brakerate  = 0,
               buildcostenergy = 58524,
               buildcostmetal = 7848,
               builder = true,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 10,
               buildinggrounddecalsizey = 10,
               buildinggrounddecaltype = "Pavimentazione_nfa_vp.png",
               buildpic = "nfagant.png",
               buildtime  = 67321,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOWEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corgant_dead",
               description = "Produces Level 3 Units",
--               firestandorders = 1,
               energystorage = 1400,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 9,
               footprintz = 9,
               icontype = "factory",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 16000,
               maxslope = 18,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 800,
--               mobilestandorders= 1,
               name = "Experimental Gantry",
               noAutoFire = false,
               objectname = "nfagant.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 273,
--               soundcategory= "CORE_GANTRY",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 600,
               YardMap= "ooooooooo ooooooooo occccccco occccccco occccccco occccccco occccccco occccccco occccccco",
-----------------------------------
--- BUILDLIST
----------------------------------- 
              buildoptions = { 
			[1] = "corkarg",
			[2] = "corcoug",
			[3] = "corkrog",
			[4] = "armraven",
			[5] = "gorg",
               },



-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Experimental Gantry Wreckage",
               category = "corpses",
               object = "CORGANT_DEAD",
               featuredead = "corgant_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 9,
               footprintz = 9,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 5101,
               damage = 9600,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "90.0 14.3981628418 90.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Experimental Gantry Heap",
               category = "heaps",
	       collisionvolumeoffsets = "0 0 0",
	       collisionvolumescales = "114 10 129",
               collisionvolumetype = "box",
               object = "7X7B",
               footprintx = 9,
               footprintz = 9,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 2040,
               damage = 4800,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
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
