function onCreate()
	--places the bg and shit
	makeLuaSprite('grad','hog/grad',-650,-220)
	scaleObject('grad',1000,1)
	setScrollFactor('grad',0.1,0)
	
	addLuaSprite('grad')
	
	makeLuaSprite('mountains','hog/mountains',-550,-50)
	scaleObject('mountains',1.6,1.5)
	setScrollFactor('mountains',0.35,1)
	
	addLuaSprite('mountains')
	
	makeAnimatedLuaSprite('wf','hog/Waterfalls',-1150,120)
	addAnimationByPrefix('wf','loop','waterfall',8,true)
	scaleObject('wf',1.5,1.5)
	setScrollFactor('wf',0.6,1)
	
	addLuaSprite('wf')
	
	makeAnimatedLuaSprite('bg','hog/HillsandHills',-850,-200)
	addAnimationByPrefix('bg','rings','bg',8,true)
	scaleObject('bg',1.5,1.5)
	setScrollFactor('bg',0.7,1)
	
	addLuaSprite('bg')
	
	--Places the floor and the rocks
	
	makeLuaSprite('tree1','hog/tree1',-850,-480)
	scaleObject('tree1',1.54,1.54)
	setScrollFactor('tree1',0.9,1)
	
	addLuaSprite('tree1')
	
	makeLuaSprite('tree2','hog/tree2',850,-480)
	scaleObject('tree2',1.54,1.54)
	setScrollFactor('tree2',0.9,1)
	
	addLuaSprite('tree2')
	
	makeLuaSprite('floor','hog/floor',-1400,490)
	scaleObject('floor',2.04,2.04)
	
	addLuaSprite('floor')
	
	makeLuaSprite('rock1','hog/rock1',-1400,400)
	scaleObject('rock1',2.04,2.04)
	setScrollFactor('rock1',1.3,1)
	
	addLuaSprite('rock1')
	
	makeLuaSprite('rock2','hog/rock2',1200,400)
	scaleObject('rock2',2.04,2.04)
	setScrollFactor('rock2',1.3,1)
	
	addLuaSprite('rock2')
	
	--overlay
	makeLuaSprite('overlay','hog/overlay',0,-400)
	scaleObject('overlay',1000,2)
	setProperty('overlay.alpha',0.7)
	setObjectCamera('overlay','hud')
	
	addLuaSprite('overlay',true)
end