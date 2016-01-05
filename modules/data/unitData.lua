
UNIT_DESCRIPTIONS={}
HOVER_LAYOUT={}
PRICES={}
ICONS={}
MAX_HEALTH={}
FIRE_RATE={}
MOVE_SPEED={}
CONSTRUCTION_TIME={}
FIRING_RANGE={}
VISION_RANGE={}

HEALING_RADIUS={}
HEALING_STRENGTH={}
HEALING_RATE={}

FOG_RADIUS={}

INFLATION={}
NUMBER_BOUGHT={}
NUMBER_QUEUED={}




--worker
WORKER_NAME="WORKER"
UNIT_DESCRIPTIONS[WORKER_NAME]="Worker can build things but cannot fight"
MAX_HEALTH[WORKER_NAME]=100
FOG_RADIUS[WORKER_NAME]=1
MOVE_SPEED[WORKER_NAME]=6


DESELECT="deselect"
HOVER_LAYOUT[DESELECT] = { name="",description="Deselect all units" }

CANCEL_PRODUCTION="cancelProduction"
HOVER_LAYOUT[CANCEL_PRODUCTION] = { name="",description="Cancel spawning" }

RELEASE_WORKER="releaseWorker"
HOVER_LAYOUT[RELEASE_WORKER] = { name="",description="Release worker" }

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