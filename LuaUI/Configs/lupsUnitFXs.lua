-- note that the order of the MergeTable args matters for nested tables (such as colormaps)!

local presets = {
	commandAuraRed = {
		{class='StaticParticles', options=commandCoronaRed},
		{class='GroundFlash', options=MergeTable(groundFlashRed, {radiusFactor=3.5,mobile=true,life=60,
			colormap={ {1, 0.2, 0.2, 1},{1, 0.2, 0.2, 0.85},{1, 0.2, 0.2, 1} }})},
	},
	commandAuraOrange = {
	    {class='StaticParticles', options=commandCoronaOrange},
		{class='GroundFlash', options=MergeTable(groundFlashOrange, {radiusFactor=3.5,mobile=true,life=math.huge,
			colormap={ {0.8, 0, 0.2, 1},{0.8, 0, 0.2, 0.85},{0.8, 0, 0.2, 1} }})},
	},
	commandAuraGreen = {
		{class='StaticParticles', options=commandCoronaGreen},
		{class='GroundFlash', options=MergeTable(groundFlashGreen, {radiusFactor=3.5,mobile=true,life=math.huge,
			colormap={ {0.2, 1, 0.2, 1},{0.2, 1, 0.2, 0.85},{0.2, 1, 0.2, 1} }})},
	},
	commandAuraBlue = {
		{class='StaticParticles', options=commandCoronaBlue},
		{class='GroundFlash', options=MergeTable(groundFlashBlue, {radiusFactor=3.5,mobile=true,life=math.huge,
			colormap={ {0.2, 0.2, 1, 1},{0.2, 0.2, 1, 0.85},{0.2, 0.2, 1, 1} }})},
	},	
	commandAuraViolet = {
		{class='StaticParticles', options=commandCoronaViolet},
		{class='GroundFlash', options=MergeTable(groundFlashViolet, {radiusFactor=3.5,mobile=true,life=math.huge,
			colormap={ {0.8, 0, 0.8, 1},{0.8, 0, 0.8, 0.85},{0.8, 0, 0.8, 1} }})},
	},	
	
	commAreaShield = {
		{class='ShieldJitter', options={delay=0, life=math.huge, heightFactor = 0.75, size=350, strength = .001, precision=50, repeatEffect=true, quality=4}},
	},
	
	commandShieldRed = {
		{class='ShieldSphere', options=MergeTable({colormap1 = {{1, 0.1, 0.1, 0.6}}, colormap2 = {{1, 0.1, 0.1, 0.15}}}, commandShieldSphere)},
--		{class='StaticParticles', options=commandCoronaRed},
--		{class='GroundFlash', options=MergeTable(groundFlashRed, {radiusFactor=3.5,mobile=true,life=60,
--			colormap={ {1, 0.2, 0.2, 1},{1, 0.2, 0.2, 0.85},{1, 0.2, 0.2, 1} }})},	
	},
	commandShieldOrange = {
		{class='ShieldSphere', options=MergeTable({colormap1 = {{0.8, 0.3, 0.1, 0.6}}, colormap2 = {{0.8, 0.3, 0.1, 0.15}}}, commandShieldSphere)},
	},	
	commandShieldGreen = {
		{class='ShieldSphere', options=MergeTable({colormap1 = {{0.1, 1, 0.1, 0.6}}, colormap2 = {{0.1, 1, 0.1, 0.15}}}, commandShieldSphere)},
	},
	commandShieldBlue= {
		{class='ShieldSphere', options=MergeTable({colormap1 = {{0.1, 0.1, 0.8, 0.6}}, colormap2 = {{0.1, 0.1, 1, 0.15}}}, commandShieldSphere)},
	},	
	commandShieldViolet = {
		{class='ShieldSphere', options=MergeTable({colormap1 = {{0.6, 0.1, 0.75, 0.6}}, colormap2 = {{0.6, 0.1, 0.75, 0.15}}}, commandShieldSphere)},
	},	
}

