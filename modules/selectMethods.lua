

function handleSelectMethods(self,go,message_id,message)
	--message that some unit is single-selected, check if the unit is self
	--if not us, deselect self because some other unit is in focus
	if message_id==hash("unitSelected") then
		if message.selectedId ~= go.get_id() then
			deselect(self,go)
		end
		
	--check if self is inside the selection, if it is, select itself
	elseif message_id==hash("massSelection") then
		if isInsideSelection(message.start,message.current,message.pivot) then
			massSelect(self,"hej",go)
		end
	
	elseif message_id==hash("deselect") then
		deselect(self,go)
 	end
end

