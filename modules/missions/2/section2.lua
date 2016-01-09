
function lvl2Section2Act()

	if not level2State.playedVoice3 and level2State.VOICE3_START_TIME and GAME_TIME>level2State.VOICE3_START_TIME then
		msg.post("mixer","stopVoice")
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission2Voice3")
		
		level2State.resetBackground=false
		level2State.playedVoice3=true
		
	elseif level2State.playedVoice3 and 
			level2State.VOICE3_DONE_TIME and 
			GAME_TIME>level2State.VOICE3_DONE_TIME and not 
			level2State.resetBackground and not level2State.playedVoice4 then
		
		
		msg.post("mixer","normalBackground")
		level2State.resetBackground=true
	
	elseif not level2State.playedVoice4 and level2State.VOICE4_START_TIME and GAME_TIME>level2State.VOICE4_START_TIME then
		msg.post("mixer","stopVoice")
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission2Voice4")
		
		level2State.resetBackground=false
		level2State.playedVoice4=true
		
	elseif level2State.playedVoice4 and 
			level2State.VOICE4_DONE_TIME and 
			GAME_TIME>level2State.VOICE4_DONE_TIME and not 
			level2State.resetBackground then
		
		msg.post("mixer","normalBackground")
		level2State.resetBackground=true
		level2State.needMissionObjectiveUpdate=true
		
		level2State.section2Done=true
		
		level2State.VOICE5_START_TIME=GAME_TIME+10
		
		level2State.FIRST_ATTACK_TIME=GAME_TIME+level2State.FIRST_ATTACK_TIME_OFFSET
	end

end