effectUnitDefs = {
  --// FUSIONS //--------------------------
  cafus = {
    {class='Bursts', options=cafusBursts},
    {class='StaticParticles', options=cafusCorona},
    --{class='ShieldSphere', options=cafusShieldSphere},
    --{class='ShieldJitter', options={layer=-16, life=math.huge, pos={0,58.9,0}, size=100, precision=22, strength = 0.001, repeatEffect=true}},
    {class='GroundFlash', options=groundFlashOrange},
  },
  corfus = {
    {class='StaticParticles', options=corfusNova},
    {class='StaticParticles', options=corfusNova2},
    {class='StaticParticles', options=corfusNova3},
    {class='StaticParticles', options=corfusNova4},

    {class='Bursts', options=corfusBursts},
    {class='ShieldJitter', options={delay=0,life=math.huge, pos={0,40.5,0.0}, size=10, precision=22, repeatEffect=true}},
  },
  aafus = {
    {class='Bursts', options=icufusBurstssx},
    {class='Bursts', options=icufusBurstsdx},
    {class='SimpleParticles2', options=MergeTable({piece="elettro1", delay=30, lifeSpread=math.random()*20},sparks)},
    {class='SimpleParticles2', options=MergeTable({piece="elettro1", delay=60, lifeSpread=math.random()*20},sparks)},
-- aggiungere sfere come originale
{class='ShieldSphere', options=aafusShieldSpheresx},
{class='ShieldSphere', options=aafusShieldSpheredx},

-- rimuovo i suoni    {class='Sound', options={repeatEffect=true, file="Sparks", blockfor=4.8*30, length=5.1*30}},
  },

  --// SHIELDS //---------------------------
  -- Don't raise strength of ShieldJitter recklessly, it can really distort things (including unit icons) under it!
--  corjamt = {
--   {class='Bursts', options=corjamtBursts},
--    {class='ShieldSphere', options={life=math.huge, piece="glow", size=11, colormap1 = {{0.8, 0.1, 0.8, 0.5}}, repeatEffect=true}},
--	{class='ShieldJitter', options={delay=0, life=math.huge, pos={0,15,0}, size=350, strength = .001, precision=50, repeatEffect=true, quality = 4}},
--	{class='ShieldSphere', options={piece="base", life=math.huge, size=350, pos={0,-15,0}, colormap1 = {{0.95, 0.1, 0.95, 0.2}}, repeatEffect=true}},
--	{class='GroundFlash', options=groundFlashShield},
--	{class='UnitPieceLight', options={piece="glow", colormap = {{0,0,1,0.2}},},},
--  },
--  core_spectre = {
 --   {class='Bursts', options=corjamtBursts},
--    {class='ShieldSphere', options={piece="glow", life=math.huge, size=11, colormap1 = {{0.95, 0.1, 0.95, 0.9}}, repeatEffect=true}},
--	{class='ShieldJitter', options={delay=0, life=math.huge, pos={0,15,0}, size=350, strength = .001, precision=50, repeatEffect=true, quality = 4}},
--	{class='ShieldSphere', options={piece="base", life=math.huge, size=360, pos={0,-15,0}, colormap1 = {{0.95, 0.1, 0.95, 0.2}}, repeatEffect=true}},
--  },
--  shieldfelon = {
--	{class='Bursts', options=MergeTable({piece="lpilot"},corjamtBursts)},
--	{class='Bursts', options=MergeTable({piece="rpilot"},corjamtBursts)},
--	--{class='ShieldJitter', options={delay=0, life=math.huge, pos={0,15,0}, size=100, strength = .001, precision=50, repeatEffect=true, quality = 5}},
--  },
  
--  funnelweb = {
--	{class='ShieldJitter', options={delay=0, life=math.huge, pos={0,25,-10}, size=400, strength = .002, precision=50, repeatEffect=true, quality = 4}},
--	{class='Bursts', options=MergeTable(corjamtBursts, {piece="emitl"})},
--		{class='Bursts', options=MergeTable(corjamtBursts, {piece="emitr"})},
  --  {class='ShieldSphere', options={piece="emitl", life=math.huge, size=11, colormap1 = {{0.95, 0.1, 0.95, 0.9}}, repeatEffect=true}},
--    {class='ShieldSphere', options={piece="emitr", life=math.huge, size=11, colormap1 = {{0.95, 0.1, 0.95, 0.9}}, repeatEffect=true}},
--  },

  --// ENERGY STORAGE //--------------------
  corestor = {
    {class='GroundFlash', options=groundFlashCorestor},
  },
  icuestor = {
    {class='GroundFlash', options=groundFlashArmestor},
  },

  --// FACTORIES //----------------------------
--  factoryship = {
--  	{class='StaticParticles', options=MergeTable(blinkyLightRed, {piece="flash01"}) },
--	{class='StaticParticles', options=MergeTable(blinkyLightGreen, {piece="flash03", delay = 20,}) },
--	{class='StaticParticles', options=MergeTable(blinkyLightBlue, {piece="flash05", delay = 40,}) },	
--  },

  --// PYLONS // ----------------------------------
--  mexpylon = {
--    {class='GroundFlash', options=groundFlashCorestor},
--  },

  --// OTHER
--  roost = {
--    {class='SimpleParticles', options=roostDirt},
--    {class='SimpleParticles', options=MergeTable({delay=60},roostDirt)},
--    {class='SimpleParticles', options=MergeTable({delay=120},roostDirt)},
--  },
  
  
--  armrad = {
--    {class='StaticParticles', options=MergeTable(blinkyLightWhite,{piece="point"})},
    --{class='StaticParticles', options=MergeTable(blinkyLightBlue,{piece="point", delay=15})},
--  },  
--  corarad = {
--    {class='StaticParticles', options=radarBlink},
--    {class='StaticParticles', options=MergeTable(radarBlink,{pos={-1.6,25,0.0},delay=15})},
--    {class='StaticParticles', options=MergeTable(radarBlink,{pos={0,21,-1.0},delay=30})},
--  },
--  corrad = {
--    {class='StaticParticles', options=MergeTable(radarBlink,{piece="head"})},
 --   {class='StaticParticles', options=MergeTable(radarBlink,{piece="head", delay=15})},
--  },

--  armcrabe = {
--	{class='StaticParticles', options=MergeTable(blinkyLightWhite, {piece="blight"}) },
--  },   
--  corcan = {
	--{class='StaticParticles', options=MergeTable(jackGlow, {piece="point"}) },
--  },  
  
--  spherepole = {
--    {class='Ribbon', options={color={.3,.3,01,1}, width=5.5, piece="blade", onActive=false}},
--  },
  
--  pw_warpgate = {
--    {class='StaticParticles', options=warpgateCorona},
--    {class='GroundFlash', options=groundFlashOrange},
--  },

--  zenith = {
--    {class='StaticParticles', options=zenithCorona},
--  },    

--  amphtele = {
--	{class='ShieldSphere', options=MergeTable(teleShieldSphere, {piece="sphere"})},
--	{class='StaticParticles', options=MergeTable(teleCorona, {piece="sphere"})},
	--{class='ShieldSphere', options=MergeTable(teleShieldSphere, {piece="sphere", onActive = true, size=18})},
--	{class='StaticParticles', options=MergeTable(teleCorona, {piece="sphere", onActive = true, size=100})},
--	{class='ShieldJitter', options={delay=0, life=math.huge, piece="sphere", size=50, strength = .005, precision=50, repeatEffect=true, onActive=true}},
--  },
	
--  tele_beacon = {
--	{class='ShieldSphere', options=MergeTable(teleShieldSphere, {piece="sphere"})},
--	{class='StaticParticles', options=MergeTable(teleCorona, {piece="sphere"})},
--	{class='StaticParticles', options=MergeTable(teleCorona, {piece="sphere", onActive = true, size=50})},
--	{class='ShieldJitter', options={delay=0, life=math.huge, piece="sphere", size=30, strength = .005, precision=50, repeatEffect=true, onActive=true}},	
--  },
  
--  armbanth = {
--	{class='StaticParticles', options=MergeTable(blinkyLightBlue, {piece="light", delay = 20, size = 25}) },
--  },
  
--  armorco = {
--	{class='StaticParticles', options=MergeTable(blinkyLightGreen, {piece="light", delay = 20, size = 30}) },
--  },
---------------------------
---------------------------
---------------------------
-- SISTEMARE AEREI
---------------------------
---------------------------
---------------------------
  -- length tag does nothing
  --// PLANES //----------------------------
  armcybr = {
    {class='AirJet', options={color={0.2,0.2,1.0}, width=3.5, length=30, piece="thrust1", onActive=true}},
    {class='AirJet', options={color={0.2,0.2,1.0}, width=3.5, length=30, piece="thrust2", onActive=true}},
   }, 
--colore alien
--    {class='AirJet', options={color={0.4,0.1,0.8}, width=3.5, length=30, piece="thrust1", onActive=true}}, 
--    {class='AirJet', options={color={0.4,0.1,0.8}, width=3.5, length=30, piece="thrust2", onActive=true}},

  armhawk = {
    {class='AirJet', options={color={0.2,0.2,1.0}, width=2.8, length=25, piece="rearthrust", onActive=true}},
--    {class='AirJet', options={color={0.2,0.2,1.0}, width=2.8, length=25, piece="enginer", onActive=true}},
--    {class='Ribbon', options={width=1, size=12, piece="rearthrust"}},
--    {class='Ribbon', options={width=1, size=12, piece="wingtip2"}},
  },
-- sistemare
  armbrawl = {
    {class='AirJet', options={color={0.0,0.5,1.0}, width=5, length=15, piece="thrust1", onActive=true}},
    {class='AirJet', options={color={0.0,0.5,1.0}, width=5, length=15, piece="thrust2", onActive=true}},
--    {class='AirJet', options={color={0.0,0.5,1.0}, width=2.5, length=10, piece="lrjet", onActive=true}},
--    {class='AirJet', options={color={0.0,0.5,1.0}, width=2.5, length=10, piece="rrjet", onActive=true}},
  },
  armawac = {
{class='AirJet', options={color={0.2,0.2,1.0}, width=2.8, length=25, piece="thrust", onActive=true}},
--    {class='Ribbon', options={color={.3,.3,01,1}, width=5.5, piece="rjet"}},
--    {class='Ribbon', options={color={.3,.3,01,1}, width=5.5, piece="ljet"}},
  },
   bladew = {
 --   {class='Ribbon', options={width=1, size=5, piece="ljet"}},
  --  {class='Ribbon', options={width=1, size=5, piece="rjet"}},  
    {class='AirJet', options={color={0.1,0.4,0.6}, width=3, length=14, piece="thrust", onActive=true
}},
  },

  armkam = {
    {class='Ribbon', options={width=1, size=10, piece="lflare"}},
    {class='Ribbon', options={width=1, size=10, piece="rflare"}},  
    {class='AirJet', options={color={0.1,0.4,0.6}, width=4, length=25, piece="rflare", onActive=true}},
    {class='AirJet', options={color={0.1,0.4,0.6}, width=4, length=25, piece="lflare", onActive=true}},
  },
    corshad = {
    {class='AirJet', options={color={0.9,0.2,0.2}, width=4, length=30, piece="thrusta1", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet', options={color={0.9,0.2,0.2}, width=4, length=30, piece="thrusta2", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='Ribbon', options={width=1, piece="ribbon1"}},
    {class='Ribbon', options={width=1, piece="ribbon2"}},
	--{class='StaticParticles', options=MergeTable(blinkyLightRed, {piece="wingtipl"}) },
	--{class='StaticParticles', options=MergeTable(blinkyLightGreen, {piece="wingtipr"}) },
  },
  armfig = {
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="rearthrust", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
   -- {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="nozzle2", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='Ribbon', options={width=1, piece="ribbon1"}},
    {class='Ribbon', options={width=1, piece="ribbon2"}},
  },
  armflyk = {
    {class='Ribbon', options={width=1, piece="ribbon1"}},
  },
  corape = {
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=22, piece="thrustb2", onActive=true}},
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=22, piece="thrustb1", onActive=true}},
  },
  corhurc = {
    {class='AirJet', options={color={0.7,0.3,0.1}, width=5, length=40, piece="thrust", onActive=true}},
 --   {class='Ribbon', options={width=1, piece="wingtipl"}},
 --   {class='Ribbon', options={width=1, piece="wingtipr"}},
--	{class='StaticParticles', options=MergeTable(blinkyLightRed, {piece="wingtipr"}) },
--	{class='StaticParticles', options=MergeTable(blinkyLightGreen, {piece="wingtipl"}) },	
  },
  corvamp = {
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrustb", onActive=true}},
--    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust2", onActive=true}},
--    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust3", onActive=true}},
    {class='Ribbon', options={width=1, size=8, piece="thrusta1"}},
    {class='Ribbon', options={width=1, size=8, piece="thrusta2"}},
  },
  corvalk = {
    {class='AirJet', options={color={0.2,0.4,0.8}, width=3.5, length=22, piece="thrust", onActive=true}},
    {class='ShieldSphere', options=MergeTable(valkShieldSphere, {piece="thrust1", onActive=true})},
    {class='StaticParticles', options=MergeTable(valkCorona, {piece="thrust1", onActive=true})},
    {class='ShieldSphere', options=MergeTable(valkShieldSphere, {piece="thrust2", onActive=true})},
    {class='StaticParticles', options=MergeTable(valkCorona, {piece="thrust2", onActive=true})},
    {class='ShieldSphere', options=MergeTable(valkShieldSphere, {piece="thrust3", onActive=true})},
    {class='StaticParticles', options=MergeTable(valkCorona, {piece="thrust3", onActive=true})},
    {class='ShieldSphere', options=MergeTable(valkShieldSphere, {piece="thrust4", onActive=true})},
    {class='StaticParticles', options=MergeTable(valkCorona, {piece="thrust4", onActive=true})},
  },
