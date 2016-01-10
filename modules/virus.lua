
PLAYER_X=4400
PLAYER_Y=3000

function virusMessageHandler(self,go,message_id,message,sender)
	
	if message_id == hash("attack")  then
		
		CURRENT_VIRUSES_ATTACKING[self]=true
		self.shouldAttackPlayer=true
		self.movingTowardsPlayer=false
		self.lastTileUpdate=0
		self.zombieMode=true
		self.timeSinceNotZombie=0
		
		self.attackingFromRight=message.fromRight
		
		print("attack recieved")
		

	end
	
end

function turnOffZombieMode(self)
	self.zombieMode=false
	self.timeSinceNotZombie=0
end

function reachedPlayer(self)

	if self.attackingFromRight then
		
		if (self.goalX-PLAYER_X)<0 then return true end
	else
		
		if (self.goalX-PLAYER_X)>0 then return true end
	end

	return false

end


function virusUpdate(self,dt)
	
	if math.abs(self.goalX-go.get_position().x)<10 and math.abs(self.goalY-go.get_position().y)<10 and self.zombieMode then 
		self.movingTowardsPlayer=false 
	end
	
	if self.shouldAttackPlayer and not self.movingTowardsPlayer and not self.virusExitZombieForever and not reachedPlayer(self) then
		
		if self.attackingFromRight then
			self.goalX=self.goalX-TILE_SIZE
		else
			self.goalX=self.goalX+TILE_SIZE
		end
	
		avoidObstacles(self)
		
		self.movingTowardsPlayer=true
		virusTileUpdate(self)
	end
	
	if self.timeSinceNotZombie then
		if not self.zombieMode and self.timeSinceNotZombie>5 then 
			self.zombieMode=true
		end
	end

	if self.lastTileUpdate then
		self.lastTileUpdate=self.lastTileUpdate+dt
	end
	if self.timeSinceNotZombie then
		self.timeSinceNotZombie=self.timeSinceNotZombie+dt
	end
end

function avoidObstacles(self)

	--try one tile down
	if isGoalTileOccupied(self) and self.lastGoalY~=(self.goalY+TILE_SIZE) then
		self.goalY=self.goalY+TILE_SIZE
		
		if self.attackingFromRight then
			self.goalX=self.goalX+TILE_SIZE
		else self.goalX=self.goalX-TILE_SIZE end
		
		self.lastGoalY=self.goalY
		
		if isGoalTileOccupied(self) then 
			if self.targetEnemyId==nil then
				
				
				if LEVEL==2 then 
					self.goalY=self.goalY+TILE_SIZE 
				else
					self.goalY=self.goalY+TILE_SIZE 
				end
				
				
				
				self.virusExitZombieForever=true 
			end
			
		end
	end
	

	
end

function isGoalTileOccupied(self)
	self.tileCoordinates={pixelToTileCoords(self.goalX-CAMERA_OFFSETX,self.goalY-CAMERA_OFFSETY)}
	if self.tileCoordinates and TILEMAP_INDEX_LOOKUP[self.tileCoordinates[1]+1] then
	
		local currentNodeIndex=TILEMAP_INDEX_LOOKUP[self.tileCoordinates[1]+1][self.tileCoordinates[2]+1]
		if (TILEMAP_NODES[currentNodeIndex].occupied and TILEMAP_NODES[currentNodeIndex].occupiedBy.teamNumber~=self.teamNumber) or 
			TILEMAP_NODES[currentNodeIndex].type==0 then return true end
		
	end
end

function virusTileUpdate(self)
	
	if self.lastTileUpdate<0.5 then return end

	self.lastTileUpdate=0
	
	self.tileCoordinates={pixelToTileCoords(self.goalX-CAMERA_OFFSETX,self.goalY-CAMERA_OFFSETY)}
	
	--print ( "map bounds  ",TILEMAP_MAXX,TILEMAP_MAXY,self.tileCoordinates[1].." "..self.tileCoordinates[2])
	if self.tileCoordinates and TILEMAP_INDEX_LOOKUP[self.tileCoordinates[1]+1] then
	
			
	    	local currentNodeIndex=TILEMAP_INDEX_LOOKUP[self.tileCoordinates[1]+1][self.tileCoordinates[2]+1]
	
			
			if self.lastIndex then
				
				TILEMAP_NODES[self.lastIndex].occupied = false
		    	TILEMAP_NODES[self.lastIndex].occupiedBy = nil
		    	
		    	--tilemapObject.set_tile("world#tilemap", "reachable", (TILEMAP_NODES[self.lastIndex].x+1), (TILEMAP_NODES[self.lastIndex].y+1), 1)
			end
	
			self.lastIndex=currentNodeIndex
		    TILEMAP_NODES[currentNodeIndex].occupied = true
		    TILEMAP_NODES[currentNodeIndex].occupiedBy = self
		    
		    --tilemapObject.set_tile("world#tilemap", "reachable", (TILEMAP_NODES[currentNodeIndex].x+1), (TILEMAP_NODES[currentNodeIndex].y+1), 0)
		    
	end
end