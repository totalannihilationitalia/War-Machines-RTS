-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufpath= {
--               badTargetCategory = VTOL,
--               buildangle = 4096,
               buildcostenergy = 4598,
               buildcostmetal = 514,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 6,
               buildinggrounddecalsizey = 6,
               buildinggrounddecaltype = "pavimento_piccolo_euf.png",
               buildpic = "eufpath.png",
               buildtime  = 10575,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufpath_dead",
               description = "Heavy Gatling Tower",
--               firestandorders = 1,
               explodeas = "MEDIUM_BUILDINGEX",
               footprintx = 4,
               footprintz = 4,
--               mass = 0 --definire massa,
               maxdamage = 2500,
               maxslope = 10,
               maxwaterdepth = 0,
               name = "Psychopath",
               noAutoFire = false,
               objectname = "eufpath.s3o",
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 500,
--               soundcategory= "CUP_GTURRET",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               usebuildinggrounddecal = true,
               wpri_badtargetcategory = "VTOL",
               YardMap= "oooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Wreckage",
               category = "corecorpses",
               object = "corpath_dead",
               featuredead = "corpath_heap",
               featurereclamate = "smudge01",
               footprintx = 4,
               footprintz = 4,
               height = 25,
               blocking= true,
               hitdensity = 100,
               metal = 999,
               damage = 2000,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Wreckage",
               category = "heaps",
               collisionvolumescales = "85.0 14.0 6.0",
               collisionvolumetype = "cylY",
               object = "4x4a",
               footprintx = 4,
               footprintz = 4,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 1998,
               damage = 2000,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
               collisionvolumescales = "85.0 14.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS  --************************************************************************sistemare colore effetto
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:beigeflare",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		eufpath_laser = {
                     accuracy = 32,
                     areaofeffect = 14,
                     avoidfeature = true,
                     beamtime = 0.1,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 75,
                     explosiongenerator = "custom:GatorYellow",
                     firestarter = 10,
                     impulseboost = 1,
                     impulsefactor = 1,
                     name= "EufPathLaser",
                     noselfdamage = true,
                     proximitypriority = 1.5,
                     range = 750,
                     reloadtime = 0.15,
                     rgbcolor = "1 1 0.8",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasfirerb",
                     soundtrigger = "1",
                     thickness = 2,
                     tolerance = 20000,
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 1920,
                     damage = {
                         default = 90,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
--                 badtargetcategory = "VTOL",
                 def = "eufpath_laser",
                 onlytargetcategory = "SURFACE VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
