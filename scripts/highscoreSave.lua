function onCreate()
	initSaveData('highScores','psychenginemods/DS_SonicCreepyBundle')
	if type(getDataFromSave('highScores', string.lower(songName)..'Score')) ~= 'number' then
        setDataFromSave('highScores', string.lower(songName)..'Score', 0)
    end
end

function onEndSong()
	if getDataFromSave('highScores', string.lower(songName)..'Score') < score then 
		setDataFromSave('highScores', string.lower(songName)..'Score', score ) end
	flushSaveData('highScores')
end

function onDestroy()
	flushSaveData('highScores')
end