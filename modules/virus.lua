
PLAYER_X=2500
PLAYER_Y=3000

function virusMessageHandler(self,go,message_id,message,sender)
	
	if message_id == hash("attackPlayer") then
		
		CURRENT_VIRUSES_ATTACKING[self]=true
		self.shouldAttackPlayer=true
		self.movingTowardsPlayer=false
		self.lastTileUpdate=0
		self.zombieMode=true
		self.timeSinceNotZombie=0
	end
	
end

function turnOffZombieMode(self)
	self.zombieMode=false
	self.timeSinceNotZombie=0
end


function virusUpdate(self,dt)
	
	if math.abs(self.goalX-go.get_position().x)<10 and self.zombieMode then 
		self.movingTowardsPlayer=false 
	end
	
	if self.shouldAttackPlayer and not self.movingTowardsPlayer then
		
		self.goalX=self.goalX-TILE_SIZE
		self.movingTowardsPlayer=true
		virusTileUpdate(self)
	end
	
	if not self.zombieMode and self.timeSinceNotZombie>5 then 
		self.zombieMode=true
	end

	
	self.lastTileUpdate=self.lastTileUpdate+dt
	self.timeSinceNotZombie=self.timeSinceNotZombie+dt
end


function virusTileUpdate(self)
	
	if self.lastTileUpdate<0.5 then return end

	self.lastTileUpdate=0
	
	self.tileCoordinates={pixelToTileCoords(self.goalX-CAMERA_OFFSETX,self.goalY-CAMERA_OFFSETY)}
	
	--print ( "map bounds  ",TILEMAP_MAXX,TILEMAP_MAXY,self.tileCoordinates[1].." "..self.tileCoordinates[2])
	if self.tileCoordinates and TILEMAP_INDEX_LOOKUP[self.tileCoordinates[1]+1] then
	
			print("virus at "..self.tileCoordinates[1].." "..self.tileCoordinates[2])
	    	local currentNodeIndex=TILEMAP_INDEX_LOOKUP[self.tileCoordinates[1]+1][self.tileCoordinates[2]+1]
	
			
			if self.lastIndex then
				TILEMAP_NODES[self.lastIndex].occupied = nil
		    	TILEMAP_NODES[self.lastIndex].occupiedBy = nil
			end
	
			self.lastIndex=currentNodeIndex
		    TILEMAP_NODES[currentNodeIndex].occupied = true
		    TILEMAP_NODES[currentNodeIndex].occupiedBy = self
		    
		    --tilemapObject.set_tile("world#tilemap", "reachable", (self.tileCoordinates[1]+1), (self.tileCoordinates[2]+1), 0)
		    
	end
end