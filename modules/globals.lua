

TILE_SIZE=128
TILE_NOT_REACHABLE_CODE=0

JEEP_NAME="ARMED JEEP"

TILEMAP_NODE={}

--populates the TILEMAP_NODE array with tiles in the tilemap
function populateNodeArray(globalTilemapObject)
	local minX, minY, w, h = globalTilemapObject.get_bounds("world#tilemap")
	local maxX=minX+w
	local maxY=minY+h
	
	--go through each row
	for xCounter=minX, maxX-1, 1 do
		--go through each column
		for yCounter=minY, maxY-1, 1 do
		
			--insert a node for each tile
			local newNode={}
			newNode.x=xCounter
			newNode.y=yCounter
			newNode.type=tilemap.get_tile("world#tilemap", "reachable", xCounter, yCounter)
			
		end
	end
end

--valid function used by the A* algorithm
valid_node_func = function ( node, neighbor ) 
	
		
	--if the tile is reachable - it's a valid neightbour
	if 	neighbor.typ~=TILE_NOT_REACHABLE_CODE and 
		return true
	end
	
	--if we've come here - the tile is not reachable
	return false
	
end


