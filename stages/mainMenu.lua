local canMove = true
function onCreate()
	makeAnimatedLuaSprite('MainMenu','customMenu/MainMenu') scaleObject('MainMenu',screenWidth/1280,screenHeight/720) setObjectCamera('MainMenu','other') --ADD MENU BG
	addAnimationByPrefix('MainMenu','BG','BG',24,true) addLuaSprite('MainMenu')
	
	local initX,initY,addX,addY = 700,180,0,0 --ADDS BUTTONS
	for i=0, 3 do
		makeAnimatedLuaSprite('button'..i,'customMenu/buttons/button'..i,initX+addX,initY+addY)
		addAnimationByPrefix('button'..i,i..'white',i..'white')
		addAnimationByPrefix('button'..i,i..'basic',i..'basic')
		setObjectCamera('button'..i,'other')
		screenCenter('button'..i,'x')
		runTimer('move',1)
		doTweenX('button'..i,'button'..i,initX+addX,2,'expoOut')
		addLuaSprite('button'..i)
		addX = addX + 60
		addY = addY + 100
	end
end

function onCreatePost()
	setProperty('iconP1.alpha',0) setProperty('iconP2.alpha',0) setProperty('healthBar.alpha',0) setProperty('healthBarBG.alpha',0) setProperty('scoreTxt.alpha',0) --MAKES INVISBLE SHIT
	playSound('menu/freakyMenu',1,'menu')
end

function onStartCountdown()
	return Function_Stop;
end

local curMenu = 'main'
local mainSelec = 0
function onUpdate()
	if curMenu == 'main' then
		if canMove then
			if keyboardJustPressed('ESCAPE') then endSong() end
			if keyboardJustPressed('UP') then mainSelec = mainSelec -1 playSound('scrollMenu') end --CHANGE SELECTION
			if keyboardJustPressed('DOWN') then mainSelec = mainSelec +1 playSound('scrollMenu') end --DITTO
			
			if mainSelec == 4 then mainSelec = 0 end --LOOPS DOWN
			if mainSelec == -1 then mainSelec = 3 end --LOOPS UP
			
			if keyboardJustPressed('ENTER') then 
				if mainSelec == 2 then playSound('confirmMenu') runTimer('fpChange',1.68) canMove = false end
			end
		end
		for i=0,3 do
			playAnim('button'..i,i..'basic',true) --BASIC AND HIGHLIGHTED ANIMATIONS
		end
		playAnim('button'..mainSelec,mainSelec..'white',true)
		
		if keyboardJustPressed('ENTER') then
			if mainSelec == 2 then setProperty('button'..mainSelec..'.visible',false) runTimer('flicker',0.07,24) end
		end
	end
end

function onUpdatePost()
	--debugPrint(curMenu)
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'flicker' then 
		setProperty('button'..mainSelec..'.visible',not getProperty('button'..mainSelec..'.visible'))
	end
	if tag == 'fpChange' then 
		openCustomSubstate('freeplay') curMenu = 'freeplay'
	end
end

function onSoundFinished(tag)
	if tag == 'menu' then playSound('menu/freakyMenu',1,'menu') end
end

function onCustomSubstateDestroy(name)
	if name == 'freeplay' then curMenu = 'main' canMove = true setProperty('button'..mainSelec..'.visible',true) end
end
