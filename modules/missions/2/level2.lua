

level2State={}

level2State.FIRST_ATTACK_TIME=nil
level2State.FIRST_ATTACK_TIME_OFFSET=40

level2State.attacked=false

level2State.fatExtractorDone=false
level2State.proteinExtractorDone=false
level2State.carbsExtractorDone=false

level2State.VOICE1_START_TIME=3
level2State.VOICE1_DONE_TIME=16.5

level2State.VOICE2_START_TIME=level2State.VOICE1_DONE_TIME+1.5
level2State.VOICE2_DONE_TIME=level2State.VOICE2_START_TIME+40

level2State.VOICE3_START_TIME=nil
level2State.VOICE3_DONE_TIME=nil

level2State.VOICE4_START_TIME=nil
level2State.VOICE4_DONE_TIME=nil

level2State.VOICE5_START_TIME=nil
level2State.VOICE5_DONE_TIME=nil

level2State.VOICE6_START_TIME=nil
level2State.VOICE6_DONE_TIME=nil

level2State.tutorialSkipped=false

level2State.topTextSet=false

level2State.replicationStationDone=false

attackCounter=0

function level2Act()


	--section 1 and 2 are introduction
	if not level2State.tutorialSkipped then
		
		if not level2State.section1Done then
			lvl2Section1Act()
		elseif not level2State.section2Done then
			lvl2Section2Act()
		end
		
		level2SubtitlesIntroduction()
	end
	
	--section 3 is evil voice
	if level2State.section2Done and level2State.section1Done then
		lvl2Section3Act()
	end
	
	level2Subtitles()
	
	level2MissionObjectives()
	

	if level2State.FIRST_ATTACK_TIME and GAME_TIME>level2State.FIRST_ATTACK_TIME and not level2State.attacked then
		msg.post("virusMind","attack",{fromRight=true,attackNumber=attackCounter})
		msg.post("virusMind1","attack",{fromRight=false,attackNumber=attackCounter})
		--level2State.attacked=true
		
		level2State.FIRST_ATTACK_TIME=level2State.FIRST_ATTACK_TIME+15
		attackCounter=attackCounter+1
	end
	
	checkResources()
	
end


function queueFirstAttack()
	level2State.FIRST_ATTACK_TIME=GAME_TIME+level2State.FIRST_ATTACK_TIME_OFFSET
	
	if not level2State.VOICE5_START_TIME then	
		print("queueFirstAttack")
		level2State.VOICE5_START_TIME=GAME_TIME+level2State.FIRST_ATTACK_TIME_OFFSET
		level2State.VOICE5_DONE_TIME=level2State.VOICE5_START_TIME+6
	end
	
	--engineer
	if not level2State.tutorialSkipped then
		level2State.VOICE6_START_TIME=GAME_TIME+15
		level2State.VOICE6_DONE_TIME = level2State.VOICE6_START_TIME+11
	end
end


function centralMarrowDead()
	gameOver(false,LVL2_DEFEAT)
end

function checkResources()
	if FAT>=1000 and PROTEIN>=1000 and CARBS>=1000 then
		gameOver(true,LVL2_VICTORY)
	end
end


function skipTutorial()
	if not level2State.tutorialSkipped and not level2State.cantSkipIntro then
		level2State.tutorialSkipped=true
		level2State.needMissionObjectiveUpdate=true
		msg.post("mixer","stopVoice")
		msg.post("HUD","setSubtitleText",{text=""})
		msg.post("HUD","setTopBigText",{text=""})
		msg.post("mixer","normalBackground")
		level2State.resetBackground=true
		
		queueFirstAttack()
	end
end


