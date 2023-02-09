local function RGBtoHex(rgb)
    local hexadecimal = '' -- yeah ignore

    for key, value in pairs(rgb) do
        local hex = ''

        while(value > 0)do
            local index = math.fmod(value, 16) + 1
            value = math.floor(value / 16)
            hex = string.sub('0123456789ABCDEF', index, index) .. hex            
        end

        if(string.len(hex) == 0)then
            hex = '00'

        elseif(string.len(hex) == 1)then
            hex = '0' .. hex
        end

        hexadecimal = hexadecimal .. hex
    end

    return hexadecimal
end

function onCreatePost()
	dadHC = RGBtoHex(getProperty("dad.healthColorArray"))
	setTimeBarColors(tostring(dadHC))
end
function onEvent(name, value1, value2)
	if name == 'Change Character' then
		dadHC = RGBtoHex(getProperty("dad.healthColorArray"))
		setTimeBarColors(tostring(dadHC))
	end
end