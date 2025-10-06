-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  blab= {
               buildcostenergy = 25748,
               buildcostmetal = 15485,
               builder = true,
               buildpic = "",
               buildtime  = 3912,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "CORE PLANT CTRL_F LEVEL3 NOWEAPON NOTAIR NOTSUB",
               cloakcost = 1,
               cloakcostmoving = 1,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "blab_dead",
               description = "Builds encryp family",
--               firestandorders = 1,
               energystorage = 3000,
               energyUse = 0,
               explodeas = "NUCLEAR_MISSILE",
               footprintx = 15,
               footprintz = 15,
--               mass = 0 --definire massa,
               maxdamage = 5298,
               maxslope = 10,
               maxwaterdepth = 0,
               metalStorage = 2000,
--               mobilestandorders= 1,
               name = "Saitan's Lair",
               noAutoFire = false,
               objectname = "blab",
               radardistance = 0,
               selfdestructas = "NUCLEAR_MISSILE",
               sightdistance = 210,
--               soundcategory= "CORE_GANTRY",
--               standingfireorder = 2,
--               standingmoveorder = 1,
               TEDClass = "PLANT", -- verificare se necessario
               workertime = 350,
               YardMap= "yyyyoooooooyyyy yyoooooooooooyy yoooocccccooooy yooocccccccoooy ooocccccccccooo oocccccccccccoo oocccccccccccoo oocccccccccccoo oocccccccccccoo oocccccccccccoo ooocccccccccooo yooocccccccoooy yooocccccccoooy yyoocccccccooyy yyyyyyyyyy               buildoptions = { 
-----------------------------------
--- INSERT BUILDLIST
-----------------------------------
               },



-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  blab_dead = {
               world = "All Worlds",
               description = "Wreckage",
               category = "core_corpses",
               object = "blab_dead",
               featuredead = "blab_heap",
               footprintx = 15,
               footprintz = 15,
               height = 60,
               blocking= true,
               hitdensity = 100,
               metal = 13845,
               damage = 12054,
               reclaimable = true,
--               collisionvolumeoffsets = ,
--               collisionvolumescales = ,
--               collisionvolumetype = ,
               },  -- Close Dead Features
  blab_heap = {
               world = "All Worlds",
               description = "Wreckage",
               category = "heaps",
               object = "blab_heap",
               footprintx = 15,
               footprintz = 15,
               height = 20,
               blocking = true,
               hitdensity= 100,
               metal = 11745,
               damage = 10547,
               reclaimable = true,
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               activate = "gantok2",
               build = "gantok2",
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               deactivate = "gantok2",
               repair = "lathelrg",
               select = {
                     [1] = "gantsel1",
                        },
               unitcomplete = "gantok1",
               underattack = "warning1",
               working = "build",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		demonic_aura = {
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     weapontype = " ",
                     damage = {
                         default = ,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "demonic_aura",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
