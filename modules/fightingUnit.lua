

function lookForEnemies(self)
	
	--[[
		1) Look 4 tiles in radius after an enemy
		2) If ranger - shoot 
		3) If not ranger - go there
	--]]
	
	local nearbyEnimies = getNearbyEnemies(self)
	
end

local findEnemyFunc=function(x,y,self)
		
		if isWithinTilemap(x,y) then
			
			local tileNodeIndex=TILEMAP_INDEX_LOOKUP[x][y]
			local tileNode=TILEMAP_NODES[tileNodeIndex]
			
			--something on the tile
			if tileNode.occupied and tileNode.occupiedBy.teamNumber~=self.teamNumber then
				print("enemy found "..tileNode.occupiedBy.teamNumber)	
			end
			
		end
	
end

function getNearbyEnemies(self)

	loopAreaAroundUnit(self,SPOT_ENEMY_RADIUS,findEnemyFunc)

end


