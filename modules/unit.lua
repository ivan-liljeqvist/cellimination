
require "modules.coordinates"


function initBasicUnit(self,name,goID)

	populateNodeArray()
	
	self.bounds=getSpriteBounds("#sprite",self)    
    self.selected=false
    
    self.canFight=false
    
    self.isBuilding=false
    local pos=self.go.get_position()
    pos.x=pos.x
	pos.y=pos.y
	self.go.set_position(pos)
	
    self.name=name
    self.id=goID
    
    self.showingHealthBar=true
    self.highHealth=true
    self.timeSinceTempShowHealth=0
    self.showingHelthTemp=false
    hideHealthBar(self)
    
    ALIVE[self.id]=true
    registerForInput(goID)
    
    table.insert(selectableUnits, self.go.get_id())
    self.indexInSelectableUnits=table.getn(selectableUnits)
    
    self.movableUnit=false
    
    go.set_scale(self.initialScale)
    
    MY_UNITS[self]=true
    
    self.teamNumber=PLAYER_TEAM
    
    self.goalX = getPosition(self).x
    self.goalY = getPosition(self).y
    
    self.hitByLastId={}
    
    self.tileCoordinates={pixelToTileCoords(self.goalX,self.goalY)}
    local currentNodeIndex=TILEMAP_INDEX_LOOKUP[self.tileCoordinates[1]+1][self.tileCoordinates[2]+1]
   
    if self.willBecomeBuilding~=true then
	    TILEMAP_NODES[currentNodeIndex].occupied = true
	    TILEMAP_NODES[currentNodeIndex].occupiedBy = self
	    --tilemapObject.set_tile("world#tilemap", "reachable", self.tileCoordinates[1]+1, self.tileCoordinates[2]+1, 4)
	end
	
	self.originalHealth=MAX_HEALTH[self.name]
	self.health=self.originalHealth	
	
	self.showingProgressBar=true
	self.producingSomething=false
	hideProgressBar(self)
	hideHealthBar(self)
end



function destroyUnit(self)

	if ALIVE[self.id] then
		print("destory unt team "..self.teamNumber)
		ALIVE[self.id]=false
		
		if self.worker then
			abortConstruction(self)
		end
		
		GAME_OBJECTS_THAT_REQUIRE_INPUT[self.go.get_id()]=nil
		--table.remove(selectableUnits,self.indexInSelectableUnits)
		
		MY_UNITS[self]=nil
		local currentNodeIndex=TILEMAP_INDEX_LOOKUP[self.tileCoordinates[1]][self.tileCoordinates[2]]
	    TILEMAP_NODES[currentNodeIndex].occupied = false
	    TILEMAP_NODES[currentNodeIndex].occupiedBy = nil
	    TILEMAP_NODES[currentNodeIndex].occupiedByID = nil
	    
	    --tilemapObject.set_tile("world#tilemap", "reachable", self.tileCoordinates[1], self.tileCoordinates[2], 0)
	    
	    unregisterForInput(self.id)
	    
	    removeFromSelectedUnits(self)
	    
	    
	    if self.isBuilding then
	    	if self.prototypeMode~=true then
	    		destroyBuilding(self)
	    	end
	    end
	    
	    msg.post("HUD","unitDestroyed",{id=self.id})
	    
	    msg.post(self.id,"deleteGO")
	    
	    
	    self=nil
	end

end

function basicUnitUpdate(self,dt,go)

	--if self.producing then
		local pos = go.get_position()
		pos.x=(pos.x-CAMERA_OFFSETX)/ZOOM_LEVEL
		pos.y=(pos.y+30-CAMERA_OFFSETY)/ZOOM_LEVEL
		msg.post(msg.url("#progressGUI"),"setPosition",{position=pos})
	--end
	
	checkIfShouldShowProgress(self)
	
	--update healthbar
	--if self.showingHealthBar or self.showingHelthTemp then
	
		--1) move the bar after the unit
		local pos = go.get_position()
		pos.x=(pos.x-CAMERA_OFFSETX)/ZOOM_LEVEL
		pos.y=(pos.y+30-CAMERA_OFFSETY)/ZOOM_LEVEL
		
		msg.post(msg.url("#healthGUI"),"setPosition",{position=pos})
		
		
		local ratio = self.health/self.originalHealth 
		--2) if the health is below 30% - set low health
		if ratio < 0.3 and self.highHealth then
			msg.post(msg.url("#healthGUI"),"lowHealth",{position=pos})
			self.highHealth=false
		elseif ratio >= 0.3 and self.highHealth==false then
			msg.post(msg.url("#healthGUI"),"highHealth",{position=pos})
			self.highHealth=true
		end
		
		--3) update the width of the health bar
		msg.post(msg.url("#healthGUI"),"updateSize",{ratio=ratio})
	--end
	
	--see if we should hide the temporary healthbar
	if self.showingHelthTemp then
		
			
			self.timeSinceTempShowHealth=self.timeSinceTempShowHealth+dt
			
			if self.timeSinceTempShowHealth>2 then
				msg.post(msg.url("#healthGUI"),"hide")
				self.showingHelthTemp=false
			end
			
		
	end
	

