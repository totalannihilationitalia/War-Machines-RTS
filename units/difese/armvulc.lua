-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armvulc= {
               acceleration = 0,
--               badTargetCategory = MOBILE,
               brakerate  = 0,
--               buildangle = 29096,
               buildcostenergy = 503644,
               buildcostmetal = 33890,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 9,
               buildinggrounddecalsizey = 9,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icuvulc.png",
               buildtime  = 672961,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armvulc_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Rapid-Fire Long-Range Plasma Cannon",
--               firestandorders = 1,
               energymake = 0,
               energystorage = 0,
               energyUse = 0,
               explodeas = "ATOMIC_BLAST",
               footprintx = 8,
               footprintz = 8,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 34440,
               maxslope = 13,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Vulcan",
               objectname = "icuvulc.s3o",
               seismicsignature = 0,
               selfdestructas = "ATOMIC_BLAST",
               sightdistance = 273,
--               soundcategory= "ARM_BRTHA",
--               standingfireorder = 1,
               TEDClass = "FORT", -- verificare se necessario
               turnrate = 0,
	       usebuildinggrounddecal = true,
               workertime = 0,
               wpri_badtargetcategory = "MOBILE",
               YardMap= "oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Vulcan Wreckage",
               category = "corpses",
               object = "ARMVULC_DEAD",
               featuredead = "armvulc_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 7,
               footprintz = 7,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 22029,
               damage = 20664,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Vulcan Heap",
               category = "heaps",
               object = "7X7A",
               footprintx = 7,
               footprintz = 7,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 8812,
               damage = 10332,
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
               [1]="custom:vulcanflare",
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
               cant = {
                     [1] = "cantdo4",
                      },
               ok = {
                     [1] = "Servlrg3",
                    },
               select = {
                     [1] = "Servlrg3",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		armvulc_weapon = {
                     accuracy = 700,
                     areaofeffect = 224,
                     avoidfeature = true,
                     cegTag = "vulcanfx",
--                     craterareaofeffect =  ,
                     craterboost = 0.25,
                     cratermult = 0.25,
                     edgeeffectiveness = 0.75,
                     energypershot = 9000,
                     explosiongenerator = "custom:FLASHBIGBUILDING",
                     impulseboost = 0.5,
                     impulsefactor = 0.5,
                     name= "RapidfireLRPC",
                     noselfdamage = true,
                     range = 5750,
                     reloadtime = 0.4,
                     rgbcolor = "1 0.8 0.5",
                     size = "5",
                     soundhit = "rflrpc3",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "XPLONUK4",
                     tolerance = 500,
                     turret  = true, 
                     weapontimer = 14,
                     weapontype = "Cannon",
                     weaponvelocity  = 1100,
                     damage = {
                         default = 600,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "armvulc_weapon",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
