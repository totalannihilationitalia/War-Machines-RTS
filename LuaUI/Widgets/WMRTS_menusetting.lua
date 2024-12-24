--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_mainmenu.lua
--  brief:   War Machines RTS options mainmenu
--  author:  Dario Molinaroli ( Molixx81 )
--
--  Copyright (C) 2024.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "WMRTS_menusetting",
    desc      = "Setting the WMRTS menu",
    author    = "molixx81",
    date      = "24 Dicember, 2024",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = false -- false at the moment, under test 
  }
end

--------------------------------------------------------------------------------
--[[
to do list 
-- pulsanti piccoli / grossi del minimenu
-- Le immagini dei comandanti di fianco al menu principale (on/off)
-- Configurazione del widget IDLE (mostra zzzzZZZ sulle unità idle? ) 
-- Mostra wind/tidal/los/snd ecc button? -- puoi mostrare o no i singoli pulsanti del minimenu
]]--
--------------------------------------------------------------------------------
-- rev 0 by molix
-- designing WMRTS main-menù
