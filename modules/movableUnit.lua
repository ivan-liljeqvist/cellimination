

function giveFollowersMyPosition(self)

	for follower,stillHere in pairs(self.followers) do
		
		if stillHere and follower ~= self.followee then
			msg.post(msg.url(follower.id),"followeeChangedPosition",{tileCoords=self.tileCoordinates})
		end
		
	end

end


function followUnit(self,unitToFollow)
	if self.followee==nil and unitToFollow.followee ~= self then
	
		self.followee=unitToFollow
		unitToFollow.followers[self]=true
		
		generateNewPathToUnit(self,unitToFollow)
		
	end
end



function updateRotation(self,go)
	local pos = getPosition(self)
	if self.needToUpdateRotation then
    	local old_rot = self.go.get_rotation()
    
	    local angle = math.atan2(self.goalY - pos.y, self.goalX - pos.x)
		angle = angle-math.pi*0.5
		
		angle=math.abs(angle)
		if angle>=3.14 and self.isFighting then angle=0.0 end
		
		
		self.go.set_rotation(vmath.quat_rotation_z(angle))
		self.needToUpdateRotation=false
		
		self.dir=vmath.vector3(pos.x-self.goalX,pos.y-self.goalY,0)
		

	end
end


function initMovableUnit(self)

    self.needToUpdateRotation=false
    
    self.followee=nil
    self.followers={}
    
    self.currentPath={}
	self.neverMoved=true
	
	self.speed=MOVE_SPEED[self.name]
	
	if self.speed == nil then self.speed=6 end
	
	self.dir=vmath.vector3(0,0,0)
	
	self.lastDestIndex=1
	
	self.movableUnit=true
	
	self.orderedToMove=false
	self.orderedToMoveResetting=false
	self.orderedToMoveTimer=0
	self.orderedToMoveResetTime=3
	
end

function unitUpdate(self,go,dt)

	if self.canFight then
		fightingUnitUpdate(self,go,dt)
	end
	
	
	updateRotation(self,go)
	moveAccordingToPath(self,go,dt)
	
		
	self.x=go.get_position().x
	self.y=go.get_position().y	
	
	self.rotation=go.get_rotation()
	
	orderToMoveResetManager(self,dt)

	if self.worker and self.headingForExtractor and table.getn(self.currentPath)<=0 then
		
		arrivedAtExtractor(self)
		
	end

end

function orderToMoveResetManager(self,dt)
	--if orderedToMove is set, we want to reset it after an interval
	if self.orderedToMove and self.orderedToMoveResetting==false then
		self.orderedToMoveResetting=true
	end
	--if we're resetting, increment timer
	if self.orderedToMoveResetting then
		self.orderedToMoveTimer=self.orderedToMoveTimer+dt
	end
	--if timer is over, reset
	if self.orderedToMoveResetting and self.orderedToMoveTimer>self.orderedToMoveResetTime then
			self.orderedToMove=false
			self.orderedToMoveResetting=false
			self.orderedToMoveTimer=0
			self.orderedToMoveResetTime=3
	end
end
