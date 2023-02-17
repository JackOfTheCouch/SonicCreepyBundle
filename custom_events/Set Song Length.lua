local defaultLength = 0
local idk = 0
function onCreatePost()
    defaultLength = getPropertyFromClass('flixel.FlxG', 'sound.music.length')
    idk = defaultLength
    --debugPrint(tostring(defaultLength))
end
function onUpdatePost(elapsed)
    defaultLength = getPropertyFromClass('flixel.FlxG', 'sound.music.length')
end
function onEvent(n, v1, v2)
    if n == 'Set Song Length' then
        local funnyyy = 0
        local fnuuyyy = 'linear'
        if v2 ~= '' then
            funnyyy = stringTrim(stringSplit(v2, ',')[1])
            if string.find(v2, ',') then
                fnuuyyy = stringTrim(stringSplit(v2, ',')[2])
                fnuuyyy = fnuuyyy:lower()
                fnuuyyy = fnuuyyy:gsub(' ', '')
                fnuuyyy = fnuuyyy:gsub('step', 'Step')
                if stringEndsWith(fnuuyyy, 'in') then 
                    fnuuyyy = fnuuyyy:gsub('in', 'In')
                elseif stringEndsWith(fnuuyyy, 'inout') then 
                    fnuuyyy = fnuuyyy:gsub('inout', 'InOut')
                elseif stringEndsWith(fnuuyyy, 'out') then 
                    fnuuyyy = fnuuyyy:gsub('out', 'Out')
                end
            end
        end
        if string.lower(stringTrim(v1)) == 'default' then
            idk = defaultLength
        else
            idk = tonumber(stringTrim(v1))
        end
        if tonumber(stringTrim(funnyyy)) <= 0 then
            setProperty('songLength', idk)
        elseif tonumber(stringTrim(funnyyy)) > 0 then
            addHaxeLibrary('FunkinLua')
            addHaxeLibrary('flixel.FlxG') -- useless???
            addHaxeLibrary('flixel.system.FlxSound') -- useless???
            runHaxeCode([[
                targetValue = ]]..idk..[[;
                duration = ]]..funnyyy..[[;
                tweenTag = 'songLengthTweenThingHahaFunnyHilarious';


                // tween shits //
                if(game.modchartTweens.exists(tweenTag)) {
                   game.modchartTweens.get(tweenTag).cancel();
                   game.modchartTweens.get(tweenTag).destroy();
                   game.modchartTweens.remove(tweenTag);
                }
				game.modchartTweens.set(tweenTag, FlxTween.tween(game, {songLength: targetValue}, duration / game.playbackRate, {ease: FlxEase.]]..fnuuyyy..[[,
                    onComplete: function(twn:FlxTween) {
                        if(game.modchartTweens.exists(tweenTag)) {
                            game.callOnLuas('onTweenCompleted', [tweenTag]);
                            game.modchartTweens.remove(tweenTag);
                        }
                    }
                }));
            ]])
        end
    end
end