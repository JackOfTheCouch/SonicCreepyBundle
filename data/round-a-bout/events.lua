local texts = { "1963","I KNOw wHERe yoU livE","I'M TRAPPED","30 YEARS","30 LONG YEARS..","MOM","DAD","LILY","I REMEMBER EVERYTHING","THERE IS NO GOD.","YOU ARE IN MY WORLD NOW.","803 Branch Lane Kennersville, NC 27284","I CAN STILL FEEL THE PAIN"}
local chance = 0
local stringsOn = false
function onCreate()
	makeLuaSprite('otherBlack','')
	makeGraphic('otherBlack',screenWidth,screenHeight,'040207') setObjectCamera('otherBlack','other')
	addLuaSprite('otherBlack')
	makeLuaSprite('intro','stages/needlemouse/intro1') scaleObject('intro',screenHeight/540,screenHeight/540)
	setObjectCamera('intro', 'other') screenCenter('intro') setProperty('intro.alpha',0)
	addLuaSprite('intro')
	
	
	for i=1,6 do
		makeLuaText('text'..i,'',600) setObjectCamera('text'..i,'hud') setTextFont('text'..i,'Limelight.ttf') setTextSize('text'..i,50) setTextAlignment('text'..i,'left') setTextBorder('text'..i,1.5,'FF0000')
		setTextString('text'..i,texts[getRandomInt(1,#texts)])
		setProperty('text'..i..'.x',getRandomInt(0,screenWidth-getProperty('text'..i..'.width'))) setProperty('text'..i..'.y',getRandomInt(0,screenHeight-getProperty('text'..i..'.height')))
		addLuaText('text'..i)
	end
	
	makeLuaSprite('scene','stages/needlemouse/frames/8')
	scaleObject('scene',screenWidth/640,screenHeight/360) setObjectCamera('scene','hud') setObjectOrder('scene',getObjectOrder('text1')-1) setProperty('scene.alpha',0)
	addLuaSprite('scene')
end

function onCreatePost()
	makeAnimatedLuaSprite('stat','lowstat') addAnimationByPrefix('stat','stat','stat') scaleObject('stat',screenWidth/320,screenHeight/180)
	setObjectCamera('stat','hud') setProperty('stat.alpha',0.35) setProperty('stat.visible',false)
	addLuaSprite('stat')
	for i=0,3 do
		makeLuaSprite('string'..i,'stages/needlemouse/notes/string'..i,getPropertyFromGroup('opponentStrums', i, 'x')+10,getPropertyFromGroup('opponentStrums', i, 'y')-80) setObjectCamera('string'..i,'hud')
		scaleObject('string'..i,0.75,0.75) setProperty('string'..i..'.alpha',0)
		addLuaSprite('string'..i)
	end
end

function onSongStart()
	doTweenAlpha('intro','intro',1,stepCrochet/1000*18,'sineInOut')
	chance = 0.5
end

function onStepHit()
	setProperty('stat.visible',false)
	for i=1,getRandomInt(1,6) do
		setProperty('text'..i..'.visible',false)
		if getRandomBool(chance) then
			setProperty('stat.visible',true) setProperty('text'..i..'.visible',true)
			setTextString('text'..i,texts[getRandomInt(1,#texts)])
			setProperty('text'..i..'.x',getRandomInt(0,200+screenWidth-getProperty('text'..i..'.width')))
			setProperty('text'..i..'.y',getRandomInt(0,screenHeight-getProperty('text'..i..'.height')))
		end
	end
	if curStep == 13 then
		loadGraphic('intro','stages/needlemouse/intro2')
	end
	if curStep == 16 then removeLuaSprite('intro',true) setProperty('otherBlack.visible',false) end
	if curStep == 742 then runTimer('load',stepCrochet/1000*0.5,64) doTweenAlpha('scene','scene',1,stepCrochet/1000*24,'sineInOut') end
	if curStep == 1154 then setProperty('camGame.visible',false) setProperty('camHUD.visible',false) end
end

function onEvent(n,v1,v2)
	if n == 'needle stage' then
		if v1 == '0' then
			chance = 5
			setTextString('timeTxt',songName)
		elseif v1 == '1' then
			stringsOn = true
			chance = 25
			setTextString('timeTxt',"I'M-STILL-HERE")
			removeLuaSprite('scene')
		end
	end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if stringsOn then
	setPropertyFromGroup('opponentStrums',noteData,'y',_G['defaultOpponentStrumY'..noteData]-30)
	noteTweenY('down'..noteData,noteData,_G['defaultOpponentStrumY'..noteData],stepCrochet/1000*4,'elasticInOut')
	end
end

function onUpdate()
	for n=0,3 do
		setProperty('string'..n..'.y',getPropertyFromGroup('opponentStrums', n, 'y')-80)
		setProperty('string'..n..'.alpha',getProperty('Sarah.alpha'))
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'load' then loadGraphic('scene','stages/needlemouse/frames/'..getRandomInt(1,17)) end
end