

function lvl2Section3Act()

	
	if level2State.VOICE5_START_TIME and GAME_TIME>level2State.VOICE5_START_TIME and not level2State.playedVoice5 then
	
		msg.post("mixer","stopVoice")
		
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission2Voice5")
		
		level2State.resetBackground=false
		level2State.playedVoice5=true
		
	elseif level2State.VOICE5_START_TIME and GAME_TIME>level2State.VOICE5_DONE_TIME and not level2State.resetBackground
			and not level2State.playedVoice6 then
	
		msg.post("mixer","normalBackground")
		level2State.resetBackground=true
	
	end

end