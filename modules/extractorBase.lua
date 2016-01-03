
function initExtractor(self)

	self.isExtractor = true
	
	self.workersInside=0
	
	EXTRACTORS[self]=true

end


function extractorMessages(self, message_id, message, sender,go)

	if message_id == hash("extractorRightClicked") then

		if isInsideSelection(message.start,message.current,message.pivot,self) then
			
			local action={x=message.start[1],y=message.start[2]}
			
			msg.post(message.workerID,"goToExtractor",{preciseLocation=action})
		end
		
	end

end