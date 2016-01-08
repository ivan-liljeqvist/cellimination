


function initFightingUnit(self)
	
	self.isFighting=false
	self.canFight=true
	
	self.targetEnemyId=nil
	self.targetEnemyPosition=nil
	self.targetEnemyLastPosition=nil
	self.targetEnemyTeam=nil
	self.currentShot=nil
	self.attackers={}
	
	self.isInHostileArea=true

	
	self.firingRange=FIRING_RANGE[self.name]
	self.visionRange = VISION_RANGE[self.name]
	
	self.fightUpdateCounter=0 --we don't want to run fight logic every frame
	
	self.timeSinceLastShot = 0 -- this is for the fire rate, so we know when we've reloaded

end

function resetTargetEnemy(self)
	self.targetEnemyId=nil
	self.targetEnemyPosition=nil
	self.targetEnemyTeam=nil
	self.currentShot=nil
	self.isFighting=false
end

function moveTowardsTarget(self)
	
	local distX = self.x - self.targetEnemyPosition.x
	local distY = self.y - self.targetEnemyPosition.y
	
	local tileX = self.tileCoordinates[1]
	local tileY = self.tileCoordinates[2]
	
	if distX > 0 then --go left
		tileX=tileX-1
	else
		tileX=tileX+1
	end
	
	if distY > 0 then --go up
		tileY=tileY-1
	else
		tileY=tileY+1
	end 
	
	local willFindWay=generateNewPathToTileCoords(self,tileX-1,tileY-1)
	
	if willFindWay == false then
		resetTargetEnemy(self)
	end
	
end

function fightingUnitUpdate(self,go,dt)
	
	
	if self.canFight==false or not self.isInHostileArea then return end

	if self.fightUpdateCounter%10==0 then
		searchForTarget(self)
		self.fightUpdateCounter=0
	end
	
	if self.targetEnemyId and  ALIVE[self.targetEnemyId] then
		
		self.isFighting=true
		msg.post(self.targetEnemyId,"requestPosition",{})
	end
	
	if self.currentShot == nil and self.targetEnemyPosition then
		self.timeSinceLastShot=self.timeSinceLastShot+dt
	end

	
	self.fightUpdateCounter=self.fightUpdateCounter+1
	
end

function shootOrChase(self)
	
		
	if self.targetEnemyId then
		
		--we can reach the target without chasing
		if targetWithinFiringRange(self) then
		
			
		
			if self.orderedToMove==false then
				abortPath(self) --stop if we are moving and are not ordered to move
			else
				--self.isFighting=false --if we are ordered to move, quit fighting mode
			end
			
			shootTarget(self)
		--we need to chase
		else
			if table.getn(self.currentPath)<=0 and self.orderedToMove==false then
				if targetWithinVisionRange(self) then
					moveTowardsTarget(self) --only move if we see target
				else
					resetTargetEnemy(self)
				end
			end
		end
	end
end


function shootTarget(self)

	if self.currentShot == nil and self.targetEnemyPosition and self.timeSinceLastShot>=FIRE_RATE[self.name]then
				
		self.currentShot=self.factory.create("#shotFactory", vmath.vector3(self.x,self.y,1), nil, {})
		msg.post(msg.url(self.currentShot),"setOwnerUrl",{id=self.id,name=self.name})
		msg.post(msg.url(self.currentShot),"setTeam",{team=self.teamNumber})
		
		BULLET_OWNER[self.currentShot]=self.id
		
		local shotDirection = vmath.vector3(self.x,self.y,0)-vmath.vector3(self.targetEnemyPosition.x,self.targetEnemyPosition.y,0)
		msg.post(msg.url(self.currentShot),"setDirection",{dir=-vmath.normalize(shotDirection)})
		
		self.timeSinceLastShot=0
		
		if self.teamNumber~=PLAYER_TEAM then
				turnOffZombieMode(self)
		end
		
	else
	end
end

function targetWithinFiringRange(self)
	
	if self.targetEnemyPosition then
	
		local xDiff=math.abs(self.x-self.targetEnemyPosition.x)
		local yDiff=math.abs(self.y-self.targetEnemyPosition.y)
		local distance = math.sqrt(xDiff*xDiff+yDiff*yDiff)
		distance=math.floor(distance/(TILE_SIZE))
		
		--print(xDiff,yDiff,distance,self.firingRange)
		
		if distance <= self.firingRange then
			return true
		else
			--print("targetWithinFiringRange is not within")
		end
		
	else
		--print("targetWithinFiringRange is nil")
	end
	
	return false
	
end

function targetWithinVisionRange(self)
	
	if self.targetEnemyPosition then
	
		local xDiff=math.abs(self.x-self.targetEnemyPosition.x)
		local yDiff=math.abs(self.y-self.targetEnemyPosition.y)
		local distance = math.sqrt(xDiff*xDiff+yDiff*yDiff)
		distance=math.floor(distance/(TILE_SIZE))
		
		--print(xDiff,yDiff,distance,self.firingRange)
		
		if distance <= self.visionRange then
			return true
		else
			--print("targetWithinFiringRange is not within")
		end
		
	else
		--print("targetWithinFiringRange is nil")
	end
	
	return false
	
end


function fightingUnitMessageHandler(self,go,message_id,message,sender)
	if message_id == hash("resetCurrentShot") then
		self.currentShot=nil
	
	elseif message_id == hash("requestDamage") then
		msg.post(sender,"damageCallback",{damage=10})
		
		
	elseif message_id == hash("positionCallback")then

		self.targetEnemyLastPosition=self.targetEnemyPosition
		self.targetEnemyPosition=message.position
		shootOrChase(self)
	
	
	end

end

function searchForTarget(self)

	if self.targetEnemy==nil then
	
		local target = getFirstEnemyInRange(self)
		
		if target then
			self.targetEnemyId = target.id
		elseif self.teamNumber==2 then
			--print("no target ")
		end
	else
		print("already ahve target")
	end

end

function getFirstEnemyInRange(self)
	
	if self == nil then return end	


	local minY = self.tileCoordinates[2]+1-self.firingRange
	local maxY = self.tileCoordinates[2]+1+self.firingRange
	local minX = self.tileCoordinates[1]+1-self.firingRange
	local maxX = self.tileCoordinates[1]+1+self.firingRange
	

	for x = minX, maxX, 1 do

		for y = minY, maxY, 1 do 
			
			
			if  TILEMAP_INDEX_LOOKUP[x] then
				
				local tileNodeIndex = TILEMAP_INDEX_LOOKUP[x][y]
				local tileNode = TILEMAP_NODES[tileNodeIndex]
				
				
				 
				if tileNode and tileNode.occupiedBy then
					if self then
						
						if tileNode.occupied then
								if pcall(tryAccess,tileNode) then
									if tileNode.occupiedBy.teamNumber~=self.teamNumber then
										
										
										return tileNode.occupiedBy
									end
								else
									--TILEMAP_NODES[tileNodeIndex].occupied=false
									--TILEMAP_NODES[tileNodeIndex].occupiedBy=nil
									
									resetTargetEnemy(self)
								end
						end
					end
					
				end
			end
			
		
		
		end--
	end
	
	
	
	return nil
end

function tryAccess(tileNode)
	local test=tileNode.occupiedBy.id
end