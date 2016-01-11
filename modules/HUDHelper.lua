HUDButtons={}


BUTTON1="hudButton1"
BUTTON2="hudButton2"
BUTTON3="hudButton3"
BUTTON4="hudButton4"
BUTTON5="hudButton5"
BUTTON6="hudButton6"
BUTTON7="hudButton7"
BUTTON8="hudButton8"
BUTTON9="hudButton9"

PRODUCTION_BUTTON1="productionButton1"
PRODUCTION_BUTTON2="productionButton2"
PRODUCTION_BUTTON3="productionButton3"
PRODUCTION_BUTTON4="productionButton4"
PRODUCTION_TITLE="productionTitle"
PRODUCTION_PERCENT="productionPercent"

COST_CARB_ICON="costCarbIcon"
COST_FAT_ICON="costFatIcon"
COST_PROTEIN_ICON="costProteinIcon"

COST_CARB="costCarb"
COST_PROTEIN="costProtein"
COST_FAT="costFat"

UNIT_DESCRIPTION="unitDescription"


NO_BUTTON=""

currentlyHitButton=NO_BUTTON;

displayingError=false
displayingErrorTimeSinceStarted=0
displayingErrorTime=3



PAUSE_MENU_BOUNDS={}
PAUSE_MENU_BOUNDS[1]={x=960,y=455}
PAUSE_MENU_BOUNDS[2]={x=960,y=370}
PAUSE_MENU_BOUNDS[3]={x=960,y=285}

PAUSE_BUTTON_WIDTH=200
PAUSE_BUTTON_HEIGHT=70

currentlyHighlightedPauseButton=0

function handlePauseMenuButton(action,action_id)

	if action_id==hash("leftClicked") then 
	
		if currentlyHighlightedPauseButton==1 then
			--continue
		elseif currentlyHighlightedPauseButton==2 then
			--menu
			print("pressed menu")
			startMenu()
		elseif currentlyHighlightedPauseButton==3 then
			--restart
		end
	
	end


	for btnNumber,bound in pairs(PAUSE_MENU_BOUNDS) do

		local nodeToHighlight="continueButton"
   		if btnNumber==2 then nodeToHighlight="backToMenuButton" 
   		elseif btnNumber==3 then nodeToHighlight="restartButton" end
		
		if action.x>(bound.x-PAUSE_BUTTON_WIDTH/2) and action.x<(bound.x+PAUSE_BUTTON_WIDTH/2) and
		   action.y>(bound.y-PAUSE_BUTTON_HEIGHT/2) and action.y<(bound.y+PAUSE_BUTTON_HEIGHT/2)
		   then
		   
		   		if btnNumber~=currentlyHighlightedPauseButton then
		   		
		   			highlightNode(nodeToHighlight)
		   			msg.post("mixer","click1")
		   			currentlyHighlightedPauseButton=btnNumber
		   		end

		   else	
		   		if btnNumber==currentlyHighlightedPauseButton then
			   		dehighlightNode(nodeToHighlight)
			   		currentlyHighlightedPauseButton=0	
			   	end   		
		   end
		
	end

end

function highlightNode(id)
	gui.set_scale(gui.get_node(id),vmath.vector3(1.1,1.1,1.1))
end

function dehighlightNode(id)
	gui.set_scale(gui.get_node(id),vmath.vector3(1,1,1))
end

