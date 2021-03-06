--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    group_label.lua
--  brief:   displays label on units in a group
--  author:  gunblob
--
--  Copyright (C) 2008.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Group Label",
    desc      = "Displays label on units in a group",
    author    = "gunblob, modified by molix",
    date      = "June 12, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end
---------------------------------------------------------------------------------
--- Add background to group number (War Machines RTS style)
---------------------------------------------------------------------------------

local textColor = {1, 1, 1, 1.0}
local backColor = {1, 1, 1, 1}
local textSize = 10.0
backgroundRank = "LuaUI/Images/Ranks/background.png"

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  Rendering
--

function widget:DrawWorld()
   local groups = Spring.GetGroupList()
   for group, _ in pairs(groups) do
      units = Spring.GetGroupUnits(group)
      for _, unit in ipairs(units) do
         if Spring.IsUnitInView(unit) then
            local ux, uy, uz = Spring.GetUnitViewPosition(unit)
				-- draw back button texture
	    gl.PushMatrix()
        gl.Translate(ux, uy, uz)
        gl.Billboard()
		gl.Color(backColor)
		gl.Texture(backgroundRank)
		gl.TexRect(-20, -22, -0,-2)
        gl.PopMatrix()
		gl.Texture(false)		
				-- draw number
			
            gl.PushMatrix()
            gl.Translate(ux, uy, uz)
            gl.Billboard()
            gl.Color(textColor)
            gl.Text("" .. group, -10.0, -15.0, textSize, "cn")
            gl.PopMatrix()

         end
      end
   end
end
