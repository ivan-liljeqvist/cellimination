
function initBuilding(self,spriteObject,buildingSize,go)

	self.spriteObject=spriteObject
	self.prototypeMode=true
	self.buildingSize=buildingSize
	prototypeColorPositionInvalid(self,self.x,self.y)
	self.canBuildHere=false
	
	self.go=go
	
	self.rightReleasedSinceLast=true
	
	self.builtAtX=nil
	self.builtAtY=nil
	
	
	self.putDownAndWaitingForWorker=false
	
	self.isBuilding=true
	
	self.waypointHidden=false
	self.waypoint=self.factory.create("#waypointFactory",nil,nil,{})
	self.waypointPosition=vmath.vector3(self.x,self.y,1)
	
	self.workerID = nil -- worker building the building

	hideWaypoint(self)
	
	self.constructionStarted=false
	self.constructionDone=false
	self.constructionProgress=0
	self.constructionTime=CONSTRUCTION_TIME[self.name]
	
	self.construction=self.factory.create("#constructionFactory")
	self.building = self.factory.create("#buildingFactory")
	
	hideConstruction(self)
	
	print("self.constructionScale "..self.constructionScale)
	
	go.set_scale(vmath.vector3(self.constructionScale, self.constructionScale, self.constructionScale),self.construction)
	go.set_scale(vmath.vector3(self.initialScale, self.initialScale, self.initialScale),self.building)

	
	
end

function buildingMessageHandler(self,go,message_id,message,sender)
	
	if message_id == hash("setWorkerID") and self.workerID==nil then

		self.workerID=message.workerID
	elseif message_id == hash("abortConstruction") and self.workerID then
		destroyUnit(self)
	elseif message_id == hash("workerArrived") and self.workerID then
		print("worker arrived!")
		msg.post(self.workerID,"resetBuilding")
		self.workerID=nil
		
		buildHere( self.builtAtX, self.builtAtY,self)
		self.x=self.builtAtX
		self.y=self.builtAtY
		
		hideBuilding(self)
		showConstruction(self)

		
	end

end


function constructionDone(self)
	
	msg.post(msg.url("mixer"),"constructionDone")
	
	msg.post(msg.url("healthBars#gui"),"hide",{unitId=self.id})
	
	if self.isFatExtractor==true then 
		FAT_EXTRACTORS_MADE=FAT_EXTRACTORS_MADE+1
		if LEVEL==2 then level2FatExtractorDone() end
	elseif self.isCarbExtractor==true then 
		CARB_EXTRACTORS_MADE=CARB_EXTRACTORS_MADE+1
		if LEVEL==2 then level2CarbsExtractorDone() end
	elseif self.isProteinExtractor==true then 
		PROTEIN_EXTRACTORS_MADE=PROTEIN_EXTRACTORS_MADE+1 
		if LEVEL==2 then level2ProteinExtractorDone() end
	end
	
	if self.name==BARACKS_NAME and LEVEL==2 then
		level2ReplicationStationDone()
	end
	
	showBuilding(self)
	hideConstruction(self)
		
	self.GUILayout=self.GUILayoutComplete
	
	--msg.post("#sprite", "play_animation", {id = hash(BUILDING_COMPLETED_SPRITE[self.name])})
	
	go.delete(self.construction)
	
	if self.name==STORAGE_NAME then
		MAX_STORAGE=MAX_STORAGE+STORAGE_INCREASE
	elseif self.name==HOUSE_NAME then
		MAX_HOUSE=MAX_HOUSE+HOUSING_INCREASE
	end
	
end


function putPrototypeHere(x,y,self)

	print("putting here ",x,y)

	self.builtAtX=x*ZOOM_LEVEL
	self.builtAtY=y*ZOOM_LEVEL
	
	
	
	self.putDownAndWaitingForWorker=true
	
	--self.prototypeMode=false
	--setTilesUnderMeToOccupied(self,x,y)
	setTilesUnderMeToOccupied(self,self.builtAtX,self.builtAtY)
	
	self.orOffX=CAMERA_OFFSETX
	self.orOffY=CAMERA_OFFSETY
	
