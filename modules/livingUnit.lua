

function initLivingUnit(self)
	if self.teamNumber==PLAYER_TEAM then
		self.requiresCapacity = true
		self.takenCapcity = false
		--TOTAL_POPULATION = TOTAL_POPULATION+1
	end
end

function destroyLivingUnit(self)
	if self.teamNumber==PLAYER_TEAM then
	
		if not self.isBuilding and not self.headingForExtractor then
			msg.post("mixer","deathVoice")
		end
		
		if not self.headingForExtractor then
			TOTAL_POPULATION = TOTAL_POPULATION-1
		end
	end
	
end