end

function hideProgressBar(self)
	if self.showingProgressBar then
		msg.post(msg.url("#progressGUI"),"hide")
	end
end

function showProgressBar(self)
	if not self.showingProgressBar then
		msg.post(msg.url("#progressGUI"),"show")
	end
end

function checkIfShouldShowProgress(self)
	if self.producing and not self.showingProgressBar then
		showProgressBar(self)
	elseif not self.producing and self.showingProgressBar then
		hideProgressBar(self)
	end
end

function hideHealthBar(self)
	msg.post(msg.url("#healthGUI"),"hide")
	self.showingHealthBar=false
end

function showHealthBar(self)
	if not (self.isBuilding and self.putDownAndWaitingForWorker) then
		msg.post(msg.url("#healthGUI"),"show")
		self.showingHealthBar=true
	end
end

function showHealthBarTemporarily(self)
	msg.post(msg.url("#healthGUI"),"show")
	self.timeSinceTempShowHealth=0
	self.showingHelthTemp=true
end

function registerForInput(id)
	GAME_OBJECTS_THAT_REQUIRE_INPUT[id]=true
end

function unregisterForInput(id)
	GAME_OBJECTS_THAT_REQUIRE_INPUT[id]=nil
end




function setTeam(self,teamNumber) 
	self.teamNumber=teamNumber
end

function basicUnitMessageHandler(self,go,message_id,message,sender)


	if message_id==hash("setTeam") then
		self.teamNumber=message.newTeamNumber
		print("new team "..message.newTeamNumber)

	elseif message_id==hash("rollOutOfProducer") then
		--generateNewPathToMouseClick(self,message,tilemap)--last argument is to ignore camera offset
		
		local pixelX,pixelY=message.x,message.y
		local tileX,tileY=pixelToTileCoords(pixelX-CAMERA_OFFSETX,pixelY-CAMERA_OFFSETY)

		
		local didFindAWay=false
		--[[if message.waypointSet then
		
			--if we didn't find a way, use regular goStraightToNode() in the if below
			didFindAWay=generateNewPathToTileCoordsB(self,tileX,tileY)
			
			if not didFindAWay then --set the goal back to the producer, not the waypoint
				pixelX,pixelY=message.prodX,message.prodY
				tileX,tileY=pixelToTileCoords(pixelX-CAMERA_OFFSETX,pixelY-CAMERA_OFFSETY)
			end
		end--]]
		
		if didFindAWay==false then
			local nodeIndex=TILEMAP_INDEX_LOOKUP[tileX+1][tileY+1]
			local node=TILEMAP_NODES[nodeIndex]
			
			if node.occupied then
				local newDestIndex=findNotOccupiedNeighbour(tileX+1,tileY+1,7)
				if newDestIndex then
					nodeIndex=newDestIndex
				end
			end
			
			goStraightToNode(self,nodeIndex)
		end
		
		
		
	elseif message_id == hash("requestPosition") then
		
		if sender~=self.id then
			msg.post(sender,"positionCallback",{position={x=self.x,y=self.y}})
		end
		
	elseif message_id == hash("contact_point_response") then
	
		if message.other_id ~= self.hitByLastId and BULLET_OWNER[message.other_id]~=self.id and not BULLET_HIT_ALREADY[message.other_id] then
		
			--get owner and damage
			msg.post(message.other_id,"requestOwner",{}) --request the shot for it's owner
			BULLET_HIT_ALREADY[message.other_id]=true
			
			self.hitByLastId=message.other_id
		end
		
	--2) now we know who shot us
	elseif message_id == hash("shotOwnerCallback")then
		
		if message.team ~= self.teamNumber and message.ownerId ~= self.id then
			
			--if we don't have a target, set the shooter as target
			if self.targetEnemyId == nil and self.canFight then
				
				self.targetEnemyId=message.ownerId
			
			end
			
			
		
			msg.post(self.hitByLastId,"die")	
		
			self.health=self.health-message.damage
			
			if self.showingHealthBar==false then
				showHealthBarTemporarily(self)
			end
	
			if self.health <= 0 then
				destroyUnit(self)
			end
	   end

	end
end

function getPosition(self)
	local posTemp = self.go.get_position()
	return vmath.vector3(self.x,self.y,posTemp.z)
end




