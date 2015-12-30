
function initBuilding(self,spriteObject,buildingSize,go)

	self.prototypeMode=true
	self.buildingSize=buildingSize
	prototypeColorPositionInvalid(spriteObject)
	self.canBuildHere=false
	self.spriteObject=spriteObject
	self.go=go
	
	self.rightReleasedSinceLast=true
	
	self.builtAtX=nil
	self.builtAtY=nil
	
	self.isBuilding=true
	
	self.waypointHidden=false
	self.waypoint=self.factory.create("#waypointFactory",nil,nil,{})
	self.waypointPosition=vmath.vector3(self.x,self.y,1)

	hideWaypoint(self)
	
end

function hideWaypoint(self)
	if not self.waypointHidden then
		msg.post(self.waypoint,"hide")
		self.waypointHidden=true
	end
end

function tempHideWP(self)
	msg.post(self.waypoint,"hide")
end

function tempShowWP(self)
	msg.post(self.waypoint,"show")
end

function showWaypoint(self,pos)
	
	local x = pos.x
	local y = pos.y
	local tileX,tileY = pixelToTileCoords((x)-CAMERA_OFFSETX,(y)-CAMERA_OFFSETY)
	
	local tileType = getTileTypeAt(tileX,tileY)
	
	if tileType == TILE_NOT_REACHABLE_CODE then
		msg.post("HUD","displayErrorMessage",{text=WAYPOINT_UNREACHABLE})
	else

		msg.post(self.waypoint,"show",{pos=pos})
		self.waypointHidden=false

		
	end
	

end

function buildingInput(self,action,action_id)

	if action_id==hash("rightClicked") and not moreThanOneSelected() and self.selected and action.pressed and self.rightReleasedSinceLast then
		self.rightReleasedSinceLast=false
		
		local newWPPos=vmath.vector3(action.x*ZOOM_LEVEL+CAMERA_OFFSETX,action.y*ZOOM_LEVEL+CAMERA_OFFSETY,1)
		
		if math.abs(newWPPos.x-self.x)>400 or math.abs(newWPPos.y-self.y)>400 then
			msg.post("HUD","displayErrorMessage",{text=WAYPOINT_TOO_FAR})
		else
			self.waypointPosition=newWPPos
			showWaypoint(self,self.waypointPosition)
		end
		
	elseif action_id==hash("rightClicked") and action.released and not self.rightReleasedSinceLast then
		self.rightReleasedSinceLast=true
		--hideWaypoint(self)
	end

	if self.prototypeMode and action_id == hash("leftClicked") and action.pressed then
	
		if self.canBuildHere then
			
			deductResources(self.name)
			buildHere(action.x*ZOOM_LEVEL,action.y*ZOOM_LEVEL,self)
			
		else 
			destroyUnit(self)
			alertCantBuildHere()
		end

	--if prototype mode - follow the cursor
	elseif self.prototypeMode then
		GUI_CLICKED=true
		--follow cursor
		go.set_position(vmath.vector3(action.x*ZOOM_LEVEL+CAMERA_OFFSETX,action.y*ZOOM_LEVEL+CAMERA_OFFSETY,1))
		--check if we can build here
		self.canBuildHere = canBuildAt(self,action.x,action.y)
		updatePrototypeColor(self)
	end
end


function alertCantBuildHere()
	--play sound or something
	msg.post("HUD","displayErrorMessage",{text=CANT_BUILD_HERE})
end

function destroyBuilding(self)
	setTilesUnderMeToNotOccupied(self,self.builtAtX,self.builtAtY)
end

function buildHere(x,y,self)
	removePrototypeColor(self.spriteObject)
	self.prototypeMode=false
	setTilesUnderMeToOccupied(self,x,y)
	
	self.builtAtX=x
	self.builtAtY=y
	
	if self.isFatExtractor==true then FAT_EXTRACTORS_MADE=FAT_EXTRACTORS_MADE+1
	elseif self.isCarbExtractor==true then CARB_EXTRACTORS_MADE=CARB_EXTRACTORS_MADE+1
	elseif self.isProteinExtractor==true then PROTEIN_EXTRACTORS_MADE=PROTEIN_EXTRACTORS_MADE+1 end
	
	self.x=x+CAMERA_OFFSETX
	self.y=y+CAMERA_OFFSETY
end

--change between red and green
function updatePrototypeColor(self)
	if self.prototypeMode then
		if self.canBuildHere then
			prototypeColor(self.spriteObject)
		else
			prototypeColorPositionInvalid(self.spriteObject)
		end
	end
end

