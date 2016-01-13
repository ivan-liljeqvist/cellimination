

level3State={}

level3State.ATTACK_TIME=2
level3State.shouldAttack=false

level3State.VOICE1_START_TIME=2
level3State.VOICE1_DONE_TIME=39

level3State.tutorialSkipped=false

level3State.peaceOver=false

function level3Act()

	if not level3State.tutorialSkipped then
		if not level3State.section1Done then
			lvl3Section1Act()
		end
		
		level3Subtitles()
	end
	
	
	
	handleAttacks()
	
	
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
		
		level3State.peaceOver=true
		--queueFirstAttack()
	end
end


function handleAttacks()

	if not level3State.peaceOver then return end

	if GAME_TIME>level3State.ATTACK_TIME then
		level3State.ATTACK_TIME=GAME_TIME+10
		level3State.shouldAttack=true
	end
	
	if level3State.shouldAttack then 
		msg.post("virusMind","attack",{fromRight=false,attackNumber=1})
		level3State.shouldAttack=false
	end
end