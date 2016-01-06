

function loadPath(self,path)
	self.goalX=self.x
	self.goalY=self.y
	--table.remove(self.currentPath, 1)
	TILEMAP_NODES[self.lastDestIndex].occupied=false
	TILEMAP_NODES[self.lastDestIndex].occupiedBy=nil
	TILEMAP_NODES[self.lastDestIndex].occupiedByID=nil
	self.currentPath=copyTable(path)--concatTables(self.currentPath,copyTable(path))
	
	self.noNextNode=false
end





function goStraightToNode(self,nodeIndex)
	
	self.tileCoordinates={pixelToTileCoords(self.goalX,self.goalY)}
    local currentNodeIndex=TILEMAP_INDEX_LOOKUP[self.tileCoordinates[1]+1][self.tileCoordinates[2]+1]
   
    
	TILEMAP_NODES[currentNodeIndex].occupied = false
	TILEMAP_NODES[currentNodeIndex].occupiedBy = nil
	   -- tilemapObject.set_tile("world#tilemap", "reachable", self.tileCoordinates[1]+1, self.tileCoordinates[2]+1, 4)

	
	TILEMAP_NODES[self.lastDestIndex].occupied=false
	TILEMAP_NODES[self.lastDestIndex].occupiedByID=nil
	TILEMAP_NODES[self.lastDestIndex].occupiedBy=nil
	
	self.currentPath={TILEMAP_NODES[nodeIndex]}
	
	TILEMAP_NODES[nodeIndex].occupied=true
	TILEMAP_NODES[nodeIndex].occupiedBy=self
	TILEMAP_NODES[nodeIndex].occupiedByID=self.id
	self.lastDestIndex=nodeIndex
end

function moveAccordingToPath(self,go,dt)

	if self.teamNumber~=PLAYER_TEAM and not self.isFighting then return end

	local pos = getPosition(self)
	local yDiff=pos.y-self.goalY
	local xDiff=pos.x-self.goalX
	local reachedGoal=(yDiff<1 and yDiff>-1) and (xDiff<1 and xDiff>-1)
	
	self.dir=vmath.vector3(pos.x-self.goalX,pos.y-self.goalY,0)
	
    if reachedGoal==false then
  
    	--self.go.set_position(pos-self.dir*MOVE_SPEED[self.name]*2*dt)
    	
    	local step=MOVE_SPEED[self.name]*dt*50
    	
    	if self.name == TANK1_NAME and self.teamNumber==PLAYER_TEAM then
    		step=step+NUMBER_BOUGHT[UPGRADE_TANK_NAME]*5
    	end
    	
    	if pos.y<self.goalY then 
    		pos.y=pos.y+step
    		if pos.y>self.goalY then pos.y=self.goalY end
    	elseif pos.y>self.goalY then 
    		pos.y=pos.y-step 
    		if pos.y<self.goalY then pos.y=self.goalY end
    	end
    	
       if pos.x<self.goalX then 
    		pos.x=pos.x+step
    		if pos.x>self.goalX then pos.x=self.goalX end
    	elseif pos.x>self.goalX then 
    		pos.x=pos.x-step 
    		if pos.x<self.goalX then pos.x=self.goalX end
    	end
    	
    	triggerCheck(pos.x,pos.y)
    	
    	self.go.set_position(pos)
    	
    	--moveHealthbar(self)
    elseif not self.noNextNode or self.headingForExtractor  then
    	followPath(self)
    end
    
end

function abortPath(self)

	if self.lastDestIndex then
		TILEMAP_NODES[self.lastDestIndex].occupied=false
		TILEMAP_NODES[self.lastDestIndex].occupiedBy=nil
		TILEMAP_NODES[self.lastDestIndex].occupiedByID=nil
	end
	
	self.currentPath={}
end


function followPath(self)

	if self.noNextNode then return end


	
	local nextNode=table.remove(self.currentPath, 1)
	
	if nextNode then
	
		if self.lastNodeInPath then
			TILEMAP_NODES[self.lastNodeInPath.tilemapIndex].occupied=false
			TILEMAP_NODES[self.lastNodeInPath.tilemapIndex].occupiedBy=nil
			TILEMAP_NODES[self.lastNodeInPath.tilemapIndex].occupiedByID=nil
			--tilemapObject.set_tile("world#tilemap", "reachable", self.lastNodeInPath.x, self.lastNodeInPath.y, 1)
		end
	
		
		
	
		self.noNextNode=false

		if nextNode.occupied==true and nextNode.occupiedBy~=self and table.getn(self.currentPath)<1 then
			
		
			local newNodeIndex=findNotOccupiedNeighbour(nextNode.x,nextNode.y,3) --the last is the total number of recursions allowed
    		if newNodeIndex then
    				
    			nextNode=TILEMAP_NODES[newNodeIndex]
    			
    		end
		end
		
		if nextNode then
	
			TILEMAP_NODES[nextNode.tilemapIndex].occupied=true
			TILEMAP_NODES[nextNode.tilemapIndex].occupiedBy=self
			TILEMAP_NODES[nextNode.tilemapIndex].occupiedByID=self.id
			--tilemapObject.set_tile("world#tilemap", "reachable", nextNode.x, nextNode.y, 0)
		end
		
		self.lastNodeInPath=nextNode
		

		self.goalX,self.goalY=tileToPixelCoords(nextNode.x-1,nextNode.y-1)
		
		giveFollowersMyPosition(self)
	
		
		self.needToUpdateRotation=true
		
		self.tileCoordinates={nextNode.x,nextNode.y}
	else 	
		self.noNextNode=true
	end
	
	
end