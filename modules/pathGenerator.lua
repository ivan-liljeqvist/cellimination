
--[[
	1) find one movable unit
	2) compute the path for that unit
	3) give that path to the rest of the selection
--]]


				
function generateNewPathForGroupToPixel(group,action)
	
		local foundAPathForWholeSelection=false
		local pathFound={}
		local leadingUnit={}
		
		for unit,isSelected in pairs(SELECTED_UNITS) do 
			--key is the GO, value is true/nil
			if isSelected==true and unit.movableUnit then
				
				if foundAPathForWholeSelection==false then
					generateNewPathToMouseClick(unit,action,tilemapObject)
					pathFound=unit.currentPath
					foundAPathForWholeSelection=true
					leadingUnit=unit
				else
					--only follow leader if near leader
					if math.abs(unit.x-leadingUnit.x)<200 and math.abs(unit.y-leadingUnit.y)<200 then
						loadPath(unit,pathFound)
					else --otherwise find own path
						generateNewPathToMouseClick(unit,action,tilemapObject)
					end
				end
				
				unit.isFighting=false
				unit.followee=nil
			else
				--print("not movable selected unit!")
			end
		end
				
end

function generateNewPathToUnit(self,unit)
	generateNewPathToTileCoords(self,unit.tileCoordinates[1],unit.tileCoordinates[2])
end

function generateNewPathToMouseClick(self,action)
		local tileX,tileY=pixelToTileCoords(action.x*ZOOM_LEVEL,action.y*ZOOM_LEVEL)
    	generateNewPathToTileCoords(self,tileX,tileY)
end

function generateNewPathToTile(self,tileNode)
	generateNewPathToTileCoords(self,tileNode.x,tileNode.y)
end

function generateNewPathToTileCoords(self,tileX,tileY)

	if tileX<TILEMAP_MINX or tileX>TILEMAP_MAXX or tileY<TILEMAP_MINY or tileY>TILEMAP_MAXY then
		return false
	end
		
		
	 TILEMAP_NODES[self.lastDestIndex].occupied=false
	 TILEMAP_NODES[self.lastDestIndex].occupiedByID=false
	 TILEMAP_NODES[self.lastDestIndex].occupiedBy=nil
		
		
		local tileType=getTileTypeAt(tileX,tileY)
    	
    	--check if we can go there
    	if tileType~=TILE_NOT_REACHABLE_CODE then
    		
    		
    		--we need to figure out the start and end nodes, we know their coordinates

			--by using the coordinates, get the index of dest-node in the NODE_ARRAY
    		local destIndex=TILEMAP_INDEX_LOOKUP[tileX+1][tileY+1]
    		--by using the coordinates, get the index of start-node in the NODE_ARRAY
    		local startIndex=TILEMAP_INDEX_LOOKUP[self.tileCoordinates[1]][self.tileCoordinates[2]]
    		
    		--now use indeces to get start and finish nodes
    		local startNode,finishNode=TILEMAP_NODES[startIndex],TILEMAP_NODES[destIndex]
    		
    		--see if some other unit has already occupied the finish-node
    		if finishNode.occupied==false then
    			--do nothing
    		--if occupied find a neighbour tile that is not occupied and set it as new destination
    		else
    			local newDestIndex=findNotOccupiedNeighbour(tileX+1,tileY+1,3) --the last is the total number of recursions allowed
    			if newDestIndex then
    				
    				destIndex=newDestIndex
    				finishNode=TILEMAP_NODES[destIndex]
    				
    			end
    		end
    		
    		startNode.occupied=false
    		startNode.occupiedBy=nil
    		startNode.occupiedByID=nil
    		TILEMAP_NODES[startIndex]=startNode
    		finishNode.occupied=true
    		finishNode.occupiedBy=self
    		finishNode.occupiedByID=self.id
    		TILEMAP_NODES[destIndex]=finishNode
    		
    		self.lastDestIndex=destIndex
    						  			
    		
    		--use A* to find out the path
    		self.currentPath=pathfinder.path (startNode, finishNode, TILEMAP_NODES, true, validator )
    		
    		--for some reason the first goal in first path is wrong, just remove it
    		if self.currentPath and self.neverMoved and table.getn(self.currentPath)>0 then
    			table.remove(self.currentPath, 1)
    			self.neverMoved=false
    		end
   
			if not self.currentPath then
				print ( "No valid path found" )
				
				self.currentPath={}
				return false
			else
				--print("path with "..table.getn(self.currentPath).." nodes")
			end

    	else
    		print("not reachable!")
    		return false
    	end
    	
    	return true

end


