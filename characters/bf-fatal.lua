function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-fatal-death'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fatal/lost'); --put in mods/sounds/
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'fatal/gameOver'); --put in mods/music/
end
function onGameOverConfirm()
	cameraFlash('game', 'B71010', 5)
end