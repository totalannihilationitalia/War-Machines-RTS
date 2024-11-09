-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andlaunch= {
               activatewhenbuilt = true,
--               buildangle = 2048,
               buildcostenergy = 2686524,
               buildcostmetal = 120965,
               builder = false,
 --              buildinggrounddecaldecayspeed= 0.01,
  --             buildinggrounddecalsizex= 9,
  --             buildinggrounddecalsizey = 9,
  --             buildinggrounddecaltype = "asphalt512c.dds",
               buildpic = "",
               buildtime  = 1774578,
               canGuard = true,
               category = "SURFACE NOTAIR NOTSUB NOTSHIP",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "120 120 120",
               --collisionvolumetype = "box",
               corpse = "armgate_dead",
               description = "Launch Facility",
               energyUse = 0,
               explodeas = "ATOMIC_BLAST",
               footprintx = 8,
               footprintz = 8,
               icontype = "bigstar",
               idleautoheal = 2,
               idletime = 2200,
--               mass = 0 --definire massa,
               maxdamage = 4651,
               maxslope = 14,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Orbital Laser",
               noAutoFire = false,
               objectname = "andlaunch.s3o",
               radardistance = 0,
               selfdestructas = "ATOMIC_BLAST",
               sightdistance = 500,
--               soundcategory= "GATE",
               TEDClass = "SPECIAL", -- verificare se necessario
--               usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  armgate_dead = {
               world = "All Worlds",
               description = "Keeper Wreckage",
               category = "corpses",
               object = "ARMGATE_DEAD",
               featuredead = "armgate_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 2296,
               damage = 1800,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  armgate_heap = {
               world = "All Worlds",
               description = "Keeper Heap",
               category = "heaps",
               object = "2X2D",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 918,
               damage = 900,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
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
                     [1] = "drone1",
                    },
               select = {
                     [1] = "drone1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		orbital_laser = {
                     areaofeffect = 5,
                     avoidfeature = true,
                     beamtime = 4,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0.05,
                     cratermult = 0.05,
                     explosiongenerator = "custom:ORBITALLASER_Expl",
                     firestarter = 90,
                     impulsefactor = 0.1,
                     Intensity = 15,
                     name= "Orbital Beam of Death",
                     laserflaresize = 4,
                     range = 65000,
--                     reloadtime = 120,
                     reloadtime = 1,
                     rgbcolor = "1 0 1",
                     soundhit = "xplolrg1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Orbitlaser",
                     thickness = 20,
                     tolerance = 500,
                     weapontype = "BeamLaser",
--                     weapontype = "LightningCannon",
                     weaponvelocity  = 1000,
                     damage = {
                         default = 50000,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "orbital_laser",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
