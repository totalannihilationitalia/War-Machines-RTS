-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  nfafff= {
               buildcostenergy = 21520,
               buildcostmetal = 5345,
               builder = true,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 12,
               buildinggrounddecalsizey = 12,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfafff.png",
               buildtime  = 80210,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corfff_dead",
               description = "Builds very large aircraft",
--               firestandorders = 1,
               energystorage = 500,
               energyUse = 0,
               explodeas = "LARGE_BUILDING",
               footprintx = 12,
               footprintz = 12,
--               mass = 0 --definire massa,
               maxdamage = 5642,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 100,
--               mobilestandorders= 1,
               name = "Anti-gravity hangar",
               noAutoFire = false,
               objectname = "nfafff.s3o",
               radardistance = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 510,
--               soundcategory= "CORE_GANTRY",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               usebuildinggrounddecal = true,
               workertime = 400,
               YardMap= "oooooooooooo oyyyyyyyyyyo oyyyyyyyyyyo oyyyyyyyyyyo oyyyyyyyyyyo oyyyyyyyyyyo oyyyyyyyyyyo oyyyyyyyyyyo oyyyyyyyyyyo oyyyyyyyyyyo oooooooooooo oooooooooooo",
-----------------------------------
--- BUILDLIST
-----------------------------------
    		buildoptions = {
--			[1] = "corff",
			[1] = "taln",
			[2] = "odyc",
			[3] = "ostr",
		},
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  corfff_dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "core_corpses",
               object = "CORFFF_dead",
               featurereclamate = "smudge01",
               footprintx = 9,
               footprintz = 8,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 17545,
               damage = 6931,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
},  --  Wreckage and heaps
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
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
