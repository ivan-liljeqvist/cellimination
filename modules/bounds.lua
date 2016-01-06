
function getSpriteBounds(id,self)
	local pos = go.get_position()
	
	local Xmin = pos.x-200/2*self.boundsWidthScale
	local Ymin = pos.y-200/2*self.boundsHeightScale
	local Xmax = pos.x+200*0.5*self.boundsWidthScale
	local Ymax = pos.y+200*0.5*self.boundsHeightScale
	
	return {Xmin,Xmax,Ymin,Ymax}
end


function isInsideSelection(startMouse, currentMouse, pivot,self)
	
	
	local bounds = getSpriteBounds("#sprite",self)
	
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
		
		playCallSound(self.name)
		
		if self.waypointHidden~=true then
			 tempShowWP(self)
		end
		
		moveHealthbar(self)
	end
end

function deselect(self,go)
	self.selected=false
    go.set_scale(self.initialScale)
    
	if self.waypointHidden~=true then
		 tempHideWP(self)
	end
		
    hideHealthBar(self)
end

function select(self,title,go)
	self.selected=true
    go.set_scale(self.initialScale*1.2)
    
    
    msg.post("HUD","setLeftTitle",{text=title})
    msg.post("manager","unitSelected",{selectedId=go.get_id()})
    
    
end
