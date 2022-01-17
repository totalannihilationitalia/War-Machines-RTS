-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armmakr= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 1087,
               buildcostmetal = 1,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 4,
               buildinggrounddecalsizey = 4,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icumakr.png",
               buildtime  = 2605,
               category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               damagemodifier = 0.3,
               description = "Converts Energy to Metal",
               energystorage = 0,
               energyUse = 60,
               explodeas = "ARMESTOR_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
               makesMetal = 1,
--               mass = 0 --definire massa,
               maxdamage = 150,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Metal Maker",
               noAutoFire = false,
               objectname = "icumakr.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "ARMESTOR_BUILDING",
               sightdistance = 273,
--               soundcategory= "ARM_MAKER",
               TEDClass = "METAL", -- verificare se necessario
               turnrate = 0,
		usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               activate = "metlon1",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "metloff1",
               select = {
                     [1] = "metlon1",
                        },
               underattack = "warning1",
               working = "metlrun1",
}, --close sound section
}, -- close unit data 
} -- close total
