--------------------------------------------------------------------------------
-- usage:
--
-- /luaui exportheightmapppm
-- /luaui exportheightmapraw
-- both export images of the heightmap to spring userdata directory, as .pgm or .raw
-- .raw is photoshop raw
--
-- /luaui exportheightmaptxt
-- exports a text file of the heightmap. have not tested, merely kept the function from earlier script version
--
-- /luaui exportslopemapppm
-- /luaui exportslopemapraw
-- /luaui exportslopemaptxt
-- export images of the slopemap, both normalized and absolute
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Export Heightmap",
    desc      = "Usage: /luaui exportheightmapppm",
    author    = "user finished it, again, zoggop updated",
    date      = "Feb ??, 2008, updated Jan 2015",
    license   = "GNU GPL, v2 or later",
    layer     = -5,
    enabled   = true  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local heightMapX = (Game.mapX * 64)
local heightMapY = (Game.mapY * 64)

local GetGroundHeight = Spring.GetGroundHeight

local le = {}

local function mod(one, two)
  return one % two
end
local max = math.max
local floor = math.floor

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

do
  function le.uint32(n)
    return string.char( mod(n,256), mod(n,65536)/256, mod(n, 16777216)/65536,n/16777216 )
  end

  function le.uint16(n)
    return string.char( mod(n,256), mod(n,65536)/256 )
  end

  function le.uint16rev(n)
    return string.char( mod(n,65536)/256, mod(n,256) )
  end

  function le.uint8(n)
    return string.char( mod(n,256) )
  end
end

local function bmptxt(data, filename)
   local file = assert(io.open(filename,'w'), "Unable to save to "..filename)
   for row = heightMapX, 0, -1 do
      for col = 0, heightMapY, 1 do  
         file:write(tostring(data[row][col] or 0))
         file:write('\n')
      end 
   end

   file:close()
   Spring.Echo("Created temporary file " .. filename)
end

