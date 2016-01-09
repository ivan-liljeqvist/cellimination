

function lvl2Section3Act()

	--engineer 1
	if level2State.VOICE5_START_TIME and GAME_TIME>level2State.VOICE5_START_TIME and not level2State.playedVoice5 then
	
		msg.post("mixer","stopVoice")
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission2Voice5")
		
		level2State.resetBackground=false
		level2State.playedVoice5=true
	
	end

end