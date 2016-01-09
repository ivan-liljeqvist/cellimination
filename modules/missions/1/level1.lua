

level1State={}

level1State.VOICE1_START_TIME=1
level1State.VOICE1_DONE_TIME=25

level1State.VOICE2_START_TIME=28
level1State.VOICE2_DONE_TIME=50

level1State.FIRST_VIRUS_DEAD=false

level1State.VOICE3_START_TIME=nil --will be set when it's triggered
level1State.VOICE3_DONE_TIME=nil --will be set when it's triggered

level1State.VOICE4_START_TIME=nil --will be set when it's triggered
level1State.VOICE4_DONE_TIME=nil

level1State.VOICE5_START_TIME=nil --will be set when it's triggered
level1State.VOICE5_DONE_TIME=nil

level1State.KILLED_VIRUSES=0

function level1Act()

	if not level1State.section1Done then
		lvl1Section1Act()
	elseif not level1State.section2Done then
		lvl1Section2Act()
	end
	
	level1Subtitles()
end


function level1PurpleDeath()
	level1State.KILLED_VIRUSES=level1State.KILLED_VIRUSES+1
	if not level1State.FIRST_VIRUS_DEAD then
		level1State.FIRST_VIRUS_DEAD=true
	end
end

function level1TriggerCheck(x,y)

	

	--walked back to safety
	
	if level1State.VOICE5_DONE_TIME and  GAME_TIME>level1State.VOICE5_DONE_TIME  and y<780 and x <740 and not level1State.levelOver then
		level1State.levelOver=true
		gameOver(true)
	end
	
	--WALKED AND SHOWED THAT PLAYER CAN PLAY
	if (y>1127 and not level1State.introDoneSection1) then
	
		level1State.playedVoice1=true
		level1State.playedVoice2=true
		level1State.resetBackground=true
		level1State.firstTriggered=true
		
		level1State.introDoneSection1=true
		
		msg.post("mixer","stopVoice")
		msg.post("mixer","normalBackground")
		
		GAME_TIME = level1State.VOICE2_DONE_TIME
		
		msg.post("HUD","displayErrorMessage",{text="YOU ALREADY KNOW HOW TO PLAY!"})
		msg.post("HUD","setMissionObjectiveText",{text="Follow the path until you encounter viruses."})

		level1State.sub1=true
		level1State.sub2=true
		level1State.sub3=true
		level1State.sub4=true
		level1State.sub5=true
		level1State.sub6=true
		level1State.sub7=true
		level1State.sub8=true
		level1State.sub9=true
		level1State.sub10=true
		level1State.sub11=true
		
		msg.post("HUD","setSubtitleText",{text=""})
		
		level1State.section1Done=true
	end
	
	--NEAR ENEMY
	if y>1250 and not level1State.playedVoice3  then
	
		level1State.VOICE3_START_TIME=GAME_TIME
		level1State.VOICE3_DONE_TIME=GAME_TIME+20
		
		
		msg.post("mixer","lowerBackground")
		msg.post("mixer","mission1Voice3")
		
		level1State.playedVoice3=true
		level1State.resetBackground=false
		
	end
end