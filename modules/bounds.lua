
function getSpriteBounds(id)
	local pos = go.get_position()
	
	local Xmin = pos.x-go.get(id, "size.x")/2*go.get(id, "scale.x")
	local Ymin = pos.y-go.get(id, "size.y")/2*go.get(id, "scale.y")
	local Xmax = pos.x+go.get(id, "size.x")*0.5*go.get(id, "scale.x")
	local Ymax = pos.y+go.get(id, "size.y")*0.5*go.get(id, "scale.y")
	
	return {Xmin,Xmax,Ymin,Ymax}
end

function isSpriteHit(action)

	
	if ((action.x > getSpriteBounds("#sprite")[1] and action.x < getSpriteBounds("#sprite")[2]) and 
		(action.y > getSpriteBounds("#sprite")[3] and action.y < getSpriteBounds("#sprite")[4])) then
    	return true
	end
	
	return false
end


function isInsideSelection(startMouse, currentMouse, pivot)
	
	
	local bounds = getSpriteBounds("#sprite")
	
	--selection
	local RectA={}
	RectA.X1 = startMouse[1]*ZOOM_LEVEL
	RectA.X2 = currentMouse[1]*ZOOM_LEVEL
	RectA.Y1 = startMouse[2]*ZOOM_LEVEL
	RectA.Y2 = currentMouse[2]*ZOOM_LEVEL
	
	--sprite
	local RectB={}
	RectB.X1 = bounds[1]-CAMERA_OFFSETX
	RectB.X2 = bounds[2]-CAMERA_OFFSETX
	RectB.Y1 = bounds[3]-CAMERA_OFFSETY
	RectB.Y2 = bounds[4]-CAMERA_OFFSETY
	
	--if SW - no change, we now want to adjust so that pivot is SW
	--if SE - switch X1 and X2
	if(pivot == gui.PIVOT_SE)then
		local oldX1=RectA.X1
		RectA.X1 = RectA.X2
		RectA.X2 = oldX1
	--if NW - switch Y1 and Y2
	elseif(pivot == gui.PIVOT_NW)then
		local oldY1=RectA.Y1
		RectA.Y1 = RectA.Y2
		RectA.Y2 = oldY1
	--if NE - switch both X1-X2 and Y1-Y2
	elseif(pivot==gui.PIVOT_NE)then
		local temp=RectA.X1
		RectA.X1 = RectA.X2
		RectA.X2 = temp
		
		temp=RectA.Y1
		RectA.Y1 = RectA.Y2
		RectA.Y2 = temp
	end
    
    if(RectA.X1 < RectB.X2 and RectA.X2 > RectB.X1 and
       RectA.Y1 < RectB.Y2 and RectA.Y2 > RectB.Y1) then
    	return true
    end
	
	return false
end

function massSelect(self,title,go)
	
	if self.selected==false then
		self.selected=true
		go.set_scale(self.initialScale*1.2)
		showHealthBar(self)
		msg.post("mixer","slime",{})
	end
end

function deselect(self,go)
	self.selected=false
    go.set_scale(self.initialScale)
    
    hideHealthBar(self)
end

function select(self,title,go)
	self.selected=true
    go.set_scale(self.initialScale*1.2)
    
    msg.post("mixer","slime",{})
    
    msg.post("HUD","setLeftTitle",{text=title})
    msg.post("manager","unitSelected",{selectedId=go.get_id()})
    
    
end
