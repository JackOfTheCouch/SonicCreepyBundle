function onCreate()
	--places the bg and shit
	makeLuaSprite('grad','stages/hog/grad',-650,-330)
	scaleObject('grad',1000,2.53)
	setScrollFactor('grad',0,0)
	
	addLuaSprite('grad')
	
	makeLuaSprite('mountains','stages/hog/mountains',-550,-150)
	scaleObject('mountains',1.6,1.5)
	setScrollFactor('mountains',0.35,0.45)
	
	addLuaSprite('mountains')
	
	makeAnimatedLuaSprite('wf','stages/hog/Waterfalls',-1150,0)
	addAnimationByPrefix('wf','loop','waterfall',8,true)
	scaleObject('wf',1.5,1.5)
	setScrollFactor('wf',0.6,0.7)
	
	addLuaSprite('wf')
	
	makeAnimatedLuaSprite('bg','stages/hog/HillsandHills',-850,-200)
	addAnimationByPrefix('bg','rings','bg',8,true)
	scaleObject('bg',1.5,1.5)
	setScrollFactor('bg',0.7,0.9)
	
	addLuaSprite('bg')
	
	--Places the floor and the rocks
	
	makeLuaSprite('tree1','stages/hog/tree1',-850,-480)
	scaleObject('tree1',1.54,1.54)
	setScrollFactor('tree1',0.9,1)
	
	addLuaSprite('tree1')
	
	makeLuaSprite('tree2','stages/hog/tree2',850,-480)
	scaleObject('tree2',1.54,1.54)
	setScrollFactor('tree2',0.9,1)
	
	addLuaSprite('tree2')
	
	makeLuaSprite('floor','stages/hog/floor',-1400,490)
	scaleObject('floor',2.04,2.04)
	
	addLuaSprite('floor')
	
	makeLuaSprite('rock1','stages/hog/rock1',-1400,400)
	scaleObject('rock1',2.04,2.04)
	setScrollFactor('rock1',1.3,1.3)
	
	addLuaSprite('rock1')
	
	makeLuaSprite('rock2','stages/hog/rock2',1200,400)
	scaleObject('rock2',2.04,2.04)
	setScrollFactor('rock2',1.3,1.3)
	
	addLuaSprite('rock2')
	
	--overlay
	makeLuaSprite('overlay','stages/hog/overlay',-500,-400)
	scaleObject('overlay',1000,2)
	setProperty('overlay.alpha',0.7)
	setScrollFactor('overlay',0,0)
	
	addLuaSprite('overlay',true)
end

function onEvent(n,v1,v2)
	if n == 'scorchedStage' then
		loadGraphic('grad','stages/hog/blast/Sunset')
		
		loadGraphic('mountains','stages/hog/blast/Mountains')
		
		makeAnimatedLuaSprite('wf','stages/hog/blast/Waterfalls',-1150,0)
		addAnimationByPrefix('wf','loop','waterfall',8,true)
		scaleObject('wf',1.5,1.5)
		setScrollFactor('wf',0.6,0.6)
		setObjectOrder('wf',getObjectOrder('bg'))
		
		addLuaSprite('wf')
		
		loadGraphic('bg','stages/hog/blast/Hills')
		
		loadGraphic('tree1','stages/hog/blast/tree1')
		setProperty('tree1.x',getProperty('tree1.x')+170)
		setProperty('tree1.y',getProperty('tree1.y')+80)
		
		loadGraphic('tree2','stages/hog/blast/tree2')
		setProperty('tree2.x',getProperty('tree2.x')+70)
		setProperty('tree2.y',getProperty('tree2.y')+20)
		
		loadGraphic('floor','stages/hog/blast/floor')
		setProperty('floor.y',getProperty('floor.y')+80)
		
		loadGraphic('rock1','stages/hog/blast/rock1')
		loadGraphic('rock2','stages/hog/blast/rock2')
		
		removeLuaSprite('overlay',true)
		
		setProperty('boyfriend.x',getProperty('boyfriend.x')+100)
		setProperty('boyfriend.color',getColorFromHex('B7B7B7'))
	end
end