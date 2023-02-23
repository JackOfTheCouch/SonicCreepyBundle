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
local input
function onEvent(name, value1, value2)
	if name == 'cameraShake' then
		input = mysplit(value1)
		debugPrint(input[2])
		cameraShake(input[1],tonumber(input[2]),(stepCrochet/1000)*(tonumber(value2)))
	end
end