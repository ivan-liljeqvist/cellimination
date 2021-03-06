


function lvl2Section1Act()
	
	if not level2State.playedVoice1 and GAME_TIME>level2State.VOICE1_START_TIME then
		
		if not level2State.topTextSet then
			msg.post("HUD","setTopBigText",{text="Press Enter to skip the introduction"})
			level2State.topTextSet=true
		end
	
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission2Voice1")
		
		level2State.playedVoice1=true
		level2State.resetBackground=false
	
	elseif level2State.playedVoice1 and 
		   GAME_TIME>level2State.VOICE1_DONE_TIME and 
		   not level2State.resetBackground and
		   GAME_TIME<level2State.VOICE2_START_TIME
		   then
		
		
		msg.post("mixer","normalBackground")
		level2State.resetBackground=true
	
	elseif not level2State.playedVoice2 and GAME_TIME>level2State.VOICE2_START_TIME then
		
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission2Voice2")
		
		level2State.playedVoice2=true
		level2State.resetBackground=false
		
	elseif level2State.playedVoice2 and 
		   GAME_TIME>level2State.VOICE2_DONE_TIME and 
		   not level2State.resetBackground and
		   not level2State.VOICE3_START_TIME
		   then
		
		level2State.needMissionObjectiveUpdate=true
		
		if not level2State.carbsExtractorDone and not level2State.proteinExtractorDone and not level2State.fatExtractorDone then
			msg.post("extractorHelp","show")
		end
		
		level2State.cantSkipIntro=true
		
		msg.post("HUD","setTopBigText",{text=""})
		
		msg.post("mixer","normalBackground")
		level2State.resetBackground=true
	end
end