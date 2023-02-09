local beatNum
local isActive
function onEvent(n, v1, v2)
	if n == 'Set Beat Bop' then
		isActive = tonumber(v1)
		beatNum = tonumber(v2)
		if isActive == 0 then
			doTweenY('YDef','camHUD',0,crochet/1000,'quintOut')
			doTweenAngle('AngleDef','camHUD',0,crochet/1000,'quintOut')
		end
	end
end

local dir = 0 --Determines which direction it goes, 0 = Right, 1 = Left
local didHudBop = false
function onBeatHit()
    if curBeat % beatNum == 0 and isActive == 1 then
		if dir == 1 then
			doTweenAngle('angle','camHUD',-1,(crochet/1000)/beatNum,'quintOut')
			dir =  0
		else
			doTweenAngle('angle2','camHUD',1,(crochet/1000)/beatNum,'quintOut')
			dir = dir + 1
		end
		doTweenY('Ydown','camHUD',10,(crochet/1000)/(beatNum*2),'quintOut')
    end
end

function onTweenCompleted(tag)
	if tag == 'Ydown' then doTweenY('Yup','camHUD',0,(crochet/1000)/(beatNum*2),'circIn') end
end