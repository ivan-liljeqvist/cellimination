
CURRENT_CODE_INPUT=""
BACK_RELEASED=true

function clickSound()
	msg.post("mixer","click1")
end

function clickSound2()
	msg.post("mixer","click2")
end

function validateCode(code)

	if code=="1" then
		MISSIONS_COMPLETE=1
		goToMenu2()
	else	
		showNode("codeError")
	end	

	return false
end

function handleCodeInputButtonHover(action)
	if action.x>(1920/2)-BUTTON_WIDTH/2 and action.x<(1920/2)+BUTTON_WIDTH/2 and 
   	  action.y<CONTINUE_BUTTON_Y+CONTINUE_BUTTON_HEIGHT/2 and action.y>CONTINUE_BUTTON_Y-CONTINUE_BUTTON_HEIGHT/2 then
   		gui.set_scale(gui.get_node("continueButton"),vmath.vector3(1.1,1.1,1.1))
   		
   		if not CONTINUE_GAME then 
   			clickSound()
   		end
   		
   		CONTINUE_GAME=true
   	else
   		gui.set_scale(gui.get_node("continueButton"),vmath.vector3(1,1,1))
   		CONTINUE_GAME=false
   end
end


function handleCodeInputText(action,action_id)
	
	if action.text then
	 	CURRENT_CODE_INPUT=CURRENT_CODE_INPUT..action.text
	 	gui.set_text(gui.get_node("codeInputText"),CURRENT_CODE_INPUT)
	elseif action_id==hash("backPressed") and action.pressed and BACK_RELEASED then
		
		CURRENT_CODE_INPUT=string.sub(CURRENT_CODE_INPUT, 1, string.len(CURRENT_CODE_INPUT)-1)
		print("backPressed "..CURRENT_CODE_INPUT)
	 	gui.set_text(gui.get_node("codeInputText"),CURRENT_CODE_INPUT)
	 	BACK_RELEASED=false
	 	
	elseif action_id==hash("backPressed") and action.released and not BACK_RELEASED then
		BACK_RELEASED=true
	end
	
	if action_id=="text" then
		print("textInpit")
	end

end


function handleButtonHover(action)
	if action.x>(1920/2)-BUTTON_WIDTH/2 and action.x<(1920/2)+BUTTON_WIDTH/2 and 
   	  action.y<NEW_BUTTON_Y+NEW_BUTTON_HEIGHT/2 and action.y>NEW_BUTTON_Y-NEW_BUTTON_HEIGHT/2 then
   		gui.set_scale(gui.get_node("newButton"),vmath.vector3(1.1,1.1,1.1))
   		
   		if not NEW_GAME then 
   			clickSound()
   		end
   		
   		NEW_GAME=true
   		CONTINUE_GAME=false
   		
   	else
   		gui.set_scale(gui.get_node("newButton"),vmath.vector3(1,1,1))
   		NEW_GAME=false
   end
   
     if action.x>(1920/2)-BUTTON_WIDTH/2 and action.x<(1920/2)+BUTTON_WIDTH/2 and 
   	  action.y<CONTINUE_BUTTON_Y+CONTINUE_BUTTON_HEIGHT/2 and action.y>CONTINUE_BUTTON_Y-CONTINUE_BUTTON_HEIGHT/2 then
   		gui.set_scale(gui.get_node("continueButton"),vmath.vector3(1.1,1.1,1.1))
   		
   		if not CONTINUE_GAME then 
   			clickSound()
   		end
   		
   		CONTINUE_GAME=true
   		NEW_GAME=false
   	else
   		gui.set_scale(gui.get_node("continueButton"),vmath.vector3(1,1,1))
   		CONTINUE_GAME=false
   end
end


function showNode(id)
	if id=="clickToStart4" then return end
	
	if string.sub(id,1,string.len("click"))=="click" then
		gui.set_color(gui.get_node(id),vmath.vector4(1,1,1,0.5))
	else
		gui.set_color(gui.get_node(id),vmath.vector4(1,1,1,1))
	end
end

function hideNode(id)
	if id=="clickToStart4" then return end
	gui.set_color(gui.get_node(id),vmath.vector4(1,1,1,0))
end


function setMissionDisabled(mission)

	print("setMissionDisabled "..mission)

	ENABLED_MISSIONS[mission]=false
	hideNode("mission"..mission.."Description")
	hideNode("clickToStart"..mission)
	
	local titlePos=gui.get_position(gui.get_node("mission"..mission.."Title"))
	titlePos.y=300
	
	gui.set_position(gui.get_node("mission"..mission.."Title"),titlePos)
	gui.set_text(gui.get_node("mission"..mission.."Title"),"LOCKED")
end

function setMissionEnabled(mission)

	print("setMissionEnabled "..mission)

	ENABLED_MISSIONS[mission]=true
	showNode("mission"..mission.."Description")
	showNode("clickToStart"..mission)
	
	local titlePos=gui.get_position(gui.get_node("mission"..mission.."Title"))
	titlePos.y=355
	
	gui.set_position(gui.get_node("mission"..mission.."Title"),titlePos)
	gui.set_text(gui.get_node("mission"..mission.."Title"),"MISSION "..mission)
	
end


