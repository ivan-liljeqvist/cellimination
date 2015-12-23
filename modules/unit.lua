
require "modules.coordinates"


function initBasicUnit(self,name,goID)
	self.bounds=getSpriteBounds("#sprite")    
    self.selected=false
    self.initialScale=self.go.get_scale()
    
    local pos=self.go.get_position()
    pos.x=pos.x
	pos.y=pos.y
	self.go.set_position(pos)
    
    self.name=name
    
    registerForInput(goID)
    
    table.insert(selectableUnits, self.go.get_id())
    
    self.movableUnit=false
end


function registerForInput(id)
	GAME_OBJECTS_THAT_REQUIRE_INPUT[id]=true
end

function unregisterForInput(id)
	GAME_OBJECTS_THAT_REQUIRE_INPUT[id]=nil
end

function initMovableUnit(self)

	
	self.goalX = getPosition(self).x
    self.goalY = getPosition(self).y
    
    self.needToUpdateRotation=false
    
    self.tileCoordinates={pixelToTileCoords(self.goalX,self.goalY)}
    
    self.currentPath={}
	self.neverMoved=true
	self.speed=6
	self.dir=vmath.vector3(0,0,0)
	
	self.lastDestIndex=1
	
	self.movableUnit=true
	
end


function loadPath(self,path)
	TILEMAP_NODES[self.lastDestIndex].occupied=false
	TILEMAP_NODES[self.lastDestIndex].occupiedBy=nil
	self.currentPath=concatTables(self.currentPath,copyTable(path))
	
	print(" new path with: "..table.getn(self.currentPath).." nodes")
end

function generateNewPathToMouseClick(self,action,tilemap)

		TILEMAP_NODES[self.lastDestIndex].occupied=false
		TILEMAP_NODES[self.lastDestIndex].occupiedBy=nil

		local tileX,tileY=pixelToTileCoords(action.x,action.y,ignoreCameraOffset)
    	local tileType=getTileTypeAt(tileX,tileY,tilemap)
    	
    	--check if we can go there
    	if tileType~=TILE_NOT_REACHABLE_CODE then
    		
    		
    		--we need to figure out the start and end nodes, we know their coordinates

			--by using the coordinates, get the index of dest-node in the NODE_ARRAY
    		local destIndex=TILEMAP_INDEX_LOOKUP[tileX+1][tileY+1]
    		--by using the coordinates, get the index of start-node in the NODE_ARRAY
    		local startIndex=TILEMAP_INDEX_LOOKUP[self.tileCoordinates[1]][self.tileCoordinates[2]]
    		
    		--now use indeces to get start and finish nodes
    		local startNode,finishNode=TILEMAP_NODES[startIndex],TILEMAP_NODES[destIndex]
    		
    		--see if some other unit has already occupied the finish-node
    		if finishNode.occupied==false then
    			--do nothing
    		--if occupied find a neighbour tile that is not occupied and set it as new destination
    		else
  
    			local newDestIndex=findNotOccupiedNeighbour(tileX+1,tileY+1,3) --the last is the total number of recursions allowed
    			if newDestIndex then
    				
    				destIndex=newDestIndex
    				finishNode=TILEMAP_NODES[destIndex]
    				
    			end
    		end
    		
    		startNode.occupied=false
    		startNode.occupiedBy=nil
    		TILEMAP_NODES[startIndex]=startNode
    		finishNode.occupied=true
    		finishNode.occupiedBy=self
    		TILEMAP_NODES[destIndex]=finishNode
    		
    		self.lastDestIndex=destIndex
    						  			
    		
    		--use A* to find out the path
    		self.currentPath=pathfinder.path (startNode, finishNode, TILEMAP_NODES, true, validator )
    		
    		--for some reason the first goal in first path is wrong, just remove it
    		if self.currentPath and self.neverMoved and table.getn(self.currentPath)>0 then
    			table.remove(self.currentPath, 1)
    			self.neverMoved=false
    		end
   
			if not self.currentPath then
				print ( "No valid path found" )
				self.currentPath={}
			else
				--print("path with "..table.getn(self.currentPath).." nodes")
			end

    	else
    		print("not reachable!")
    	end
 end
 

function updateRotation(self,go)
	local pos = getPosition(self)
	if self.needToUpdateRotation then
    	local old_rot = self.go.get_rotation()
    
	    local angle = math.atan2(self.goalY - pos.y, self.goalX - pos.x)
		angle = angle-math.pi*0.5
		
		self.go.set_rotation(vmath.quat_rotation_z(angle))
		self.needToUpdateRotation=false
		
		self.dir=vmath.vector3(pos.x-self.goalX,pos.y-self.goalY,0)
	end
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

function getPosition(self)
	local posTemp = self.go.get_position()
	return vmath.vector3(self.x,self.y,posTemp.z)
end

function goStraightToNode(self,nodeIndex)
	TILEMAP_NODES[self.lastDestIndex].occupied=false
	TILEMAP_NODES[self.lastDestIndex].occupiedBy=nil
	
	print("nodeIndex: "..nodeIndex)
	self.currentPath={TILEMAP_NODES[nodeIndex]}
	
	TILEMAP_NODES[nodeIndex].occupied=true
	TILEMAP_NODES[nodeIndex].occupiedBy=self
	self.lastDestIndex=nodeIndex
end


function followPath(self)

	if self.lastNodeInPath then
		self.lastNodeInPath.occupied=false
		self.lastNodeInPath.occupiedBy=nil
	end
	
	local nextNode=table.remove(self.currentPath, 1)
	
	if nextNode then

		if nextNode.occupied==true and nextNode.occupiedBy~=self and table.getn(self.currentPath)<1 then
			print("next node occupied "..nextNode.x.." "..nextNode.y)
			local newNodeIndex=findNotOccupiedNeighbour(nextNode.x-1,nextNode.y-1,3) --the last is the total number of recursions allowed
    		if newNodeIndex then
    				
    			nextNode=TILEMAP_NODES[newNodeIndex]
    			print("resolved node occupied "..nextNode.x.." "..nextNode.y)
    		end
		end
		
		nextNode.occupied=true
		nextNode.occupiedBy=self
		
		self.lastNodeInPath=nextNode
		
		self.goalX,self.goalY=tileToPixelCoords(nextNode.x-1,nextNode.y-1)
		
		
	
		
		self.needToUpdateRotation=true
		
		self.tileCoordinates={nextNode.x,nextNode.y}
	else 	
		print("nextNode is nil")
	end
	
	
end