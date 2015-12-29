
function initProductionUnit(self)
	print("initProductionUnit")
	
	self.producer=true
	self.toProduce={}
	
	self.currentProductionProgress=0.0
	self.currentlyProducing=false
	self.currentlyProducingItem=""
	self.currentlyProducingItemIcon=""
	self.timeSinceLastProductionStarted=0
end

function resetProduction(self)
    self.currentlyProducing=false
	self.currentProductionProgress=0
	self.currentlyProducingItem=""
end

function updateProductionUnit(self,dt)
	if table.getn(self.toProduce)>0 and self.currentlyProducing==false then
    	self.currentlyProducing=true
    	self.currentProductionProgress=0
    	self.timeSinceLastProductionStarted=0
    	self.currentlyProducingItem=self.toProduce[1]

    elseif self.currentlyProducing then
    	if self.currentProductionProgress < 1.0 then
	    	self.timeSinceLastProductionStarted=self.timeSinceLastProductionStarted+dt
	    	local percent=(self.timeSinceLastProductionStarted)/TIME_TO_PRODUCE[self.currentlyProducingItem]
	    	self.currentProductionProgress=percent
	    else
	    	self.productionComplete(self.currentlyProducingItem,self)
	    	table.remove(self.toProduce,1)
			resetProduction(self)
	    end
    end
end

function productionButton1Pressed(self)
	table.remove(self.toProduce,1)
	resetProduction(self)
end

function productionButton2Pressed(self)
	table.remove(self.toProduce,2)
	resetProduction(self)
end

function productionButton3Pressed(self)
	table.remove(self.toProduce,3)
	resetProduction(self)
end

function productionButton4Pressed(self)
	table.remove(self.toProduce,4)
	resetProduction(self)
end
