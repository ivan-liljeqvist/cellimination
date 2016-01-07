


--dont update on every iteration
fogCounter=0

FOG_BLACK_TILE=12
CLEARED_CELLS={}
local clearedIndex=1

local sinceClearedLast=0

local clearFogFunc=function(x,y)
		
		if isWithinTilemap(x,y) then
			clearedIndex=x..","..y
			CLEARED_CELLS[clearedIndex]={x=x,y=y}  --save the cells we clear
			tilemapObject.set_tile("fog#tilemap", "fog", x, y,0)
		end
	
end

function updateFoW(dt)


	
	sinceClearedLast=sinceClearedLast+dt
	
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
						
						
						clearedIndex=tileX..","..tileY
						CLEARED_CELLS[clearedIndex]={x=tileX,y=tileY}  --save the cells we clear
						
						
						tilemapObject.set_tile("fog#tilemap", "fog", tileX, tileY,0)
					end
					
					--for counter=1, unit.fogRadius, 1 do
				
					loopAreaAroundTile(tileX,tileY,3,clearFogFunc)
					
					--end
					
			
			else
				--print("prototype mode!")
			end
		end
		
	end
end

function hideClearedCells()
	
	for index,coords in pairs(CLEARED_CELLS) do
		if coords then
			tilemapObject.set_tile("fog#tilemap", "fog", coords.x, coords.y,FOG_BLACK_TILE)
			CLEARED_CELLS[index]=nil
		end
	end

end









