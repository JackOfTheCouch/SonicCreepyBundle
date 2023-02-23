local iconColor = false

function getIconColor(chr)
	if iconColor then
		return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
	else
		return getColorFromHex('FFFFFF')
	end
end

function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if _G['boyfriendGhostData.strumTime'] == getPropertyFromGroup('notes', id, 'strumTime') and not isSustainNote then
		createGhost('boyfriend')
	end
	if not isSustainNote then
		_G['boyfriendGhostData.strumTime'] = getPropertyFromGroup('notes', id, 'strumTime')
		updateGData('boyfriend')	
	end
	if noteType == 'GF Sing' then
		if _G['gfGhostData.strumTime'] == getPropertyFromGroup('notes', id, 'strumTime') and not isSustainNote then
			createGhost('gf')
		end
		if not isSustainNote then
			_G['gfGhostData.strumTime'] = getPropertyFromGroup('notes', id, 'strumTime')
			updateGData('gf')	
		end
	end
end
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if _G['dadGhostData.strumTime'] == getPropertyFromGroup('notes', id, 'strumTime') and not isSustainNote then
		createGhost('dad')
	end
	if not isSustainNote then
		_G['dadGhostData.strumTime'] = getPropertyFromGroup('notes', id, 'strumTime')
		updateGData('dad')	
	end
	if getPropertyFromGroup('notes', id, 'gfNote') then
		if _G['gfGhostData.strumTime'] == getPropertyFromGroup('notes', id, 'strumTime') and not isSustainNote then
			createGhost('gf')
		end
		if not isSustainNote then
			_G['gfGhostData.strumTime'] = getPropertyFromGroup('notes', id, 'strumTime')
			updateGData('gf')	
		end
	end
end

function createGhost(char)
	songPos = getSongPosition() --in case game stutters
    makeAnimatedLuaSprite(char..'Ghost'..songPos, getProperty(char..'.imageFile'),getProperty(char..'.x'),getProperty(char..'.y'))
    addLuaSprite(char..'Ghost'..songPos, false)
	setProperty(char..'Ghost'..songPos..'.visible', getProperty(char..'.visible'))
    setProperty(char..'Ghost'..songPos..'.scale.x',getProperty(char..'.scale.x'))
	setProperty(char..'Ghost'..songPos..'.scale.y',getProperty(char..'.scale.y'))
	setProperty(char..'Ghost'..songPos..'.flipX', getProperty(char..'.flipX'))
	setProperty(char..'Ghost'..songPos..'.flipY', getProperty(char..'.flipY'))
	setProperty(char..'Ghost'..songPos..'.antialiasing', getProperty(char..'.antialiasing'))
	setProperty(char..'Ghost'..songPos..'.color', getIconColor(char))
	setProperty(char..'Ghost'..songPos..'.alpha', 1)
	doTweenAlpha(char..'Ghost'..songPos..'delete', char..'Ghost'..songPos, 0, 0.4)
	setProperty(char..'Ghost'..songPos..'.animation.frameName', _G[char..'GhostData.frameName'])
	setProperty(char..'Ghost'..songPos..'.offset.x', _G[char..'GhostData.offsetX'])
	setProperty(char..'Ghost'..songPos..'.offset.y', _G[char..'GhostData.offsetY'])
	setObjectOrder(char..'Ghost'..songPos, getObjectOrder(char..'Group')-1)
end

function onTweenCompleted(tag)
	if (tag:sub(#tag- 5, #tag)) == 'delete' then
		removeLuaSprite(tag:sub(1, #tag - 6), true)
	end
end

function updateGData(char)
	_G[char..'GhostData.frameName'] = getProperty(char..'.animation.frameName')
	_G[char..'GhostData.offsetX'] = getProperty(char..'.offset.x')
	_G[char..'GhostData.offsetY'] = getProperty(char..'.offset.y')
end

-- i like number 45 :thumbs_up: