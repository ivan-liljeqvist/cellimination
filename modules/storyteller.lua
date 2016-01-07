



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


function act()

	if not CURRENT_LEVEL_COMPLETE then
	
		if LEVEL==1 then
			level1Act()
		end
	
		if numberOfPlayerUnits()<=0 then
			gameOver(false)
		end
		
	end

end


function triggerCheck(x,y)

	
	if LEVEL==1 then
		level1TriggerCheck(x,y)
	end
	
	
end

