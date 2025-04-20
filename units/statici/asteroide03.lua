-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  asteroide03= {
               buildcostenergy = 200,
               buildcostmetal = 0.00006,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 3,
               buildinggrounddecalsizey = 3,
               buildinggrounddecaltype = "sfondo_pini.png",
               buildpic = "asteroide03.png",
               buildtime  = 300,
               canAttack = false,
               category = "OGGETTISTATICI",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               description = "An asteroid",
               explodeas = "DEADTREE",
               footprintx = 12,
               footprintz = 10,

               hidedamage = true,
               icontype = "seemefar",
               idleautoheal = 0.01,
               idletime = 30,
--               mass = 0 --definire massa,
               maxdamage = 50,
               maxslope = 65,
               name = "Building",
               objectname = "asteroide03.s3o",
               reclaimable = false,
               selfdestructas = "DEADTREE",
               selfdestructcountdown = 1,
               sightdistance = 0,
               upright = true,
               usebuildinggrounddecal = false,
               YardMap= "oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo ",
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:TREE_EXPLOSION_FX",
               }, -- close effects list
}, -- close section sfxtypes

}, -- close unit data 
} -- close total
