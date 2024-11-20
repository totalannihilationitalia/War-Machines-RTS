--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    snd_volume.lua
--  brief:   volume_master control slider
--  author:  Dave Rodgers
--
--  Copyright (C) 2007.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "SoundVolume",
    desc      = "A sound volume_master slider  (only works in game)",
    author    = "trepan",
    date      = "Jan 15, 2007",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = false  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--fixed to work with 0.79.1 by very_bad_soldier
--fixed to work with 0.76b1 by very_bad_soldier
--rev 1 by molix 20/11/2024 
--		only sx button mouse can select soundbar
-- 		extended sound options (like music, battle, icon of menù


local TEST_SOUND = LUAUI_DIRNAME .. 'Sounds/pop.wav'

local function PlayTestSound()
  Spring.PlaySoundFile(TEST_SOUND, 1.0)
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local volume_master = 1.0

local vsx, vsy = widgetHandler:GetViewSizes()

local xmin = 200 -- parte dalla sinistra dello schermo
local ymin = 650 -- parte dal basso dello schermo
local larghezza_barre =  200
local altezza_barre = 10
local xmax = xmin + larghezza_barre
local ymax = ymin + altezza_barre
local main_background				= "LuaUI/Images/menu/sfondo_sound.png"
local posx_menu = 300 -- da sinistra
local posy_menu = 300 -- dal basso
local altezza_menu = 140
local larghezza_menu = 400
local margine_barre_sx = 150 -- il margine sinistro delle barre dal background
local margine_barre_giu = 20 -- il margine sotto delle barre dal background
local interasse_righe = 20 -- distanza tra le righe
--local xmin, xmax, ymin, ymax

--[[
local function UpdateGeometry() -- aggiorno geometria
  xmin = math.floor(vsx * 0.205)
  xmax = math.floor(vsx * 0.22)
  ymin = math.floor(vsy * 10) --0.975
  ymax = math.floor(vsy * 11) --0.997
end
UpdateGeometry()


function widget:ViewResize(viewSizeX, viewSizeY) -- quando si modifica la dimensione della finestra di spring, prelevane larghezza e altezza e fai partire la funzione "aggiorno geometria"
  vsx = viewSizeX
  vsy = viewSizeY
  UpdateGeometry()
end
]]--

--------------------------------------------------------------------------------

local function Calcvolume_master(x)
  -- volume_master = (x - xmin) / (xmax - xmin) -- è diventato:
  volume_master = (x - (posx_menu + margine_barre_sx)) / ((posx_menu + margine_barre_sx+ larghezza_barre) - (posx_menu + margine_barre_sx))
  if (volume_master > 100) then
    volume_master = 1
  elseif (volume_master < 0) then
    volume_master = 0
  end
end


function widget:Initialize()
  volume_master = Spring.GetConfigInt("snd_volmaster", 60)
  volume_master = volume_master * 0.01
end


function widget:IsAbove(x, y) -- se il mouse è sopra.....
  return ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu) and (y <= posy_menu +margine_barre_giu + altezza_barre)) -- ....il primo "quadrato" di selezione, definisco se il mouse si trova dentro le coordinate "x min",  "x max", "ymin" e "ymax" di un quadrato immaginario che fungerà da selezione
  or 
  ((x >= xmin) and (x <= xmax) and (y >= ymin+20) and (y <= ymax+20)) -- .... il secondo "quadrato" di selezione .. etc, cosi da definire più selettori
end


function widget:GetTooltip(x, y) -- modificare con le condizioni dei quadrati
  if (Spring.GetGameSeconds() < 0.1) then
    return "Sound Options  (only works in game)"
  else
    return "Sound Options"
  end
end


function widget:MousePress(x, y, button)
  if (Spring.GetGameSeconds() < 0.1) then
    return false
  end
  if button== 1 then -- aggiunto rev1
  if (widget:IsAbove(x, y)) then
	if ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu) and (y <= posy_menu +margine_barre_giu + altezza_barre))  then --se è sopra  il primo "quadrato" di selezione esegui le modifiche al volume_master
    Calcvolume_master(x)
	Spring.SetConfigInt("snd_volmaster", volume_master * 100)
	
	volume_master = Spring.GetConfigInt("snd_volmaster", volume_master)

	volume_master = volume_master * 0.01
  
    return true
	end
  end
  end-- aggiunto rev1
  return false
end


function widget:MouseMove(x, y, dx, dy, button)
  if button == 1 then -- aggiunto rev1
  Calcvolume_master(x)
  Spring.SetConfigInt("snd_volmaster", volume_master * 100)
  return
  end -- aggiunto rev1
end


function widget:MouseRelease(x, y, button)
  if button == 1 then -- aggiunto rev1
  Calcvolume_master(x)
  Spring.SetConfigInt("snd_volmaster", volume_master * 100)
  PlayTestSound()
  return -1
  end
end


function widget:DrawScreen()
  -- fade before the game starts  ("volume_master" command is not available)
  local alpha = (Spring.GetGameSeconds() < 0.1) and 0.2 or 0.9