local function writeRAW(data, filename)
     local file = assert(io.open(filename,'wb'), "Unable to save to "..filename)
     local rawData = {}
   for row = heightMapY, 0, -1 do
      for col = 0, heightMapX, 1 do
         if not data[row] then data[row] = {} end
         table.insert(rawData, data[row][col] or 0)
      end    
   end
   local rawString = VFS.PackU16(rawData)
   file:write(rawString)

   file:close()
   Spring.Echo(heightMapX, heightMapY, #rawData, string.len(rawString))
   Spring.Echo("Exported to " .. filename)
end

local function writePPM(data, filename)
   local file = assert(io.open(filename,'wb'), "Unable to save to "..filename)

   file:write("P5 " .. tostring(heightMapX+1) .. " " .. tostring(heightMapY+1) .. " 65535 ")

   local rawData = {}
   for row = heightMapY, 0, -1 do
        for col = 0, heightMapX, 1 do
             local twochars = le.uint16rev(data[row][col] or 0)
             if string.len(twochars) < 2 or string.len(twochars) > 2 then Spring.Echo("bad string") end
           file:write(twochars) 
        end    
   end

   file:close()
   Spring.Echo(heightMapX, heightMapY, #rawData)
   Spring.Echo("Exported to " .. filename)
end

local function writeTXT(data, filename)
   local file = assert(io.open(filename,'w'), "Unable to save to "..filename)
   for row = heightMapX, 0, -1 do
      for col = 0, heightMapY, 1 do
        if not data[row] then data[row] = {} end  
        if not data[row][col] then data[row][col] = 0 end
         if (tonumber(data[row][col]) < 100)and(tonumber(data[row][col]) > 9)then  
           data[row][col] = "0"..tostring(data[row][col])   
         end    
         if (tonumber(data[row][col]) < 10)then  
           data[row][col] = "00"..tostring(data[row][col])   
         end  
         file:write(tostring(data[row][col] or 0).."-")
      end 
      file:write('\n')
   end

   file:close()
   Spring.Echo("Exported to " .. filename)
end

-- Spring.GetGroundExtremes only knows the original heightmap, not the modified one
local function GetActualGroundExtremes()
  local minHeight, maxHeight = 9999, 0
   for row = 0, heightMapY, 1 do
     for col = 0, heightMapX, 1 do
        local pixelHeight = GetGroundHeight(col * 8, row * 8)
        if pixelHeight < minHeight then minHeight = pixelHeight end
        if pixelHeight > maxHeight then maxHeight = pixelHeight end
     end
  end
  return minHeight, maxHeight
end

local function GetHeightMapImage(bitdepth)
  local maxvalue = (2 ^ bitdepth) - 1
  local minHeight, maxHeight = GetActualGroundExtremes()
  Spring.Echo("min height: " .. tostring(minHeight) .. ", max height: " .. tostring(maxHeight))
  local heightDif = (maxHeight - minHeight)
  -- save the image data
  local imageData = {}
  for row = 0, heightMapY, 1 do
     imageData[row] = {}
     for col = 0, heightMapX, 1 do
        local pixelHeight = GetGroundHeight(col * 8, row * 8)
        local pixelColor = floor(((pixelHeight - minHeight) / heightDif) * maxvalue)
        imageData[row][col] = pixelColor
     end
  end
  return imageData
end

local function GetSlopeMapImage(bitdepth)
  local minSlope = 99
  local maxSlope = 0
  local slopeData = {}
  for row = 0, heightMapY, 1 do
     slopeData[row] = {}
     for col = 0, heightMapX, 1 do
        local sx,sy,sz = Spring.GetGroundNormal(col * 8, row * 8)
        local slopelevel = sy
        if slopelevel > maxSlope then maxSlope = slopelevel end
        if slopelevel < minSlope then minSlope = slopelevel end
        slopeData[row][col] = slopelevel
     end
  end
  Spring.Echo(minSlope, maxSlope)
  local slopeDif = maxSlope - minSlope
  local maxvalue = (2 ^ bitdepth) - 1
  local imageData = {}
  local imageDataNormalized = {}
  for row = 0, heightMapY, 1 do
     imageData[row] = {}
     imageDataNormalized[row] = {}
     for col = 0, heightMapX, 1 do
        local slopelevel = slopeData[row][col]
        local pixelColor = floor(slopelevel * maxvalue)
        local pixelColorNormalized = floor(((slopelevel - minSlope) / slopeDif) * maxvalue)
        imageData[row][col] = pixelColor
        imageDataNormalized[row][col] = pixelColorNormalized
     end
  end
  return imageData, imageDataNormalized
end

function widget:TextCommand(command)
    if (string.find(command, 'exportheightmapraw') == 1) then
      local imageData = GetHeightMapImage(16)
      local filename = (string.lower(string.gsub(Game.mapName, ".smf", "_")) .. "heightmap.raw")
      writeRAW(imageData, filename)
    end
    if (string.find(command, 'exportheightmapppm') == 1) then
      local imageData = GetHeightMapImage(16)
      local filename = (string.lower(string.gsub(Game.mapName, ".smf", "_")) .. "heightmap.pgm")
      writePPM(imageData, filename)
   end
   if (string.find(command, 'exportheightmaptxt') == 1) then
      local imageData = GetHeightMapImage(8)
      local filename = (string.lower(string.gsub(Game.mapName, ".smf", "_")) .. "heightmap.txt")
      writeTXT(imageData, filename)
   end
   if (string.find(command, 'exportslopemapppm') == 1) then
      local imageData, imageDataNormalized = GetSlopeMapImage(16)
      local filename = (string.lower(string.gsub(Game.mapName, ".smf", "_")) .. "slopemap.pgm")
      writePPM(imageData, filename)
      filename = (string.lower(string.gsub(Game.mapName, ".smf", "_")) .. "slopemap-normalized.pgm")
      writePPM(imageDataNormalized, filename)
   end
   if (string.find(command, 'exportslopemapraw') == 1) then
      local imageData, imageDataNormalized = GetSlopeMapImage(16)
      local filename = (string.lower(string.gsub(Game.mapName, ".smf", "_")) .. "slopemap.raw")
      writeRAW(imageData, filename)
      filename = (string.lower(string.gsub(Game.mapName, ".smf", "_")) .. "slopemap-normalized.raw")
      writeRAW(imageDataNormalized, filename)
   end
  if (string.find(command, 'exportslopemaptxt') == 1) then
      local imageData, imageDataNormalized = GetSlopeMapImage(8)
      local filename = (string.lower(string.gsub(Game.mapName, ".smf", "_")) .. "slopemap.txt")
      writeTXT(imageData, filename)
      filename = (string.lower(string.gsub(Game.mapName, ".smf", "_")) .. "slopemap-normalized.txt")
      writeTXT(imageDataNormalized, filename)
   end

end




--------------------------------------------------------------------------------
--------------------------------------------------------------------------------