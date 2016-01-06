


function lvl1Section2Act()

	--voice 3 is triggered, after it we need to reset the background 
	if  level1State.playedVoice3 and GAME_TIME>level1State.VOICE3_DONE_TIME and not level1State.resetBackground then
	
		msg.post("HUD","setMissionObjectiveText",{text="MISSION OBJECTIVES:\n1) Search the area for abnormalities.\n2) If you see a virus, kill it!"})
		msg.post("mixer","normalBackground")
		level1State.resetBackground=true
		
	end

end