armatlas = {
    {class='AirJet', options={color={0.2,0.4,0.8}, width=3.5, length=22, piece="thrust", onActive=true}},
    {class='ShieldSphere', options=MergeTable(valkShieldSphere, {piece="jet1", onActive=true})},
    {class='StaticParticles', options=MergeTable(valkCorona, {piece="jet1", onActive=true})},
    {class='ShieldSphere', options=MergeTable(valkShieldSphere, {piece="jet2", onActive=true})},
    {class='StaticParticles', options=MergeTable(valkCorona, {piece="jet2", onActive=true})},
    {class='ShieldSphere', options=MergeTable(valkShieldSphere, {piece="jet3", onActive=true})},
    {class='StaticParticles', options=MergeTable(valkCorona, {piece="jet3", onActive=true})},
     }, 
 armdfly = {
    {class='AirJet', options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="jet1", onActive=true}},	
{class='AirJet', options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="jet2", onActive=true}},	

  },
 blade = {
    {class='AirJet', options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="thrust2", onActive=true}},
{class='AirJet', options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="thrust3", onActive=true}},	
  },


 armaca = {
    {class='AirJet', options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="thrust", onActive=true}},	
  },
armca = {
    {class='AirJet', options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="rearthrust", onActive=true}},	
  },
corca = {
    {class='AirJet', options={color={0.9,0.2,0.2}, width=3.5, length=25, piece="thrusta1", onActive=true}},	
  },
