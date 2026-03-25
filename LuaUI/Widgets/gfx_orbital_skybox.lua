function widget:GetInfo()
  return {
    name      = "Orbital Sky Override",
    desc      = "Skybox rotante ottimizzata per limite 8000",
    author    = "Dario",
    layer     = -10000, -- Fondamentale: deve essere disegnato prima del terreno
    enabled   = true
  }
end

-- --- CONFIGURAZIONE ---
-- Prova a togliere .dds se vedi ancora scritte bianche
local skyTexture = "maps/eveningsky.dds" 
local rotationSpeed = 0.5
local s = 7000 -- Stiamo sotto il limite di 8000
-- ----------------------

local angle = 0

function widget:Initialize()
    Spring.SendCommands("sky 0")
    Spring.SendCommands("dynamicsky 0")
    Spring.SendCommands("clouds 0")
end

function widget:Shutdown()
    Spring.SendCommands("sky 1")
    Spring.SendCommands("dynamicsky 1")
end

function widget:DrawWorld()
    angle = (os.clock() * rotationSpeed) % 360
    local x, y, z = Spring.GetCameraPosition()

    -- TRUCCO DELLA PROFONDITÀ
    gl.DepthTest(false) -- Dice: "Non controllare se c'è qualcosa davanti"
    gl.DepthMask(false) -- Dice: "Non scrivere la posizione di questo cubo nel buffer"
    
    -- CARICAMENTO TEXTURE
    -- Se vedi scritte bianche, il motore non trova il file. 
    -- Proviamo a usare "$sky" se il file specifico fallisce.
    if not gl.Texture(skyTexture) then
        gl.Texture("$sky")
    end
    
    gl.Color(1, 1, 1, 1)

    gl.PushMatrix()
        gl.Translate(x, y, z)
        gl.Rotate(angle, 0, 1, 0)
        
        -- Disegniamo il cubo
        -- Se la texture è un DDS Cubemap, dobbiamo usare coordinate 3D (-1, 1)
        gl.BeginEnd(GL.QUADS, function()
            -- Le coordinate TexCoord 3D sono necessarie per i file .dds cubemap di Spring
            -- Front
            gl.TexCoord(-1,-1, 1) gl.Vertex(-s,-s, s)
            gl.TexCoord( 1,-1, 1) gl.Vertex( s,-s, s)
            gl.TexCoord( 1, 1, 1) gl.Vertex( s, s, s)
            gl.TexCoord(-1, 1, 1) gl.Vertex(-s, s, s)
            -- Back
            gl.TexCoord( 1,-1,-1) gl.Vertex( s,-s,-s)
            gl.TexCoord(-1,-1,-1) gl.Vertex(-s,-s,-s)
            gl.TexCoord(-1, 1,-1) gl.Vertex(-s, s,-s)
            gl.TexCoord( 1, 1,-1) gl.Vertex( s, s,-s)
            -- Right
            gl.TexCoord( 1,-1, 1) gl.Vertex( s,-s, s)
            gl.TexCoord( 1,-1,-1) gl.Vertex( s,-s,-s)
            gl.TexCoord( 1, 1,-1) gl.Vertex( s, s,-s)
            gl.TexCoord( 1, 1, 1) gl.Vertex( s, s, s)
            -- Left
            gl.TexCoord(-1,-1,-1) gl.Vertex(-s,-s,-s)
            gl.TexCoord(-1,-1, 1) gl.Vertex(-s,-s, s)
            gl.TexCoord(-1, 1, 1) gl.Vertex(-s, s, s)
            gl.TexCoord(-1, 1,-1) gl.Vertex(-s, s,-s)
            -- Top
            gl.TexCoord(-1, 1, 1) gl.Vertex(-s, s, s)
            gl.TexCoord( 1, 1, 1) gl.Vertex( s, s, s)
            gl.TexCoord( 1, 1,-1) gl.Vertex( s, s,-s)
            gl.TexCoord(-1, 1,-1) gl.Vertex(-s, s,-s)
            -- Bottom
            gl.TexCoord(-1,-1,-1) gl.Vertex(-s,-s,-s)
            gl.TexCoord( 1,-1,-1) gl.Vertex( s,-s,-s)
            gl.TexCoord( 1,-1, 1) gl.Vertex( s,-s, s)
            gl.TexCoord(-1,-1, 1) gl.Vertex(-s,-s, s)
        end)
    gl.PopMatrix()
    
    gl.Texture(false)
    -- RIPRISTINO (Fondamentale altrimenti il terreno sparisce!)
    gl.DepthMask(true)
    gl.DepthTest(true)
end