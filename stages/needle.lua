local assets = {'sky','mountains','ruins1','ruins2','buildings','floor','fg1','fg2'}
local defTime
function onCreate()
	defTime = getPropertyFromClass('ClientPrefs', 'timeBarType')
	setPropertyFromClass('ClientPrefs', 'timeBarType', 'Song Name')
	
	makeLuaSprite('bg','',-screenWidth,-screenHeight)
	makeGraphic('bg',screenWidth,screenHeight,'0F0F0F') scaleObject('bg',9,9)
	addLuaSprite('bg')
	makeLuaSprite('intro','stages/needlemouse/intro1') scaleObject('intro',screenHeight/540,screenHeight/540)
	setObjectCamera('intro', 'other') screenCenter('intro') setProperty('intro.alpha',0)
	addLuaSprite('intro')
	makeLuaSprite('sky','stages/needlemouse/sky',-500,-430) 
	setProperty('sky.antialiasing',false) scaleObject('sky',1.6,1.6) setScrollFactor('sky',0.4,0.4)
	addLuaSprite('sky')
	makeLuaSprite('mountains','stages/needlemouse/mountains',-900,-850) 
	setProperty('mountains.antialiasing',false) scaleObject('mountains',2.1,2.1) setScrollFactor('mountains',0.85,0.85)
	addLuaSprite('mountains')
	makeLuaSprite('ruins1','stages/needlemouse/ruins1',-970,355) 
	setProperty('ruins1.antialiasing',false) scaleObject('ruins1',2.9,2.9) setScrollFactor('ruins1',0.95,1)
	addLuaSprite('ruins1')
	makeLuaSprite('ruins2','stages/needlemouse/ruins2',965,415) 
	setProperty('ruins2.antialiasing',false) scaleObject('ruins2',2.9,2.9) setScrollFactor('ruins2',0.95,1)
	addLuaSprite('ruins2')
	makeLuaSprite('buildings','stages/needlemouse/buildings',-1200,-430) 
	setProperty('buildings.antialiasing',false) scaleObject('buildings',1.7,1.7) setScrollFactor('buildings',0.95,1)
	addLuaSprite('buildings')
	makeLuaSprite('floor','stages/needlemouse/CONK_CREET',-1750,560) 
	setProperty('floor.antialiasing',false) scaleObject('floor',2.85,2.85)
	addLuaSprite('floor')
	makeLuaSprite('fg1','stages/needlemouse/fg1',-1200,560) 
	setProperty('fg1.antialiasing',false) scaleObject('fg1',2,2) setScrollFactor('fg1',1.3,1.3)
	addLuaSprite('fg1',true)
	makeLuaSprite('fg2','stages/needlemouse/fg2',2200,120) 
	setProperty('fg2.antialiasing',false) scaleObject('fg2',1.2,1.2) setScrollFactor('fg2',1.2,1.2)
	addLuaSprite('fg2',true)
	makeLuaSprite('basecirc','stages/needlemouse/basecirc',defaultOpponentX-120,defaultOpponentY+620)
	scaleObject('basecirc',1.6,1.6) setProperty('basecirc.color',getColorFromHex('FF87F5')) setProperty('basecirc.visible',false)
	addLuaSprite('basecirc')
	
	if shadersEnabled then
	initLuaShader('needleVCR')
	makeLuaSprite('vcrGame')
	makeGraphic('vcrGame', screenWidth, screenHeight)
	setSpriteShader('vcrGame', 'needleVCR')
	
	initLuaShader('needleBlur')
	makeLuaSprite('blur')
	makeGraphic('blur', screenWidth, screenHeight)
	setSpriteShader('blur', 'needleBlur')
	--setShaderFloat('crtGame','u_alpha',1)
	
	runHaxeCode([[
		game.camGame.setFilters([new ShaderFilter(game.getLuaObject("blur").shader), new ShaderFilter(game.getLuaObject("vcrGame").shader)]);
		game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("blur").shader), new ShaderFilter(game.getLuaObject("vcrGame").shader)]);
		game.camOther.setFilters([new ShaderFilter(game.getLuaObject("vcrGame").shader)]);
	]]) end
end

function onEvent(n,v1,v2)
	if n == 'needle stage' then
		if v1 == '0' then
			for i=1, #assets do setProperty(assets[i]..'.visible',true) end
			setProperty('basecirc.visible',false) cameraFlash('camHUD','FFFFFF',(stepCrochet/1000)*6)
		end
		if v1 == '1' then
			for i=1, #assets do setProperty(assets[i]..'.visible',false) end
			setProperty('basecirc.visible',true) cameraFlash('camHUD','000000',(stepCrochet/1000)*6)
		end
	end
end

function onUpdate()
	setShaderFloat('vcrGame','iTime',os.clock())
end

function onDestroy()
	setPropertyFromClass('ClientPrefs', 'timeBarType', defTime)
end