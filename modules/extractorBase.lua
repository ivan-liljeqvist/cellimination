
function initExtractor(self)

	self.isExtractor = true
	

	
	updateMaxWorkers(self)
	
	self.workersInside=0
	
	EXTRACTORS[self]=true
	
	initProductionUnit(self)
	
	self.timeSinceUpdatedWorkers=0
	
	

end

function updateMaxWorkers(self)
	
	self.maxWorkersInside=2
	
	if self.isProteinExtractor then
		self.maxWorkersInside=self.maxWorkersInside+NUMBER_BOUGHT[UPGRADE_MORE_PROTEIN_NAME]
	elseif self.isFatExtractor then
		self.maxWorkersInside=self.maxWorkersInside+NUMBER_BOUGHT[UPGRADE_MORE_FAT_NAME]
	elseif self.isCarbExtractor then
		self.maxWorkersInside=self.maxWorkersInside+NUMBER_BOUGHT[UPGRADE_MORE_CARB_NAME]
	end
	
end


function extractorMessages(self, message_id, message, sender,go)

	if message_id == hash("extractorRightClicked") and self.constructionDone then

		if isInsideSelection(message.start,message.current,message.pivot,self) then
			
			local action={x=message.start[1],y=message.start[2]}
			
			msg.post(message.workerID,"goToExtractor",{preciseLocation=action,extractorID=self.id})
		else
			--if not foundWay then
				--msg.post("mixer","errorSound")
				--msg.post("HUD","displayErrorMessage",{text="Unreachable location!"})
			--end
		end
		
	elseif message_id == hash("workerEntered") then
	
		print("worker entered!")
		if self.workersInside<=(self.maxWorkersInside-1) then
			self.workersInside=self.workersInside+1
			
			if self.isFatExtractor then
				WORKERS_EXTRACTING_FAT=WORKERS_EXTRACTING_FAT+1
			elseif self.isProteinExtractor then
				WORKERS_EXTRACTING_PROTEIN=WORKERS_EXTRACTING_PROTEIN+1
			elseif self.isCarbExtractor then
				WORKERS_EXTRACTING_CARB=WORKERS_EXTRACTING_CARB+1
			end
			
			msg.post(sender,"permittedToEnterExtractor",{canEnter=true})
			self.currentlyProducingItem=SOLDIER_NAME
			table.insert(self.toProduce,SOLDIER_NAME)
		else
			msg.post(sender,"permittedToEnterExtractor",{canEnter=false})
		end
		
	end

end

function updateExtractor(self,dt)
	handleWorkerAndRPMGUI(self)
	
	if self.timeSinceUpdatedWorkers>1.0 then
		updateMaxWorkers(self)
		self.timeSinceUpdatedWorkers=0
	end
	
	self.timeSinceUpdatedWorkers=self.timeSinceUpdatedWorkers+dt
end


function handleWorkerAndRPMGUI(self)

	if self.constructionDone then
	
		local pos = go.get_position()
		pos.x=(pos.x-CAMERA_OFFSETX)/ZOOM_LEVEL
		pos.y=(pos.y-30-CAMERA_OFFSETY)/ZOOM_LEVEL
		--msg.post(msg.url("#workerAndRPMGUI"),"setPosition",{position=pos})
		
		local resource="protein"
		if self.isFatExtractor then
			resource="fat"
		elseif self.isCarbExtractor then
			resource="carbs."
		end
		
		local text=self.workersInside.."/"..self.maxWorkersInside.." cells, "..WORKER_RPM*self.workersInside.." "..resource.."/min"
		msg.post(msg.url("extractorInfo"),"updateExtractorInfo",
				{text=text,position=pos,userId=self.id})

	
	end
end