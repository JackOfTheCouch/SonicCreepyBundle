local videoTime = false
function onCreate()
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'needle/needlemouse-loop'); --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'needle/needlemouse-retry'); --put in mods/music/
end

function onGameOverStart()
	setProperty('boyfriend.alpha',0)
	makeLuaSprite('death','characters/needle/needlemouse-death') scaleObject('death',screenWidth/1280,screenHeight/720) setObjectCamera('death','other')
	setProperty('death.alpha',0) runTimer('now',1.25) 
	addLuaSprite('death')
end

function onGameOverConfirm()
	doTweenAlpha('bye','death',0,2,'sineInOut')
end


function onTimerCompleted(tag)
	if tag == 'now' then doTweenAlpha('show','death',1,1,'expoOut') end
end