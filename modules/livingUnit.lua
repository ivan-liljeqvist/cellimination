

function initLivingUnit(self)
	if self.teamNumber==PLAYER_TEAM then
		self.requiresCapacity = true
		self.takenCapcity = false
		TOTAL_HOUSE = TOTAL_HOUSE+1
	end
end

function destroyLivingUnit(self)
	if self.teamNumber==PLAYER_TEAM then
		TOTAL_HOUSE = TOTAL_HOUSE-1
	end
end