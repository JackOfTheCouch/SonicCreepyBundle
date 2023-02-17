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

function onCreate()

	makeLuaSprite('black','',0,0)
	makeGraphic('black', screenWidth, screenHeight, '000000')
	setObjectCamera('black', 'other')
	addLuaSprite('black', true)
	
	makeLuaSprite('circle','StartScreens/circleDef',1366,0)
	scaleObject('circle', screenWidth/960, screenHeight/540)
	setObjectCamera('circle', 'other')
	setProperty('circle.antialiasing', false)
	addLuaSprite('circle', true)
	
	makeLuaSprite('circleText','StartScreens/text-'..string.lower(songName),-1366,0)
	scaleObject('circleText', screenWidth/960, screenHeight/540)
	setObjectCamera('circleText', 'other')
	setProperty('circleText.antialiasing', false)
	addLuaSprite('circleText', true)
	
end

local dadColor
function onCreatePost()
	dadColor = RGBtoHex(getProperty("dad.healthColorArray"))
	setProperty('circle.color',getColorFromHex(dadColor))
end

function onCountdownTick(counter)
	if counter == 0 then
	doTweenX('circle', 'circle', 0, 0.75, 'linear')
	doTweenX('circleText', 'circleText', 0, 0.75, 'linear')
	end
	if counter == 4 then
	doTweenAlpha('circleA', 'circle', 0, 0.75, 'linear')
	doTweenAlpha('circleTextA', 'circleText', 0, 0.75, 'linear')
	doTweenAlpha('blackA', 'black', 0, 0.75, 'linear')
	end
	-- counter = 0 -> "Three"
	-- counter = 1 -> "Two"
	-- counter = 2 -> "One"
	-- counter = 3 -> "Go!"
	-- counter = 4 -> Nothing happens lol, tho it is triggered at the same time as onSongStart i think
end

function onTweenCompleted(tag)
	-- A tween you called has been completed, value "tag" is it's tag
	if tag == 'circleA' then
		removeLuaSprite('circleA', true)
		removeLuaSprite('circleTextA', true)
		removeLuaSprite('blackA', true)
	end
end