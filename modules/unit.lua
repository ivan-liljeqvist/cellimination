
require "modules.coordinates"


function initBasicUnit(self,name,goID)

	populateNodeArray()
	
	self.bounds=getSpriteBounds("#sprite",self)    
    self.selected=false
    
    self.isBuilding=false
    local pos=self.go.get_position()
    pos.x=pos.x
	pos.y=pos.y
	self.go.set_position(pos)
	
    self.name=name
    self.id=goID
    
    self.showingHealthBar=true
    self.highHealth=true
    self.timeSinceTempShowHealth=0
    self.showingHelthTemp=true
    hideHealthBar(self)
    
    ALIVE[self.id]=true
    registerForInput(goID)
    
    table.insert(selectableUnits, self.go.get_id())
    self.indexInSelectableUnits=table.getn(selectableUnits)
    
    self.movableUnit=false
    
    go.set_scale(self.initialScale)
    
    MY_UNITS[self]=true
    
    self.teamNumber=PLAYER_TEAM
    
    self.goalX = getPosition(self).x
    self.goalY = getPosition(self).y
    
    self.tileCoordinates={pixelToTileCoords(self.goalX,self.goalY)}
    local currentNodeIndex=TILEMAP_INDEX_LOOKUP[self.tileCoordinates[1]+1][self.tileCoordinates[2]+1]
   
    TILEMAP_NODES[currentNodeIndex].occupied = true
    TILEMAP_NODES[currentNodeIndex].occupiedBy = self
   
end



function destroyUnit(self)
	self.go.delete(self.go.get_id())
	GAME_OBJECTS_THAT_REQUIRE_INPUT[self.go.get_id()]=nil
	table.remove(selectableUnits,self.indexInSelectableUnits)
	
	MY_UNITS[self]=nil
	local currentNodeIndex=TILEMAP_INDEX_LOOKUP[self.tileCoordinates[1]+1][self.tileCoordinates[2]+1]
    TILEMAP_NODES[currentNodeIndex].occupied = false
    TILEMAP_NODES[currentNodeIndex].occupiedBy = nil
    unregisterForInput(self.id)
    
    removeFromSelectedUnits(self)
    
    msg.post("HUD","unitDestroyed",{id=self.id})
    
    ALIVE[self.id]=false
end

function basicUnitUpdate(self,dt,go)
	--update healthbar
	if self.showingHealthBar or self.showingHelthTemp then
	
		--1) move the bar after the unit
		local pos = go.get_position()
		pos.x=(pos.x-CAMERA_OFFSETX)/ZOOM_LEVEL
		pos.y=(pos.y+30-CAMERA_OFFSETY)/ZOOM_LEVEL
		
		msg.post(msg.url("#healthGUI"),"setPosition",{position=pos})
		
		local ratio = self.health/self.originalHealth 
		--2) if the health is below 30% - set low health
		if ratio < 0.3 and self.highHealth then
			msg.post(msg.url("#healthGUI"),"lowHealth",{position=pos})
			self.highHealth=false
		elseif ratio >= 0.3 and self.highHealth==false then
			msg.post(msg.url("#healthGUI"),"highHealth",{position=pos})
			self.highHealth=true
		end
		
		--3) update the width of the health bar
		msg.post(msg.url("#healthGUI"),"updateSize",{ratio=ratio})
	end
	
	--see if we should hide the temporary healthbar
	if self.showingHelthTemp then
		
			
			self.timeSinceTempShowHealth=self.timeSinceTempShowHealth+dt
			
			if self.timeSinceTempShowHealth>2 then
				msg.post(msg.url("#healthGUI"),"hide")
				self.showingHelthTemp=false
			end
			
		
	end
	

end

function hideHealthBar(self)
	msg.post(msg.url("#healthGUI"),"hide")
	self.showingHealthBar=false
end

function showHealthBar(self)
	msg.post(msg.url("#healthGUI"),"show")
	self.showingHealthBar=true
end

function showHealthBarTemporarily(self)
	msg.post(msg.url("#healthGUI"),"show")
	self.timeSinceTempShowHealth=0
	self.showingHelthTemp=true
end

function registerForInput(id)
	GAME_OBJECTS_THAT_REQUIRE_INPUT[id]=true
end

function unregisterForInput(id)
	GAME_OBJECTS_THAT_REQUIRE_INPUT[id]=nil
end




function setTeam(self,teamNumber) 
	self.teamNumber=teamNumber
end

function basicUnitMessageHandler(self,go,message_id,message)


	if message_id==hash("setTeam") then
		self.teamNumber=message.newTeamNumber
		print("new team "..message.newTeamNumber)

	elseif message_id==hash("rollOutOfProducer") then
		--generateNewPathToMouseClick(self,message,tilemap)--last argument is to ignore camera offset
		
		local pixelX,pixelY=message.x,message.y
		local tileX,tileY=pixelToTileCoords(pixelX-CAMERA_OFFSETX,pixelY-CAMERA_OFFSETY)
		print(tileX,tileY)
		
		local nodeIndex=TILEMAP_INDEX_LOOKUP[tileX+1][tileY+1]
		local node=TILEMAP_NODES[nodeIndex]
		
		if node.occupied then
			local newDestIndex=findNotOccupiedNeighbour(tileX+1,tileY+1,7)
			if newDestIndex then
				nodeIndex=newDestIndex
			end
		end
		
		goStraightToNode(self,nodeIndex)
		
	end
end

function getPosition(self)
	local posTemp = self.go.get_position()
	return vmath.vector3(self.x,self.y,posTemp.z)
end




