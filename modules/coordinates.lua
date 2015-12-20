
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

