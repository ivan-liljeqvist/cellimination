

function lookForEnemies(self)
	
	--[[
		1) Look 4 tiles in radius after an enemy
		2) If ranger - shoot 
		3) If not ranger - go there
	--]]
	
	local nearbyEnemies = getNearbyEnemies(self)
	
end

local findEnemyFunc=function(x,y,self)


		if isWithinTilemap(x,y) then
			
			
			local tileNodeIndex=TILEMAP_INDEX_LOOKUP[x][y]
			local tileNode=TILEMAP_NODES[tileNodeIndex]
		
			--something on the tile
			if tileNode.occupied and tileNode.occupiedBy.teamNumber~=self.teamNumber then
				return tileNode
			end
			
		else
			print("not within tilemap")
		end
		
		return nil
	
end

function getNearbyEnemies(self)

	local nearbyEnemies = findEnemiesAroundUnit(self,SPOT_ENEMY_RADIUS,findEnemyFunc)
	
	local numEnemies = table.getn(nearbyEnemies)
	
	if numEnemies>0 then
		print(" found "..numEnemies.." enemies. My team: "..self.teamNumber)
	end

end


