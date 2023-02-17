function onCreate()
	
	makeLuaSprite('blackBg', '', screenWidth * -1.5, screenHeight * -.5)
	makeGraphic('blackBg', screenWidth * 2, screenHeight * 2, '000000')
	scaleObject('blackBg', 100, 100)
	addLuaSprite('blackBg')
	setProperty('blackBg.alpha',0)
	
	makeAnimatedLuaSprite('target','stages/hog/TargetLock',defaultBoyfriendX-150,defaultBoyfriendY+150)
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

local hudShit = {'healthBar','healthBarBG','timeBar','timeBarBG','timeTxt','scoreTxt'}
local x = {}
local y = {}
local angle = {}
function onSongStart()
	for i = 1, #hudShit do --saves default hud positions for restoring later
		x[i] = getProperty(hudShit[i]..'.x')
		y[i] = getProperty(hudShit[i]..'.y')
		angle[i] = getProperty(hudShit[i]..'.angle')
	end
	addAnimationByPrefix('warning','warn','warn',24,false)
end

function onBeatHit()
	playAnim('warning','warn',true,false,0)
end

function onStepHit()
	if curStep == 1032 then doTweenZoom('epicZoom','camGame',0.85,(stepCrochet/1000)*120,'linear') end
	if curStep == 1160 then doTweenZoom('epicZoom','camGame',0.85,(stepCrochet/1000)*120,'linear') end
	if curStep == 1264 then 
		doTweenZoom('epicZoom','camGame',0.63,stepCrochet/1000,'linear')
		setProperty('warning.visible',true)
		doTweenX('warningX','warning.scale',1,(stepCrochet/1000)*4,'bounceOut')
		doTweenY('warningY','warning.scale',1,(stepCrochet/1000)*4,'bounceOut')
	end
	if curStep == 1271 then
		setProperty('target.visible',true)
		doTweenX('targetX','target.scale',2.5,(stepCrochet/1000)*4,'bounceOut')
		doTweenY('targetY','target.scale',2.5,(stepCrochet/1000)*4,'bounceOut')
	end
	if curStep == 1276 then addAnimationByPrefix('target','lock','lock',60,false) end
	if curStep == 1280 then
		doTweenX('targetX','target.scale',7.5,(stepCrochet/1000)*2,'bounceIn')
		doTweenY('targetY','target.scale',7.5,(stepCrochet/1000)*2,'bounceIn')
		doTweenAlpha('targetA','target',0,(stepCrochet/1000)*2,'linear')
	end
	if curStep == 1281 then
		doTweenX('warningX','warning.scale',7.5,(stepCrochet/1000)*2,'bounceIn')
		doTweenY('warningY','warning.scale',7.5,(stepCrochet/1000)*2,'bounceIn')
		doTweenAlpha('warningA','warning',0,(stepCrochet/1000)*2,'linear')
	end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if dadName == 'hog_glitch' then
		setProperty('defaultCamZoom',0.85)
		setProperty('iconP1.alpha',0)
		setProperty('iconP2.alpha',0)
		doTweenAlpha('black','blackBg',.7,stepCrochet/1000,'linear')
		for i = 0,4 do
			setPropertyFromGroup("playerStrums", i, "x", getRandomInt(0,screenWidth))
			setPropertyFromGroup("playerStrums", i, "y", getRandomInt(0,screenHeight))
			setPropertyFromGroup("opponentStrums", i, "x", getRandomInt(0,screenWidth))
			setPropertyFromGroup("opponentStrums", i, "y", getRandomInt(0,screenHeight))
		end
		for i = 1, #hudShit do
			setProperty(hudShit[i]..'.x',getRandomInt(0,screenWidth))
			setProperty(hudShit[i]..'.y',getRandomInt(0,screenHeight))
			setProperty(hudShit[i]..'.angle',getRandomInt(0,360))
		end
	elseif dadName == 'hog' and curStep >= 1280 and curStep <= 1441 then
		setProperty('defaultCamZoom',0.63)
		setProperty('iconP1.alpha',1)
		setProperty('iconP2.alpha',1)
		doTweenAlpha('black','blackBg',0,stepCrochet/1000,'linear')
		
		for i = 0,4 do
			setPropertyFromGroup("playerStrums", i, "x",_G['defaultPlayerStrumX'..i])
			setPropertyFromGroup("playerStrums", i, "y",_G['defaultPlayerStrumY'..i])
			setPropertyFromGroup("opponentStrums", i, "x", _G['defaultOpponentStrumX'..i])
			setPropertyFromGroup("opponentStrums", i, "y", _G['defaultOpponentStrumY'..i])
		end
		for i = 1, #hudShit do
			setProperty(hudShit[i]..'.x',x[i])
			setProperty(hudShit[i]..'.y',y[i])
			setProperty(hudShit[i]..'.angle',angle[i])
		end
	end
end

function onEvent(n,v1,v2)
	if n == 'Set Beat Bop' then
		if tonumber(v1) == 1 then setProperty('defaultCamZoom',0.73) elseif tonumber(v1) == 0 then setProperty('defaultCamZoom',0.63) end
	end
end