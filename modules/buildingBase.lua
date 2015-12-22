
function initBuilding(self,spriteObject,buildingSize,go)

	self.prototypeMode=true
	self.buildingSize=buildingSize
	prototypeColorPositionInvalid(spriteObject)
	self.canBuildHere=false
	self.spriteObject=spriteObject
	self.go=go
	
end

function buildingInput(self,action,action_id)

	if self.prototypeMode and action_id == hash("leftClicked") and action.pressed then
	
		if self.canBuildHere then
			buildHere(action.x,action.y,self)
		else 
			removeBuilding(self)
			alertCantBuildHere()
		end

	--if prototype mode - follow the cursor
	elseif self.prototypeMode then
		GUI_CLICKED=true
		--follow cursor
		go.set_position(vmath.vector3(action.x+CAMERA_OFFSETX,action.y+CAMERA_OFFSETY,1))
		--check if we can build here
		self.canBuildHere = canBuildAt(self,action.x,action.y)
		updatePrototypeColor(self)
	end
end

function removeBuilding(self)
	self.go.delete(self.go.get_id())
	GAME_OBJECTS_THAT_REQUIRE_INPUT[self.go.get_id()]=nil
end

function alertCantBuildHere()
	--play sound or something
	print("cant build here")
end

function buildHere(x,y,self)
	removePrototypeColor(self.spriteObject)
	self.prototypeMode=false
	setTilesUnderMeToOccupied(self,x,y)
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

	
	local centerTileX, centerTileY = pixelToTileCoords(x,y)
	
	--go through each row and column
	local minTileX = centerTileX + self.buildingSize.startPointFromCenter.x
	local maxTileX = minTileX + self.buildingSize.width
	local minTileY = centerTileY + self.buildingSize.startPointFromCenter.y
	local maxTileY = minTileY + self.buildingSize.height
	
	
	for currentX=minTileX, maxTileX, 1 do
		for currentY=minTileY, maxTileY, 1 do
			if canBuildAtTile(currentX,currentY) == false then
				return false
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
		
			local nodeIndex = TILEMAP_INDEX_LOOKUP[currentX+1][currentY+1] 
			TILEMAP_NODES[nodeIndex].occupied=true
			TILEMAP_NODES[nodeIndex].blocked=true

			
		end
	end
	
	
	return true
end

function canBuildAtTile(tileX,tileY)

	tileX=tileX+1
	tileY=tileY+1

	if tileX>TILEMAP_MAXX or tileX<TILEMAP_MINX or tileY>TILEMAP_MAXY or tileY<TILEMAP_MINY then
		print("outside map!")
		return false
	end

	local nodeIndex = TILEMAP_INDEX_LOOKUP[tileX][tileY] 
	local tileNode = TILEMAP_NODES[nodeIndex] 
	
	if tileNode.type~=TILE_NOT_REACHABLE_CODE and tileNode.occupied==false then
		return true
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

function buildingUpdate(self,dt)

end