end

function buildHere(x,y,self)

	--msg.post("#sprite", "play_animation", {id = hash("construction")})
	
	self.workerID=nil
	self.prototypeMode=false
	
	
	self.builtAtX=x
	self.builtAtY=y
	
	self.x=x+self.orOffX
	self.y=y+self.orOffY
	
	--self.go.set_position(vmath.vector3(self.x+self.orOffX,self.y+self.orOffY+100,0))
	
	self.putDownAndWaitingForWorker=false
	
	if self.selected then
		showHealthBar(self)
	end
	
	self.constructionStarted=true
end

function hideWaypoint(self)
	if not self.waypointHidden then
		msg.post(self.waypoint,"hide")
		self.waypointHidden=true
	end
end

function tempHideWP(self)
	msg.post(self.waypoint,"hide")
end

function tempShowWP(self)
	msg.post(self.waypoint,"show")
end

function showWaypoint(self,pos)
	
	local x = pos.x
	local y = pos.y
	local tileX,tileY = pixelToTileCoords((x)-CAMERA_OFFSETX,(y)-CAMERA_OFFSETY)
	
	local tileType = getTileTypeAt(tileX,tileY)
	
	if tileType == TILE_NOT_REACHABLE_CODE then
		msg.post("HUD","displayErrorMessage",{text=WAYPOINT_UNREACHABLE})
	else

		msg.post(self.waypoint,"show",{pos=pos})
		self.waypointHidden=false

		
	end
	

end

function buildingInput(self,action,action_id)

	if action_id==hash("rightClicked") and self.needsWaypoint and not moreThanOneSelected() and self.selected and action.pressed and self.rightReleasedSinceLast then
		self.rightReleasedSinceLast=false
		
		local newWPPos=vmath.vector3(action.x*ZOOM_LEVEL+CAMERA_OFFSETX,action.y*ZOOM_LEVEL+CAMERA_OFFSETY,1)
		
		if math.abs(newWPPos.x-(self.x+self.orOffX))>400 or math.abs(newWPPos.y-(self.y+self.orOffY))>400 then
			msg.post("HUD","displayErrorMessage",{text=WAYPOINT_TOO_FAR})
		else
			self.waypointPosition=newWPPos
			showWaypoint(self,self.waypointPosition)
		end
		
	elseif action_id==hash("rightClicked") and action.released and not self.rightReleasedSinceLast then
		self.rightReleasedSinceLast=true
		--hideWaypoint(self)
	end

	if self.prototypeMode and action_id == hash("leftClicked") and action.pressed and self.putDownAndWaitingForWorker==false then
	
		if self.canBuildHere then
			
			if canAfford(self.name) then
				go.set_position(vmath.vector3(action.x*ZOOM_LEVEL+CAMERA_OFFSETX,action.y*ZOOM_LEVEL+CAMERA_OFFSETY,1),self.construction)
				go.set_position(vmath.vector3(action.x*ZOOM_LEVEL+CAMERA_OFFSETX,action.y*ZOOM_LEVEL+CAMERA_OFFSETY,1))
				
				local workerPos=go.get_position()
				workerPos.x=workerPos.x-CAMERA_OFFSETX
				workerPos.y=workerPos.y-CAMERA_OFFSETY
				workerPos.x=workerPos.x+TILE_SIZE
				
				if self.isExtractor then
					workerPos.x=workerPos.x+TILE_SIZE*2
				end
				
				
				msg.post(self.workerID,"goToBuildingSite",{pos=workerPos})
				
				deductResources(self.name)	
				NUMBER_BOUGHT[self.name]=NUMBER_BOUGHT[self.name]+1
				
				--buildHere(action.x*ZOOM_LEVEL,action.y*ZOOM_LEVEL,self)
				putPrototypeHere(action.x,action.y,self)
			else
				msg.post("HUD","displayErrorMessage",{text=NOT_ENOUGH_RESOURCES})
			end
		else
			self.builtAtX=action.x*ZOOM_LEVEL
			self.builtAtY=action.y*ZOOM_LEVEL
			
			destroyUnit(self)
			alertCantBuildHere()
		end

	--if prototype mode - follow the cursor
	elseif self.prototypeMode and self.putDownAndWaitingForWorker==false then
		GUI_CLICKED=true
		--follow cursor
		
		self.x=action.x*ZOOM_LEVEL-CAMERA_OFFSETX
		self.y=action.y*ZOOM_LEVEL-CAMERA_OFFSETY
		
		--check if we can build here
		self.canBuildHere = canBuildAt(self,action.x,action.y)
		
		
		if self.canBuildHere then
			go.set_position(vmath.vector3(action.x*ZOOM_LEVEL+CAMERA_OFFSETX,action.y*ZOOM_LEVEL+CAMERA_OFFSETY,1),self.building)
		else
			go.set_position(vmath.vector3(action.x*ZOOM_LEVEL+CAMERA_OFFSETX,action.y*ZOOM_LEVEL+CAMERA_OFFSETY,1))
		end
		
		updatePrototypeColor(self,action.x,action.y)
	end