function level2MissionObjectives()

	if not level2State.tutorialSkipped then
		--collect resourses
		
		if level2State.playedVoice4 and 
				level2State.VOICE4_DONE_TIME and 
				GAME_TIME>level2State.VOICE4_DONE_TIME and not
				level2State.collectedResources then
				
				msg.post("HUD","setMissionObjectiveText",{text=LVL2_COLLECT_1000_OBJ1})
				level2State.needMissionObjectiveUpdate=false
		end
		
		if level2State.VOICE5_DONE_TIME and GAME_TIME>level2State.VOICE5_DONE_TIME then
			msg.post("HUD","setMissionObjectiveText",{text=LVL2_COLLECT_1000_OBJ2})
			level2State.needMissionObjectiveUpdate=false
		end
	
		--replication station
		if level2State.playedVoice3 and not level2State.VOICE4_START_TIME and 
				GAME_TIME>(level2State.VOICE3_START_TIME+12) then
		
			
			if not level2State.replicationStationDone then
				local string="Build a REPLICATION STATION."
				msg.post("HUD","setMissionObjectiveText",{text=string})
			else
				print("replication station done")
				msg.post("HUD","setMissionObjectiveText",{text=""})
				level2State.VOICE4_START_TIME=GAME_TIME
				level2State.VOICE4_DONE_TIME=level2State.VOICE4_START_TIME+30
			end
			
			level2State.needMissionObjectiveUpdate=false
		end
	
		--objective about extractors
		if not level2State.section1Done and level2State.playedVoice2 and GAME_TIME>level2State.VOICE2_DONE_TIME and level2State.needMissionObjectiveUpdate then
		
			if not level2State.carbsExtractorDone or
			   not level2State.proteinExtractorDone or
			   not level2State.fatExtractorDone then
			   
				local string=""
				
				if not level2State.fatExtractorDone then
					string=string.."\nBuild one FAT EXTRACTOR."
				end
				
				if not level2State.proteinExtractorDone then
					string=string.."\nBuild one PROTEIN EXTRACTOR."
				end
				
				if not level2State.carbsExtractorDone then
					string=string.."\nBuild one CARBS. EXTRACTOR."
				end
					
				msg.post("HUD","setMissionObjectiveText",{text=string})
				
				level2State.needMissionObjectiveUpdate=false
			
			--ALL EXTRACTORS ARE BUILT
			else
				if WORKERS_EXTRACTING_PROTEIN<=0 or WORKERS_EXTRACTING_FAT<=0 or WORKERS_EXTRACTING_CARB<=0 then
					local string=LVL2_PUT_WORKERS_IN_EXTRACTORS
					msg.post("HUD","setMissionObjectiveText",{text=string})
					level2State.needMissionObjectiveUpdate=false
				else	
					msg.post("marrowHelp","hide")
					msg.post("extractorHelp","hide")
					msg.post("HUD","setMissionObjectiveText",{text=""})
					level2State.section1Done=true
					level2State.VOICE3_START_TIME=GAME_TIME
					level2State.VOICE3_DONE_TIME=level2State.VOICE3_START_TIME+12.5
				end
			end
			
		end
	elseif not level2State.setVoice5 then
		msg.post("HUD","setMissionObjectiveText",{text=LVL2_COLLECT_1000_OBJ1})
		level2State.needMissionObjectiveUpdate=false
		level2State.setVoice5=true
		
		level2State.section2Done=true
		level2State.section1Done=true
		

	end
	
end

function level2ReplicationStationDone()
	if not level2State.replicationStationDone then
		level2State.replicationStationDone=true
		level2State.needMissionObjectiveUpdate=true
	end
end


function level2FatExtractorDone()
	if not level2State.fatExtractorDone then
		level2State.fatExtractorDone=true
		level2State.needMissionObjectiveUpdate=true
		msg.post("extractorHelp","hide")
	end
end

function level2ProteinExtractorDone()
	if not level2State.proteinExtractorDone then
		level2State.proteinExtractorDone=true
		level2State.needMissionObjectiveUpdate=true
		msg.post("extractorHelp","hide")
	end
end

function level2CarbsExtractorDone()
	if not level2State.carbsExtractorDone then
		level2State.carbsExtractorDone=true
		level2State.needMissionObjectiveUpdate=true
		msg.post("extractorHelp","hide")
	end
end


function level2TriggerCheck(x,y)

	
end