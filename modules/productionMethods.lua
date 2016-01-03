

function productionDone(self,unitName)

	if self.waypointHidden then
		msg.post("unitManager", "new"..unitName, {position=vmath.vector3(self.x+self.orOffX,self.y+self.orOffY,1), producerPosition=vmath.vector3(self.x+self.orOffX,self.y+self.orOffY,1)}) 
	else 
		msg.post("unitManager", "new"..unitName, {position=vmath.vector3(self.waypointPosition.x,self.waypointPosition.y,1), producerPosition=vmath.vector3(self.x+self.orOffX,self.y+self.orOffY,1),waypointSet=(not self.waypointHidden)}) 
	end
end