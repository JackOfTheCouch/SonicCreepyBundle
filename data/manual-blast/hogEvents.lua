local jumpStep

function onCreate()
	addHaxeLibrary('Paths')
	
	makeAnimatedLuaSprite('target','stages/hog/TargetLock',defaultBoyfriendX-150,defaultBoyfriendY+150)
	addAnimationByPrefix('target','idle','idle',60,true)
	addAnimationByPrefix('target','lock','lock',60,false)
	scaleObject('target',2.5,2.5)
	setProperty('target.visible',false)
	doTweenX('targetX','target.scale',0,1,'linear')
	doTweenY('targetY','target.scale',0,1,'linear')
	addLuaSprite('target',true)
	
	makeAnimatedLuaSprite('warning','spacebar_icon',(screenWidth/2)-(393/2),(screenHeight/2)-(359/2))
	setObjectCamera('warning','other')
	setProperty('warning.visible',false)
	doTweenX('warningX','warning.scale',0,1,'linear')
	doTweenY('warningY','warning.scale',0,1,'linear')
	addLuaSprite('warning')
	
end

function onSongStart()
	addAnimationByPrefix('warning','warn','warn',24,false)
end

function onBeatHit()
	playAnim('warning','warn',true,false,0)
end

function onStepHit()
	if curStep == 212 or curStep == 300 then
		setProperty('target.visible',true)
		setProperty('target.alpha',1)
		doTweenX('targetX','target.scale',2.5,(stepCrochet/1000)*4,'bounceOut')
		doTweenY('targetY','target.scale',2.5,(stepCrochet/1000)*4,'bounceOut')
	end
	if curStep == 221 or curStep == 309 then playAnim('target','lock') end
	if curStep == jumpStep + 4 then
		doTweenX('targetX','target.scale',7.5,(stepCrochet/1000)*2,'bounceIn')
		doTweenY('targetY','target.scale',7.5,(stepCrochet/1000)*2,'bounceIn')
		doTweenAlpha('targetA','target',0,(stepCrochet/1000)*2,'linear')
	end
	if curStep == jumpStep + 5 then
		doTweenX('warningX','warning.scale',7.5,(stepCrochet/1000)*2,'bounceIn')
		doTweenY('warningY','warning.scale',7.5,(stepCrochet/1000)*2,'bounceIn')
		doTweenAlpha('warningA','warning',0,(stepCrochet/1000)*2,'linear')
	end
	
	if curStep == 864 then
		close()
	end
end

function onEvent(n,v1,v2)
	if n == 'Play Animation' then
		if v1 == 'jumpONE' then 
			setProperty('warning.visible',true)
			setProperty('warning.alpha',1)
			setProperty('warning.scale.x',0)
			setProperty('warning.scale.y',0)
			setProperty('target.scale.x',0)
			setProperty('target.scale.y',0)
			playAnim('target','idle')
			doTweenX('warningX','warning.scale',1,(stepCrochet/1000)*4,'bounceOut')
			doTweenY('warningY','warning.scale',1,(stepCrochet/1000)*4,'bounceOut')
		end
		if v1 == 'jumpFOUR' then
			jumpStep = curStep
		end
	end
	if n == 'Set Beat Bop' then
		if tonumber(v1) == 1 then setProperty('defaultCamZoom',0.73) elseif tonumber(v1) == 0 then setProperty('defaultCamZoom',0.63) end
	end
end

function onDestroy()
	runHaxeCode([[
		Paths.clearUnusedMemory();
		]])
end