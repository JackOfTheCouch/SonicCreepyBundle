local endingTime = false
function onCreate()
	addHaxeLibrary('Paths')
end
function onCountdownTick()
	runHaxeCode([[
	Paths.clearUnusedMemory();
	]])
end
function onSongStart()
	runHaxeCode([[
	Paths.clearUnusedMemory();
	]])
end

function onEvent(n,v1,v2)
	if n == 'Change Character' then
		runHaxeCode([[
		Paths.clearUnusedMemory();
		]])
	end
end

function onEndSong()
	endingTime = true
end

function onDestroy()
	if string.lower(songName) ~= 'main menu' and endingTime then loadSong('main menu',0) end
end