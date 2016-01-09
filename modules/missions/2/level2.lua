

level2State={}

level2State.FIRST_ATTACK_TIME=200
level2State.attacked=false

level2State.fatExtractorDone=false
level2State.proteinExtractorDone=false
level2State.carbsExtractorDone=false

level2State.VOICE1_START_TIME=2
level2State.VOICE1_DONE_TIME=12.5

level2State.VOICE2_START_TIME=level2State.VOICE1_DONE_TIME+1
level2State.VOICE2_DONE_TIME=level2State.VOICE2_START_TIME+40

level2State.VOICE3_START_TIME=nil
level2State.VOICE3_DONE_TIME=nil

function level2Act()

	if not level2State.section1Done then
		lvl2Section1Act()
	elseif not level1State.section2Done then
		lvl2Section2Act()
	end
	
	level2MissionObjectives()

	if GAME_TIME>level2State.FIRST_ATTACK_TIME and not level2State.attacked then
		msg.post("virusMind","attack",{fromRight=true})
		msg.post("virusMind1","attack",{fromRight=false})
		level2State.attacked=true
	end

end


function level2MissionObjectives()

	--replication station
	if level2State.playedVoice3 and 
			GAME_TIME>(level2State.VOICE3_START_TIME+12) and not 
			level2State.replicationStationDone then
	
		local string="MISSION OBJECTIVES:\nBuild a REPLICATION STATION."
		msg.post("HUD","setMissionObjectiveText",{text=string})
	end

	--objective about extractors
	if not level2State.section1Done and level2State.playedVoice2 and GAME_TIME>level2State.VOICE2_DONE_TIME and level2State.needMissionObjectiveUpdate then
	
		if not level2State.carbsExtractorDone or
		   not level2State.proteinExtractorDone or
		   not level2State.fatExtractorDone then
		   
			local string="MISSION OBJECTIVES:\n"
			
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
			print("fat, prtoa "..WORKERS_EXTRACTING_PROTEIN.." "..WORKERS_EXTRACTING_FAT.." "..WORKERS_EXTRACTING_CARB)
			if WORKERS_EXTRACTING_PROTEIN<=0 or WORKERS_EXTRACTING_FAT<=0 or WORKERS_EXTRACTING_CARB<=0 then
				local string="MISSION OBJECTIVES:\n\nPut at least one RED BLOOD CELL (WORKER) in each extractor."
				msg.post("HUD","setMissionObjectiveText",{text=string})
				level2State.needMissionObjectiveUpdate=false
			else	
				msg.post("marrowHelp","hide")
				msg.post("extractorHelp","hide")
				msg.post("HUD","setMissionObjectiveText",{text=""})
				level2State.section1Done=true
				level2State.VOICE3_START_TIME=GAME_TIME
				level2State.VOICE3_DONE_TIME=level2State.VOICE3_START_TIME+38
			end
		end
		
	end
	
end

function level2ReplicationStationDone()
	level2State.replicationStationDone=true
	level2State.needMissionObjectiveUpdate=true
end


function level2FatExtractorDone()
	level2State.fatExtractorDone=true
	level2State.needMissionObjectiveUpdate=true
end

function level2ProteinExtractorDone()
	level2State.proteinExtractorDone=true
	level2State.needMissionObjectiveUpdate=true
end

function level2CarbsExtractorDone()
	level2State.carbsExtractorDone=true
	level2State.needMissionObjectiveUpdate=true
end


function level2TriggerCheck(x,y)

	
end