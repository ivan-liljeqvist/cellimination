

function lvl3Section2Act()

	if level3State.VOICE2_START_TIME and GAME_TIME>level3State.VOICE2_START_TIME and not level3State.playedVoice2 then
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission3Voice2")
		level3State.playedVoice2=true
		level3State.resetBackground=false
	elseif level3State.VOICE2_DONE_TIME and GAME_TIME>level3State.VOICE2_DONE_TIME and not level3State.resetBackground
	and not level3State.playedVoice3 then
		
		msg.post("mixer","normalBackground")
		level3State.resetBackground=true
		
	elseif level3State.VOICE3_START_TIME and GAME_TIME>level3State.VOICE3_START_TIME and not level3State.playedVoice3 then
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission3Voice3")
		level3State.playedVoice3=true
		level3State.resetBackground=false
		
	elseif level3State.VOICE3_DONE_TIME and GAME_TIME>level3State.VOICE3_DONE_TIME and not level3State.resetBackground then
		
		level3State.section2Done=true
		msg.post("mixer","normalBackground")
		level3State.resetBackground=true
	end
end