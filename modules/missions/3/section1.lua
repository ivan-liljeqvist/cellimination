
function lvl3Section1Act()


	
	if GAME_TIME>level3State.VOICE1_START_TIME and not level3State.playedVoice1 then
		
		if not level3State.topTextSet then
			msg.post("HUD","setTopBigText",{text="Press Enter to skip the introduction"})
			level3State.topTextSet=true
		end
	
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission3Voice1")
		level3State.playedVoice1=true
	
	end


end



