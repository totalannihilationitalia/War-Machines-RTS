-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  bigrock008= {
               buildcostenergy = 200,
               buildcostmetal = 0.00006,
--               buildinggrounddecaldecayspeed= 0.01,
--               buildinggrounddecalsizex= 3,
--               buildinggrounddecalsizey = 3,
--               buildinggrounddecaltype = "sfondo_pini.png",
               buildpic = "bigrock008.png",
               buildtime  = 300,
               canAttack = false,
               category = "OGGETTISTATICI",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               description = "A rock",
               explodeas = "DEADTREE",
               footprintx = 2,
               footprintz = 2,
               hidedamage = true,
               icontype = "seemefar",
               idleautoheal = 0.01,
               idletime = 30,
--               mass = 0 --definire massa,
               maxdamage = 50,
               maxslope = 65,
               name = "Rock",
               objectname = "bigrock008_feature.s3o",
               reclaimable = false,
               selfdestructas = "DEADTREE",
               selfdestructcountdown = 1,
               sightdistance = 0,
               upright = true,
 --              usebuildinggrounddecal = true,
               YardMap= "oooo",
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
