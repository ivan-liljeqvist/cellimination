
require "modules.coordinates"


function initBasicUnit(self)
	self.bounds=getSpriteBounds("#sprite")    
    self.selected=false
    self.initialScale=go.get_scale()
    
    msg.post(".", "acquire_input_focus")
end


function initMovableUnit(self)
	self.goalX = go.get_position("#sprite").x
    self.goalY = go.get_position("#sprite").y
    self.needToUpdateRotation=false
    
    self.tileCoordinates={mouseToTileCoords(self.goalX+1,self.goalY+1)}
    
    self.currentPath={}
	self.neverMoved=true
	self.speed=6
	self.dir=vmath.vector3(0,0,0)
	
	table.insert(selectableUnits, go.get_id())
end

function generateNewPathToMouseClick(self,action,tilemap)

		local tileX,tileY=mouseToTileCoords(action.x,action.y)
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
    			print("already occupied!")
    			local newDestIndex=findNotOccupiedNeighbour(tileX+1,tileY+1,true) --the last is if should use recursion
    			if newDestIndex then
    				
    				destIndex=newDestIndex
    				finishNode=TILEMAP_NODES[destIndex]
    				
    			end
    		end
    		
    		startNode.occupied=false
    		TILEMAP_NODES[startIndex]=startNode
    		finishNode.occupied=true
    		TILEMAP_NODES[destIndex]=finishNode
    						  			
    		
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
			end

    	else
    		print("not reachable!")
    	end
 end

function updateRotation(self,go)
	local pos = go.get_position()
	if self.needToUpdateRotation then
    	local old_rot = go.get_rotation()
    
	    local angle = math.atan2(self.goalY - pos.y, self.goalX - pos.x)
		angle = angle-math.pi*0.5
		
		go.set_rotation(vmath.quat_rotation_z(angle))
		self.needToUpdateRotation=false
		
		self.dir=vmath.vector3(pos.x-self.goalX,pos.y-self.goalY,0)
	end
end

function moveAccordingToPath(self,go,dt)
	local pos = go.get_position()
	local reachedGoal=(math.abs(pos.y-self.goalY)<1) and (math.abs(pos.x-self.goalX)<1)
    if reachedGoal==false then
    	
    	go.set_position(pos-self.dir*self.speed*dt)
    elseif self.currentPath then
    	--check if the current path has more nodes
    	if table.getn(self.currentPath)~=0 then
    		followPath(self)
    	end
    end
end


function followPath(self)
	
	
	local nextNode=table.remove(self.currentPath, 1)
	
	if nextNode then

		self.goalX,self.goalY=tileToPixelCoords(nextNode.x-1,nextNode.y-1)
		
		local pos=go.get_position("#sprite")
		
		self.needToUpdateRotation=true
		
		self.tileCoordinates={nextNode.x,nextNode.y}
	else 	
		print("nextNode is nil")
	end
	
end