holdTimer = -1.0;
singDuration = 4;
specialAnim = false;

characterAnimationsList = {};

characterAnimationsList[0] = 'idle' -- idle
characterAnimationsList[1] = 'singLEFT' -- left
characterAnimationsList[2] = 'singDOWN' -- down
characterAnimationsList[3] = 'singUP' -- up
characterAnimationsList[4] = 'singRIGHT' -- right

player3 = 'Sarah'
directions = {'left', 'down', 'up', 'right'}

function onCreate()
	--- Caching the character into the memory ---
	makeAnimatedLuaSprite(player3, 'characters/needle/Sarah', 0, 0);

	--- Setting up Character Animations ---
	addAnimationByPrefix(player3, 'idle', 'Sarah_IDLE', 24, false);
	addOffset(player3, 'idle', -190, -100)

	addAnimationByPrefix(player3, 'singLEFT', 'Sarah_LEFT', 24, false);
	addOffset(player3, 'singLEFT', -60, -195)

	addAnimationByPrefix(player3, 'singDOWN', 'Sarah_DOWN', 24, false);
	addOffset(player3, 'singDOWN', -40, -118)

	addAnimationByPrefix(player3, 'singUP', 'Sarah_UP', 24, false);
	addOffset(player3, 'singUP', -208, -70)

	addAnimationByPrefix(player3, 'singRIGHT', 'Sarah_RIGHT', 24, false);
	addOffset(player3, 'singRIGHT', -70, -230)
	
	scaleObject(player3,1.2,1.2)
	updateHitbox(player3)
end

function onCreatePost()
	setProperty(player3..'.x', (getProperty('dad.x') - getProperty('dad.width')/4)+20);
	setProperty(player3..'.y', (getProperty('dad.y')+ getProperty('dad.height')/4)-380);
	--setProperty(player3..'.flipX', true) -- remove this for other characters
	
	doTweenY('sYUP',player3,getProperty(player3..'.y')-20,4,'quadInOut')
	
	addLuaSprite(player3, true);
	
	setObjectOrder(player3,getObjectOrder('dadGroup')-1)
	
	setProperty(player3..'.alpha',0);
end

function onBeatHit()
	if curBeat % 2 == 0 and holdTimer < 0 and not (getProperty(player3..".animation.curAnim.name"):sub(1,4) == 'sing') then
		characterPlayAnimation(0, false)
	end
end

function characterPlayAnimation(animId, forced) -- thank you shadowmario :imp:
	-- 0 = keyArrow
	-- 1 = keyConfirm
	-- 2 = keyPressed

	specialAnim = false;

	local animName = characterAnimationsList[animId]
	playAnim(player3, animName, forced); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)

	if animId > 0 then 
		specialAnim = true ;
		holdTimer = 0;
	end
end


function onUpdate(elapsed)
	holdCap = stepCrochet * 0.0011 * singDuration;
	if holdTimer >= 0 then
		holdTimer = holdTimer + elapsed;
		if holdTimer >= holdCap and getProperty(player3..".animation.curAnim.name"):sub(1,4) == 'sing' then
			characterPlayAnimation(0, false)
			holdTimer = -1;
		end
	end

	if getProperty(player3..".animation.curAnim.finished") and specialAnim then
		specialAnim = false;
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	characterPlayAnimation(direction + 1, true)
end

function onStepHit()
	-- triggered 16 times per section
	if curStep == 770 then doTweenAlpha('sAppear',player3,1,stepCrochet/1000*4,'quadInOut') end
end

function onTweenCompleted(tag)
	if tag == 'sAppear' then doTweenAlpha('sA0',player3,0.25,stepCrochet/1000*8,'quadInOut') end
	
	if tag == 'sA0' then doTweenAlpha('sA1',player3,1,stepCrochet/1000*8,'quadInOut') end
	if tag == 'sA1' then doTweenAlpha('sA0',player3,0.25,stepCrochet/1000*8,'quadInOut') end

	if tag == 'sYUP' then doTweenY('sYDOWN',player3,getProperty(player3..'.y')+40,4,'quadInOut') end
	if tag == 'sYDOWN' then doTweenY('sYUP',player3,getProperty(player3..'.y')-40,4,'quadInOut') end
	
end