--  local xvol = xmin + volume_master * (xmax - xmin) -- sostituito da:
	local xvol = (posx_menu + margine_barre_sx) + (volume_master * ((posx_menu + margine_barre_sx +larghezza_barre) - (posx_menu + margine_barre_sx)))
  -- green/red level indicator
  gl.ShadeModel(GL.FLAT)
  gl.Color(.3, .3, .3)
    -- inserisco lo sfondo
 	gl.Color(1,1,1,1)
	gl.Texture(main_background)	-- aggiungo l'immagine di sfondo --rev1
	gl.TexRect(	posx_menu,posy_menu,posx_menu+larghezza_menu,posy_menu+altezza_menu)	
	gl.Texture(false)	-- fine texture	
--
-- VOLUME MASTER
--
-- disegno il rettangolo di sfondo della linea di selezione volume master
    gl.Shape(GL.QUAD_STRIP, {
    { v = { posx_menu + margine_barre_sx, posy_menu + margine_barre_giu },c = { 1, 0, 0, alpha } }, -- basso sx = posizione del background + margine
    { v = { posx_menu + margine_barre_sx +larghezza_barre, posy_menu + margine_barre_giu } }, -- basso dx =  posizione del background + margine + larghezza della barra
    { v = { posx_menu + margine_barre_sx, posy_menu +margine_barre_giu + altezza_barre } }, --xvol -- alto sx 
    { v = { posx_menu + margine_barre_sx +larghezza_barre, posy_menu +margine_barre_giu + altezza_barre } }, -- alto dx
  })
  
	-- disegno la linea che definisce il volume master
    gl.Shape(GL.QUAD_STRIP, {
    { v = { posx_menu + margine_barre_sx, posy_menu + margine_barre_giu },c = { 0, 1, 0, alpha } }, -- basso sx = posizione del background + margine
    { v = { xvol, posy_menu + margine_barre_giu } }, -- basso dx =  posizione del background + margine + larghezza della barra
    { v = { posx_menu + margine_barre_sx, posy_menu +margine_barre_giu + altezza_barre } }, --xvol -- alto sx 
    { v = { xvol, posy_menu +margine_barre_giu + altezza_barre } }, -- alto dx
  })


--
-- VOLUME MUSIC
--
-- disegno il rettangolo di sfondo della linea di selezione volume MUSIC
    gl.Shape(GL.QUAD_STRIP, {
    { v = { posx_menu + margine_barre_sx, posy_menu + margine_barre_giu + interasse_righe*1},c = { 1, 0, 0, alpha } }, -- basso sx = posizione del background + margine
    { v = { posx_menu + margine_barre_sx +larghezza_barre, posy_menu + margine_barre_giu +interasse_righe*1 } }, -- basso dx =  posizione del background + margine + larghezza della barra
    { v = { posx_menu + margine_barre_sx, posy_menu +margine_barre_giu + altezza_barre+interasse_righe*1 } }, --xvol -- alto sx 
    { v = { posx_menu + margine_barre_sx +larghezza_barre, posy_menu +margine_barre_giu + altezza_barre +interasse_righe *1} }, -- alto dx
  })
  
	-- disegno la linea che definisce il volume MUSIC ############################# finire di qui
    gl.Shape(GL.QUAD_STRIP, {
    { v = { posx_menu + margine_barre_sx, posy_menu + margine_barre_giu },c = { 0, 1, 0, alpha } }, -- basso sx = posizione del background + margine
    { v = { xvol, posy_menu + margine_barre_giu } }, -- basso dx =  posizione del background + margine + larghezza della barra
    { v = { posx_menu + margine_barre_sx, posy_menu +margine_barre_giu + altezza_barre } }, --xvol -- alto sx 
    { v = { xvol, posy_menu +margine_barre_giu + altezza_barre } }, -- alto dx
  })


  
  
  
  
  gl.ShadeModel(GL.SMOOTH)
  -- outline
 -- gl.Color(0, 0, 0, alpha)
 -- gl.Shape(GL.LINE_LOOP, {
  --  { v = { xmin - 0.5, ymin - 0.5 } },
   -- { v = { xmax + 0.5, ymin - 0.5 } },
  --  { v = { xmax + 0.5, ymax + 0.5 } },
  --  { v = { xmin - 0.5, ymax + 0.5 } },
 -- })
 -- gl.Color(1, 1, 1, alpha)
 -- gl.Shape(GL.LINE_LOOP, {
 --   { v = { xmin - 1.5, ymin - 1.5 } },
  --  { v = { xmax + 1.5, ymin - 1.5 } },
  --  { v = { xmax + 1.5, ymax + 1.5 } },
 --   { v = { xmin - 1.5, ymax + 1.5 } },
 -- })
  -- header
  gl.Text(string.format("%i%%", 100 * volume_master),
                        0.5 * (xmin + xmax), ymax + 4, 12, "ocn")
  return
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
