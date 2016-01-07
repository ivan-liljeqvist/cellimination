



function gameOver(victory)
	if victory and not CURRENT_LEVEL_COMPLETE then
		msg.post("mixer","victory")
		msg.post("HUD","setGameOverTitle",{text="VICTORY"})
		msg.post("HUD","setGameOverText",{text="You managed to survive!"})
		CURRENT_LEVEL_COMPLETE=true
	end
end


function act()

	if LEVEL==1 then
		level1Act()
	end

end


function triggerCheck(x,y)

	
	if LEVEL==1 then
		level1TriggerCheck(x,y)
	end
	
end

