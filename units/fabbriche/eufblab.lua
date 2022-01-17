-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufblab= {
--               buildangle = 4096,
               buildcostenergy = 756,
               buildcostmetal = 470,
               builder = true,
               buildpic = "eufblab.png",
               buildtime  = 4004,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL PLANT NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               description = "Produces Clones",
--               firestandorders = 1,
               energystorage = 80,
               energyUse = 0,
               explodeas = "MEDIUM_BUILDINGEX",
               footprintx = 4,
               footprintz = 4,
--               mass = 0 --definire massa,
               maxdamage = 1234,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 80,
--               mobilestandorders= 1,
               name = "Bio Lab",
               noAutoFire = false,
               objectname = "ARMBLAB",
               radardistance = 0,
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 202,
--               soundcategory= "KBOTPLANT",
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               workertime = 69,
               YardMap= "oooo occo occo occo",
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               buildoptions = { 
		[1]= "armmedic",
               },

-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------

-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
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
