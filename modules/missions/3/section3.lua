




function lvl3Section3Act()

	if level3State.VOICE4_START_TIME and GAME_TIME>level3State.VOICE4_START_TIME and not level3State.playedVoice4 then
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission3Voice4")
		level3State.playedVoice4=true
		level3State.resetBackground=false
		
	elseif level3State.VOICE4_DONE_TIME and GAME_TIME>level3State.VOICE4_DONE_TIME and not level3State.resetBackground then
		
		msg.post("mixer","normalBackground")
		level3State.resetBackground=true
		
	end
end