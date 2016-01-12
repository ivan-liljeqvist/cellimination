

function startMenu()
	if not LOAD_MENU then
	
		print("startMenu")
		resetGlobals()
		GAME_TIME=0
		IN_GAME=false
		BETWEEN_PROXIES=true
		LOAD_MENU=true
		LEVEL=0
		
	end
end


function startLevel(level)

	resetGlobals()
	
	RELOAD_LEVEL=true
	
	BETWEEN_PROXIES=true

	LEVEL=level
	setStartingResources(LEVEL)
	GAME_TIME=0
	IN_GAME=true
	
	
end