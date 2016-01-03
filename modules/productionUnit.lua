
function initProductionUnit(self)
	
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

    elseif self.currentlyProducing and TOTAL_HOUSE<MAX_HOUSE then
    
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


function removeOneWorkerFromExtractor(self)
	if self.isFatExtractor then
		WORKERS_EXTRACTING_FAT=WORKERS_EXTRACTING_FAT-1
	elseif self.isProteinExtractor then
		WORKERS_EXTRACTING_PROTEIN=WORKERS_EXTRACTING_PROTEIN-1
	elseif self.isCarbExtractor then
		WORKERS_EXTRACTING_CARB=WORKERS_EXTRACTING_CARB-1
	end
end

function productionButton1PressedExtractor(self)
	table.remove(self.toProduce,1)
	resetProduction(self)
	msg.post("unitManager", "new"..WORKER_NAME, {position=vmath.vector3(self.x+self.orOffX+TILE_SIZE*3,self.y+self.orOffY,1), producerPosition=vmath.vector3(self.x+self.orOffX,self.y+self.orOffY,1)}) 
	self.workersInside=self.workersInside-1
	removeOneWorkerFromExtractor(self)
end

function productionButton2PressedExtractor(self)
	table.remove(self.toProduce,2)
	resetProduction(self)
	msg.post("unitManager", "new"..WORKER_NAME, {position=vmath.vector3(self.x+self.orOffX+TILE_SIZE*3,self.y+self.orOffY,1), producerPosition=vmath.vector3(self.x+self.orOffX,self.y+self.orOffY,1)}) 
	self.workersInside=self.workersInside-1
	removeOneWorkerFromExtractor(self)
end

function productionButton3PressedExtractor(self)
	table.remove(self.toProduce,3)
	resetProduction(self)
	msg.post("unitManager", "new"..WORKER_NAME, {position=vmath.vector3(self.x+self.orOffX+TILE_SIZE*3,self.y+self.orOffY,1), producerPosition=vmath.vector3(self.x+self.orOffX,self.y+self.orOffY,1)}) 
	self.workersInside=self.workersInside-1
	removeOneWorkerFromExtractor(self)
end

function productionButton4PressedExtractor(self)
	table.remove(self.toProduce,4)
	resetProduction(self)
	msg.post("unitManager", "new"..WORKER_NAME, {position=vmath.vector3(self.x+self.orOffX+TILE_SIZE*3,self.y+self.orOffY,1), producerPosition=vmath.vector3(self.x+self.orOffX,self.y+self.orOffY,1)}) 
	self.workersInside=self.workersInside-1
	removeOneWorkerFromExtractor(self)
end
