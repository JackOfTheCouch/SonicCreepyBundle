local winNum = 0
local spawnNum = 1
local warningShow = false

function onCreate()
	makeLuaText('warning','Press\nCTRL + W \n to close the windows!',300) setObjectCamera('warning','other')
	setTextSize('warning',40) screenCenter('warning')
	
end

function onEvent(n,v1,v2)
	if n == 'Fatal Popup' then
		if not warningShow then setObjectOrder('warning',99) addLuaText('warning') warningShow = true end
		if v1 == '' or v1 == nil then spawnNum = 1 else spawnNum = tonumber(v1) end
		for i = 1, spawnNum do
			winNum = winNum + 1
			makeAnimatedLuaSprite('pop'..winNum,'stages/fatal/error_popups',getRandomInt(getPropertyFromGroup('playerStrums', 0, 'x')-200,getPropertyFromGroup('playerStrums', 3, 'x')-50),getRandomInt(50,screenHeight-250)) addAnimationByPrefix('pop'..winNum,'pop','idle',24,false) 
			setObjectCamera('pop'..winNum,'other') setProperty('pop'..winNum..'.antialiasing',false)
			doTweenX('popX'..winNum,'pop'..winNum..'.scale',1.7,crochet/1000,'elasticOut') doTweenY('popY'..winNum,'pop'..winNum..'.scale',1.7,crochet/1000,'elasticOut')
			if getHealth() > 0.1 then addHealth(-3*0.023) end
			addLuaSprite('pop'..winNum)
		end
	end
	if n == 'Clear Popups' then
		for c = 0, winNum do
			playAnim('pop'..c,'pop',true,true)
			doTweenX('popX'..c..'bye','pop'..c..'.scale',1,crochet/1000*0.75,'elasticIn') doTweenY('popY'..c..'bye','pop'..c..'.scale',1,crochet/1000*0.7,'elasticIn')
		end
		winNum = 0
	end
end

function onUpdate()
	if keyboardPressed('CONTROL') and keyboardJustPressed('W') then
			removeLuaText('warning',true)
			playAnim('pop'..winNum,'pop',true,true)
			doTweenX('popX'..winNum..'bye','pop'..winNum..'.scale',1,crochet/1000*0.75,'elasticIn') doTweenY('popY'..winNum..'bye','pop'..winNum..'.scale',1,crochet/1000*0.7,'elasticIn')
			winNum = winNum - 1
	end
	if winNum < 0 then winNum = 0 end
end

function onTweenCompleted(tag)
	for i=-1,200 do
		if tag == 'popX'..i..'bye' then removeLuaSprite('pop'..i) end
	end
end