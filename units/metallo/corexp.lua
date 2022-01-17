-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corexp= {
               acceleration = 0,
               activatewhenbuilt = true,
--               badTargetCategory = ANTILASER,
               brakerate  = 0,
--               buildangle = 32768,
               buildcostenergy = 2264,
               buildcostmetal = 188,
               builder = false,
               buildpic = "nfaexp.png",
               buildtime  = 3460,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND ANTIGATOR NOTSUB ANTIEMG NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corexp_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Armed Metal Extractor",
--               firestandorders = 1,
               energystorage = 0,
               energyUse = 5,
               explodeas = "MEDIUM_BUILDINGEX",
               ExtractsMetal = 0.0009,
               footprintx = 3,
               footprintz = 3,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 1300,
               maxslope = 20,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 75,
               name = "Exploiter",
               noAutoFire = false,
               nochasecategory = "MOBILE",
               objectname = "nfaexp.s3o",
               onoffable = true,
               seismicsignature = 0,
               selfdestructas = "",
               selfdestructcountdown = 1,
               sightdistance = 455,
--               soundcategory= "COR_MEX",
--               standingfireorder = 2,
               TEDClass = "METAL", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               wpri_badtargetcategory = "ANTILASER",
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Exploiter Wreckage",
               category = "corpses",
               object = "COREXP_DEAD",
               featuredead = "corexp_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 122,
               damage = 780,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Exploiter Heap",
               category = "heaps",
               object = "3X3A",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 49,
               damage = 390,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
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
               activate = "mexrun2",
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
               deactivate = "mexoff2",
               ok = {
                     [1] = "servmed2",
                    },
               select = {
                     [1] = "mexon2",
                        },
               underattack = "warning1",
               working = "mexrun2",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		core_lightlaser = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.12,
--                     cegTag = "",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 20,
                     explosiongenerator = "custom:SMALL_ARANCIO_BURN",
                     firestarter = 100,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 435,
                     reloadtime = 0.48,
                     rgbcolor = "1 0.2 0",
                     soundhit = "lasrhit2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir3",
                     soundtrigger = "1",
                     targetmoveerror = 0.1,
                     thickness = 2.5,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 2250,
                     damage = {
                         default = 75,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "ANTILASER",
                 def = "core_lightlaser",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
