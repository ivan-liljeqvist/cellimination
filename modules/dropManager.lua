


function generateDrop(self)


	
	local res=math.random(1,3)
		
	local dropAmount=math.random(1,MAX_DROP[self.name])
	
	if res==1 then PROTEIN=PROTEIN+dropAmount return "+"..dropAmount.." protein" 
	elseif res==2 then CARBS=CARBS+dropAmount  return "+"..dropAmount.." carbs."
	elseif res==3 then FAT=FAT+dropAmount  return "+"..dropAmount.." fat"  end
	
	
end