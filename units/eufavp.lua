-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufavp = {
               buildcostenergy = 13440,
               buildcostmetal = 2698,
               builder = true,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 11,
               buildinggrounddecalsizey = 11,
               buildinggrounddecaltype = "pavimentazione_euf.png",
               buildpic = "eufavp.png",
               buildtime  = 17940,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND PLANT NOTSUB NOWEAPON NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufavp_dead",
               description = "Produces EUF Vehicles",
--               firestandorders = 1,
               energystorage = 200,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 8,
               footprintz = 8,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 4300,
               maxslope = 15,
               maxwaterdepth = 0,
               metalStorage = 200,
--               mobilestandorders= 1,
               name = "Advanced Vehicle Plant",
               noAutoFire = false,
               objectname = "eufavp.s3o",
               radardistance = 50,
               selfdestructas = "LARGE_BUILDING",
	       showNanoSpray = false,
               sightdistance = 286,
--               soundcategory= "TANKPLANT",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               usebuildinggrounddecal = true,
               workertime = 200,
               YardMap= "ooooooooooooooooooooooooooccccooooccccooooccccooooccccooocccccco",
-----------------------------------
--- BUILDLIST
-----------------------------------
               buildoptions = { 
			[1] = "coracd", -- sostituire con eufacd (solo 3D.s3o)
			[2] = "eufbomb",
			[3] = "eufher",
			[4] = "euflong",
			[5] = "eufopp",
			[6] = "eufrld",
			[7] = "eufshat",
			[8] = "eufbigfoot",
			[9] = "eufkaat",
			[10] = "eufpilonax",
               },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Wreckage",
               category = "corecorpses",
               object = "eufavp_dead",
               featuredead = "eufavp_heap",
               featurereclamate = "smudge01",
               footprintx = 8,
               footprintz = 8,
               height = 25,
               hitdensity = 100,
               metal = 1608,
               damage = 2240,
               seqnamereclamate = "tree1reclamate",
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Advance vehicle factory heap",
               category = "heaps",
	       collisionvolumeoffsets = "0 0 0",
	       collisionvolumescales = "114 10 129",
               collisionvolumetype = "box",
               object = "7X7B",
               footprintx = 9,
               footprintz = 9,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 2040,
               damage = 4800,
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
		[1]="custom:Nano",
		[2]="custom:Nano",
--                [3]="custom:linkbeam",
--                [4]="custom:linkbeam",
               }, -- close effects list
}, -- close section sfxtypes
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               build = "pvehwork",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               select = {
                     [1] = "pvehactv",
                        },
               unitcomplete = "untdone",
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		buildlaser = {
                     areaofeffect = 1,
                     avoidfeature = true,
                     beamtime = 0.06,
		     beamTTL=2,
                     burst = 30, -- lua:salvoSize
                     burstrate = 0.01, -- lua: salvoDelay
--                     cegTag = "",
		     collideFirebase = true, -- era false
                     collidefriendly = false,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:oldskool_build",
                     impulseboost = 0,
                     impulsefactor = 0,
                     Intensity = 5,
		     laserFlareSize = 5,
                     name= "MG",
                     range = 50,
                     reloadtime = 0,
                     rgbcolor = "1, 1, 0",
                     size = "1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     thickness = 5,
                     tolerance = 3000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 256,
                     damage = {
                         default = 0.0000000001,
                     }, -- close damage
             }, --close single weapon definitions
}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "buildlaser",
                 onlytargetcategory = "VOID",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
