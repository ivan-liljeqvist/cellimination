
function initBasicWorker(self)
	self.worker=true
	self.currentBuilding = nil
	self.headingToBuilding=false
	
	self.generateCounter=1 --we can generate 2 times before we abort the construction. the first time is when he is heading the initialtime
end

function workerUpdate(self,go,dt)

	if table.getn(self.currentPath)<=0 and self.headingToBuilding and self.currentBuilding then
		print("seind worker arrived from worker to building")
		msg.post(self.currentBuilding,"workerArrived")

	end

end

function workerMessageHandler(self,go,message_id,message,sender)

	if message_id == hash("goToBuildingSite") then
		print("worker ordered to go to building site")
		
		local tileX,tileY = pixelToTileCoords(message.pos.x,message.pos.y)
		generateNewPathToTileCoords(self,tileX,tileY)
		self.headingToBuilding=true
	
	elseif message_id == hash("setCurrentBuilding") then
		self.generateCounter=1
		self.currentBuilding = message.building
	elseif message_id == hash("resetBuilding") then
		self.currentBuilding = nil
		self.headingToBuilding=false
		
		self.generateCounter=1
	end

end

function abortConstruction(self)
	
	if self.currentBuilding then
		msg.post(self.currentBuilding,"abortConstruction")
		self.currentBuilding=nil
	end

end

