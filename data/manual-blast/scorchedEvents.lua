specialNoteProbability = 0
probIncreaseRate = 2
zoomTime = false

local icon 
iconsLol = {'beast','eyx','fatal-sonic','MightyZIP','Rerun','sallyalt','scorched','sonicexe','soylent','terion','cyclops','sunky'}
affectedSprite = "none"

function onCreate()
	makeLuaSprite('VG','HugeGrad2')
	scaleObject('VG',screenWidth/213,screenHeight/120)
	setProperty('VG.color',getColorFromHex('000000'))
	setProperty('VG.alpha',0)
	setObjectCamera('VG','hud')
	addLuaSprite('VG')
end
function onCreatePost()
	addHaxeLibrary('Paths') --For clerUnusedMemory shit

	makeLuaSprite('blackBg', '', screenWidth * -1.5, screenHeight * -1) --Self explanatory
	makeGraphic('blackBg', screenWidth * 2, screenHeight * 2, '000000')
	scaleObject('blackBg', 100, 100)
	setProperty('blackBg.alpha',0)
	addLuaSprite('blackBg')
	
	makeAnimatedLuaSprite('staticc','stages/hog/blast/staticc') --Passive static
	addAnimationByPrefix('staticc','staticc','staticc',24,true)
	scaleObject('staticc',screenWidth/480,screenHeight/270)
	setObjectCamera('staticc','hud')
	setObjectOrder('staticc',99)
	setProperty('staticc.alpha',0)
	addLuaSprite('staticc')
	
	
	makeLuaSprite('room', 'stages/hog/blast/Screen', 0,0) --Room sprite
	setObjectCamera('room','other')
	scaleObject('room', screenHeight/1025,screenHeight/1025)
	screenCenter('room','x')
	doTweenX('roomXS','room.scale',screenHeight/1025*3.3,0.000001,'linear')
	doTweenY('roomYS','room.scale',screenHeight/1025*3.3,0.000001,'linear')
	doTweenY('roomY','room',380,0.000001,'linear')
	setProperty('room.alpha',0)
	addLuaSprite('room')
	
	makeLuaSprite('scaleGraphic', '',1,1) --Graphic trick to tween values
	makeGraphic('scaleGraphic', 1,1, '000000')
	setProperty('scaleGraphic.visible',false)
	setProperty('scaleGraphic.visible',false)
	addLuaSprite('scaleGraphic')
	
	makeLuaSprite('AAmountGraphic', '',0,0) --same but for the glitch amount
	makeGraphic('AAmountGraphic', 1,1, '000000')
	setProperty('AAmountGraphic.visible',false)
	addLuaSprite('AAmountGraphic')
	
end

function glitchKill(sprite,steps) --function lol
	affectedSprite = sprite
	setSpriteShader(affectedSprite,'GlitchShaderA')
	doTweenX('kill','AAmountGraphic',1.25,(stepCrochet/1000)*steps,'linear')
