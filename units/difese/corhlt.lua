-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corhlt= {
               acceleration = 0,
--               badTargetCategory = ANTILASER,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 4443,
               buildcostmetal = 449,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 3,
               buildinggrounddecalsizey = 3,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfahlt.png",
               buildtime  = 9622,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corhlt_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Heavy Laser Tower",
--               firestandorders = 1,
               energystorage = 200,
               energyUse = 0,
               explodeas = "MEDIUM_BUILDINGEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 2475,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Gaat Gun",
               noAutoFire = false,
               nochasecategory = "MOBILE",
               objectname = "nfahvyturr.s3o",
               seismicsignature = 0,
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 455,
--               soundcategory= "HLT",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               wpri_badtargetcategory = "ANTILASER",
               YardMap= "oooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Gaat Gun Wreckage",
               category = "corpses",
               object = "CORHLT_DEAD",
               featuredead = "corhlt_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 292,
               damage = 1485,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Gaat Gun Heap",
               category = "heaps",
               object = "2X2A",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 117,
               damage = 743,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "35.0 4.0 6.0",
               collisionvolumetype = "cylY",
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
		core_laserh1 = {
                     areaofeffect = 14,
                     avoidfeature = true,
                     beamtime = 0.15,
--                     cegTag = "",
                     corethickness = 0.2,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 50,
                    explosiongenerator = "custom:SMALL_ARANCIO_BURN",  --LARGE_YELLOW_LASER_BURN",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HighEnergyLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 620,
                     reloadtime = 1.2,
                     rgbcolor = "1 1 0",
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
                     weaponvelocity  = 2250,
                     damage = {
                         default = 261,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
--                 badtargetcategory = "ANTILASER",
                 def = "core_laserh1",
                 onlytargetcategory = "SURFACE VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
