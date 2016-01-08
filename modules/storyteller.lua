






function act()

	if not CURRENT_LEVEL_COMPLETE then
	
		
		if LEVEL==1 then
			level1Act()
		elseif LEVEL==2 then
			level2Act()
		end
	
		--this is the same for all levels, if you lose all your units, you lose
		if numberOfPlayerUnits()<=0 then
			gameOver(false)
		end
		
	end

end


function triggerCheck(x,y)

	
	if LEVEL==1 then
		level1TriggerCheck(x,y)
	elseif LEVEL==2 then
		level2TriggerCheck(x,y)
	end
	
	
end




function gameOver(victory)
	if victory and not CURRENT_LEVEL_COMPLETE then
		msg.post("mixer","stopHealing")
		msg.post("HUD","setSubtitleText",{text=""})
		msg.post("HUD","setMissionObjectiveText",{text=""})
		msg.post("mixer","stopVoice")
		msg.post("mixer","victory")
		msg.post("HUD","setGameOverTitle",{text="VICTORY"})
		msg.post("HUD","setGameOverText",{text="You managed to survive!"})
		CURRENT_LEVEL_COMPLETE=true
	elseif not victory and not CURRENT_LEVEL_COMPLETE then
		msg.post("mixer","stopHealing")
		msg.post("HUD","setSubtitleText",{text=""})
		msg.post("HUD","setMissionObjectiveText",{text=""})
		msg.post("mixer","stopVoice")
		msg.post("mixer","defeat")
		msg.post("HUD","setGameOverTitle",{text="DEFEAT"})
		msg.post("HUD","setGameOverText",{text="Your forces were crushed!"})
		CURRENT_LEVEL_COMPLETE=true
	end
end
