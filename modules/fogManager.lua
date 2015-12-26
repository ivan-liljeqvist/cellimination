


--dont update on every iteration
fogCounter=0

local clearFogFunc=function(x,y)
		
		if isWithinTilemap(x,y) then
			tilemapObject.set_tile("world#tilemap", "fogOfWar", x, y,0)
		end
	
end

function updateFoW()


	fogCounter=fogCounter+1
	
	if fogCounter%13 ~= 0 then
		return
	else 
		fogCounter=0
	end

	--go through all of player's units
	for unit,isAlive in pairs(MY_UNITS) do
		
		if isAlive then
			--get the coordinates in pixels
			local pixelX=unit.x-CAMERA_OFFSETX
			local pixelY=unit.y-CAMERA_OFFSETY
			
			--translate to tile coordinates
			local tileX,tileY=pixelToTileCoords(pixelX,pixelY)
			
			--make the tile the unit stands on visible
			if tileX+1<TILEMAP_MAXX and tileY+1<TILEMAP_MAXY then
				tilemapObject.set_tile("world#tilemap", "fogOfWar", tileX+1, tileY+1,0)
			end
			
			for counter=1, unit.fogRadius, 1 do
		
				loopAreaAroundTile(tileX,tileY,unit.fogRadius,clearFogFunc)
			
			end
		end
		
	end
end









