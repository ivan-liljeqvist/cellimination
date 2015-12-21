

function initBuilding(self)
	self.prototypeMode=true
end

function buildingInput(self,action)

	--if prototype mode - follow the cursor
	if self.prototypeMode then
		--follow cursor
		
		go.set_position(vmath.vector3(action.x,action.y,1))
	end
end

function buildingUpdate(self,dt)

end

