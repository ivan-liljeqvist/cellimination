

function initFightingUnit(self)
	
	self.isFighting=false
	self.canFight=true
	
	self.targetEnemyId=nil
	self.targetEnemyPosition=nil
	self.currentShot=nil
	self.attackers={}
	
	self.range=1 --if melee we need to be next to the enemy
	
	if ranger then
		--set some range for range units
	else
		self.range=1
	end
	
end



function fightingUnitUpdate(self,go,dt)

	if self.canFight==false then return end

	searchForTarget(self)
	
	if self.targetEnemyId then
		msg.post(self.targetEnemyId,"requestPosition",{})
		self.isFighting=true
	end
	
	if self.targetEnemyId then
		shootTarget(self)
	end
	
end

-- set rotation: 3.141588838878 =bad
--3.1415850241662 = bad

function shootTarget(self)

	if self.currentShot == nil and self.targetEnemyPosition then
		
		self.currentShot=self.factory.create("#shotFactory", nil, nil, {})
		msg.post(msg.url(self.currentShot),"setOwnerUrl",{id=self.id})
		
		local shotDirection = vmath.vector3(self.x,self.y,1)-vmath.vector3(self.targetEnemyPosition.x,self.targetEnemyPosition.y,1)
		msg.post(msg.url(self.currentShot),"setDirection",{dir=-vmath.normalize(shotDirection)})
		
		
	else
		
	end
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
		
	elseif message_id == hash("addToAttackers")then
	
		table.insert(self.attackers,message.attacker)
		
	elseif message_id == hash("positionCallback")then

		self.targetEnemyPosition=message.position
	
	--1) we get shot by someone
	elseif message_id == hash("contact_point_response") then
		
		--print("im hit")
		--msg.post(message.other_id,"requestOwner",{}) --request the shot for it's owner
	--2) now we know who shot us
	elseif message_id == hash("shotOwnerCallback")then
		--msg.post(message.ownerId,

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

