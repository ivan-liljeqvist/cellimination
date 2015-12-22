
function initBuilding(self,spriteObject,buildingSize)

	self.prototypeMode=true
	self.buildingSize=buildingSize
	prototypeColorPositionInvalid(spriteObject)
	self.canBuildHere=false
	self.spriteObject=spriteObject
	
end

function buildingInput(self,action)

	--if prototype mode - follow the cursor
	if self.prototypeMode then
		--follow cursor
		go.set_position(vmath.vector3(action.x,action.y,1))
		--check if we can build here
		self.canBuildHere = canBuildAt(self,action.x,action.y)
		updatePrototypeColor(self)
	end
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
	
	print("maxX "..maxTileX.." maxY "..maxTileY)
	
	for currentX=minTileX, maxTileX, 1 do
		for currentY=minTileY, maxTileY, 1 do
			if canBuildAtTile(currentX,currentY) == false then
				return false
			end
		end
	end
	
	
	return true
end

function canBuildAtTile(tileX,tileY)
	
	print("canBuildAtTile("..(tileX+1)..","..(tileY+1)..")")

	local nodeIndex = TILEMAP_INDEX_LOOKUP[tileX+1][tileY+1] 
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

function buildingUpdate(self,dt)

end

