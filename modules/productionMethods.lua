

function redBloodCellDone(self)
	if self.waypointHidden then
		msg.post("unitManager", "newJeep", {position=vmath.vector3(self.x,self.y,1), producerPosition=vmath.vector3(self.x,self.y,1)}) 
	else 
		msg.post("unitManager", "newJeep", {position=vmath.vector3(self.waypointPosition.x,self.waypointPosition.y,1), producerPosition=vmath.vector3(self.x,self.y,1),waypointSet=(not self.waypointHidden)}) 
	end
end


function heal1Done(self)
	if self.waypointHidden then
		msg.post("unitManager", "newHeal1", {position=vmath.vector3(self.x,self.y,1), producerPosition=vmath.vector3(self.x,self.y,1)}) 
	else 
		msg.post("unitManager", "newHeal1", {position=vmath.vector3(self.waypointPosition.x,self.waypointPosition.y,1), producerPosition=vmath.vector3(self.x,self.y,1),waypointSet=(not self.waypointHidden)}) 
	end
end