coraca = {
    {class='AirJet', options={color={0.9,0.2,0.2}, width=3.5, length=25, piece="thrustb", onActive=true}},	
  },

corfink = {
    {class='AirJet', options={color={0.9,0.2,0.2}, width=3.5, length=25, piece="thrustb", onActive=true}},	
  },
cortitan = {
    {class='AirJet', options={color={0.9,0.2,0.2}, width=3.5, length=25, piece="thrusta1", onActive=true}},	
  },

corveng = {
    {class='AirJet', options={color={0.9,0.2,0.2}, width=3.5, length=25, piece="thrusta2", onActive=true}},
{class='AirJet', options={color={0.9,0.2,0.2}, width=3.5, length=25, piece="thrusta1", onActive=true}},	
  },


armpnix = {
    {class='AirJet', options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="thrust", onActive=true}},	
  },
armlance = {
    {class='AirJet', options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="thrust", onActive=true}},	
  },

 armpeep = {
    {class='AirJet', options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="thrust", onActive=true}},	
{class='Ribbon', options={width=1, size=8, piece="thrust"}}, 

 },
armthund = {
    {class='AirJet', options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="thrust1", onActive=true, emitVector = {0, 1, 0}}},
    {class='AirJet', options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="thrust2", onActive=true,emitVector = {0, 1, 0}}},	
    {class='AirJet', options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="thrust3", onActive=true,emitVector = {0, 1, 0}}},	
    {class='AirJet', options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="thrust4", onActive=true,emitVector = {0, 1, 0}}},	
	
  },

  corawac = {
    {class='AirJet', options={color={0.9,0.2,0.2}, width=3.5, length=25, piece="thrust", onActive=true}},
   -- {class='Ribbon', options={width=1, size=8, piece="wingtipl"}},
  --  {class='Ribbon', options={width=1, size=8, piece="wingtipr"}},
--	{class='StaticParticles', options=MergeTable(blinkyLightRed, {piece="wingtipr"}) },
--	{class='StaticParticles', options=MergeTable(blinkyLightGreen, {piece="wingtipl"}) },		
  },
  
  corcrw = {
    {class='AirJet', options={color={0.9,0.2,0.2}, width=10, length=20, piece="thrust2", onActive=true}},
    {class='AirJet', options={color={0.9,0.2,0.2}, width=10, length=20, piece="thrust1", onActive=true}},
	{class='ShieldSphere', options=MergeTable(valkShieldSphere, {piece="bladesbottom", onActive=true})},
    {class='StaticParticles', options=MergeTable(valkCorona, {piece="bladesbottom", onActive=true})},
  	  },
  orcl = {
	{class='ShieldSphere', options=MergeTable(ffficuthrust, {piece="thrust", onActive=true})},
	{class='ShieldSphere', options=MergeTable(ffficuthrust, {piece="thrust2", onActive=true})},
	{class='ShieldSphere', options=MergeTable(ffficuthrust, {piece="thrust3", onActive=true})},	
	{class='ShieldSphere', options=MergeTable(ffficuthrust, {piece="thrust4", onActive=true})},		
 	{class='StaticParticles', options=MergeTable(fffCorona, {piece="thrust", onActive=true})},
	{class='StaticParticles', options=MergeTable(fffCorona, {piece="thrust2", onActive=true})},
	{class='StaticParticles', options=MergeTable(fffCorona, {piece="thrust3", onActive=true})},
	{class='StaticParticles', options=MergeTable(fffCorona, {piece="thrust4", onActive=true})},
		},
  demr = {
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thust1", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thust2", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thust3", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thust4", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
  	  },

  taln = {
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust1", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust2", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust3", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
  	  },

  odyc = {
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust1", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust2", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust3", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
  	  },

  ostr = {
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust1", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='ShieldSphere', options=MergeTable(ffficuthrust, {piece="thrust2", onActive=true})},
    {class='StaticParticles', options=MergeTable(fffCorona, {piece="thrust2", onActive=true})},
    {class='ShieldSphere', options=MergeTable(ffficuthrust, {piece="thrust3", onActive=true})},
    {class='StaticParticles', options=MergeTable(fffCorona, {piece="thrust3", onActive=true})},

  	  },


  cirr = {
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust1", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet', options={color={0.6,0.1,0.0}, width=3.5, length=55, piece="thrust2", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
  	  },
  
  
 }

