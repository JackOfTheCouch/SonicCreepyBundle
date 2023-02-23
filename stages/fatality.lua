local defTime
function onCreate()
	defTime = getPropertyFromClass('ClientPrefs', 'timeBarType')
	setPropertyFromClass('ClientPrefs', 'timeBarType', 'Time Elapsed')
	
	if shadersEnabled then
	
		initLuaShader('fastCRT') -- MAKES CUBES
		makeLuaSprite('crtGame')
		makeGraphic('crtGame', screenWidth, screenHeight)
		setSpriteShader('crtGame', 'fastCRT')
		
		runHaxeCode([[
			game.camGame.setFilters([new ShaderFilter(game.getLuaObject("crtGame").shader)]);
			game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("crtGame").shader)]);
			game.camOther.setFilters([new ShaderFilter(game.getLuaObject("crtGame").shader)]);
		]])
	end
	
	makeAnimatedLuaSprite('bg1','stages/fatal/launchbase',-1780,-630) addAnimationByPrefix('bg1','idle','idle',14)
    setProperty('bg1.antialiasing', false) scaleObject('bg1',5.15,5.15)
	addLuaSprite('bg1')
	
	makeAnimatedLuaSprite('statix','stages/fatal/statix') addAnimationByPrefix('statix','statix','statixx',24,true)
    setProperty('statix.antialiasing', false) scaleObject('statix',screenWidth/500,screenHeight/375) setObjectCamera('statix','other') setProperty('statix.visible',false)
	addLuaSprite('statix')
end
function onCreatePost()
	setProperty('showComboNum', false) setProperty('scoreTxt.visible',false) setProperty('timeBar.visible',false) setProperty('timeBarBG.visible',false) setProperty('timeTxt.visible',false)
	setProperty('healthBar.x',getProperty('healthBar.x')+100)
	
	makeLuaSprite('fatalHealth','stages/fatal/fatalHealth',getProperty('healthBar.x')-163,getProperty('healthBar.y')-12) setObjectCamera('fatalHealth','hud') 
	setProperty('fatalHealth.antialiasing', false) scaleObject('fatalHealth',1.52,2) setObjectOrder('fatalHealth',getObjectOrder('healthBar')-1)
	addLuaSprite('fatalHealth')
	
	makeLuaSprite('hud','sonicUI/sonic3',25,0) scaleObject('hud',3.5,3.5) setObjectCamera('hud','hud') setProperty('hud.antialiasing',false) setObjectOrder('hud',99)
	if downscroll then setProperty('hud.y',25) else setProperty('hud.y',screenHeight - getProperty('hud.height') - 25 )end
	addLuaSprite('hud')
	--GENERATING TEXT
	makeLuaText('scoreLol1','0',200,169.5,getProperty('hud.y')+2.5) setObjectCamera('scoreLol1','hud')--SCOREBACK
	setTextFont('scoreLol1','sonic-hud-font.ttf') setTextColor('scoreLol1','202020') setTextBorder('scoreLol1',0,'202020') setTextSize('scoreLol1',55) setTextAlignment('scoreLol1','right')
	addLuaText('scoreLol1')
	makeLuaText('scoreLol','0',200,165,getProperty('hud.y')-2) setObjectCamera('scoreLol','hud')--SCOREFRONT
	setTextFont('scoreLol','sonic-hud-font.ttf') setTextColor('scoreLol','E0E0E0') setTextBorder('scoreLol',0,'E0E0E0') setTextSize('scoreLol',55) setTextAlignment('scoreLol','right')
	addLuaText('scoreLol')
	makeLuaText('timeLol1','0:00',150,169.5,getProperty('hud.y')+55.5) setObjectCamera('timeLol1','hud')--TIMEBACK
	setTextFont('timeLol1','sonic-hud-font.ttf') setTextColor('timeLol1','202020') setTextBorder('timeLol1',0,'202020') setTextSize('timeLol1',55) setTextAlignment('timeLol1','left')
	addLuaText('timeLol1')
	makeLuaText('timeLol','0:00',150,165,getProperty('hud.y')+51) setObjectCamera('timeLol','hud')--TIMEFRONT
	setTextFont('timeLol','sonic-hud-font.ttf') setTextColor('timeLol','E0E0E0') setTextBorder('timeLol',0,'E0E0E0') setTextSize('timeLol',55) setTextAlignment('timeLol','left')
	addLuaText('timeLol')
	makeLuaText('comboLol1','0',150,144.5,getProperty('hud.y')+108.5) setObjectCamera('comboLol1','hud')--COMBOBACK
	setTextFont('comboLol1','sonic-hud-font.ttf') setTextColor('comboLol1','202020') setTextBorder('comboLol1',0,'202020') setTextSize('comboLol1',55) setTextAlignment('comboLol1','right')
	addLuaText('comboLol1')
	makeLuaText('comboLol','0',150,140,getProperty('hud.y')+104) setObjectCamera('comboLol','hud')--COMBOFRONT
	setTextFont('comboLol','sonic-hud-font.ttf') setTextColor('comboLol','E0E0E0') setTextBorder('comboLol',0,'E0E0E0') setTextSize('comboLol',55) setTextAlignment('comboLol','right')
	addLuaText('comboLol')
	makeLuaText('missesLol1','0',150,154.5,getProperty('hud.y')+161.5) setObjectCamera('missesLol1','hud')--MISSESBACK
	setTextFont('missesLol1','sonic-hud-font.ttf') setTextColor('missesLol1','202020') setTextBorder('missesLol1',0,'202020') setTextSize('missesLol1',55) setTextAlignment('missesLol1','right')
	addLuaText('missesLol1')
	makeLuaText('missesLol','0',150,150,getProperty('hud.y')+157) setObjectCamera('missesLol','hud')--MISSESFRONT
	setTextFont('missesLol','sonic-hud-font.ttf') setTextColor('missesLol','E0E0E0') setTextBorder('missesLol',0,'E0E0E0') setTextSize('missesLol',55) setTextAlignment('missesLol','right')
	addLuaText('missesLol')
