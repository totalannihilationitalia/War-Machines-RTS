-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  medusa= {
--               badTargetCategory = VTOL,
--               buildangle = 16384,
               buildcostenergy = 27687,
               buildcostmetal = 2546,
               builder = false,
               buildpic = "medusa",
               buildtime  = 25656,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "medusa_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Heavy Quad-HLT Battery",
--               firestandorders = 1,
               energymake = 0,
               energystorage = 500,
               explodeas = "MEDIUM_BUILDINGEX",
               footprintx = 6,
               footprintz = 4,
--               mass = 0 --definire massa,
               maxdamage = 2195,
               maxslope = 10,
               maxwaterdepth = 0,
               metalmake = 0,
               metalStorage = 0,
               name = "Medusa",
               noAutoFire = false,
               objectname = "MEDUSA",
               radardistance = 0,
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 380,
--               soundcategory= "HLT",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               YardMap= "oooooo oooooo oooooo oooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  medusa_dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "arm_corpses",
               object = "MEDUSA_dead",
               featuredead = "medusa_heap",
               footprintx = 6,
               footprintz = 4,
               height = 20,
               blocking= true,
               hitdensity = 60,
               metal = 1630,
               damage = 456,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  medusa_heap = {
               world = "All Worlds",
               description = "Metal Shards",
               category = "heaps",
               object = "5x5a",
               footprintx = 5,
               footprintz = 5,
               blocking = false,
               hitdensity= 5,
               metal = 847,
               damage = 175,
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
                     weapontype = "BeamLaser",
                     weaponvelocity  = 700,
                     damage = {
                         default = 300,
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
                     weapontype = "BeamLaser",
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
--                 badtargetcategory = "VTOL",
                 def = "core_batslaser",
                 onlytargetcategory = "SURFACE VTOL",
                 },
                 [2] = {
--                 badtargetcategory = "VTOL",
                 def = "core_batslaser",
                 onlytargetcategory = "SURFACE VTOL", -- weapon 2
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
