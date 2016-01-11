


function lvl1Section2Act()

	--voice 3 is triggered, after it we need to reset the background 
	if  level1State.playedVoice3 and GAME_TIME>level1State.VOICE3_DONE_TIME and not level1State.playedVoice4 and not level1State.resetBackground and not level1State.playedVoice4 then
	
		msg.post("HUD","setMissionObjectiveText",{text="Follow the path until you encounter viruses.\nIf you see a virus, kill it!"})
		print("normalBackground3")
		msg.post("mixer","normalBackground")
		level1State.resetBackground=true
	
	elseif level1State.FIRST_VIRUS_DEAD and not level1State.playedVoice4 then
	
		if not level1State.resetBackground then
			msg.post("mixer","stopVoice")
			
			level1State.sub12=true
			level1State.sub13=true
			level1State.sub14=true
			level1State.sub15=true
			level1State.sub16=true
		end
		
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission1Voice4")	
		level1State.playedVoice4=true
		level1State.VOICE4_START_TIME=GAME_TIME
		level1State.VOICE4_DONE_TIME=GAME_TIME+8
		level1State.resetBackground=false
	
	elseif level1State.playedVoice4 and GAME_TIME>level1State.VOICE4_DONE_TIME and not level1State.resetBackground and not level1State.playedVoice5 then
		print("normalBackground4")
		msg.post("mixer","normalBackground")
		level1State.resetBackground=true
		
	elseif level1State.KILLED_VIRUSES>=7 and not level1State.playedVoice5 then
	
		msg.post("HUD","setMissionObjectiveText",{text="GET BACK TO THE STARTING POINT WITH AT LEAST ONE CELL!"})
		

		level1State.playedVoice5=true
		
		msg.post("mixer","battleMode")
		
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission1Voice5")	
		level1State.playedVoice5=true
		level1State.resetBackground=false
		
		level1State.VOICE5_START_TIME=GAME_TIME
		level1State.VOICE5_DONE_TIME=level1State.VOICE5_START_TIME+21
		
		msg.post("mark","show")
		msg.post("weakPurpleSpawner","spawn")
		
		hideClearedCells()
	
	elseif level1State.playedVoice5 and GAME_TIME>level1State.VOICE5_DONE_TIME and not level1State.resetBack5 then
		print("normalBackground5")
		
		level1State.resetBack5=true
		
		msg.post("mixer","normalBackground")
		
		
		level1State.resetBackground=true
		
		
	end

end