-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufpathsmall= {
--               badTargetCategory = VTOL,
--               buildangle = 4096,
               buildcostenergy = 652,
               buildcostmetal = 84,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 6,
               buildinggrounddecalsizey = 6,
               buildinggrounddecaltype = "pavimento_piccolo_euf.png",
               buildpic = "eufpathsmall.png",
               buildtime  = 2724,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufpathsmall_dead",
               description = "Light Gatling Tower",
--               firestandorders = 1,
               explodeas = "MEDIUM_BUILDINGEX",
               footprintx = 2,
               footprintz = 2,
--               mass = 0 --definire massa,
               maxdamage = 600,
               maxslope = 10,
               maxwaterdepth = 0,
               name = "Psychopath",
               noAutoFire = false,
               objectname = "eufpath_small.s3o",
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 494,
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
		eufpath_pilu = {
                     accuracy = 32,
                     areaofeffect = 14,
                     avoidfeature = true,
                     beamtime = 0.1,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 25,
                     explosiongenerator = "custom:GatorYellow",
                     firestarter = 10,
                     impulseboost = 1,
                     impulsefactor = 1,
                     name= "EufPathLaser",
                     noselfdamage = true,
                     proximitypriority = 1.5,
                     range = 485,
                     reloadtime = 0.5,
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
                         default = 100,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
--                 badtargetcategory = "VTOL",
                 def = "eufpath_pilu",
                 onlytargetcategory = "SURFACE VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
