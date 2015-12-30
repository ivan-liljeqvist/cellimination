
SELECTED_UNITS={}
LAST_SELECTED_NAME=""

function addToSelectedUnits(unit)
    SELECTED_UNITS[unit] = true
    LAST_SELECTED_NAME=unit.name
end

function removeFromSelectedUnits(unit)
    SELECTED_UNITS[unit] = nil
end

function alreadySelected(unit)
    return SELECTED_UNITS[unit] ~= nil
end

function getSelectedUnits()
	local toReturn={}
	
	for key,value in pairs(SELECTED_UNITS) do 
	  	if value~=nil then
	  	
	  		if toReturn[key.name]==nil then
	  			toReturn[key.name]=0
	  		end
	  		
	  		toReturn[key.name]=toReturn[key.name]+1 --the key is the actual object in the set, the value is true or false
	  	end
	end
	
	return toReturn
end



function handleSelectMethods(self,go,message_id,message)
	--message that some unit is single-selected, check if the unit is self
	--if not us, deselect self because some other unit is in focus
	
	if message_id==hash("unitSelected") then
		if message.selectedId ~= go.get_id() then
			deselect(self,go)
		end
		
	--check if self is inside the selection, if it is, select itself
	elseif message_id==hash("massSelection") then
		
		if isInsideSelection(message.start,message.current,message.pivot) and alreadySelected()==false and self.teamNumber==PLAYER_TEAM then
			
			addToSelectedUnits(self)
			massSelect(self,"hej",go)
		else
	
			removeFromSelectedUnits(self)
			deselect(self,go)
		end
		
	elseif message_id==hash("allOnScreenSelectSpecific") then
		
		if isInsideSelection({0,0},{getScreenWidth(),getScreenHeight()},gui.PIVOT_SW) and self.name==message.name and self.teamNumber==PLAYER_TEAM then
			
			addToSelectedUnits(self)
			massSelect(self,"hej",go)
		else
	
			removeFromSelectedUnits(self)
			deselect(self,go)
		end
		
	elseif message_id==hash("deselect") then
		
		removeFromSelectedUnits(self)
		deselect(self,go)
 	end
 	
 	if message_id==hash("newInput") then
		self.parseInput(self, message.action_id, message.action)
	end
end

