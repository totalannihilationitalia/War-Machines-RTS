-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andchaos= {
--               badTargetCategory = VTOL,
--               buildangle = 16384,
               buildcostenergy = 12968,
               buildcostmetal = 1584,
               builder = false,
               buildpic = "andchaos.png",
               buildtime  = 18575,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "cgausstw_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Heavy-Duty Stunner",
--               firestandorders = 1,
               energystorage = 200,
               energyUse = 0,
               explodeas = "MEDIUM_BUILDINGEX",
               footprintx = 4,
               footprintz = 4,
--               mass = 0 --definire massa,
               maxdamage = 2060,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Chaos Machine",
               noAutoFire = false,
               objectname = "andchaos.s3o",
               radardistance = 0,
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 380,
--               soundcategory= "HLT",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               YardMap= "oooo oooo oooo oooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  cgausstw_dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "arm_corpses",
               object = "CGAUSSTW_dead",
               featuredead = "cgausstw_heap",
               featurereclamate = "smudge01",
               footprintx = 2,
               footprintz = 2,
               height = 25,
               blocking= true,
               hitdensity = 100,
               metal = 556,
               damage = 1219,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  cgausstw_heap = {
               world = "All Worlds",
               description = "Wreckage",
               category = "heaps",
               object = "2x2d",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 443,
               damage = 609,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               cloak = "kloak1",
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
                     [1] = "twractv3",
                    },
               select = {
                     [1] = "twractv3",
                        },
               uncloak = "kloak1un",
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		medusa_stun = {
                     areaofeffect = 8,
                     avoidfeature = true,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     duration = 0.1,
                     energypershot = 100,
                     firestarter = 0,
                     name= "Medusa Stun",
                     paralyzer = true,
                     range = 600,
                     reloadtime = 7,
                     soundhit = "capture1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "medusashot",
                     soundtrigger = "1",
                     tolerance = 500,
                     turret  = true, 
                     weapontype = " ",
                     weaponvelocity  = 900,
                     damage = {
                         default = 1800,
                     }, -- close damage
             }, --close single weapon definitions

		ata = {
                     areaofeffect = 16,
                     avoidfeature = true,
                     beamtime = 1.5,
--                     cegTag = "",
                     corethickness = 0.2,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 1500,
                     explosiongenerator = "custom:BURN_WHITE",
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
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "annigun1",
                     targetmoveerror = 0.3,
                     thickness = 7,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = " ",
                     weaponvelocity  = 1400,
                     damage = {
                         default = 9000,
                     }, -- close damage
             }, --close single weapon definitions

		core_batslaser = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.2,
--                     beamweapon = true,
--                     cegTag = "",
                     corethickness = 0.2,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 125,
                     explosiongenerator = "custom:LARGE_GREEN_LASER_BURN",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HighEnergyLaser",
                     noselfdamage = true,
                     laserflaresize = 15,
                     range = 950,
                     reloadtime = 1.1,
                     rgbcolor = "0 1 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Lasrmas2",
                     targetmoveerror = 0.2,
                     thickness = 3,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = " ",
                     weaponvelocity  = 700,
                     damage = {
                         default = 300,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "medusa_stun",
--               onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 def = "ata",
--               onlytargetcategory = "SURFACE", -- weapon 2
                 },
                 [3] = {
                 def = "core_batslaser",
--               onlytargetcategory = "SURFACE", -- weapon 3
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
