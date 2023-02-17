
-- the name of this script, which is the name of the character
local charName;


function onCreatePost()
    charName = scriptName:sub(- scriptName:reverse():find('/') + 1,-5);

	for i = 0, getProperty('unspawnNotes.length')-1 do
        -- Check if the note is an Sustain Note
        if getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
            -- Checks stuff
            local gfNote = getPropertyFromGroup('unspawnNotes', i, 'gfNote') or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing';
                -- if character is player and note mustPress or..
            if  (boyfriendName == charName and getPropertyFromGroup('unspawnNotes', i, 'mustPress') and not gfNote) or
                -- if character is gf and note is gfNote or GF Sing type or..
                (gfName == charName and gfNote) or
                -- if character is opponent and not note mustPress
                (dadName == charName and not getPropertyFromGroup('unspawnNotes', i, 'mustPress') and not gfNote) then
                
			    setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
            end
        end
    end
end


function goodNoteHit(id, direction, noteType, isSustainNote)
    -- Check if the note is an Sustain Note
    if isSustainNote then
        -- Check if character is gf and note is gfNote or GF Sing type
        if gfName == charName and (getPropertyFromGroup('notes', id, 'gfNote') or noteType == 'GF Sing') then
            setProperty('gf.holdTimer', 0);
        -- Check if character is player
        elseif boyfriendName == charName then
            setProperty('boyfriend.holdTimer', 0);
        end
    end
end


function opponentNoteHit(id, direction, noteType, isSustainNote)
    -- Check if the note is an Sustain Note
    if isSustainNote then
        -- Check if character is gf and note is gfNote or GF Sing type
        if gfName == charName and (getPropertyFromGroup('notes', id, 'gfNote') or noteType == 'GF Sing') then
            setProperty('gf.holdTimer', 0);
        -- Check if character is opponent
        elseif dadName == charName then
            setProperty('dad.holdTimer', 0);
        end
    end
end