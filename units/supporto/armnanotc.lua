-- made by DaRyL - www.warmachinesrts.com
-- SISTEMARE!!!!!!!!!!!!!
-- SISTEMARE!!!!!!!!!!!!!
-- SISTEMARE!!!!!!!!!!!!!
-- SISTEMARE!!!!!!!!!!!!!
-- SISTEMARE!!!!!!!!!!!!!
-- SISTEMARE!!!!!!!!!!!!!
-- SISTEMARE!!!!!!!!!!!!!

return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armnanotc= {
               acceleration = 0,
               brakerate  = 1.5,
               buildcostenergy = 5021,
               buildcostmetal = 597,
               builddistance = 400,
               builder = true,
               buildpic = "nfananotc.png",
               buildtime  = 5312,
               canGuard = true,
               canmove = false,
               canPatrol = true,
--               canreclamate = true,
--               canstop = 1,
	       cantbetransported = true,
               category = "ALL NOTSUB CONSTR NOWEAPON NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
--               defaultmissiontype = Standby,
               description = "Repairs and builds in large radius",
               energystorage = 0,
               energyUse = 30,
               explodeas = "NANOBOOM2",
               footprintx = 3,
               footprintz = 3,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 380,
               mass = 700,
               maxdamage = 500,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               movementclass = "KBOT1",
               name = "Nano Turret",
               noAutoFire = false,
               objectname = "nfananotc.s3o",
               seismicsignature = 0,
               selfdestructas = "TINY_BUILDINGEX",
               sightdistance = 380,
--               soundcategory= "CORE_CVEHICLE",
--               steeringmode= 1,
               TEDClass = "CNSTR", -- verificare se necessario
               turnrate = 1,
               upright = true,
               workertime = 50,
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:Nano",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "nanlath2",
               capture = "capture1",
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
                     [1] = "vcormove",
                    },
               repair = "repair2",
               select = {
                     [1] = "vcorsel",
                        },
               underattack = "warning1",
               working = "reclaim1",
}, --close sound section
}, -- close unit data 
} -- close total