effectUnitDefsXmas = {
 icucom = {
    {class='SantaHat',options={color={1,0.1,0,1}, pos={0,0.5,0.7}, emitVector={0.3,0.7,0.3}, width=5, height=13, ballSize=1.3, piecenum=8, piece="head"}},
  },
 kicucom = {
    {class='SantaHat',options={color={1,0.1,0,1}, pos={0,6,6}, emitVector={0.3,0.7,0.3}, width=5, height=13, ballSize=1.3, piecenum=8, piece="testa"}},
  },
 nfacom = {
    {class='SantaHat',options={color={1,0.1,0,1}, pos={0,0.5,0.7}, emitVector={0.3,0.7,0.3}, width=5, height=13, ballSize=1.3, piecenum=8, piece="head"}},
  },
 knfacom = {
    {class='SantaHat',options={color={1,0.1,0,1}, pos={0,30,26}, emitVector={0.3,0.7,0.3}, width=5, height=13, ballSize=1.3, piecenum=8, piece="testa"}},
  },
}

local levelScale = {
    1,
    1.1,
    1.2,
    1.25,
    1.3,
}

-- load presets from unitdefs
for i=1,#UnitDefs do
	local unitDef = UnitDefs[i]
	
	if unitDef.customParams and unitDef.customParams.commtype then
		local s = levelScale[tonumber(unitDef.customParams.level) or 1]
		if unitDef.customParams.commtype == "1" then
			effectUnitDefsXmas[unitDef.name] = {
				{class='SantaHat', options={color={0,0.7,0,1}, pos={0,4*s,0.35*s}, emitVector={0.3,1,0.2}, width=2.7*s, height=6*s, ballSize=0.7*s, piece="head"}},
			}
		elseif unitDef.customParams.commtype == "2" then
			effectUnitDefsXmas[unitDef.name] = {
				{class='SantaHat', options={pos={0,6*s,2*s}, emitVector={0.4,1,0.2}, width=2.7*s, height=6*s, ballSize=0.7*s, piece="head"}},
			}
		elseif unitDef.customParams.commtype == "3" then 
			effectUnitDefsXmas[unitDef.name] = {
				{class='SantaHat', options={color={0,0.7,0,1}, pos={1.5*s,4*s,0.5*s}, emitVector={0.7,1.6,0.2}, width=2.2*s, height=6*s, ballSize=0.7*s, piece="head"}},
			}
		elseif unitDef.customParams.commtype == "4" then 
			effectUnitDefsXmas[unitDef.name] = {
				{class='SantaHat', options={pos={0,3.8*s,0.35*s}, emitVector={0,1,0}, width=2.7*s, height=6*s, ballSize=0.7*s, piece="head"}},
			}
		elseif unitDef.customParams.commtype == "5" then 
			effectUnitDefsXmas[unitDef.name] = {
				{class='SantaHat', options={color={0,0,0.7,1}, pos={0,0,0}, emitVector={0,1,0.1}, width=2.7*s, height=6*s, ballSize=0.7*s, piece="hat"}},
			}	    
		elseif unitDef.customParams.commtype == "6" then 
			effectUnitDefsXmas[unitDef.name] = {
				{class='SantaHat', options={color={0,0,0.7,1}, pos={0,0,0}, emitVector={0,1,-0.1}, width=4.05*s, height=9*s, ballSize=1.05*s, piece="hat"}},
			}	    
		end
	end
	if unitDef.customParams then
		local fxTableStr = unitDef.customParams.lups_unit_fxs
		if fxTableStr then
			local fxTableFunc = loadstring("return "..fxTableStr)
			local fxTable = fxTableFunc()
			effectUnitDefs[unitDef.name] = effectUnitDefs[unitDef.name] or {}
			for i=1,#fxTable do	-- for each item in preset table
				local toAdd = presets[fxTable[i]]
				for i=1,#toAdd do
					table.insert(effectUnitDefs[unitDef.name],toAdd[i])	-- append to unit's lupsFX table
				end
			end
		end
	end
end
