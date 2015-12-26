

function initFightingUnit(self,ranger)
	
	self.isFighting=false
	self.canFight=true
	self.isRanger=ranger
	
	
end

function enterFightMode(self)
	if self.canFight then
		self.isFighting = true
	end
end

function isInFightMode(self)
	return self.isFighting
end

function lookForEnemies(self)
	
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

	--find nearby enemies
	local nearbyEnemyTiles = findEnemiesAroundUnit(self,SPOT_ENEMY_RADIUS,findEnemyFunc)
	
	--go to the enemies
	for _,enemyTile in pairs(nearbyEnemyTiles) do
		if isInFightMode(self) == false then
			--generateNewPathToTile(self,enemyTile)
			--enterFightMode(self)
			followUnit(self,enemyTile.occupiedBy)
		end
	end

end


