return {
  ["building_destruction_heavy"] = {
      useDefaultExplosions = true, 
    -- 1. BAGLIORE AL SUOLO 
    groundflash = {
      circleAlpha = 0.6,
      circleGrowth = 12,    -- Aumentato da 8
      flashAlpha = 1.0,
      flashSize = 180,      -- Raddoppiato da 90
      ttl = 25,             -- Dura di più
      color = {1, 0.4, 0.1}, -- Arancione più vivo
    },
    
    -- 2. DETRITI/MACERIE (Più veloci e numerosi)
    detriti_macerie = {
      class = "CExpGenSpawner",
      params = {
        damage = 100,
        explosionGenerator = "custom:debris_particle", 
        pos = [[0, 50, 0]],
        delay = [[i*0.5]],
        copyVelocity = true,
        number = 40,         -- Più pezzi
        -- Velocità aumentata e resa più casuale verso l'alto (v*8) e lateralmente
        speed = [[-10 + rand()*20, 10 + rand()*15, -10 + rand()*20]],
      },
    },
    
    -- 3. FUMO DENSO (Nero/Grigio che sale verso l'alto)
    fumo_nero = {
      class = "CSimpleParticleSystem",
      params = {
        allowDaylight = true,
        airResist = 0.1,
        angle = 40,
        count = 1,
        delay = 0,
        duration = 30,
        emissionRate = 2,
        gravity = {0, 0.1, 0}, -- Il fumo sale lentamente
        numParticles = 25,
        particleLife = 120,   -- Il fumo resta a lungo
        particleLifeSpread = 40,
        particleSize = 15,    -- Grandezza particella
        particleSizeSpread = 25, -- Si espande molto
        particleSpeed = 4,
        particleSpeedSpread = 2,
        pos = {0, 50, 0},
        texture = "smoke",    -- texture 'smoke'
        colorMap = {0.1, 0.1, 0.1, 0.8}, -- Sfuma da nero a grigio a trasparente
      },
    },

    -- 4. POLVERE DI CROLLO (Espansione orizzontale alla base)
    polvere_base = {
      class = "CSimpleParticleSystem",
      params = {
        airResist = 0.2,
        angle = 90,
        count = 1,
        numParticles = 30,
        particleLife = 80,
        particleLifeSpread = 30,
        particleSize = 10,
        particleSizeSpread = 30,
        particleSpeed = 12,
        particleSpeedSpread = 6,
        pos = {0, 50, 0},
        texture = "dirt", 
        gravity = {0, -0.05, 0},
        colorMap = {0.5, 0.4, 0.3, 0.6}, -- Colore terra/cemento
      },
    },

    -- 5. FIAMMATA CENTRALE (Opzionale, per il "core" dell'esplosione)
    fiammata = {
      class = "CSimpleParticleSystem",
      params = {
        airResist = 0.1,
        angle = 180,
        count = 1,
        numParticles = 10,
        particleLife = 15,
        particleLifeSpread = 10,
        particleSize = 20,
        particleSizeSpread = 40,
        particleSpeed = 5,
        particleSpeedSpread = 5,
        pos = {0, 50, 0},
        texture = "GenericExplosion", -- O una texture simile a una palla di fuoco
        colorMap = {1, 1, 0.8, 1},
      },
    },
  },
  ["debris_particle"] = {
    -- Il pezzetto di roccia/cemento
    maceria_fisica = {
      class = "CSimpleParticleSystem",
      params = {
        airResist = 0.02,
        angle = 80,
        count = 1,
        numParticles = 1,
        particleLife = 50,
        particleSize = 4,
        particleSizeSpread = 4,
        particleSpeed = 2,
        particleSpeedSpread = 1,
        pos = {0, 50, 0},
        texture = "dirt", -- texture del detrito
        colorMap = {0.3, 0.3, 0.3, 1}, 
      },
    },
    -- Una piccola scia di polvere che segue il detrito
    scia = {
      class = "CSimpleParticleSystem",
      params = {
        airResist = 0.1,
        count = 1,
        numParticles = 1,
        particleLife = 20,
        particleSize = 2,
        particleSizeSpread = 8,
        particleSpeed = 0,
        pos = {0, 0, 0},
        texture = "smoke",
        colorMap = {0.5, 0.5, 0.5, 0.5},
      },
    },
  },
}  