end


function alertCantBuildHere()
	--play sound or something
	msg.post("HUD","displayErrorMessage",{text=CANT_BUILD_HERE})
end

function destroyBuilding(self)
	setTilesUnderMeToNotOccupied(self,self.builtAtX,self.builtAtY)
end


--change between red and green
function updatePrototypeColor(self,x,y)
	if self.prototypeMode then
		if self.canBuildHere then
			prototypeColorPositionValid(self,x,y)
		else
			prototypeColorPositionInvalid(self,x,y)
		end
	end
end

--check we can fit a building at x,y
function canBuildAt(self,x,y)

	if y<HUD_RIGHT_HEIGHT and x>getScreenWidth()-HUD_RIGHT_WIDTH then return false end
	
	local centerTileX, centerTileY = pixelToTileCoords(x*ZOOM_LEVEL,y*ZOOM_LEVEL)
	
	

	--go through each row and column
	local minTileX = centerTileX+1+ self.buildingSize.startPointFromCenter.x
	local maxTileX = minTileX + self.buildingSize.width
	local minTileY = centerTileY +1+ self.buildingSize.startPointFromCenter.y
	local maxTileY = minTileY + self.buildingSize.height
	
	
	for currentX=minTileX, maxTileX, 1 do
		for currentY=minTileY, maxTileY, 1 do
			
			
			
			if canBuildAtTile(self,currentX,currentY) == false then
				return false
			end
			
			
		end
	end
	
	
	
	return true
end

function setTilesUnderMeToNotOccupied(self,x,y)

	
	local centerTileX, centerTileY = pixelToTileCoords(x,y)
	
	--go through each row and column
	local minTileX = centerTileX + self.buildingSize.startPointFromCenter.x
	local maxTileX = minTileX + self.buildingSize.width
	local minTileY = centerTileY + self.buildingSize.startPointFromCenter.y
	local maxTileY = minTileY + self.buildingSize.height
	
	
	for currentX=minTileX, maxTileX, 1 do
		for currentY=minTileY, maxTileY, 1 do
		
			local nodeIndex = TILEMAP_INDEX_LOOKUP[currentX+1][currentY+1] 
			
			if TILEMAP_NODES[nodeIndex].occupiedBy == self then
				TILEMAP_NODES[nodeIndex].occupied=false
				TILEMAP_NODES[nodeIndex].occupiedBy=nil
				TILEMAP_NODES[nodeIndex].blocked=false
				TILEMAP_NODES[nodeIndex].occupiedByID=nil
				
				--tilemapObject.set_tile("world#tilemap", "blocked", currentX, currentY, 0)
			end

			 		
		end
	end
	
	
	return true
end

