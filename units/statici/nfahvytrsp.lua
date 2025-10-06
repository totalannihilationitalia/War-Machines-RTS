-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  nfahvytrsp= {
               acceleration = 0,
               brakerate  = 0,
--               buildangle = 1024,
               buildcostenergy = 13761,
               buildcostmetal = 2729,
               builder = true,
               buildpic = "",
               buildtime  = 1224,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND PLANT NOTSUB NOWEAPON NOTSHIP NOTAIR",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               description = "Heavy transporter",
--               firestandorders = 1,
               energymake = 75000,
               energystorage = 300000,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 10,
               footprintz = 10,
               icontype = "building",
--               mass = 0 --definire massa,
               maxdamage = 400000,
               maxslope = 15,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalmake = 10000,
               metalStorage = 50000,
--               mobilestandorders= 1,
               name = "Shark transporter",
               noAutoFire = false,
               objectname = "nfahvytrsp.s3o",
               radardistance = 1500,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 286,
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 3500,
               YardMap= "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy",
               buildoptions = { 
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
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
--}, --close sound section
}, -- close unit data 
} -- close total
