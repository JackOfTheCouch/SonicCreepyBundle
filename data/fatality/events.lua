function onCreate()
    math.randomseed(os.time())
	for i = 0,3 do setPropertyFromGroup('opponentStrums',i,'texture','fatalNOTE_assets') end
	for i= 0, getProperty('unspawnNotes.length') - 1 do
		if not getPropertyFromGroup('unspawnNotes',i,'mustPress') then setPropertyFromGroup('unspawnNotes',i,'texture','fatalNOTE_assets') end
	end
	makeLuaSprite('pixelVG','pixelHugeGrad') setObjectCamera('pixelVG','hud') scaleObject('pixelVG',screenWidth/213,screenHeight/120) setProperty('pixelVG.color',getColorFromHex('FF0000'))
	setProperty('pixelVG.alpha',0) setProperty('pixelVG.antialiasing',false) addLuaSprite('pixelVG')
end

function onStartCountdown()
	doTweenZoom('1','camGame',0.8,0.0001,'linear') setProperty('cameraSpeed',9999) triggerEvent('Camera Follow Pos',getProperty('dad.x')+250, getProperty('dad.y')-400)
end

function onCountdownTick(counter)
	if counter == 0 then end
	if counter == 1 then 
		triggerEvent('Camera Follow Pos',getProperty('boyfriend.x'), getProperty('boyfriend.y')) end
	if counter == 2 then 
		doTweenZoom('1','camGame',0.6,0.0001,'linear') triggerEvent('Camera Follow Pos',(getProperty('boyfriend.x')+getProperty('dad.x'))/2, getProperty('boyfriend.y')-300) end
	if counter == 3 then 
		setProperty('cameraSpeed',2.5) triggerEvent('Camera Follow Pos','','') cameraSetTarget('dad') end
end

function onCreatePost()
	for i = 0,3 do setPropertyFromGroup('opponentStrums',i,'texture','fatalNOTE_assets') end
end
function onSectionHit()
	if curSection < 124 then 
		if mustHitSection then setProperty('defaultCamZoom',0.7) 
		else 
			if dadName == 'fatal-glitched' then 
				setProperty('defaultCamZoom',0.7) 
			else setProperty('defaultCamZoom',0.5) end 
		end 
	end
	if curSection >= 124 then if mustHitSection then setProperty('defaultCamZoom',1) else setProperty('defaultCamZoom',0.7) end end
end

function onUpdate()
	if dadName == 'fatal-glitched' then
		local noteShit = math.floor(math.random(0,3))
		local alpha = math.floor(math.random(0,1))
		setPropertyFromGroup('opponentStrums',noteShit,'alpha', alpha)
		setProperty('iconP2.alpha',alpha)
	end
end

function onEvent(n,v1,v2)
	if n == 'Change Character' then
		if v2 == 'bf-fatal-small' then
			setProperty('boyfriend.y',getProperty('boyfriend.y')-120)
			setProperty('boyfriend.x',getProperty('boyfriend.x')-895)
			setProperty('dad.x',getProperty('dad.x')+200)
			setProperty('iconP2.alpha',1)
			removeLuaSprite('pixelVG')
			for i=0,3 do setPropertyFromGroup('opponentStrums',i,'alpha', 0) setPropertyFromGroup('playerStrums',i,'x', getPropertyFromGroup('playerStrums',i,'x')-300) end
		end
		if v2 == 'fatal-glitched' then
			doTweenAlpha('pixelVGOn','pixelVG',1,crochet/1000*4,'sineInOut')
		end
	end
end

local popProb = 0
function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if mustHitSection and getRandomBool(popProb/2) then triggerEvent('Fatal Popup','','') end 
	if not mustHitSection and getRandomBool(popProb) then triggerEvent('Fatal Popup','','') end 
	if curBeat == 64 then popProb = 5 end
	if curBeat == 288 then popProb = 7.5 end
end

function onTweenCompleted(tag)
	if tag == 'pixelVGOn' then doTweenAlpha('pixelVGOff','pixelVG',0.3,crochet/1000*4,'sineInOut') end
	if tag == 'pixelVGOff' then doTweenAlpha('pixelVGOn','pixelVG',1,crochet/1000*4,'sineInOut') end
end