


function generateDrop(self)


	
	local res=math.random(1,3)
		
	local dropAmount=math.random(1,MAX_DROP[self.name])
	
	if LEVEL~=3 then
		if res==1 then PROTEIN=PROTEIN+dropAmount return "+"..dropAmount.." protein" 
		elseif res==2 then CARBS=CARBS+dropAmount  return "+"..dropAmount.." carbs."
		elseif res==3 then FAT=FAT+dropAmount  return "+"..dropAmount.." fat"  end
	elseif LEVEL==3 then
	
		if self.name~=CLOUDY_STRONG4_NAME then
			dropAmount=dropAmount*2
			PROTEIN=PROTEIN+dropAmount 
			
			return "+"..dropAmount.." protein" 
		else --boss
			PROTEIN=PROTEIN+500 
			return "+ 500 protein" 
		end
	end
	
	
end