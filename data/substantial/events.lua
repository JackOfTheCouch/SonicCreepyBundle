local moved = false
local bfYdef,dadYdef --I KNOW DEFAULTBOYFRIENDY EXISTS BUT IT WON'T WORK AS INTENDED FOR SOME REASON
local floatSpeed = 4 

function startFloating(speed)
	floatSpeed = speed
	setProperty('floor.alpha',0) setProperty('sky.y',-340) setProperty('boyfriend.y',bfYdef+100) 
	doTweenY('bfUP','boyfriend',bfYdef-100,crochet/1000*floatSpeed,'sineInOut')
	doTweenY('dadDO','dad',dadYdef+100,crochet/1000*floatSpeed,'sineInOut')
end
function stopFloating()
	cancelTween('bfUP') cancelTween('bfDO') cancelTween('dadUP') cancelTween('dadDO')
	setProperty('boyfriend.y',bfYdef) setProperty('dad.y',dadYdef)
	setProperty('floor.alpha',1) setProperty('sky.y',-1140)
end

function onCreate()
	--setProperty('cpuControlled',true)
	
	setProperty('camGame.alpha',0)
	
	setProperty('cameraSpeed',9999)
	makeLuaSprite('highlight','stages/xterion/highlight',0,0)
	scaleObject('highlight',screenHeight/45,screenHeight/45)
	setObjectCamera('highlight','hud')
	setObjectOrder('highlight',0)
	screenCenter('highlight','x')
	setProperty('highlight.x',getProperty('highlight.x')-100)
	setProperty('highlight.antialiasing',false)
	setProperty('highlight.alpha',0)
	addLuaSprite('highlight',true)
end

function onCreatePost()
	setProperty('camGame.zoom',0.8)
	bfYdef = getProperty('boyfriend.y')
	dadYdef = getProperty('dad.y')
	setSpriteShader('sky', 'scroll') 
	setShaderFloat('sky','xSpeed',0.15)
end
function onSongStart()
end

function onSectionHit()
	if mustHitSection and not moved then setProperty('highlight.x',getProperty('highlight.x')+130) moved = true end
	if not mustHitSection and moved then setProperty('highlight.x',getProperty('highlight.x')-130) moved = false end
end

function onStepHit()
	if curStep == 16 then setProperty('highlight.alpha',1) setProperty('camGame.alpha',1) end
	if curStep == 144 then setProperty('highlight.alpha',0) end
	if curStep == 528 then startFloating(4) end
	if curStep == 784 then stopFloating() end
	if curStep == 1072 then startFloating(4) end
	if curStep == 1584 then stopFloating() end
	if curStep == 1840 then setProperty('highlight.alpha',1) end
	if curStep == 1968 then setProperty('highlight.alpha',0) startFloating(3) 
		setShaderFloat('sky','xSpeed',2) end
	if curStep == 2480 then cameraFlash('game', 'FFFFFF',stepCrochet/1000*16,true) stopFloating() setShaderFloat('sky','xSpeed',0.5) end
	if curStep == 2753 then cameraFade('game', '000000', stepCrochet/1000*48, true) cameraFade('hud', '000000', stepCrochet/1000*48, true) end
end

function goodNoteHit()
	if curStep >= 2224 and curStep < 2256 then triggerEvent('Add Camera Zoom','0.03','0.06') end
end

function onUpdate()
	setShaderFloat('sky','iTime',getSongPosition()/1000)
end

function onTweenCompleted(tag)
	if tag == 'bfUP' then doTweenY('bfDO','boyfriend',bfYdef+100,crochet/1000*floatSpeed,'sineInOut') elseif tag == 'bfDO' then doTweenY('bfUP','boyfriend',bfYdef-100,crochet/1000*floatSpeed,'sineInOut') end
	if tag == 'dadUP' then doTweenY('dadDO','dad',dadYdef+100,crochet/1000*floatSpeed,'sineInOut') elseif tag == 'dadDO' then doTweenY('dadUP','dad',dadYdef-100,crochet/1000*floatSpeed,'sineInOut') end
end