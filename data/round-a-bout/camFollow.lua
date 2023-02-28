--you stuff!
movement = 30
noteblacklist = {'hey!', 'no animation'} --put in lowercase
velocity = nil --set this if you want the notes to speed up the camera

--the code
enabled = true
function onCreatePost() origSpeed = getProperty 'cameraSpeed' end
m = {{-movement, 0}, {0, movement}, {0, -movement}, {movement, 0}}
for k,v in pairs(noteblacklist) do noteblacklist[k] = '"'..v:gsub('"', '\\"')..'"' end
function goodNoteHit(id, data, type, sus) check(mustHitSection, m[data+1], id, type) end
function opponentNoteHit(id, data, type, sus) check(not mustHitSection, m[data+1], id, type) end
function check(b, m, id, type)
  if (b or gfSection and getPropertyFromGroup('notes', id, 'gfNote')) 
  and not runHaxeCode('return [' .. table.concat(noteblacklist, ', ') .. '].contains("'..type:lower()..'");') then
    moveCam(m)
  end
end
function onUpdate()
  if moving then
    local stop = mustHitSection and not stringStartsWith(getProperty 'boyfriend.animation.curAnim.name', 'sing') or
    not mustHitSection and not stringStartsWith(getProperty 'dad.animation.curAnim.name', 'sing')
    if gfSection then stop = not stringStartsWith(getProperty 'gf.animation.curAnim.name', 'sing') end
    if stop then
      moveCam{0, 0}
      moving = false
      setProperty('cameraSpeed', origSpeed)
    end
  end
end
function moveCam(m)
	if getProperty 'isCameraOnForcedPos' then return end
  moving = true
  runHaxeCode 'game.moveCameraSection();'
  setProperty('camFollow.x', getProperty 'camFollow.x' + m[1])
  setProperty('camFollow.y', getProperty 'camFollow.y' + m[2])
  setProperty('cameraSpeed', velocity or origSpeed)
end
function onMoveCamera() setProperty('cameraSpeed', origSpeed or getProperty 'cameraSpeed') end
function setCameraMovement(movement, speed)
  m = movement and {{-movement, 0}, {0, movement}, {0, -movement}, {movement, 0}} or m
  velocity = speed or velocity
end

function onEvent(n,v1,v2)
	if n == 'Set Property' and v1 == 'cameraSpeed' then origSpeed = tonumber(v2) end
end