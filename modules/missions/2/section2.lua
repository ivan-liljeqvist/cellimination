
function lvl2Section2Act()

	if not level2State.playedVoice3 and level2State.VOICE3_START_TIME and GAME_TIME>level2State.VOICE3_START_TIME then
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission2Voice3")
		
		level2State.resetBackground=false
		level2State.playedVoice3=true
		
	elseif level2State.playedVoice3 and 
			level2State.VOICE3_DONE_TIME and 
			GAME_TIME>level2State.VOICE3_DONE_TIME and not 
			level2State.resetBackground then
		
		
		msg.post("mixer","normalBackground")
		level2State.resetBackground=true
		
	end

end