

function productionDone(self,unitName)

	
	
	if self.waypointHidden then
		msg.post("unitManager", "new"..unitName, {position=vmath.vector3(self.x+self.orOffX,self.y+self.orOffY,1), producerPosition=vmath.vector3(self.x+self.orOffX,self.y+self.orOffY,1)}) 
	else 
		msg.post("unitManager", "new"..unitName, {position=vmath.vector3(self.waypointPosition.x,self.waypointPosition.y,1), producerPosition=vmath.vector3(self.x+self.orOffX,self.y+self.orOffY,1),waypointSet=(not self.waypointHidden)}) 
	end
end


function queue(self,unitName)
	--do we have the resources?
	if canAfford(unitName) then
		if table.getn(self.toProduce)<MAX_PRODUCTION_QUEUE then
			deductResources(unitName)
			table.insert(self.toProduce,unitName)
			NUMBER_QUEUED[unitName]=NUMBER_QUEUED[unitName]+1
		end
	else
	
		msg.post("HUD","displayErrorMessage",{text=NOT_ENOUGH_RESOURCES})
	end
end
