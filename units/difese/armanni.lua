-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armanni= {
               acceleration = 0,
               activatewhenbuilt = true,
--               badTargetCategory = ANTILASER,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 62563,
               buildcostmetal = 2985,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 5,
               buildinggrounddecalsizey = 5,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icuanni.png",
               buildtime  = 52071,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armanni_dead",
               damagemodifier = 0.25,
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Tachyon Accelerator",
--               firestandorders = 1,
               energystorage = 2000,
               energyUse = 0,
               explodeas = "CRAWL_BLASTSML",
               footprintx = 4,
               footprintz = 4,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 5500,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Annihilator",
               nochasecategory = "MOBILE",
               objectname = "icuanni.s3o",
               onoffable = true,
               radardistance = 1500,
               seismicsignature = 0,
               selfdestructas = "ATOMIC_BLAST",
               sightdistance = 780,
--               soundcategory= "ARM_ANNI",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               turnrate = 0,
	       usebuildinggrounddecal = true,
               workertime = 0,
               wpri_badtargetcategory = "ANTILASER",
               YardMap= "oooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Annihilator Wreckage",
               category = "corpses",
               object = "ARMANNI_DEAD",
               featuredead = "armanni_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 1940,
               damage = 1800,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Annihilator Heap",
               category = "heaps",
               object = "3X3B",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 776,
               damage = 900,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
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
                     [1] = "anni",
                    },
               select = {
                     [1] = "anni",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		ata = {
                     areaofeffect = 16,
                     avoidfeature = true,
                     beamtime = 1.5,
--                     cegTag = ""
                     corethickness = 0.2,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 1500,
                     explosiongenerator = "custom:ANNILAHATORLASER", --BURN_WHITE",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "ATA",
                     noselfdamage = true,
                     laserflaresize = 20,
                     range = 1400,
                     reloadtime = 9.9,
                     rgbcolor = "0 0 1",
                     soundhit = "xplolrg1",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "annigun1",
                     targetmoveerror = 0.3,
                     thickness = 7,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 1400,
                     damage = {
                         default = 9000,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "ata",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
