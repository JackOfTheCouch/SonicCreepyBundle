weekNames = {'fatalerror','xterion','hog','scorched'} --add whatever week you want here (needs to have the frame thingy)
--ADD THE SONGS OF EACH WEEK
fatalerror = {'fatality'}
xterion = {'substantial'}
hog = {'hedge'}
scorched = {'manual blast'}
--OTHER SHIT DON'T TOUCH
local weekSelec = 1
local songSelec = 1
local curSub = 'weeks'
local startX, startY, moreY = 80,190,0
local defPos
local defTY, textY, addTextY =320,0,0
local canPlay = false
function onCustomSubstateCreate(name)
	if name == 'freeplay' then
		moreY = 0
		addTextY = 0
		weekSelec = 1
		songSelec = 1
		curSub = 'weeks'
		
		initLuaShader('scroll')
		
		makeLuaSprite('fpbg','customMenu/backgroundlool') scaleObject('fpbg',screenWidth/1280,screenHeight/720) setObjectCamera('fpbg','other') --MAKE BG
		addLuaSprite('fpbg')
		makeLuaSprite('blackLine','',80+219) --black line thing
		makeGraphic('blackLine',10,screenHeight,'000000')
		setObjectCamera('blackLine','other') 
		addLuaSprite('blackLine')
		makeLuaSprite('sidebar','customMenu/sidebar') scaleObject('sidebar',screenHeight/720,screenHeight/720) setObjectCamera('sidebar','other') --MAKE SCROLLING SIDEBAR
		setProperty('sidebar.x',screenWidth - getProperty('sidebar.width'))
		addLuaSprite('sidebar')
		setSpriteShader('sidebar', 'scroll') setShaderFloat('sidebar','xSpeed',0.0) setShaderFloat('sidebar','ySpeed',-0.5)
		for i = 1, #weekNames do--MAKES THE FRAMES...YAY
			makeLuaSprite(weekNames[i],'customMenu/fpstuff/'..weekNames[i],startX,startY+moreY) setObjectCamera(weekNames[i],'other')
			moreY = moreY + getProperty(weekNames[i]..'.height') + 100
			addLuaSprite(weekNames[i])
		end
		makeLuaText('title',string.upper(weekNames[weekSelec]), getProperty('sidebar.width'), getProperty('sidebar.x')+50,30) setObjectCamera('title','other')--ADD TITLE TEXT
		setTextFont('title', 'sonic-cd-menu-font.ttf') setTextAlignment('title','center') setTextSize('title',50)
		addLuaText('title')
		for i=1,#_G[weekNames[weekSelec]] do --ADD TEXT CUR FRAME
			textY = defTY - 30 * (#_G[weekNames[weekSelec]] - 1)
			makeLuaText('song'..i,string.lower(_G[weekNames[weekSelec]][i]), getProperty('sidebar.width'), getProperty('sidebar.x')+50,textY+addTextY) setObjectCamera('song'..i,'other')
			setTextFont('song'..i, 'sonic-cd-menu-font.ttf') setTextAlignment('song'..i,'center') setTextSize('song'..i,40) setTextColor('song'..i, '000000') setTextBorder('song'..i,2.5,'FFFFFF')
			addLuaText('song'..i)
			addTextY = addTextY + 60
			for i=#_G[weekNames[weekSelec]] + 1, 10 do removeLuaText('song'..i) end
		end
		addTextY = 0
	end
end
function onCustomSubstateCreatePost(name)
	if name == 'freeplay' then
		defPos = getProperty(weekNames[1]..'.y')
	end
end
function onCustomSubstateUpdate(name)
	if name == 'freeplay' then
		setShaderFloat('sidebar','iTime',os.clock())
		if curSub == 'weeks' 	then--WEEKS MENU
			if keyboardJustPressed('ESCAPE') then closeCustomSubstate() end
			if keyboardJustPressed('UP') then weekSelec = weekSelec -1 playSound('scrollMenu') end --CHANGE SELECTION
			if keyboardJustPressed('DOWN') then weekSelec = weekSelec +1 playSound('scrollMenu') end  --DITTO
			if weekSelec == #weekNames + 1 then weekSelec = 1 end --LOOPS DOWN
			if weekSelec == 0 then weekSelec = #weekNames end --LOOPS UP
		end
		if curSub == 'songs' then --SONGS MENU
			if keyboardJustPressed('ESCAPE') then 
				curSub = 'weeks'
				for i=1,10 do setTextColor('song'..i, '000000') setTextBorder('song'..i,2.5,'FFFFFF') end
			end
			if keyboardJustPressed('UP') then songSelec = songSelec -1 playSound('scrollMenu') end --CHANGE SELECTION
			if keyboardJustPressed('DOWN') then songSelec = songSelec +1 playSound('scrollMenu') end  --DITTO
			if songSelec == #_G[weekNames[weekSelec]] + 1 then songSelec = 1 end --LOOPS DOWN
			if songSelec == 0 then songSelec = #_G[weekNames[weekSelec]] end --LOOPS UP
		end
	end
end
function onCustomSubstateUpdatePost(name)
	if name == 'freeplay' then
		if curSub == 'weeks' then --WEEKS MENU
			canPlay = false
			--CHANGING THE FRAMES
			for i=1,#weekNames + (#weekNames - 1) do	
				doTweenY('MPOS'..i,weekNames[weekSelec+i],defPos + 447 * i,0.5,'expoOut')
				doTweenAlpha('APOS'..i,weekNames[weekSelec+i],0.5,0.5,'expoOut')
				
				doTweenY('MNEG'..i,weekNames[weekSelec-i],defPos - 447 * i,0.5,'expoOut')
				doTweenAlpha('ANEG'..i,weekNames[weekSelec-i],0.5,0.5,'expoOut')
			end
			doTweenY('MBASE',weekNames[weekSelec],defPos,0.5,'expoOut')
			doTweenAlpha('ABASE',weekNames[weekSelec],1,0.5,'expoOut')
			
			--CHANGE THE TEXT
			setTextString('title',string.upper(weekNames[weekSelec]))
			
			if keyboardJustPressed('UP') or keyboardJustPressed('DOWN') then
				for i=1,#_G[weekNames[weekSelec]] do --ADD TEXT CUR FRAME
					textY = defTY - 30 * (#_G[weekNames[weekSelec]] - 1)
					makeLuaText('song'..i,string.lower(_G[weekNames[weekSelec]][i]), getProperty('sidebar.width'), getProperty('sidebar.x')+50,textY+addTextY) setObjectCamera('song'..i,'other')
					setTextFont('song'..i, 'sonic-cd-menu-font.ttf') setTextAlignment('song'..i,'center') setTextSize('song'..i,40) setTextColor('song'..i, '000000') setTextBorder('song'..i,2.5,'FFFFFF')
					addLuaText('song'..i)
					addTextY = addTextY + 60
					for i=#_G[weekNames[weekSelec]] + 1, 10 do removeLuaText('song'..i) end --REMOVE USELESS TEXT
				end
				addTextY = 0
			end
			if keyboardJustPressed('ENTER') then curSub = 'songs' songSelec = 1 runTimer('canPlay',0.1) end
		end
		if curSub == 'songs' then --SONGS MENU
			for i=1,10 do setTextColor('song'..i, '000000') setTextBorder('song'..i,2.5,'FFFFFF') end
			setTextColor('song'..songSelec, 'FFFFFF') setTextBorder('song'..songSelec,0,'000000')
			if keyboardJustPressed('ENTER') and canPlay then loadSong(_G[weekNames[weekSelec]][songSelec],0) close() end
		end
	end
end
function onCustomSubstateDestroy(name)
	if name == 'freeplay' then 
		removeLuaSprite('blackLine')
		removeLuaSprite('fpbg')
		removeLuaSprite('sidebar')
		for i = 1, #weekNames do
			removeLuaSprite(weekNames[i])
		end
		removeLuaText('title')
		for i=0,20 do removeLuaText('song'..i) end
	end
end

function onTimerCompleted(tag)
	if tag == 'canPlay' then canPlay = true end
end