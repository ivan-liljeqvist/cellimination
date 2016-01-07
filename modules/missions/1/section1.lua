

function lvl1Section1Act()

	if not level1State.playedVoice1 and GAME_TIME>level1State.VOICE1_START_TIME then
	
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission1Voice1")
		
		level1State.playedVoice1=true
		level1State.resetBackground=false
		
	
	
	elseif level1State.playedVoice1 and 
		   GAME_TIME>level1State.VOICE1_DONE_TIME and 
		   not level1State.resetBackground and
		   GAME_TIME<level1State.VOICE2_START_TIME
		   then
		
		
		msg.post("mixer","normalBackground")
		level1State.resetBackground=true
		
	elseif (not level1State.playedVoice2) and (GAME_TIME>level1State.VOICE2_START_TIME) then
		
		msg.post("HUD","setMissionObjectiveText",{text="MISSION OBJECTIVE:\n1) Search the area for abnormalities."})
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission1Voice2")
		level1State.resetBackground=false
		level1State.playedVoice2=true
		
		
		
		
	elseif level1State.playedVoice2 and  
		   level1State.playedVoice1 and GAME_TIME>level1State.VOICE2_DONE_TIME and 
		   (not level1State.resetBackground) then
		
		level1State.introDoneSection1=true
		
		msg.post("mixer","normalBackground")
		level1State.resetBackground=true
		level1State.section1Done=true
		
	end
	
end

