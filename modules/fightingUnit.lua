

function initFightingUnit(self,ranger)
	
	self.isFighting=false
	self.canFight=true
	self.isRanger=ranger
	
	self.targetEnemy=nil
	self.currentShot=nil
	
	self.attackers={}
	self.lastTargetPos={}
	
	self.range=1 --if melee we need to be next to the enemy
	
	if ranger then
		--set some range for range units
	else
		self.range=1
	end
	
	self.iChaseTarget=false
	self.attackersComingForMe=false
	self.lastTargetPos.x=self.x
	self.lastTargetPos.y=self.y
	
end

function getFirstEnemyInRange(self)
	local minY = self.tileCoordinates[2]-self.range
	local maxY = self.tileCoordinates[2]+self.range
	local minX = self.tileCoordinates[1]-self.range
	local maxX = self.tileCoordinates[1]+self.range
	
	for x = minX, maxX, 1 do
		
		for y = minY, maxY, 1 do 
		
			if  TILEMAP_INDEX_LOOKUP[x] then
				local tileNodeIndex = TILEMAP_INDEX_LOOKUP[x][y]
				local tileNode = TILEMAP_NODES[tileNodeIndex]
				
				if tileNode then
					if tileNode.occupied and tileNode.occupiedBy.teamNumber~=self.teamNumber then
						return tileNode.occupiedBy
					end
				end
			end
		
		end
	end
	
	return nil
end

function rotateTowardsTarget(self)
	
		--[[local p = {x=self.x,y=self.y}

    	local old_rot = self.rotation
  		 
	    local angle = math.atan2(self.targetEnemy.y - p.y, self.targetEnemy.x - p.x)
		angle = angle-math.pi
		
		--self.go.set_rotation(vmath.quat_rotation_z(angle))--]]
		
end

function targetIsWithinAttackDistance(self)
	
	local enemy = self.targetEnemy
	
	if self.range == nil then
		self.range=1
	end
	
	self.range=3

	local minY = self.tileCoordinates[2]-self.range
	local maxY = self.tileCoordinates[2]+self.range
	local minX = self.tileCoordinates[1]-self.range
	local maxX = self.tileCoordinates[1]+self.range
			
	for x = minX, maxX, 1 do
		
		for y = minY, maxY, 1 do 
		
			local tileNodeIndex = TILEMAP_INDEX_LOOKUP[x][y]
			local tileNode = TILEMAP_NODES[tileNodeIndex]
			
			if tileNode.occupied and tileNode.occupiedBy==self.targetEnemy then
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
	searchForTarget(self)
	
	--we've found an enemy and set it as the target
	--go kill that target
	
	if self.targetEnemy then 
		attackTarget(self)
		
	else
		msg.post(msg.url(self.id),"changeAnimation",{animation="normal"})
	end
	
end



function attackTarget(self)
	local canAttack=targetIsWithinAttackDistance(self)
			
			
	if canAttack then
		--print("enemy is close enough, can attack!")
		
		shootTarget(self)
	elseif self.attackersComingForMe==false then


		print("will generateNewPathForAttackersToTile")
		
		
		
		self.lastTargetPos.x=self.x
		self.lastTargetPos.y=self.y
		
		self.attackersComingForMe=generateNewPathForAttackersToTile(self.attackers,self.tileCoordinates[1],self.tileCoordinates[2])
		
	end
	
	
end

function shootTarget(self)
	if self.currentShot == nil then
		
		
		
		
		self.currentShot=self.factory.create("#shotFactory", nil, nil, {})
		msg.post(msg.url(self.currentShot),"setOwnerUrl",{id=self.id})
		
		local shotDirection = vmath.vector3(self.x,self.y,1)-vmath.vector3(self.targetEnemy.x,self.targetEnemy.y,1)
		msg.post(msg.url(self.currentShot),"setDirection",{dir=-vmath.normalize(shotDirection)})
		
		
		
	else
		
	end
end


function fightingUnitMessageHandler(self,go,message_id,message)
	if message_id == hash("resetCurrentShot") then
		self.currentShot=nil
	end
end

function searchForTarget(self)

	if self.targetEnemy==nil then
	
		local target = getFirstEnemyInRange(self)
		
		if target then
			self.targetEnemy = target
			self.targetEnemy.attackers[self]=true
		end
		
	end

end


