function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Static_Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'staticNotes_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.095');
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has no penalties
			end
		end
	end
	if string.lower(songName) ~= 'manual blast' then
	makeAnimatedLuaSprite('staticnoteeffectlol','hitStatic',0,0);
	addAnimationByPrefix('staticnoteeffectlol','staticANIMATION','staticANIMATION',22,false);
	setProperty('staticnoteeffectlol.alpha',0);
	setObjectCamera('staticnoteeffectlol', 'other')
	setProperty('staticnoteeffectlol.antialiasing', false)
	scaleObject('staticnoteeffectlol', screenWidth/642, screenHeight/360)
	
	precacheSound('hitStatic1');
	addLuaSprite('staticnoteeffectlol',true);
	end
	
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'Static_Note' and not isSustainNote then
		setProperty('staticnoteeffectlol.alpha',1);
		objectPlayAnimation('staticnoteeffectlol','staticANIMATION',true);
		if string.lower(songName) ~= 'manual blast' then playSound('hitStatic1') end
	end
end

function onUpdate(elapsed)
    if getProperty('staticnoteeffectlol.animation.curAnim.finished') and getProperty('staticnoteeffectlol.animation.curAnim.name') == 'staticANIMATION' then
        setProperty('staticnoteeffectlol.alpha', 0)
    end
end