function setTilesUnderMeToOccupied(self,x,y)

	
	local centerTileX, centerTileY = pixelToTileCoords(x,y)
	
	--go through each row and column
	local minTileX = centerTileX + self.buildingSize.startPointFromCenter.x
	local maxTileX = minTileX + self.buildingSize.width
	local minTileY = centerTileY + self.buildingSize.startPointFromCenter.y
	local maxTileY = minTileY + self.buildingSize.height
	
	
	for currentX=minTileX, maxTileX, 1 do
		for currentY=minTileY, maxTileY, 1 do
		
			local nodeIndex = TILEMAP_INDEX_LOOKUP[currentX+1][currentY+1] 
			TILEMAP_NODES[nodeIndex].occupied=true
			TILEMAP_NODES[nodeIndex].occupiedBy=self
			TILEMAP_NODES[nodeIndex].blocked=true
			TILEMAP_NODES[nodeIndex].occupiedByID=self.id
			
			--.set_tile("world#tilemap", "reachable", currentX, currentY, 0)

			 		
		end
	end
	
	
	return true
end

function isFatTile(type)
	if type==37 or type==51
	   then return true end
	return false
end

function canBuildAtTile(self,tileX,tileY)
	
	--tileX=tileX+1
	--tileY=tileY+1
	
	--tilemapObject.set_tile("world#tilemap", "reachable", tileX, tileX, 0)

	local nodeIndex = TILEMAP_INDEX_LOOKUP[tileX][tileY] 
	local tileNode = TILEMAP_NODES[nodeIndex] 
	

	--if normal building, not an extractor
	if tileNode and self.isProteinExtractor~=true and self.isCarbExtractor~=true 
		and self.isFatExtractor~=true then
		
		if tileNode.type~=TILE_NOT_REACHABLE_CODE and tileNode.occupied==false and not isFatTile(tileNode.blockedType) then
			return true
		else
			print("cant build: "..tileNode.type)
			if tileNode.occupied then print("and occupied") end
		end
	
	elseif self.isProteinExtractor then
		
		if tileNode.occupied==false and isFatTile(tileNode.blockedType) then
			return true
		end
	elseif self.isCarbExtractor then	
		
		if tileNode.occupied==false and isFatTile(tileNode.blockedType) then
			return true
		end
	elseif self.isFatExtractor then
		
		if tileNode.occupied==false and isFatTile(tileNode.blockedType) then
			return true
		end
	end
	
	
	return false
end

function prototypeColorPositionValid(self,x,y)
	showBuilding(self)
	self.spriteObject.set_constant("#sprite", "tint", vmath.vector4(0,0,0,0))
end

function prototypeColorPositionInvalid(self,x,y)
	
	hideBuilding(self)
	self.spriteObject.set_constant("#sprite", "tint", vmath.vector4(1,1,1,1))
end

function hideConstruction(self)
	if self.construction then
		msg.post(self.construction,"hide")
	end
end

function showConstruction(self)
	if self.construction then
		msg.post(self.construction,"show")
	end
end

function hideBuilding(self)
	if self.building then
		msg.post(self.building,"hide")
	end
end

function showBuilding(self)
	if self.building then
		msg.post(self.building,"show")
	end
end

function buildingUpdate(self,dt,go)

	
	if self.constructionStarted and not self.constructionDone then
		showProgressBar(self)
		self.constructionProgress=self.constructionProgress+dt
		
		local ratio=self.constructionProgress/self.constructionTime
		msg.post(msg.url("progressBars#gui"),"show",{unitId=self.id})
		msg.post(msg.url("progressBars#gui"),"updateSize",{ratio=ratio,unitId=self.id})
		
		
		
		if ratio>=1 then
			self.constructionDone=true
			self.constructionProgress=self.constructionTime
			constructionDone(self)
		end
		
	end
	
	
end


function spawnNow(self,x,y)
		self.orOffX=CAMERA_OFFSETX
		self.orOffY=CAMERA_OFFSETY
		self.constructionDone=true
		self.constructionStarted=true
		self.GUILayout=self.GUILayoutComplete
		setTilesUnderMeToOccupied(self,go.get_position().x,go.get_position().y)
		buildHere(x,y,self)
end

