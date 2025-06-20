-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufspazioportodin= {
               acceleration = 0,
               brakerate  = 0,
--               buildangle = 1024,
               buildcostenergy = 13761,
               buildcostmetal = 2729,
               builder = true,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 10,
               buildinggrounddecalsizey = 10,
               buildinggrounddecaltype = "asphalt512.dds",
               buildpic = "",
               buildtime  = 1224,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND PLANT NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               description = "Transport units",
--               firestandorders = 1,
               energystorage = 300000,
               energyUse = 0,
               explodeas = "NUCLEAR_MISSILE",
               footprintx = 10,
               footprintz = 10,
               icontype = "building",
--               mass = 0 --definire massa,
               maxdamage = 80000,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               name = "Spaceport",
               noAutoFire = false,
               objectname = "armspazioporto_dinamic.s3o",
               radardistance = 1500,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 286,
--               soundcategory= "KBOTPLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 3500,
               YardMap= "occccooccccooccccooccccooccccoocccco",
               buildoptions = { 
			[1] = "euftrasparte",
			[2] = "ruspa_builder",
               },



-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:GantWhiteLight",
               [2]="custom:YellowLight",
               [3]="custom:WhiteLight",
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
