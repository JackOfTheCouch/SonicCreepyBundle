function lerp(a, b, ratio) -- FlxMath.lerp()
    return a + ratio * (b - a)
end
function boundTo(value, min, max) -- CoolUtil.boundTo()
    return math.max(min, math.min(max, value));
end

function onCreate()
	
	if not shadersEnabled then close() end
	
	initLuaShader('GlitchShaderB') -- MAKES CUBES
	makeLuaSprite('glitchGame')
	makeGraphic('glitchGame', screenWidth, screenHeight)
	setSpriteShader('glitchGame', 'GlitchShaderB')
	setShaderFloat('glitchGame','Amount',0)
	
	initLuaShader('StaticShader') -- STATIC AND BS
	makeLuaSprite('staticGame')
	makeGraphic('staticGame', screenWidth, screenHeight)
	setSpriteShader('staticGame', 'staticShader')
	setShaderFloat('staticGame','alpha',1)
	setShaderBool('staticGame','enabled',false)
	
	runHaxeCode([[
		game.camGame.setFilters([new ShaderFilter(game.getLuaObject("staticGame").shader),new ShaderFilter(game.getLuaObject("glitchGame").shader)]);
		game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("glitchGame").shader)]);
	]])
end

function onUpdate(elapsed)
	local glitchYe = lerp(0.1, getShaderFloat('glitchGame','Amount'), boundTo(1 - (elapsed * 3.125),0,1))
	local glitchNo = lerp(0, getShaderFloat('glitchGame','Amount'), boundTo(1 - (elapsed * 3.125),0,1))
	
	setShaderFloat("staticGame",'iTime',os.clock())
	setShaderFloat("glitchGame",'iTime',os.clock())
	
	if getShaderFloat('glitchGame','Amount') >= 1 then setShaderFloat('glitchGame','Amount',1) end
	
	if stringStartsWith(dadName,'scorchedglitch') then 
		setShaderFloat('glitchGame','Amount',glitchYe)
	else
		setShaderFloat('glitchGame','Amount',glitchNo)
	end
	
end

function onStepHit()
	if curStep == 3120 then
	end
end

function onBeatHit()
	if curBeat % 4 == 0 then
		if stringStartsWith(dadName,'scorchedglitch') then 
			if stringStartsWith(dadName,'scorchedglitch') and not isSustainNote then 
				setShaderFloat('glitchGame','Amount',getShaderFloat('glitchGame','Amount')+0.2)
			end
		end
	end
end

function onEvent(n,v1,v2)
	if n == 'glitch' then
		if getRandomBool(25) then
			setShaderBool('staticGame','enabled',true)
			runTimer('glitchTime',0.45)
		end
	end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if stringStartsWith(dadName,'scorchedglitch') and not isSustainNote then 
		local glitchAm = getShaderFloat('glitchGame','Amount')
		setShaderFloat('glitchGame','Amount',glitchAm + 0.05)
	end
end

function removeCamFilter(cam)
	-- `cam` - Camera you want the shader to be removed from. Should be camGame, camHUD, or camOther.
	if shadersEnabled then
		runHaxeCode('game.'..cam..'.setFilters(null);')	
		if luaDebugMode then
			debugPrint('removeCamFilter : Shader successfully removed from the camera "'..cam..'"')
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'glitchTime' then
		setShaderBool('staticGame','enabled',false)
	end
end