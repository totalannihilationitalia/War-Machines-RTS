-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  gorg= {
               acceleration = 0.048,
               brakerate  = 0.125,
               buildcostenergy = 481165,
               buildcostmetal = 18705,
               builder = false,
               buildpic = "GORG.DDS",
               buildtime  = 629630,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "KBOT WEAPON ALL NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "gorg_dead",
--               defaultmissiontype = Standby,
               description = "(barely) Mobile Heavy Turret",
--               firestandorders = 1,
               explodeas = "CRAWL_BLASTSML",
               footprintx = 6,
               footprintz = 6,
--               maneuverleashlength  = 640,
               mass = 10000,
               maxdamage = 300000,
               maxslope = 14,
               maxvelocity = 0.55,
               maxwaterdepth = 12,
--               mobilestandorders= 1,
               movementclass = "HKBOT4",
               name = "Juggernaut",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfagorg.s3o",
               seismicsignature = 0,
               selfdestructas = "CRAWL_BLAST",
               sightdistance = 525,
--               soundcategory= "JUGGERNAUT",
--               standingfireorder = 2,
--               steeringmode= 2,
--               standingmoveorder = 1,
               TEDClass = "KBOT", -- verificare se necessario
               turnrate = 109,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  gorg_dead = {
               world = "All Worlds",
               description = "Juggernaut Wreckage",
               category = "corpses",
               object = "GORG_DEAD",
               featuredead = "gorg_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 8,
               blocking= true,
               hitdensity = 100,
               metal = 13959,
               damage = 27000,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  gorg_heap = {
               world = "All Worlds",
               description = "Juggernaut Heap",
               category = "heaps",
               object = "4X4A",
               footprintx = 2,
               footprintz = 2,
               height = 2,
               blocking = false,
               hitdensity= 100,
               metal = 2793,
               damage = 13500,
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
               [1]="custom:berthaflare",
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
		juggernaut_fire = {
                     areaofeffect = 48,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "GaussCannon",
                     noexplode = true,
                     noselfdamage = true,
                     range = 590,
                     reloadtime = 1,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Krogun1",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 530,
                     damage = {
                         default = 300,
                     }, -- close damage
             }, --close single weapon definitions

		hllt_bottom = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.12,
--                     cegTag = "",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 15,
                     explosiongenerator = "custom:SMALL_RED_BURN",
                     firestarter = 100,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     proximitypriority = 3,
                     range = 430,
                     reloadtime = 0.48,
                     rgbcolor = "1 0 0",
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

		hllt_bottom = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.12,
--                     cegTag = "",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 15,
                     explosiongenerator = "custom:SMALL_RED_BURN",
                     firestarter = 100,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     proximitypriority = 3,
                     range = 430,
                     reloadtime = 0.48,
                     rgbcolor = "1 0 0",
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

		hllt_top = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.12,
--                     cegTag = "",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 15,
                     explosiongenerator = "custom:SMALL_RED_BURN",
                     firestarter = 30,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     proximitypriority = -1.5,
                     range = 435,
                     reloadtime = 0.48,
                     rgbcolor = "1 0 0",
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
                 badtargetcategory = "VTOL",
                 def = "juggernaut_fire",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 def = "hllt_bottom",
                 onlytargetcategory = "SURFACE VTOL",
                 maxAngleDif = 90,
                 maindir = "1 0 4",
                 },
                 [3] = {
                 def = "hllt_bottom",
                 onlytargetcategory = "SURFACE VTOL",
                 maxAngleDif = 90,
                 maindir = "-1 0 4",
                 },
                 [4] = {
                 def = "hllt_top",
                 onlytargetcategory = "SURFACE VTOL",
                 maxAngleDif = 270,
                 maindir = "0 1 0",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
