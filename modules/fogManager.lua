


--dont update on every iteration
fogCounter=0

local clearFogFunc=function(x,y)
		
		if isWithinTilemap(x,y) then
			tilemapObject.set_tile("fog#tilemap", "fog", x, y,0)
		end
	
end

function updateFoW()


	fogCounter=fogCounter+1
	
	if fogCounter%5 ~= 0 then
		return
	else 
		fogCounter=0
	end

	--go through all of player's units
	for unit,isAlive in pairs(MY_UNITS) do
		

		
		if isAlive and unit.teamNumber==PLAYER_TEAM then

			if not (unit.isBuilding and unit.prototypeMode) then  --dont reveal if building in prototype mode
			
					--get the coordinates in pixels
					local pixelX=unit.x-CAMERA_OFFSETX
					local pixelY=unit.y-CAMERA_OFFSETY
					
					if unit.isBuilding then
						pixelX=pixelX+unit.orOffX
						pixelY=pixelY+unit.orOffY
					end
					
					--translate to tile coordinates
					local tileX,tileY=pixelToTileCoords(pixelX,pixelY)
					
					--make the tile the unit stands on visible
					if tileX+1<TILEMAP_MAXX and tileY+1<TILEMAP_MAXY then
						tilemapObject.set_tile("fog#tilemap", "fog", tileX+1, tileY+1,0)
					end
					
					for counter=1, unit.fogRadius, 1 do
				
						loopAreaAroundTile(tileX,tileY,unit.fogRadius,clearFogFunc)
					
					end
			
			else
				--print("prototype mode!")
			end
		end
		
	end
end










