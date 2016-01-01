


function initHealingUnit(self)
	
	self.healer=true
	
	self.healing=false
	
	self.playingCircleAnimation=true
	
	self.healingRadius = HEALING_RADIUS[self.name]
	self.healingStrength=HEALING_STRENGTH[self.name]
	self.healingRate=HEALING_RATE[self.name]
	
	self.timeSinceLastHeal=0
	
end

function healerUpdate(self,go,dt)

	self.timeSinceLastHeal=self.timeSinceLastHeal+dt
	
	--see if we have injured around us
	searchForSomeoneToHeal(self)
	--show and hide the circle animation
	handleCircleAnimations(self)
	
end

function searchForSomeoneToHeal(self)
	

	
	local tileX,tileY = pixelToTileCoords(self.x-CAMERA_OFFSETX,self.y-CAMERA_OFFSETY)
	local radius = self.healingRadius

	local minY = tileY+1-radius
	local maxY = tileY+1+radius
	local minX = tileX+1-radius
	local maxX = tileX+1+radius
	
	self.healing=false
	
	for x = minX, maxX, 1 do
		
		for y = minY, maxY, 1 do 
		
			local nodeIndex = TILEMAP_INDEX_LOOKUP[x][y]
			local tile = TILEMAP_NODES[nodeIndex]
			

			if tile.occupied and tile.occupiedBy then
				
				if tile.occupiedBy.id ~= self.id and tile.occupiedBy.needsHealing then
					if self.timeSinceLastHeal>=self.healingRate then
						msg.post(tile.occupiedBy.id,"heal",{hp=self.healingStrength})
						self.timeSinceLastHeal=0
					end
					self.healing=true
				else
					--self.healing=false
				end
			end
		
		end
		
	end
				


end

function handleCircleAnimations(self)

	if not self.healing then
		if self.playingCircleAnimation then
			self.spine.play("#healCircle","hide",go.PLAYBACK_LOOP_FORWARD,0.5)
			self.playingCircleAnimation=false
		end
	else
		if not self.playingCircleAnimation then
			self.spine.play("#healCircle","animation",go.PLAYBACK_LOOP_FORWARD,0.5)
			self.playingCircleAnimation=true
		end
	end
	
end
