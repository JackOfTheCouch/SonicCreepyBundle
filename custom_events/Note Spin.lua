local initAngDad = {}
local initAngBF = {}

function onEvent(n,v1,v2)
	if n == 'Note Spin' then
		for i = 0, 3 do
			initAngDad[i+1] = getPropertyFromGroup('opponentStrums', i, 'angle')
			initAngBF[i+1] = getPropertyFromGroup('playerStrums', i, 'angle')
		end
		for d=0, 3 do
			noteTweenAngle('speenD'..d,d,initAngDad[d+1]+360,stepCrochet/1000*tonumber(v1), 'linear')
		end
		for b=4, 7 do
			noteTweenAngle('speenBF'..b,b,initAngBF[b-3]+360,stepCrochet/1000*tonumber(v1), 'linear')
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'speenD0' then
		for a=0,3 do
			setPropertyFromGroup('opponentStrums',a,'angle',initAngDad[a+1])
			setPropertyFromGroup('playerStrums',a,'angle',initAngBF[a+1])
		end
	end
end