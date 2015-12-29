
UNIT_DESCRIPTIONS={}
HOVER_LAYOUT={}
PRICES={}



RBC_NAME="RED BLOOD CELL"
UNIT_DESCRIPTIONS[RBC_NAME]="Red Blood Cell is a quick and cheap unit"
PRICES[RBC_NAME]={carb=10,protein=10,fat=10}
HOVER_LAYOUT[RBC_NAME] = { price=PRICES[RBC_NAME], description=UNIT_DESCRIPTIONS[RBC_NAME] }

WORKER_NAME="WORKER"
UNIT_DESCRIPTIONS[RBC_NAME]="Worker can build things but cannot fight"

BASE_NAME="COMMAND CENTER"
UNIT_DESCRIPTIONS[RBC_NAME]="Command center produces units"



DESELECT="deselect"
HOVER_LAYOUT[DESELECT] = { description="Deselect all units" }

CANCEL_PRODUCTION="cancelProduction"
HOVER_LAYOUT[CANCEL_PRODUCTION] = { description="Cancel spawning" }


NOT_ENOUGH_RESOURCES = "Not enough resources"

function canAfford(unitName)
	if PRICES[unitName].protein<=PROTEIN and
	   PRICES[unitName].carb<=CARBS and 
	   PRICES[unitName].fat<=FAT then
	   
	   return true
	else
		return false
	end
end

function deductResources(unitName)
	if PRICES[unitName].protein<=PROTEIN and
	   PRICES[unitName].carb<=CARBS and 
	   PRICES[unitName].fat<=FAT then
	   
	   PROTEIN=PROTEIN-PRICES[unitName].protein
	   FAT=PROTEIN-PRICES[unitName].fat
	   CARBS=PROTEIN-PRICES[unitName].carb
	end
end