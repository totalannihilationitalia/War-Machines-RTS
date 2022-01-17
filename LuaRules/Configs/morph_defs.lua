--[[   Morph Definition File

Morph parameters description
local morphDefs = {		--beginig of morphDefs
	unitname = {		--unit being morphed
		into = 'newunitname',		--unit in that will morphing unit morph into
		time = 12,			--time required to complete morph process (in seconds)
		require = 'requnitname',	--unit requnitname must be present in team for morphing to be enabled
		metal = 10,			--required metal for morphing process     note: if you skip M and/or E costs morph costs the
		energy = 10,			--required energy for morphing process		difference in costs between unitname and newunitname
		xp = 0.07,			--required experience for morphing process (will be deduced from unit xp after morph, default=0)
		rank = 1,			--required unit rank for morphing to be enabled, if not specified, morph doesn't require rank
		tech = 2,			--required tech level of a team for morphing to be enabled (1,2,3), if not specified, morph doesn't require tech
		cmdname = 'Ascend',		--if not supplied will default to "Upgrade"
		texture = 'MyIcon.dds',		--if not supplied will default to [newunitname] buildpic, textures should be in "LuaRules/Images/Morph"
		text = 'Description',		--if not supplied will default to "Upgrade into a [newunitname]", else it's "Description"
						--you may use "$$unitname" and "$$into" in 'text', both will be replaced with human readable unit names 
	},
}				--end of morphDefs
--]]
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


local devolution = (-1 > 0)


local morphDefs = {

  -- Constructors
-------------------------
------- ICU COMMANDER
-------------------------
  icucom = {
    into = 'icucom_u1',
    tech = 0,
    time = 120,
    metal= 600,
    energy= 2000,
--    RequireTech = 'armham',
    --xp = .05,
  },
  icucom_u1 = {
    into = 'icucom_u2',
    tech = 0,
    time = 240,
    metal= 1200,
    energy= 4000,
--    xp = .30
  },
  icucom_u2 = {
    into = 'icucom_u3',
    tech = 0,
    time = 560,
    metal= 3200,
    energy= 16000,
--    xp = .45
  },
  icucom_u3 = {
    into = 'icucom_u4',
    tech = 0,
    time = 850,
    metal= 6000,
    energy= 160000,
 --   xp = .60
  },
-------------------------
------- NFA COMMANDER
-------------------------
  nfacom = {
    into = 'nfacom_u1',
    tech = 0,
    time = 120,
    metal= 600,
    energy= 2000,
    --xp = .05
  },
  nfacom_u1 = {
    into = 'nfacom_u2',
    tech = 0,
    time = 240,
    metal= 1200,
    energy= 4000,
--    xp = .30
  },
  nfacom_u2 = {
    into = 'nfacom_u3',
    tech = 0,
    time = 560,
    metal= 3200,
    energy= 16000,
--    xp = .45
  },
  nfacom_u3 = {
    into = 'nfacom_u4',
    tech = 0,
    time = 850,
    metal= 6000,
    energy= 160000,
--    xp = .60
  },
}

--
-- Here's an example of why active configuration
-- scripts are better then static TDF files...
--

--
-- devolution, babe  (useful for testing)
--
if (devolution) then
  local devoDefs = {}
  for src,data in pairs(morphDefs) do
    devoDefs[data.into] = { into = src, time = 10, metal = 1, energy = 1 }
  end
  for src,data in pairs(devoDefs) do
    morphDefs[src] = data
  end
end


return morphDefs

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
