

function initFightingUnit(self,ranger)
	
	self.isFighting=false
	self.canFight=true
	self.isRanger=ranger
	
	self.targetEnemy=nil
	
	self.range=1 --if melee we need to be next to the enemy
	
	if ranger then
		--set some range for range units
	else
		self.range=1
	end
	
end

function getFirstEnemyInRange(self)
	local minY = self.tileCoordinates[2]-self.range
	local maxY = self.tileCoordinates[2]+self.range
	local minX = self.tileCoordinates[1]-self.range
	local maxX = self.tileCoordinates[1]+self.range
	
	for x = minX, maxX, 1 do
		
		for y = minY, maxY, 1 do 
		
			local tileNodeIndex = TILEMAP_INDEX_LOOKUP[x][y]
			local tileNode = TILEMAP_NODES[tileNodeIndex]
			
			if tileNode.occupied and tileNode.occupiedBy.teamNumber~=self.teamNumber then
				return tileNode.occupiedBy
			end
		
		end
	end
	
	return nil
end

function targetIsWithinAttackDistance(self)
	
	local enemy = self.targetEnemy
	
	if self.range == nil then
		self.range=1
	end
	
	self.range=2

	local minY = self.tileCoordinates[2]-self.range
	local maxY = self.tileCoordinates[2]+self.range
	local minX = self.tileCoordinates[1]-self.range
	local maxX = self.tileCoordinates[1]+self.range
			
	for x = minX, maxX, 1 do
		
		for y = minY, maxY, 1 do 
		
			local tileNodeIndex = TILEMAP_INDEX_LOOKUP[x][y]
			local tileNode = TILEMAP_NODES[tileNodeIndex]
			
			if tileNode.occupied and tileNode.occupiedBy==self.targetEnemy then
				--print("returning can attack")
				return true
			end
		
		end
	end
	
	return false
end

function enterFightMode(self)
	if self.canFight then
		self.isFighting = true
	end
end

function isInFightMode(self)
	return self.isFighting
end


function fightingUnitUpdate(self,go,dt)
	--search for an enemy
	--searchForTarget(self)
	
	--we've found an enemy and set it as the target
	--go kill that target
	
	if self.targetEnemy then 
		--attackTarget(self)
	else
		msg.post(msg.url(self.id),"changeAnimation",{animation="normal"})
	end
	
end

function attackTarget(self)
	local canAttack=targetIsWithinAttackDistance(self)
			
	if canAttack then
		--print("enemy is close enough, can attack!")
		
		msg.post(msg.url(self.id),"changeAnimation",{animation="attack"})
	else
		--print("back to normal")
		msg.post(msg.url(self.id),"changeAnimation",{animation="normal"})
	end
	
	
end

function searchForTarget(self)

	local target = getFirstEnemyInRange(self)
	
	if target then
		self.targetEnemy = target
		print("found target!")
	end

end


