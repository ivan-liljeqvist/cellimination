

function startMenu()

	if not LOAD_MENU then
		
		if LEVEL==2 then msg.post("ownCamera","look",{x=0,y=0}) end
		
		resetGlobals()
		
		GAME_TIME=0
		IN_GAME=false
		BETWEEN_PROXIES=true
		LOAD_MENU=true
		LEVEL=0
		msg.post("mixer","stopBetween1and2")
	end
	
end


function startLevel(level)

	resetGlobals()
	
	JUST_STARTED=false
	
	RELOAD_LEVEL=true
	
	BETWEEN_PROXIES=true

	LEVEL=level
	setStartingResources(LEVEL)
	GAME_TIME=0
	IN_GAME=true
	
	
end