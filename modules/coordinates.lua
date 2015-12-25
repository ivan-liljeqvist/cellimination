
function pixelToTileCoords(pixelX,pixelY)

	
	local tileX=0
	local tileY=0
	

	tileX=math.floor((pixelX+CAMERA_OFFSETX)/TILE_SIZE)
	tileY=math.floor((pixelY+CAMERA_OFFSETY)/TILE_SIZE)

	
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

function verifyIndex(index)
	
	if TILEMAP_NODES[index]==nil then return false end

	if TILEMAP_NODES[index].occupied == false and
	       TILEMAP_NODES[index].type~=TILE_NOT_REACHABLE_CODE then
		   return true
	end
	
	return false
end

function isWithinTilemap(tileX,tileY)

	if tileX<TILEMAP_MAXX and
	   tileX>TILEMAP_MINX and
	   tileY>TILEMAP_MINY and 
	   tileY<TILEMAP_MAXY then
	 	
	 	return true
	 	
	 else
	 	
	 	return false
	 	  
	 end
	 
end


function loopAreaAroundTile(tileX,tileY,radius,func)

			local minY = tileY+1-radius
			local maxY = tileY+1+radius
			local minX = tileX+1-radius
			local maxX = tileX+1+radius
			
			for x = minX, maxX, 1 do
				
				for y = minY, maxY, 1 do 
				
					func(x,y)
				
				end
				
			end
			
end

function loopAreaAroundUnit(unit,radius,func)

	local tileX = unit.tileCoordinates[1]
	local tileY = unit.tileCoordinates[2]

	local minY = tileY+1-radius
	local maxY = tileY+1+radius
	local minX = tileX+1-radius
	local maxX = tileX+1+radius

	for x = minX, maxX, 1 do
			
		for y = minY, maxY, 1 do 
				
			func(x,y,unit)
				
		end
				
	end
end



--returns index in TILEMAP array
function findNotOccupiedNeighbour(tileX,tileY,recursionsLeft)
	
	

	
	if (tileY+1)<=TILEMAP_MAXY and verifyIndex(TILEMAP_INDEX_LOOKUP[tileX][tileY+1]) then
		return TILEMAP_INDEX_LOOKUP[tileX][tileY+1]
	
	elseif (tileY-1)>=TILEMAP_MINY and verifyIndex(TILEMAP_INDEX_LOOKUP[tileX][tileY-1]) then
		return TILEMAP_INDEX_LOOKUP[tileX][tileY-1]
	
	elseif (tileX-1)>=TILEMAP_MINX and verifyIndex(TILEMAP_INDEX_LOOKUP[tileX-1][tileY]) then
		return TILEMAP_INDEX_LOOKUP[tileX-1][tileY]
	
	elseif (tileX+1)<=TILEMAP_MAXX and verifyIndex(TILEMAP_INDEX_LOOKUP[tileX+1][tileY]) then
		return TILEMAP_INDEX_LOOKUP[tileX+1][tileY]
	
	elseif (tileX+1)<=TILEMAP_MAXX and (tileY+1)<=TILEMAP_MAXY and verifyIndex(TILEMAP_INDEX_LOOKUP[tileX+1][tileY+1])then
		return TILEMAP_INDEX_LOOKUP[tileX+1][tileY+1]
	
	elseif (tileX-1)<=TILEMAP_MAXX and (tileY-1)<=TILEMAP_MAXY and verifyIndex(TILEMAP_INDEX_LOOKUP[tileX-1][tileY-1])then
		return TILEMAP_INDEX_LOOKUP[tileX-1][tileY-1]
	end
	
	
	
	if recursionsLeft>0 then
		return findNotOccupiedNeighbour(tileX+1,tileY,recursionsLeft-1)
	end
	
	
	
end

