
require "modules.coordinates"


function initBasicUnit(self,name,goID)

	populateNodeArray()
	
	self.bounds=getSpriteBounds("#sprite",self)    
    self.selected=false
    
    
    local pos=self.go.get_position()
    pos.x=pos.x
	pos.y=pos.y
	self.go.set_position(pos)
    
    self.name=name
    
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
	MY_UNITS[self]=false
	table.remove(selectableUnits,self.indexInSelectableUnits)
end


function registerForInput(id)
	GAME_OBJECTS_THAT_REQUIRE_INPUT[id]=true
end

function unregisterForInput(id)
	GAME_OBJECTS_THAT_REQUIRE_INPUT[id]=nil
end




function getNearbyEnemies(self)
	
	return {}
end

function setTeam(self,teamNumber) 
	self.teamNumber=teamNumber
end

function basicUnitMessageHandler(self,go,message_id,message)


	if message_id==hash("setTeam") then
		self.teamNumber=message.newTeamNumber
		print("new team "..message.newTeamNumber)
		
	elseif message_id==hash("followeeChangedPosition")then
	
		if self.followee then
			print("followeeChangedPosition ",message.tileCoords[1],message.tileCoords[2])
			generateNewPathToTileCoords(self,message.tileCoords[1],message.tileCoords[2])
		end
		
		
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




