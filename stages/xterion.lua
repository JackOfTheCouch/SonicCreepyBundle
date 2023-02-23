function getMidpointSprite(sprite,axis)
	local sprWdth = getProperty(sprite..'.width')
	local sprHght = getProperty(sprite..'.height')
	
	if axis == 'x' then return sprWdth/2 elseif axis == 'y' then return sprHght/2 end
end
function split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end
function round(x, n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

local hudShit = {'timeBar','timeBarBG','timeTxt','scoreTxt','iconP1','iconP2'}
local defTime
function onCreate()
	if shadersEnabled then
	
		initLuaShader('vhs1') -- MAKES CUBES
		makeLuaSprite('vhsGame')
		makeGraphic('vhsGame', screenWidth, screenHeight)
		setSpriteShader('vhsGame', 'vhs1')
		
		runHaxeCode([[
			game.camGame.setFilters([new ShaderFilter(game.getLuaObject("vhsGame").shader)]);
			game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("vhsGame").shader)]);
			game.camOther.setFilters([new ShaderFilter(game.getLuaObject("vhsGame").shader)]);
		]])
	end
	defTime = getPropertyFromClass('ClientPrefs', 'timeBarType')
	
	setPropertyFromClass('ClientPrefs', 'timeBarType', 'Time Elapsed')
	initLuaShader('3D Floor')
	initLuaShader('scroll')
	
	--STAGE
	makeLuaSprite('sky','stages/xterion/sky',-1350, -1140)
	scaleObject('sky',2,2)
	setScrollFactor('sky',3,1)
	addLuaSprite('sky')
	setSpriteShader('sky', 'scroll') 
	setShaderFloat('sky','xSpeed',0.15)
	setShaderFloat('sky','ySpeed',0)
		
	makeLuaSprite('floor','stages/xterion/floor2',-2066, 440)
	scaleObject('floor',2,1.10)
	setScrollFactor('boyfriendGroup',1.33,1)
	setScrollFactor('dadGroup',1.35,1.3)
	setSpriteShader('floor', '3D Floor')
	
	addLuaSprite('floor')
	
end

function onCreatePost()
	setProperty('showComboNum', false)
	for i=1, #hudShit do setProperty(hudShit[i]..'.visible',false) end
	setProperty('healthBar.angle',90)
	setProperty('healthBar.x',screenWidth-355)
	screenCenter('healthBar','y')
	setProperty('healthGain',0.25)
	setProperty('healthLoss',3)

	makeLuaSprite('HUD','stages/xterion/HUD',25,0)
	setProperty('HUD.antialiasing',false)
	setObjectCamera('HUD','hud')
	scaleObject('HUD',3,3)
	
	if downscroll then setProperty('HUD.y',25) else setProperty('HUD.y',screenHeight - getProperty('HUD.height') - 25) end
	setObjectOrder('HUD',getObjectOrder('notes')+10)
	addLuaSprite('HUD')
	
	makeLuaText('scoreLol', '0', 400, getProperty('HUD.x')+24.5, getProperty('HUD.y')+6)
	setTextSize('scoreLol',30)
	setTextFont('scoreLol','sonic-jam-numbers.ttf')
	setTextBorder('scoreLol',0,'FFFFFF')
	setTextAlignment('scoreLol','right')
	setObjectCamera('scoreLol','hud')
	addLuaText('scoreLol')
	
	makeLuaText('time', '', 500, getProperty('HUD.x')+224, getProperty('HUD.y')+54)
	setTextSize('time',30)
	setTextFont('time','sonic-jam-numbers.ttf')
	setTextBorder('time',0,'FFFFFF')
	setTextAlignment('time','left')
	setObjectCamera('time','hud')
	setProperty('time.alpha',0)
	addLuaText('time')
	
	makeLuaText('comboYay', '0', 200, getProperty('HUD.x')+152, getProperty('HUD.y')+102)
	setTextSize('comboYay',30)
	setTextFont('comboYay','sonic-jam-numbers.ttf')
	setTextBorder('comboYay',0,'FFFFFF')
	setTextAlignment('comboYay','right')
	setObjectCamera('comboYay','hud')
	addLuaText('comboYay')
end

function onSongStart()
end

function onStepHit()
	if curStep == 1 then loadGraphic('HUD','stages/xterion/HUDEmp') setProperty('time.alpha',1) end
end

local comboCount = 0
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if not isSustainNote then comboCount = comboCount + 1 end
	setTextString('comboYay',tostring(comboCount))
end

function noteMiss()
	if comboCount ~= 0 then comboCount = 0 setTextString('comboYay',tostring(comboCount)) end
end
function noteMissPress()
	if comboCount ~= 0 then comboCount = 0 setTextString('comboYay',tostring(comboCount)) end
end

function onUpdate()
	setShaderFloat('floor','curveX',(((getProperty('camGame.scroll.x') + (getProperty('floor.width') / 2)) - getMidpointSprite('floor','x')) / 0.4) / math.pi / getProperty('floor.width'))
	setShaderFloat('floor','curveY',(((getProperty('camGame.scroll.y') + (getProperty('floor.height') / 2)) - getMidpointSprite('floor','y')) * 1) / math.pi / getProperty('floor.height'))
	setShaderFloat('vhsGame','iTime',os.clock())
	setShaderFloat('sky','iTime',getSongPosition()/1000)
	
	local timeSep = split(getTextString('timeTxt'),':')
	local mSec = split(tostring(round(getSongPosition()/1000,2)),'.')
	if mSec[2] == nil then mSec[2] = '00' end
	
	setTextString('time',tostring(timeSep[1])..'  '..tostring(timeSep[2])..'  '..mSec[2])
end

function onUpdateScore() setTextString('scoreLol',tostring(score)) end

function onGameOverStart()
	setProperty('boyfriend.visible',false)
end

function onGameOverConfirm()
	cameraFlash('game', 'B71010', 5)
end

function onDestroy()
	setPropertyFromClass('ClientPrefs', 'timeBarType', defTime)
end