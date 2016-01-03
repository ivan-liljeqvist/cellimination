
function initExtractor(self)

	self.isExtractor = true
	
	self.maxWorkersInside=5
	self.workersInside=0
	
	EXTRACTORS[self]=true
	
	initProductionUnit(self)

end


function extractorMessages(self, message_id, message, sender,go)

	if message_id == hash("extractorRightClicked") and self.constructionDone then

		if isInsideSelection(message.start,message.current,message.pivot,self) then
			
			local action={x=message.start[1],y=message.start[2]}
			
			msg.post(message.workerID,"goToExtractor",{preciseLocation=action,extractorID=self.id})
			
		end
		
	elseif message_id == hash("workerEntered") then
	
		print("worker entered!")
		if self.workersInside<=(self.maxWorkersInside-1) then
			self.workersInside=self.workersInside+1
			msg.post(sender,"permittedToEnterExtractor",{canEnter=true})
			self.currentlyProducingItem=RBC_NAME
			table.insert(self.toProduce,RBC_NAME)
		else
			msg.post(sender,"permittedToEnterExtractor",{canEnter=false})
		end
		
	end

end

function updateExtractor(self,dt)
	handleWorkerAndRPMGUI(self)
end


function handleWorkerAndRPMGUI(self)
	if self.constructionDone then
		local pos = go.get_position()
		pos.x=(pos.x-CAMERA_OFFSETX)/ZOOM_LEVEL
		pos.y=(pos.y-30-CAMERA_OFFSETY)/ZOOM_LEVEL
		msg.post(msg.url("#workerAndRPMGUI"),"setPosition",{position=pos})
		
		local resource="protein"
		if self.isFatExtractor then
			resource="fat"
		elseif self.isCarbExtractor then
			resource="carbs."
		end
		
		msg.post(msg.url("#workerAndRPMGUI"),"setText",{text=self.workersInside.."/"..self.maxWorkersInside.." cells, "..WORKER_RPM*self.workersInside.." "..resource.."/min"})
	else
	
		msg.post(msg.url("#workerAndRPMGUI"),"setText",{text=""})
	
	end
end