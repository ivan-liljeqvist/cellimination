

function initFightingUnit(self)
	
	self.isFighting=false
	self.canFight=true
	
	self.targetEnemyId=nil
	self.targetEnemyPosition=nil
	self.targetEnemyTeam=nil
	self.currentShot=nil
	self.attackers={}
	
	self.range=2 --if melee we need to be next to the enemy
	

end

function resetTargetEnemy(self)
	self.targetEnemyId=nil
	self.targetEnemyPosition=nil
	self.targetEnemyTeam=nil
	self.currentShot=nil
end



function fightingUnitUpdate(self,go,dt)

	if self.canFight==false then return end

	searchForTarget(self)
	
	if self.targetEnemyId then
		msg.post(self.targetEnemyId,"requestPosition",{})
		self.isFighting=true
	end
	
	if self.targetEnemyId and targetWithinReach(self) then
		shootTarget(self)
	end
	
end


function shootTarget(self)

	if self.currentShot == nil and self.targetEnemyPosition then
		
		self.currentShot=self.factory.create("#shotFactory", nil, nil, {})
		msg.post(msg.url(self.currentShot),"setOwnerUrl",{id=self.id})
		msg.post(msg.url(self.currentShot),"setTeam",{team=self.teamNumber})
		
		local shotDirection = vmath.vector3(self.x,self.y,1)-vmath.vector3(self.targetEnemyPosition.x,self.targetEnemyPosition.y,1)
		msg.post(msg.url(self.currentShot),"setDirection",{dir=-vmath.normalize(shotDirection)})
		
		
	else
		
	end
end

function targetWithinReach(self)
	
	if self.targetEnemyPosition then
	
		local xDiff=math.abs(self.x-self.targetEnemyPosition.x)
		local yDiff=math.abs(self.y-self.targetEnemyPosition.y)
		local distance = math.sqrt(xDiff*xDiff+yDiff*yDiff)
		distance=math.floor(distance/(TILE_SIZE))
		
		print(xDiff,yDiff,distance,self.range)
		
		if distance <= self.range then
			return true
		else
			print("targetWithinReach is not within")
		end
		
	else
		print("targetWithinReach is nil")
	end
	
	return false
	
end


function fightingUnitMessageHandler(self,go,message_id,message,sender)
	if message_id == hash("resetCurrentShot") then
		self.currentShot=nil
		
	elseif message_id == hash("requestObject") then
		
		msg.post(sender,"objectCallback",{object=self})
	
	elseif message_id == hash("requestPosition") then
	
		if sender~=self.id then
			msg.post(sender,"positionCallback",{position={x=self.x,y=self.y}})
		end
	elseif message_id == hash("requestTeam") then
		msg.post(sender,"teamCallback",{team=self.teamNumber})
	elseif message_id == hash("addToAttackers")then
	
		table.insert(self.attackers,message.attacker)
		
	elseif message_id == hash("positionCallback")then

		self.targetEnemyPosition=message.position
	
	--1) we get shot by someone
	elseif message_id == hash("contact_point_response") then
		
		msg.post(message.other_id,"requestOwner",{}) --request the shot for it's owner
	--2) now we know who shot us
	elseif message_id == hash("shotOwnerCallback")then
		
		--if we don't have a target, set the shooter as target
		if self.targetEnemyId == nil then
			self.targetEnemyId=message.ownerId
			
			--we need to make sure that our target is not on our team
			msg.post(self.targetEnemyId,"requestTeam",{})
		end
	
	--3) now we know which team the unit that shot us is on
	elseif message_id == hash("teamCallback") then
	
		self.targetEnemyTeam = message.team
		--if on our team, reset target, we don't target teammates
		
		if self.targetEnemyTeam == self.teamNumber then
			resetTargetEnemy(self)
		end

	end
end

function searchForTarget(self)

	if self.targetEnemy==nil then
	
		local target = getFirstEnemyInRange(self)
		
		if target then
			self.targetEnemyId = target.id
		end
		
	end

end

function getFirstEnemyInRange(self)
	
	if self == nil then return end	


	local minY = self.tileCoordinates[2]+1-self.range
	local maxY = self.tileCoordinates[2]+1+self.range
	local minX = self.tileCoordinates[1]+1-self.range
	local maxX = self.tileCoordinates[1]+1+self.range
	

	for x = minX, maxX, 1 do

		for y = minY, maxY, 1 do 
			
			
			if  TILEMAP_INDEX_LOOKUP then
				
				local tileNodeIndex = TILEMAP_INDEX_LOOKUP[x][y]
				local tileNode = TILEMAP_NODES[tileNodeIndex]
				
				
				if tileNode and tileNode.occupiedBy then
					if self then
						if tileNode.occupied and  tileNode.occupiedBy.teamNumber~=self.teamNumber then
								return tileNode.occupiedBy
						end
					end
				end
			end
		
		end--
	end
	
	return nil
end

