function onUpdatePost()
	if keyboardJustPressed('F4') then
		setProperty('cpuControlled', not getProperty('cpuControlled'))
		setProperty('botplayTxt.visible', not getProperty('botplayTxt.visible'))
	end
end