local allowStart = false
function onCreatePost()
	initSaveData('highScores','psychenginemods/DS_SonicCreepyBundle')
	
	makeLuaSprite('mission','stages/xterion/mission',0,0) --MISSION GRAPHIC
	scaleObject('mission',1.8,1.8)
	setProperty('mission.antialiasing',false)
	setObjectCamera('mission','other')
	setProperty('mission.x',screenWidth - getProperty('mission.width')-100)
	if downscroll then setProperty('mission.y',screenHeight) else setProperty('mission.y',- getProperty('mission.height')) end
	addLuaSprite('mission')
	
	makeLuaText('highS', '', 400, 0,0) --SCORE TEXT
	setTextSize('highS',35)
	setTextFont('highS','sonic-jam-numbers.ttf')
	setTextBorder('highS',0,'FFFFFF')
	setTextAlignment('highS','right')
	setObjectCamera('highS','other')
	if type(getDataFromSave('highScores', string.lower(songName)..'Score')) ~= 'number' then
		setTextString('highS', '0')
	else setTextString('highS', tostring(getDataFromSave('highScores', string.lower(songName)..'Score'))) end
	addLuaText('highS')
	
	makeLuaSprite('ready', 'stages/xterion/start', 0, 0)--START SPRITE
	makeLuaSprite('readyCL', 'stages/xterion/start', 0, 0)--START SPRITE BUT BIGGER
	scaleObject('ready', 1.5, 1.5)
	scaleObject('readyCL', 1.5, 1.5)
	screenCenter('ready', 'xy')
	screenCenter('readyCL', 'xy')
	setProperty('ready.antialiasing',false)
	setProperty('readyCL.antialiasing',false)
	addLuaSprite('ready', true)
	addLuaSprite('readyCL', true)
	setObjectCamera('ready', 'other')
	setObjectCamera('readyCL', 'other')
	setProperty('readyCL.visible', false)
	doTweenX('RXS0', 'ready.scale', 1.52, 0.5, 'quadInOut')
	doTweenY('RYS0', 'ready.scale', 1.52, 0.5, 'quadInOut')
	
	setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
	makeLuaSprite('mouseGraphic','')
	makeGraphic('mouseGraphic', 2,2,'FF0000')
	setObjectCamera('mouseGraphic', 'other')
	setProperty('mouseGraphic.visible',false)
	addLuaSprite('mouseGraphic')
	--
	
end

function onStartCountdown()
	if not allowStart then
		playSound('sjam_00_01', 0.6, 'bgMusic')
		runTimer('tween',0.1)
		return Function_Stop
	end
	--close()
	runTimer('flicker',	0.1,6)
	return Function_Continue
end

function onCountdownTick()
end

function onUpdate()
	setProperty('readyCL.scale.x', getProperty('ready.scale.x') + 0.1)
	setProperty('readyCL.scale.y', getProperty('ready.scale.y') + 0.1)
	setProperty('mouseGraphic.x',getMouseX('other'))
	setProperty('mouseGraphic.y',getMouseY('other'))
	setProperty('highS.x',getProperty('mission.x')+353.5)
	setProperty('highS.y',getProperty('mission.y')+74)
	
	if not allowStart then
		if keyboardJustPressed('ESCAPE') then endSong() end
		if objectsOverlap('mouseGraphic', 'ready') then
			setProperty('readyCL.visible',true)
			setProperty('ready.visible',false)
			if mouseReleased('left') then
				allowStart = true
				setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
				stopSound('bgMusic')
				if downscroll then doTweenY('missionIN','mission',screenHeight,1.25,'expoOut') else doTweenY('missionIN','mission',- getProperty('mission.height'),1.25,'expoOut') end
				setProperty('readyCL.visible',false)
				setProperty('ready.visible',false)
				startCountdown() end
		else
			setProperty('readyCL.visible',false)
			setProperty('ready.visible',true)	
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'RXS0' then
		doTweenX('RXS2', 'ready.scale', 1.5, 0.5, 'quadInOut')
		doTweenY('RYS2', 'ready.scale', 1.5, 0.5, 'quadInOut')
	elseif tag == 'RXS2' then
		doTweenX('RXS0', 'ready.scale', 1.52, 0.5, 'quadInOut')
		doTweenY('RYS0', 'ready.scale', 1.52, 0.5, 'quadInOut')
	end
end
function onTimerCompleted(tag,loops,loopsLeft)
	if tag == 'tween' then
		if downscroll then doTweenY('missionIN','mission',screenHeight - getProperty('mission.height') - 25,1.25,'expoOut') else doTweenY('missionIN','mission',25,1.25,'expoOut') end
	end
	if tag == 'flicker' then
		setProperty('readyCL.visible',not getProperty('readyCL.visible'))
		if loopsLeft == 0 then close(true) end
	end
end
function onSoundFinished(tag)
	if tag == 'bgMusic' then
		playSound('sjam_00_01', 0.6, 'bgMusic')
	end
end

function onDestroy()
	setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
end