local bopIntensDef = {0.015,0.03}
local bopIntensMult
local bopSpeed

function onCreate()
	setProperty('camZoomingMult',0)
end

function onEvent(name, value1, value2)
	if name == 'Set Beat Zoom' then
		if value1 == nil or value1 == '' then
			value1 = 4
		end
		if value2 == nil or value2 == '' then
			value2 = 1
		end
		bopSpeed = tonumber(value1)
		bopIntensMult = tonumber(value2)
	end
end

function onBeatHit()
    if curBeat % bopSpeed == 0 then
        triggerEvent('Add Camera Zoom', bopIntensDef[1]*bopIntensMult, bopIntensDef[2]*bopIntensMult) 
    end
end