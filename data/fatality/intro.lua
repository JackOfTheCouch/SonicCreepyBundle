
function onCreatePost()
	for i=1,3 do
		makeLuaSprite('fatal_'..i,'stages/fatal/fatal_'..i) setObjectCamera('fatal_'..i,'other') scaleObject('fatal_'..i,3,3) screenCenter('fatal_'..i,'xy') setProperty('fatal_'..i..'.antialiasing',false)
		setProperty('fatal_'..i..'.alpha',0) 
		addLuaSprite('fatal_'..i)
		doTweenX('fatal_'..i..'x','fatal_'..i..'.scale',0,0.0001,'linear')
		doTweenY('fatal_'..i..'y','fatal_'..i..'.scale',0,0.0001,'linear')
	end
end

function onCountdownTick(counter)
	playSound('fatal/Fatal_'..counter)
	setProperty('fatal_'..counter..'.alpha',1)
	if counter < 4 then setProperty('fatal_'..(counter-1)..'.alpha',0) end
		doTweenX('fatal_'..counter..'x','fatal_'..counter..'.scale',3,crochet/1000,'elasticOut')
		doTweenY('fatal_'..counter..'y','fatal_'..counter..'.scale',3,crochet/1000,'elasticOut')
	--doTweenAlpha('fatal_'..counter,'fatal_'..counter,1,crochet/1000*0.9,'quadInOut')
	if counter == 4 then doTweenAlpha('fatal_3bye','fatal_3',0,crochet/1000*0.9,'quadInOut') end
end
function onTweenCompleted(tag) 
	for i = 1, 2 do
		if tag == 'fatal_'..i then
			doTweenAlpha('fatal_'..i..'bye','fatal_'..i,0,crochet/1000*0.1,'quadInOut')
		end
	end
end