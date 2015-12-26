



function followUnit(self,unitToFollow)
	if self.followee==nil then
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
	self.speed=6
	self.dir=vmath.vector3(0,0,0)
	
	self.lastDestIndex=1
	
	self.movableUnit=true
	
end

function unitUpdate(self,go,dt)
	
	
	if self.canFight then
		lookForEnemies(self)
	end
	
	updateRotation(self,go)
	moveAccordingToPath(self,go,dt)
	
		
	self.x=go.get_position().x
	self.y=go.get_position().y	
	
	--self.tileCoordinates={pixelToTileCoords(self.x,self.y)}

end
