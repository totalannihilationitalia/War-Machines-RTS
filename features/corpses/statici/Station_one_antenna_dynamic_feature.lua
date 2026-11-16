return {
  Station_one_antenna_featdyn_rot =
  {
    description = "A big antenna",
    blocking = true,
    damage = 30000,
--    energy = 60000,
    flammable = false,
--    featureDead ="Station_one_antenna_feature_dead", -- non ci sono features per la parte rotante, esplode e basta
    noselect = false,
--    metal = 10000,	-- no reclamaible
    footprintx = 1,
    footprintz = 1,
    object = "Station_one_antenna_featdyn_rot.s3o",
    reclaimable = false,
    upright = true,
--    collisionvolumeoffsets = "0 0 0",
--    collisionvolumescales = "5 50 5",
--    collisionvolumetype = "Box",
  },
  Station_one_antenna_featdyn_base  =
  {
    description = "wreckage of a big antenna",
    blocking = true,
    damage = 15000,
--    energy = 30000,
    flammable = false,
	featureDead ="Station_one_antenna_feature_dead", 
    noselect = false,
--    metal = 5000,
    footprintx = 1,
    footprintz = 1,
    object = "Station_one_antenna_featdyn_base.s3o",
--    reclaimable = true,
    upright = true,
--    collisionvolumeoffsets = "0 0 0",
--    collisionvolumescales = "5 50 5",
--    collisionvolumetype = "Box",
  },
}