end
function onStepHit()
	--PASSIVE
	if getPropertyFromGroup('unspawnNotes', 0, 'noteType') == '' and getPropertyFromGroup('unspawnNotes', 0, 'isSustainNote') == false then --CHANGE TO STATIC NOTES RANDOM
		if getRandomBool(specialNoteProbability) then
			if getPropertyFromGroup('unspawnNotes', 0, 'mustPress') and curStep >= 4160 then
				setPropertyFromGroup('unspawnNotes', 0, 'noteType', 'Static_Note')
				setPropertyFromGroup('unspawnNotes', 0, 'texture', 'staticNotesGray') end
			if not getPropertyFromGroup('unspawnNotes', 0, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', 0, 'noteType', 'Static_Note')
				setPropertyFromGroup('unspawnNotes', 0, 'texture', 'staticNotesGray') end
		end
	end
	if curBeat >= 1032 and curStep < 4920 then --Random character switching
		icon = iconsLol[getRandomInt(1,#iconsLol)]
		runHaxeCode("game.iconP2.changeIcon('"..icon.."');")
		if getRandomBool(50) then triggerEvent('Change Character', 'dad', 'scorchedglitch2') else triggerEvent('Change Character', 'dad', 'scorchedglitch') end
	end
	setShaderFloat(affectedSprite,'iTime',os.clock()) --Activates glitchy shader for objects
	if dadName == 'scorched' then doTweenAlpha('VG','VG',1-getHealth(),stepCrochet/1000,'linear') else setProperty('VG.alpha',0) end
	
	--EVENTS
	if curStep == 512 then	
		setProperty('blackBg.alpha',0.8)
		specialNoteProbability = 0.1
		initLuaShader('GlitchShaderA') end
	if curStep == 1760 then	
		doTweenAlpha('blackA','blackBg',0.75,crochet/2000,'linear')
		doTweenColor('colorBF','boyfriend','FFFFFF',crochet/2000,'linear') end
	if curStep == 2048 then	
		doTweenAlpha('blackA','blackBg',0,crochet/2000,'linear')
		doTweenColor('colorBF','boyfriend','B7B7B7',crochet/2000,'linear') end
	if curStep == 3144 then	
		specialNoteProbability = 2.5
		addCharacterToList('scorchedglitch','dad') end
	if curStep == 3160 then runHaxeCode([[ Paths.clearUnusedMemory();]]) end
	if curStep == 4128 then	
		specialNoteProbability = 5
		doTweenAlpha('blackA','blackBg',0.75,crochet/2000,'linear')
		doTweenColor('colorBF','boyfriend','FFFFFF',crochet/2000,'linear') end
	if curStep == 4160 then	
		doTweenAlpha('blackA','blackBg',0,crochet/2000,'linear')
		doTweenColor('colorBF','boyfriend','B7B7B7',crochet/2000,'linear') end
	if curStep == 4176 then runHaxeCode([[Paths.clearUnusedMemory();]]) end
	if curStep == 4434 then	glitchKill('mountains',32) debugPrint("Runtime ERROR: Couldn't find object: Mountains") end
	if curStep == 4476 then	glitchKill('wf',24) debugPrint("Runtime ERROR: Couldn't find object: Waterfalls") end
	if curStep == 4552 then	glitchKill('bg',30) debugPrint("Runtime ERROR: Couldn't find object: Hills") end
	if curStep == 4584 then	glitchKill('tree2',32) debugPrint("Runtime ERROR: Couldn't find object: tree2") end
	if curStep == 4652 then	glitchKill('rock2',24) debugPrint("Runtime ERROR: Couldn't find object: rock2") end
	if curStep == 4680 then	glitchKill('floor',32) debugPrint("Runtime ERROR: Couldn't find object: Floor") end
	if curStep == 4729 then	glitchKill('iconP1',6) debugPrint("Runtime ERROR: Couldn't find object: iconP1") end
	if curStep == 4740 then	glitchKill('iconP2',6) debugPrint("Runtime ERROR: Couldn't find object: iconP2") end
	if curStep == 4752 then	
		setProperty('healthBarBG.visible',false) 
		glitchKill('healthBar',8)
		debugPrint("Runtime ERROR: Couldn't find object: healthBar") 
		debugPrint("Runtime ERROR: Couldn't find object: healthBarBG") end
	if curStep == 4765 then	glitchKill('rock1',16) debugPrint("Runtime ERROR: Couldn't find object: rock1") end
	if curStep == 4808 then	glitchKill('tree1',22) debugPrint("Runtime ERROR: Couldn't find object: tree1") end
	if curStep == 4832 then
		setProperty('timeBar.visible',false)
		debugPrint("Runtime ERROR: Couldn't find object: timeBar") 
		glitchKill('timeBarBG',7)
		debugPrint("Runtime ERROR: Couldn't find object: timeBarBG") 
		setProperty('timeTxt.visible',false)
		setProperty('scoreTxt.visible',false) end
	if curStep == 4864 then	setPropertyFromGroup("opponentStrums", 3, "alpha", 0) debugPrint("Runtime ERROR: Couldn't find object: opponentStrums")  end
	if curStep == 4872 then	setPropertyFromGroup("opponentStrums", 0, "alpha", 0) end
	if curStep == 4880 then	setPropertyFromGroup("opponentStrums", 1, "alpha", 0) end
	if curStep == 4904 then	setPropertyFromGroup("opponentStrums", 2, "alpha", 0) end
	if curStep == 4920 then	
		setProperty('camHUD.visible',false)
		setProperty('cpuControlled',true)
		setProperty('blackBg.alpha',1)
		setObjectOrder('blackBg',getObjectOrder('grad'))
		makeGraphic('blackBg', screenWidth * 2, screenHeight * 2, 'FFFFFF')
		loadGraphic('blackBg','')
		glitchKill('grad',15)
		doTweenAlpha('grad','grad',0,(stepCrochet/1000)*15,'linear')
		doTweenColor('colorBF','boyfriend','000000',crochet/2000,'linear')
		doTweenColor('colorDad','dad','000000',crochet/2000,'linear') end
	if curStep == 4944 then glitchKill('boyfriend',32) end
	if curStep == 4976 then cameraFade('game','FFFFFF',(stepCrochet/1000)*24,true) end
	if curStep == 4960 then	
		zoomTime = true
		doTweenX('scaleTrick','scaleGraphic',0.31,3,'quadInOut')
		doTweenX('roomXS','room.scale',screenHeight/1025,3,'quadInOut')
		doTweenY('roomYS','room.scale',screenHeight/1025,3,'quadInOut')
		doTweenY('roomY','room',0,3,'quadInOut')
		setProperty('room.alpha',1)
		doTweenY('GAMEY','camGame',-60,3,'quadInOut') end
end

function onBeatHit() if curBeat >= 1040 then specialNoteProbability = specialNoteProbability + probIncreaseRate end end

function onSectionHit() if curSection >= 258 then probIncreaseRate = probIncreaseRate + 0.25 end end

local shakeFloat
local healthRemove
function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if curBeat >= 216 then
		if dadName == 'scorched' then
			shakeFloat = 0.0015
			healthRemove = 0.023/1.5
		elseif stringStartsWith(dadName,'scorchedglitch') then
			shakeFloat = 0.005
			healthRemove = 0.023/1.6
		end
		cameraShake('game',2*shakeFloat,stepCrochet/1000)
		cameraShake('hud',shakeFloat,stepCrochet/1000)
		if getHealth() > 0.1 then addHealth(-1*healthRemove) end
	end
	if noteType == 'Static_Note' and getProperty('staticc.alpha') < 0.4 and curBeat >= 1032 then setProperty('staticc.alpha',getProperty('staticc.alpha')+0.0075) end
end
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Static_Note' and not isSustainNote and getProperty('staticc.alpha') > 0 then
		setProperty('staticc.alpha',getProperty('staticc.alpha')-0.075)
		addHealth(-1*(0.023/1.5)) end
end
function onUpdate()
	setShaderFloat(affectedSprite,'GlitchAmount',getProperty('AAmountGraphic.x'))
	if stringStartsWith(dadName,'scorchedglitch') then for i = 0, 1 do setPropertyFromGroup('notes', i, 'multSpeed', getRandomFloat(0.95,1.35)) end end
end

function onUpdatePost()
	if zoomTime then setProperty('camGame.zoom',getProperty('scaleGraphic.x')/(100/63)) end
end

function onTweenCompleted(tag)
	if tag == 'kill' then
		setProperty('AAmountGraphic.x',0)
		setProperty(affectedSprite..'.alpha',0)
		setProperty(affectedSprite..'.visible',false)
		removeSpriteShader(affectedSprite)
		removeLuaSprite(affectedSprite,true)
		runHaxeCode([[Paths.clearUnusedMemory();]]) end
end
