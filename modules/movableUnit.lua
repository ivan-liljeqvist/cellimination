

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
		
		self.go.set_rotation(vmath.quat_rotation_z(-angle))
		self.needToUpdateRotation=false
		
		self.dir=vmath.vector3(pos.x-self.goalX,pos.y-self.goalY,0)
		
		if self.currentShot then
			msg.post(msg.url(self.currentShot),"updateRotation",{rot=vmath.quat_rotation_z(-angle)})
		end
	end
end


function initMovableUnit(self)

    self.needToUpdateRotation=false
    
    self.followee=nil
    self.followers={}
    
    self.currentPath={}
	self.neverMoved=true
	self.speed=6
	self.dir=vmath.vector3(0,0,0)
	
	self.lastDestIndex=1
	
	self.movableUnit=true
	self.hasGoal=false
	
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
	
	--self.tileCoordinates={pixelToTileCoords(self.x,self.y)}

end