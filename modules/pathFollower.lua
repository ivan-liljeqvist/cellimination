

function loadPath(self,path)
	self.goalX=self.x
	self.goalY=self.y
	--table.remove(self.currentPath, 1)
	TILEMAP_NODES[self.lastDestIndex].occupied=false
	TILEMAP_NODES[self.lastDestIndex].occupiedBy=nil
	TILEMAP_NODES[self.lastDestIndex].occupiedByID=nil
	self.currentPath=copyTable(path)--concatTables(self.currentPath,copyTable(path))
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
	local pos = getPosition(self)
	local reachedGoal=(math.abs(pos.y-self.goalY)<1) and (math.abs(pos.x-self.goalX)<1)
	
	--print(math.abs(pos.y-self.goalY),math.abs(pos.x-self.goalX))
	
    if reachedGoal==false then
    	self.go.set_position(pos-self.dir*self.speed*dt)
    elseif self.currentPath then
    

		
    	--check if the current path has more nodes
    	if table.getn(self.currentPath)~=0 then
    		followPath(self)
    	end
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

	if self.lastNodeInPath then
		self.lastNodeInPath.occupied=false
		self.lastNodeInPath.occupiedBy=nil
		self.lastNodeInPath.occupiedByID=nil
	end
	
	local nextNode=table.remove(self.currentPath, 1)
	
	if nextNode then

		if nextNode.occupied==true and nextNode.occupiedBy~=self and table.getn(self.currentPath)<1 then
			
			local newNodeIndex=findNotOccupiedNeighbour(nextNode.x-1,nextNode.y-1,3) --the last is the total number of recursions allowed
    		if newNodeIndex then
    				
    			nextNode=TILEMAP_NODES[newNodeIndex]
    			
    		end
		end
		
		nextNode.occupied=true
		nextNode.occupiedBy=self
		nextNode.occupiedByID=self.id
		
		self.lastNodeInPath=nextNode
		
		self.goalX,self.goalY=tileToPixelCoords(nextNode.x-1,nextNode.y-1)
		
		giveFollowersMyPosition(self)
	
		
		self.needToUpdateRotation=true
		
		self.tileCoordinates={nextNode.x,nextNode.y}
	else 	
		print("nextNode is nil")
		
	end
	
	
end