local dodgeNow = false
local dodged = false
local healthLoss

function onEvent(name, value1, value2)
	if name == 'DodgeEvent' then
		dodged = false
		dodgeNow = true
		healthLoss = tonumber(value2)
		runTimer('DODGE ASSHOLE',(stepCrochet/1000)*tonumber(value1))
	end
end

function onUpdate()
	if keyJustPressed('space') == true and dodgeNow and not dodged then
		dodged = true
		--debugPrint('DODGED')
		triggerEvent('Play Animation','dodge','Boyfriend')
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'DODGE ASSHOLE' then
		if not dodged then
			--debugPrint('iDIOT')
			triggerEvent('Play Animation','hurt','Boyfriend')
			addHealth(-1*healthLoss)
		else
			--debugPrint('YOU DID IT BASTARD')
		end
		dodgeNow = false
	end
end