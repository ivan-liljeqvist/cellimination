

level3State={}

level3State.ATTACK_TIME=2
level3State.shouldAttack=false

level3State.VOICE1_START_TIME=2
level3State.VOICE1_DONE_TIME=39

level3State.VOICE2_START_TIME=nil
level3State.VOICE2_DONE_TIME=nil

level3State.VOICE3_START_TIME=nil
level3State.VOICE3_DONE_TIME=nil

level3State.tutorialSkipped=false

level3State.peaceOver=false
level3State.peaceTimeOverStartTime=0

level3State.purpleTallKilled=0
level3State.allGuardsKilled=false

level3State.secondsUntilLost=10*60+2 --20 minutes

level3State.updateObjective=false

function level3Act()

	if not level3State.tutorialSkipped then
	
		if not level3State.section1Done then
			lvl3Section1Act()
		end
		
		level3SubtitlesIntro()
	end
	
	if level3State.section1Done and not level3State.section2Done then
		lvl3Section2Act()
		level3Subtitles()
	end
	
	handleMissionObjectiveLevel3()
	
	--msg.post("HUD","setTimeText",{text="HEEEJ"})
	
	handleTime()
	handleAttacks()
	
	
end


function handleTime()
	if level3State.peaceOver then
		
			
			local secondsPassed=GAME_TIME-level3State.peaceTimeOverStartTime
			local timeLeft=level3State.secondsUntilLost-secondsPassed
			
			if timeLeft<=20*60+2-1 then
				msg.post("HUD","setTimeText",{text=secondsToTimeString(timeLeft)})
			end
			
			if timeLeft<=0 then
				gameOver(false,LVL3_DEFEAT)
			end
			
	end
end

function handleMissionObjectiveLevel3()

	if level3State.updateObjective then
		

		
			msg.post("HUD","setMissionObjectiveText",{text=LVL3_OBJECTIVE})
			level3State.updateObjective=false
			

		
	end

end

function setPeaceOver()
	level3State.peaceOver=true
	level3State.peaceTimeOverStartTime=GAME_TIME
	
	level3State.VOICE2_START_TIME=GAME_TIME+10
	level3State.VOICE2_DONE_TIME=level3State.VOICE2_START_TIME+12
	
	level3State.VOICE3_START_TIME=GAME_TIME+28
	level3State.VOICE3_DONE_TIME=level3State.VOICE3_START_TIME+13
	
	level3State.updateObjective=true
end

function skipTutorialLvl3()
	if not level3State.tutorialSkipped then
		level3State.tutorialSkipped=true
		level3State.needMissionObjectiveUpdate=true
		msg.post("mixer","stopVoice")
		msg.post("HUD","setSubtitleText",{text=""})
		msg.post("HUD","setTopBigText",{text=""})
		msg.post("mixer","normalBackground")
		level3State.resetBackground=true
		
		level3State.section1Done=true
		
		setPeaceOver()
		--queueFirstAttack()
	end
end

function level3TriggerCheck(x,y)
	
	if x<1048 and y>6500 and level3State.allGuardsKilled then
		gameOver(true,LVL3_VICTORY)
	end
	
end

function level3TallDeath()
	level3State.purpleTallKilled=level3State.purpleTallKilled+1
	
	if level3State.purpleTallKilled>=4 then
		level3State.allGuardsKilled=true
	end
end


function handleAttacks()

	if not level3State.peaceOver then return end

	if GAME_TIME>level3State.ATTACK_TIME then
		level3State.ATTACK_TIME=GAME_TIME+12
		level3State.shouldAttack=true
	end
	
	if level3State.shouldAttack then 
		msg.post("virusMind","attack",{fromRight=false,attackNumber=1})
		level3State.shouldAttack=false
	end
end