end
function onBeatHit()
	if curBeat % 2 == 0 then objectPlayAnimation('bgbop','idle',true) objectPlayAnimation('bg3','idle',true) end
end

local comboCount,missesCount = 0,0
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if not isSustainNote then comboCount = comboCount + 1 end
	setTextString('comboLol',tostring(comboCount))
	setTextString('comboLol1',tostring(comboCount))
end

function noteMiss()
	if comboCount ~= 0 then comboCount = 0 setTextString('comboLol',tostring(comboCount)) setTextString('comboLol1',tostring(comboCount)) end
	missesCount = missesCount + 1 setTextString('missesLol',tostring(missesCount)) setTextString('missesLol1',tostring(missesCount))
end
function noteMissPress()
	if comboCount ~= 0 then comboCount = 0 setTextString('comboLol',tostring(comboCount)) setTextString('comboLol1',tostring(comboCount)) end
	missesCount = missesCount + 1 setTextString('missesLol',tostring(missesCount)) setTextString('missesLol1',tostring(missesCount))
end

function onUpdateScore() setTextString('scoreLol',tostring(score)) setTextString('scoreLol1',tostring(score)) end

function onUpdate() if curSection >= 0 then setTextString('timeLol',getTextString('timeTxt')) setTextString('timeLol1',getTextString('timeTxt')) end end

function onEvent(n,v1,v2)
	if n == 'Fatal stage' then
		runTimer('stat',stepCrochet/1000*4) setProperty('statix.visible',true)
		if v1 == '2' then
			makeAnimatedLuaSprite('bg2','stages/fatal/domain2',-1050,-380) addAnimationByPrefix('bg2','idle','idle',14)
			setProperty('bg2.antialiasing', false) scaleObject('bg2',4.2,4.2)
			makeAnimatedLuaSprite('bgbop','stages/fatal/domain',-980,-380) addAnimationByPrefix('bgbop','idle','idle',12,false)
			setProperty('bgbop.antialiasing', false) scaleObject('bgbop',4.2,4.2)
			addLuaSprite('bg2') addLuaSprite('bgbop')
			removeLuaSprite('bg1',true) removeLuaSprite('bg3',true)
		end
		if v1 == '3' then
			makeAnimatedLuaSprite('bg3','stages/fatal/truefatalstage',-1380,-564) addAnimationByPrefix('bg3','idle','idle',14,false)
			setProperty('bg3.antialiasing', false) scaleObject('bg3',4.2,4.2)
			addLuaSprite('bg3')
			removeLuaSprite('bg1',true) removeLuaSprite('bg2',true) removeLuaSprite('bgbop',true)
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'stat' then setProperty('statix.visible',false) end
end

function onDestroy()
	setPropertyFromClass('ClientPrefs', 'timeBarType', defTime)
end