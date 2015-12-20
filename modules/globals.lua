

TILE_SIZE=128
TILE_NOT_REACHABLE_CODE=0

JEEP_NAME="ARMED JEEP"

TILEMAP_NODES={}
TILEMAP_WIDTH=0;

require "modules.pathfinder"

--populates the TILEMAP_NODES array with tiles in the tilemap
function populateNodeArray(globalTilemapObject)
	local minX, minY, w, h = globalTilemapObject.get_bounds("world#tilemap")
	local maxX=minX+w
	local maxY=minY+h
	
	TILEMAP_WIDTH=w
	
	--go through each row
	for xCounter=minX, maxX-1, 1 do
		--go through each column
		for yCounter=minY, maxY-1, 1 do
		
			--insert a node for each tile
			local newNode={}
			newNode.x=xCounter
			newNode.y=yCounter
			newNode.type=tilemap.get_tile("world#tilemap", "reachable", xCounter, yCounter)
			
			table.insert(TILEMAP_NODES,newNode)
			
			print("inserted index: "..newNode.x.." "..newNode.y.." type: "..newNode.type)
			
		end
	end
end

--valid function used by the A* algorithm
validator = function ( node, neighbor ) 
	
		
	local isBesides = math.abs(node.x-neighbor.x)<=1 and math.abs(node.y-neighbor.y)<=1
					  
	print(isBesides)
		
	if 	isBesides and neighbor.type~=4 then 
		return true
	end
	
	--if we've come here - the tile is not reachable
	print("invalid")
	
	return false
end


getStartAndFinish = function(startTileX,startTileY,finishTileX,finishTileY)
	
	local start={}
	local finish={}
	
	local found=0; --should be 2 when we beak the loop, then we've found start and finish
	
	for _,value in pairs(TILEMAP_NODES) do --actualcode
    	
    	if value.type==0 then
    		print("unreachable tile: "..value.x.." "..value.y)
    	end
    	
		if value.x==startTileX and startTileY==value.y then
			start=value
			found=found+1
		elseif value.x==finishTileX and finishTileY==value.y then
			finish=value
			found=found+1
		end
		
		if found==2 then
			print(startTileX,startTileY,finishTileX,finishTileY)
			return start,finish
		end
	end
	
	print("didn't find start and finish in the tile array")
	print(startTileX,startTileY,finishTileX,finishTileY)
	return nil,nil
	
end



