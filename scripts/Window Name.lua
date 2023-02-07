local username = os.getenv('USERNAME')

function onCreate()
	setPropertyFromClass("openfl.Lib", "application.window.title",  "Friday Night Funkin': Psych Engine - Loading, please wait...")
end
function onDestroy()
	setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Psych Engine - In The Menus")
end

function onCreatePost()
	if songName == 'You Cant Run Encore' then
		setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Psych Engine - You Can't Run - DanlyDaMusicant & ImThatBlueWolf [Encore]")
	elseif string.lower(songName) == 'no more innocence' then
		setPropertyFromClass("openfl.Lib", "application.window.title", "NO MORE INNOCENCE")
	else
		setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Psych Engine - ".. songName)
	end
end