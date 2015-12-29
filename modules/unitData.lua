
UNIT_DESCRIPTIONS={}
HOVER_LAYOUT={}
PRICES={}



--Red blood cell
RBC_NAME="RED BLOOD CELL"
UNIT_DESCRIPTIONS[RBC_NAME]="Red Blood Cell is a quick and cheap unit"
PRICES[RBC_NAME]={carb=10,protein=10,fat=10}
HOVER_LAYOUT[RBC_NAME] = { price=PRICES[RBC_NAME], description=UNIT_DESCRIPTIONS[RBC_NAME] }

--worker
WORKER_NAME="WORKER"
UNIT_DESCRIPTIONS[RBC_NAME]="Worker can build things but cannot fight"

--Command Center
BASE_NAME="COMMAND CENTER"
UNIT_DESCRIPTIONS[BASE_NAME]="Command center produces units"
PRICES[BASE_NAME]={carb=100,protein=100,fat=100}
HOVER_LAYOUT[BASE_NAME] = {name=BASE_NAME, price=PRICES[BASE_NAME], description=UNIT_DESCRIPTIONS[BASE_NAME] }

--Protein Extractor
PROTEIN_EXTRACTOR_NAME="PROTEIN EXTRACTOR"
UNIT_DESCRIPTIONS[PROTEIN_EXTRACTOR_NAME]="Extracts protein from tissue"
PRICES[PROTEIN_EXTRACTOR_NAME]={carb=100,protein=100,fat=100}
HOVER_LAYOUT[PROTEIN_EXTRACTOR_NAME] = { name=PROTEIN_EXTRACTOR_NAME, price=PRICES[PROTEIN_EXTRACTOR_NAME], description=UNIT_DESCRIPTIONS[PROTEIN_EXTRACTOR_NAME] }

--Fat Extractor
FAT_EXTRACTOR_NAME="FAT EXTRACTOR"
UNIT_DESCRIPTIONS[FAT_EXTRACTOR_NAME]="Extracts fat from tissue"
PRICES[FAT_EXTRACTOR_NAME]={carb=100,protein=100,fat=100}
HOVER_LAYOUT[FAT_EXTRACTOR_NAME] = {name=FAT_EXTRACTOR_NAME,  price=PRICES[FAT_EXTRACTOR_NAME], description=UNIT_DESCRIPTIONS[FAT_EXTRACTOR_NAME] }

--Carb Extractor
CARB_EXTRACTOR_NAME="CARBS. EXTRACTOR"
UNIT_DESCRIPTIONS[CARB_EXTRACTOR_NAME]="Extracts carbs. from tissue"
PRICES[CARB_EXTRACTOR_NAME]={carb=100,protein=100,fat=100}
HOVER_LAYOUT[CARB_EXTRACTOR_NAME] = {name=CARB_EXTRACTOR_NAME, price=PRICES[CARB_EXTRACTOR_NAME], description=UNIT_DESCRIPTIONS[CARB_EXTRACTOR_NAME] }



DESELECT="deselect"
HOVER_LAYOUT[DESELECT] = { name="",description="Deselect all units" }

CANCEL_PRODUCTION="cancelProduction"
HOVER_LAYOUT[CANCEL_PRODUCTION] = { name="",description="Cancel spawning" }

NOT_ENOUGH_RESOURCES = "Not enough resources"
CANT_BUILD_HERE = "Can't build here"

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