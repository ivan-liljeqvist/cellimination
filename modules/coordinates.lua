
function mouseToTileCoords(mouseX,mouseY)

	local tileX=math.floor(mouseX/TILE_SIZE)
	local tileY=math.floor(mouseY/TILE_SIZE)
	
	return tileX,tileY
end


function tileToPixelCoords(tileX,tileY)
	local pixelX=tileX*TILE_SIZE+TILE_SIZE/2
	local pixelY=tileY*TILE_SIZE+TILE_SIZE/2
	
	return pixelX,pixelY
end


function getTileTypeAt(tileX,tileY,tilemapObject)
	return tilemapObject.get_tile("world#tilemap", "reachable", tileX+1, tileY+1)
end

--returns index in TILEMAP array
function findNotOccupiedNeighbour(tileX,tileY)
	
	
	
	local neighbours={}
	
	if (tileY+1)<=TILEMAP_MAXY then
		table.insert(neighbours,TILEMAP_INDEX_LOOKUP[tileX][tileY+1]) --insert top neighbour
	end
	if (tileY-1)>=TILEMAP_MINY then
		table.insert(neighbours,TILEMAP_INDEX_LOOKUP[tileX][tileY-1]) --insert bottom neighbour
	end
	if (tileX-1)>=TILEMAP_MINX then
		table.insert(neighbours,TILEMAP_INDEX_LOOKUP[tileX-1][tileY]) --insert left neighbour
	end
	if (tileX+1)<=TILEMAP_MAXX then
		table.insert(neighbours,TILEMAP_INDEX_LOOKUP[tileX+1][tileY]) --insert right neighbour
	end
	
	for _, neighbourIndex in pairs(neighbours) do
	    if TILEMAP_NODES[neighbourIndex].occupied == false then
			return neighbourIndex
		end
	end
	
	print("didn't find free neighbour")
	
end

