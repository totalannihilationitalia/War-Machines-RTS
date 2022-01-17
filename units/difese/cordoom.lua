-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  cordoom= {
               acceleration = 0,
               activatewhenbuilt = true,
--               badTargetCategory = ANTILASER,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 22599,
               buildcostmetal = 2478,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 4,
               buildinggrounddecalsizey = 4,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfadoom.png",
               buildtime  = 55276,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "cordoom_dead",
               damagemodifier = 0.08,
               description = "Energy Weapon",
--               firestandorders = 1,
               energystorage = 2000,
               energyUse = 0,
               explodeas = "ESTOR_BUILDING",
               footprintx = 3,
               footprintz = 3,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 10000,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Doomsday Machine",
               nochasecategory = "VTOL",
               objectname = "nfadoom.s3o",
               onoffable = true,
               radardistance = 1200,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 780,
--               soundcategory= "COR_DOOM",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               wpri_badtargetcategory = "ANTILASER",
               wspe_badtargetcategory = "ANTILASER",
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Doomsday Machine Wreckage",
               category = "corpses",
               object = "CORDOOM_DEAD",
               featuredead = "cordoom_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 1611,
               damage = 5400,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Doomsday Machine Heap",
               category = "heaps",
               object = "3X3E",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 644,
               damage = 2700,
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
                     [1] = "doom",
                    },
               select = {
                     [1] = "doom",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		atadr = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.3,
--                     cegTag = "",
                     corethickness = 0.3,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 500,
                     explosiongenerator = "custom:ANNILAHATORLASER", --FLASH3blue
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "ATAD",
                     noselfdamage = true,
                     laserflaresize = 22,
                     range = 950,
                     reloadtime = 6,
                     rgbcolor = "0 0 1",
                     soundhit = "xplosml3",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "annigun1",
                     targetmoveerror = 0.3,
                     thickness = 5.5,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 1500,
                     damage = {
                         default = 5000,
                     }, -- close damage
             }, --close single weapon definitions

		corsumo_weapon = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.15,
--                     cegTag = "",
                     corethickness = 0.3,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 75,
                     explosiongenerator = "custom:LARGE_YELLOW_LASER_BURN",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HighEnergyLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 650,
                     reloadtime = 0.55,
                     rgbcolor = "1 1 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrhvy3",
                     targetmoveerror = 0.25,
                     thickness = 3,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 800,
                     damage = {
                         default = 275,
                     }, -- close damage
             }, --close single weapon definitions

		adv_decklaser = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.1,
--                     cegTag = "",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 10,
                     explosiongenerator = "custom:SMALL_RED_BURN",
                     firestarter = 30,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "L2DeckLaser",
                     noselfdamage = true,
                     laserflaresize = 12,
                     range = 450,
                     reloadtime = 0.4,
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
                     weaponvelocity  = 800,
                     damage = {
                         default = 60,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "atadr",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 badtargetcategory = "VTOL",
                 def = "corsumo_weapon",
                 onlytargetcategory = "SURFACE", -- weapon 2
                 },
                 [3] = {
                 badtargetcategory = "VTOL",
                 def = "adv_decklaser",
                 onlytargetcategory = "SURFACE", -- weapon 3
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
