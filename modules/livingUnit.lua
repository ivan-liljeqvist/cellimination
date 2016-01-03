

function initLivingUnit(self)

	self.requiresCapacity = true
	self.takenCapcity = false
	TOTAL_HOUSE = TOTAL_HOUSE+1
end

function destroyLivingUnit(self)
	TOTAL_HOUSE = TOTAL_HOUSE-1
end