local changeStep
local beepTime = 0
local textNumbers = 35
local textPos = 0
local addText = 'ILLEGALINSTRUCTION$000010E'
local unmute = false

function onCreate()
	addHaxeLibrary('Paths')
	
	makeLuaSprite('blackBox', '',-100,-100)
	makeGraphic('blackBox', screenWidth, screenHeight, '000000')
	setObjectCamera('blackBox','hud')
	scaleObject('blackBox',1.2,1.2)
	setObjectOrder('blackBox',99)
	setProperty('blackBox.alpha',0)
	addLuaSprite('blackBox')
	
	for i=0,textNumbers do
		makeLuaText('text'..i,'', 1380, (screenWidth/2)-(1260/2), textPos)
		textPos = textPos + 20
		setTextString('text'..i,addText..addText..addText..addText..addText)
		setObjectCamera('text'..i,'other')
		setTextSize('text'..i, 18)
		setTextAlignment('text'..i,'left')
		setTextFont('text'..i, 'mania-free.ttf')
		setProperty('text'..i..'.antialiasing',false)
		addLuaText('text'..i)
		setProperty('text'..i..'.alpha',0)
	end
	
end

function onCreatePost()
	setTextString('text3','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010EILLE  ALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text4','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000   10E LLEGALINSTRUCTION$00001      ILLEG  LINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text5','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000   10EIL   EGALINSTRUCTION$000   10EILLEG   LINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text6','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$00   010EILLEG      INSTRUCTION$0      010EILLEG   LINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text7','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$0   0010EILLEGAL     STRUCTION     00010EILLEGALI     STRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text8','ILLEGALINSTRUCTION$000010EILLEGALINSTR   CT ON$00   010EILLEGALIN   TRUCTIO    $0000     EILLEGA    NST   UCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text9','ILLEGALINSTRUCTION$000010EILLEGALIN   TR   CTI  N   000   10EI      EG  LINSTRUCTI   N$   000        ILLEGA   IN  TR   C  I   N$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text10','ILLEGALINSTRUCTION$000010EILLEGALINST   U   TION$0   00   0EI                I    S  RUCT ON$     0             LLEGA   INSTRUC  ION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text11','ILLEGALINSTRUCTION$000010EILLEGALINS   RUCTION$000010                         STR   C   ION                            EGALINSTRU   TION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text12','ILLEGALINSTRUCTION$000010EILLEGALINSTRU   TION$00001                            STR      TIO                            LEGALINSTRUC   ION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text13','ILLEGALINSTRUCTION$000010EILLEGALINS   R   C   ION$000010                            TRUCTI                                 EG   LINS  R   CTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text14','ILLEGALINSTRUCTION$000010EILLEGALINSTRU    TIO   $00001                               TRUCT                                LEG   LI   ST  U   TION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text15','ILLEGALINSTRUCTION$000010EILLEGALINSTRU    TIO   $00001                               TRUCT                                LEG   LI   ST  U   TION$000010EILLEGALINSTRUCTION$000010E','')
	setTextString('text16','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTI   N$    00010                            TR   C                       1      ILLE     LINS RUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text17','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$00   010EILL                   T        T                  01   EILL       LINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text18','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000        EILL     A   I    S              I      $0     010EIL          LINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text19','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000        EILLEGA   IN                  O   $000010EI        GALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text20','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$00001      ILLEGALINS     U      ION$000010              ALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text21','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010         EGALINSTRU   TION$00001               GALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text22','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010         EG   LINSTRUCTION$000                  EGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text23','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E                 I    STRUCTI   N   00                 LEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text24','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010EILL                  T      CT  ON                     ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text25','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010EILLE                                                  1  E  LLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text26','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010EILLEGA                                      0     0EILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text27','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010EILLEGALI    S                              010EILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text28','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010EILLEGA    N      R                       0010EILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text29','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010EILLEGALINST           I     $0   0010EILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
	setTextString('text30','ILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010EILLEGALINSTR     T       $000010EILLEGALINSTRUCTION$000010EILLEGALINSTRUCTION$000010E')
end

function onUpdatePost()
	if unmute then setProperty('vocals.volume',1) end
end
local txt = 0
local shakeInt = 0.0001
function onStepHit()
	if curStep >= 512 then
		unmute = true
		setProperty('blackBox.alpha',1)
	end
	if curStep == 520 or curStep == 520 + beepTime and beepTime < 128 then
		playSound('hog/error',0.3)
		setProperty('text'..txt..'.alpha',1)
		cameraShake('other', shakeInt, (stepCrochet/1000)*16)
		txt = txt + 1
		beepTime = beepTime + 16
		shakeInt = shakeInt + 0.0002
	end

	if curStep == changeStep + 16 then
		runHaxeCode([[
		Paths.clearUnusedMemory();
		]])
	end
end

function onBeatHit()
	if curBeat == 161 then
		playSound('hog/error',0.3,'errorLoop')
	end
	if curBeat >= 161 and txt < 36 then
		cameraShake('other', shakeInt, crochet/1000)
		setProperty('text'..txt..'.alpha',1)
		txt = txt + 1
		shakeInt = shakeInt + 0.0002
	end
	
	if curBeat >= 188 and curBeat < 196 then
		cameraShake('other', shakeInt, crochet/1000)
		shakeInt = shakeInt + 0.00015
	end
	
	if curBeat == 196 then
		for i=0, textNumbers do
			removeLuaText('text'..i,true)
		end
		removeLuaSprite('blackBox',true)
		setProperty('camHUD.alpha',0)
		setProperty('defaultCamZoom',0.85)
	end
	if curBeat >= 196 and curBeat < 211 then
		unmute = false
		cameraShake('game', shakeInt, crochet/1000)
	end
	
	if curBeat == 211 then
		addCharacterToList('scorchedglitch2','dad')
	end
	if curBeat >= 216 and curBeat <= 220 then
		setProperty('defaultCamZoom',0.63)
		doTweenAlpha('backAgain','camHUD',1,crochet/2000,'linear')
		doTweenAlpha('byeBlack','blackBg',0,crochet/2000,'linear')
	end
	if curBeat == 220 then
		close()
	end
end

function onEvent(n,v1,v2)
	if n == 'scorchedStage' then
		changeStep = curStep
	end
end

function onSoundFinished(tag)
	if tag == 'errorLoop' and txt < 36 then
		playSound('hog/error',0.3,'errorLoop')
	end
end

function onDestroy()
	runHaxeCode([[
	Paths.clearUnusedMemory();
	]])
end