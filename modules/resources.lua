
START_RESOURCES={}
START_RESOURCES[1]={fat=10,protein=10,carbs=10}
START_RESOURCES[2]={fat=400,protein=400,carbs=400}
START_RESOURCES[3]={fat=700,protein=1000,carbs=700}

function setStartingResources(level)
	print("setting resources to level "..level)
	FAT=START_RESOURCES[level].fat
	PROTEIN=START_RESOURCES[level].protein
	CARBS=START_RESOURCES[level].carbs
	
	TOTAL_STORAGE=PROTEIN+FAT+CARBS
end

STORAGE_INCREASE=300
HOUSING_INCREASE=5

MAX_STORAGE=1300
if LEVEL==3 then MAX_STORAGE=3000 end


MAX_POPULATION=25

PROTEIN=400
if LEVEL==3 then PROTEIN=1000 end

FAT=400
CARBS=400

TOTAL_STORAGE=PROTEIN+FAT+CARBS
TOTAL_POPULATION=0



CARB_EXTRACTORS_MADE=0
PROTEIN_EXTRACTORS_MADE=0
FAT_EXTRACTORS_MADE=0
