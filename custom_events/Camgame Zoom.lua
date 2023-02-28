function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end
local zoomInput, newZoom
function onEvent(name, value1, value2)
	if name == 'Camgame Zoom' then
		zoomInput = mysplit(value2)
		newZoom = tonumber(value1)
		doTweenZoom('zoomEventl','camGame',newZoom,stepCrochet/1000*tonumber(zoomInput[1]),zoomInput[2])
	end
end

function onTweenCompleted(tag)
	if tag == 'zoomEventl' then
		setProperty('defaultCamZoom',newZoom)
	end
end