
function startLevel(level)
	resetGlobals()

	LEVEL=level
	setStartingResources(LEVEL)
	GAME_TIME=0
	IN_GAME=true
	RELOAD_LEVEL=true
	
end