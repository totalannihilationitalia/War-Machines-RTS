-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corbhmth= {
               acceleration = 0,
               activatewhenbuilt = true,
--               badTargetCategory = VTOL,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 32428,
               buildcostmetal = 2949,
               builder = false,
               buildpic = "nfabhmth.png",
               buildtime  = 59640,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND NOTSUB WEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corbhmth_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Geothermal Plasma Battery",
--               firestandorders = 1,
               energymake = 450,
               energystorage = 500,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 5,
               footprintz = 5,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 7500,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Behemoth",
               noAutoFire = false,
               nochasecategory = "MOBILE",
               objectname = "nfabhmth.s3o",
               onoffable = false,
               seismicsignature = 0,
               selfdestructas = "ESTOR_BUILDING",
               sightdistance = 650,
--               soundcategory= "CORE_GEO",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               YardMap= "ooooo ooooo ooGoo ooooo ooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Behemoth Wreckage",
               category = "corpses",
               object = "CORBHMTH_DEAD",
               featuredead = "corbhmth_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 5,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 1917,
               damage = 4500,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Behemoth Heap",
               category = "heaps",
               object = "5X5C",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 767,
               damage = 2250,
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
               [1]="custom:MEDIUMFLARE",
               }, -- close effects list
}, -- close section sfxtypes
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
               select = {
                     [1] = "geothrm2",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		corbhmth_weapon = {
                     accuracy = 780,
                     areaofeffect = 192,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.7,
                     energypershot = 150,
                     explosiongenerator = "custom:FLASHSMALLBUILDINGEX",
                     firestarter = 99,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "PlasmaBattery",
                     noselfdamage = true,
                     range = 1650,
                     reloadtime = 0.5,
                     soundhit = "xplolrg3",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "xplonuk3",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 620,
                     damage = {
                         default = 450,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "corbhmth_weapon",
                 onlytargetcategory = "NOTAIR",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
