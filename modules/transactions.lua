
function canAfford(unitName)


	local proteinPrice=math.ceil(PRICES[unitName].protein+(NUMBER_BOUGHT[unitName]+1+NUMBER_QUEUED[unitName])*INFLATION[unitName])
	local carbPrice=math.ceil(PRICES[unitName].carb+(NUMBER_BOUGHT[unitName]+1+NUMBER_QUEUED[unitName])*INFLATION[unitName])
	local fatPrice=math.ceil(PRICES[unitName].carb+(NUMBER_BOUGHT[unitName]+1+NUMBER_QUEUED[unitName])*INFLATION[unitName])

	print("protein price: "..proteinPrice)

	if proteinPrice<=PROTEIN and
	   carbPrice<=CARBS and 
	   fatPrice<=FAT then
	   
	   return true
	else
		
		return false
	end
end

function deductResources(unitName)

	local proteinPrice=math.ceil(PRICES[unitName].protein+(NUMBER_BOUGHT[unitName]+1+NUMBER_QUEUED[unitName])*INFLATION[unitName])
	local carbPrice=math.ceil(PRICES[unitName].carb+(NUMBER_BOUGHT[unitName]+1+NUMBER_QUEUED[unitName])*INFLATION[unitName])
	local fatPrice=math.ceil(PRICES[unitName].carb+(NUMBER_BOUGHT[unitName]+1+NUMBER_QUEUED[unitName])*INFLATION[unitName])

	print("deductiong :", fatPrice,proteinPrice,fatPrice)

	if proteinPrice<=PROTEIN and
	   carbPrice<=CARBS and 
	   fatPrice<=FAT then
	   
	   PROTEIN=PROTEIN-proteinPrice
	   FAT=FAT-fatPrice
	   CARBS=CARBS-carbPrice
	end
end