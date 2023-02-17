function onCreate()
	addHaxeLibrary('Paths')
end
function onStartCountdown()
	runHaxeCode([[
	Paths.clearUnusedMemory();
	]])
end
function onSongStart()
	runHaxeCode([[
	Paths.clearUnusedMemory();
	]])
end