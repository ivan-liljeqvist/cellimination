


function updateFoW(tilemapObject)


	--go through all of player's units
	for unit,isAlive in pairs(MY_UNITS) do
		
		--get the coordinates in pixels
		local pixelX=unit.x-CAMERA_OFFSETX
		local pixelY=unit.y-CAMERA_OFFSETY
		
		--translate to tile coordinates
		local tileX,tileY=pixelToTileCoords(pixelX,pixelY)
		
		--make the tile the unit stands on visible
		tilemapObject.set_tile("world#tilemap", "fogOfWar", tileX+1, tileY+1,0)
		
		for counter=1, unit.fogRadius, 1 do
		
		
			local minY = tileY+1-unit.fogRadius 
			local maxY = tileY+1+unit.fogRadius
			local minX = tileX+1-unit.fogRadius
			local maxX = tileX+1+unit.fogRadius
			
			for x = minX, maxX, 1 do
				
				for y = minY, maxY, 1 do 
				
					if isWithinTilemap(x,y) then
						tilemapObject.set_tile("world#tilemap", "fogOfWar", x, y,0)
					end
				
				end
				
			end
			
		end
		
	end
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