--check we can fit a building at x,y
function canBuildAt(self,x,y)

	if y<HUD_RIGHT_HEIGHT and x>getScreenWidth()-HUD_RIGHT_WIDTH then return false end
	
	local centerTileX, centerTileY = pixelToTileCoords(x*ZOOM_LEVEL,y*ZOOM_LEVEL)
	
	--go through each row and column
	local minTileX = centerTileX + self.buildingSize.startPointFromCenter.x
	local maxTileX = minTileX + self.buildingSize.width
	local minTileY = centerTileY + self.buildingSize.startPointFromCenter.y
	local maxTileY = minTileY + self.buildingSize.height
	
	
	for currentX=minTileX, maxTileX, 1 do
		for currentY=minTileY, maxTileY, 1 do
			if canBuildAtTile(self,currentX,currentY) == false then
				return false
			end
		end
	end
	
	
	return true
end

function setTilesUnderMeToNotOccupied(self,x,y)

	local centerTileX, centerTileY = pixelToTileCoords(x,y)
	
	--go through each row and column
	local minTileX = centerTileX + self.buildingSize.startPointFromCenter.x
	local maxTileX = minTileX + self.buildingSize.width
	local minTileY = centerTileY + self.buildingSize.startPointFromCenter.y
	local maxTileY = minTileY + self.buildingSize.height
	
	
	for currentX=minTileX, maxTileX, 1 do
		for currentY=minTileY, maxTileY, 1 do
		
			local nodeIndex = TILEMAP_INDEX_LOOKUP[currentX][currentY] 
			
			if TILEMAP_NODES[nodeIndex].occupiedBy == self then
				TILEMAP_NODES[nodeIndex].occupied=false
				TILEMAP_NODES[nodeIndex].occupiedBy=nil
				TILEMAP_NODES[nodeIndex].blocked=false
				TILEMAP_NODES[nodeIndex].occupiedByID=nil
				
				--´tilemapObject.set_tile("world#tilemap", "reachable", currentX, currentY, 1)
			end

			 		
		end
	end
	
	
	return true
end

function setTilesUnderMeToOccupied(self,x,y)

	
	local centerTileX, centerTileY = pixelToTileCoords(x,y)
	
	--go through each row and column
	local minTileX = centerTileX + self.buildingSize.startPointFromCenter.x
	local maxTileX = minTileX + self.buildingSize.width
	local minTileY = centerTileY + self.buildingSize.startPointFromCenter.y
	local maxTileY = minTileY + self.buildingSize.height
	
	
	for currentX=minTileX, maxTileX, 1 do
		for currentY=minTileY, maxTileY, 1 do
		
			local nodeIndex = TILEMAP_INDEX_LOOKUP[currentX][currentY] 
			TILEMAP_NODES[nodeIndex].occupied=true
			TILEMAP_NODES[nodeIndex].occupiedBy=self
			TILEMAP_NODES[nodeIndex].blocked=true
			TILEMAP_NODES[nodeIndex].occupiedByID=self.id
			
			--tilemapObject.set_tile("world#tilemap", "reachable", currentX, currentY, 0)

			 		
		end
	end
	
	
	return true
end

function isFatTile(type)
	if type==7 or type==8 or type==21 or type==22 then return true end
	return false
end

function canBuildAtTile(self,tileX,tileY)
	
	tileX=tileX+1
	tileY=tileY+1

	local nodeIndex = TILEMAP_INDEX_LOOKUP[tileX][tileY] 
	local tileNode = TILEMAP_NODES[nodeIndex] 
	

	--if normal building, not an extractor
	if self.isProteinExtractor~=true and self.isCarbExtractor~=true 
		and self.isFatExtractor~=true then
		
		if tileNode.type~=TILE_NOT_REACHABLE_CODE and tileNode.occupied==false then
			return true
		end
	
	elseif self.isProteinExtractor then
		
		if tileNode.occupied==false and isFatTile(tileNode.blockedType) then
			return true
		end
	elseif self.isCarbExtractor then	
		
		if tileNode.occupied==false and isFatTile(tileNode.blockedType) then
			return true
		end
	elseif self.isFatExtractor then
		
		if tileNode.occupied==false and isFatTile(tileNode.blockedType) then
			return true
		end
	end
	
	
	return false
end

function prototypeColor(spriteObject)
	spriteObject.set_constant("#sprite", "tint", BUILDING_PROTOTYPE_COLOR)
end

function prototypeColorPositionInvalid(spriteObject)
	spriteObject.set_constant("#sprite", "tint", BUILDING_PROTOTYPE_COLOR_INVALID)
end

function removePrototypeColor(spriteObject)
	spriteObject.set_constant("#sprite", "tint", WHITE_COLOR)
end

function buildingUpdate(self,dt,go)

end

