
HEALTH_UP_CONS=5
HEAL_CONS=0.2


UPGRADE_MORE_PROTEIN_NAME="MORE PROTEIN"
UNIT_DESCRIPTIONS[UPGRADE_MORE_PROTEIN_NAME]="More protein"
PRICES[UPGRADE_MORE_PROTEIN_NAME]={carb=10,protein=10,fat=10}
HOVER_LAYOUT[UPGRADE_MORE_PROTEIN_NAME] = { name=UPGRADE_MORE_PROTEIN_NAME, price=PRICES[UPGRADE_MORE_PROTEIN_NAME], description=UNIT_DESCRIPTIONS[UPGRADE_MORE_PROTEIN_NAME] }
ICONS[UPGRADE_MORE_PROTEIN_NAME]="proteinUpgradeIcon1"
TIME_TO_PRODUCE[UPGRADE_MORE_PROTEIN_NAME]=1
INFLATION[UPGRADE_MORE_PROTEIN_NAME]=1.1
NUMBER_BOUGHT[UPGRADE_MORE_PROTEIN_NAME]=10
NUMBER_QUEUED[UPGRADE_MORE_PROTEIN_NAME]=0


UPGRADE_MORE_CARB_NAME="MORE CARBS."
UNIT_DESCRIPTIONS[UPGRADE_MORE_CARB_NAME]="More carb"
PRICES[UPGRADE_MORE_CARB_NAME]={carb=10,protein=10,fat=10}
HOVER_LAYOUT[UPGRADE_MORE_CARB_NAME] = { name=UPGRADE_MORE_CARB_NAME, price=PRICES[UPGRADE_MORE_CARB_NAME], description=UNIT_DESCRIPTIONS[UPGRADE_MORE_CARB_NAME] }
ICONS[UPGRADE_MORE_CARB_NAME]="carbUpgradeIcon1"
TIME_TO_PRODUCE[UPGRADE_MORE_CARB_NAME]=1
INFLATION[UPGRADE_MORE_CARB_NAME]=1.1
NUMBER_BOUGHT[UPGRADE_MORE_CARB_NAME]=0
NUMBER_QUEUED[UPGRADE_MORE_CARB_NAME]=0


UPGRADE_MORE_FAT_NAME="MORE FAT"
UNIT_DESCRIPTIONS[UPGRADE_MORE_FAT_NAME]="More fat"
PRICES[UPGRADE_MORE_FAT_NAME]={carb=10,protein=10,fat=10}
HOVER_LAYOUT[UPGRADE_MORE_FAT_NAME] = { name=UPGRADE_MORE_FAT_NAME, price=PRICES[UPGRADE_MORE_FAT_NAME], description=UNIT_DESCRIPTIONS[UPGRADE_MORE_FAT_NAME] }
ICONS[UPGRADE_MORE_FAT_NAME]="fatUpgradeIcon1"
TIME_TO_PRODUCE[UPGRADE_MORE_FAT_NAME]=1
INFLATION[UPGRADE_MORE_FAT_NAME]=1.1
NUMBER_BOUGHT[UPGRADE_MORE_FAT_NAME]=0
NUMBER_QUEUED[UPGRADE_MORE_FAT_NAME]=0

UPGRADE_HEALER_NAME="BETTER HEALER"
UNIT_DESCRIPTIONS[UPGRADE_HEALER_NAME]="better healer"
PRICES[UPGRADE_HEALER_NAME]={carb=10,protein=10,fat=10}
HOVER_LAYOUT[UPGRADE_HEALER_NAME] = { name=UPGRADE_HEALER_NAME, price=PRICES[UPGRADE_HEALER_NAME], description=UNIT_DESCRIPTIONS[UPGRADE_HEALER_NAME] }
ICONS[UPGRADE_HEALER_NAME]="healUpgradeIcon1"
TIME_TO_PRODUCE[UPGRADE_HEALER_NAME]=1
INFLATION[UPGRADE_HEALER_NAME]=1.1
NUMBER_BOUGHT[UPGRADE_HEALER_NAME]=0
NUMBER_QUEUED[UPGRADE_HEALER_NAME]=0

UPGRADE_TANK_NAME="BETTER TANK"
UNIT_DESCRIPTIONS[UPGRADE_TANK_NAME]="better tank"
PRICES[UPGRADE_TANK_NAME]={carb=10,protein=10,fat=10}
HOVER_LAYOUT[UPGRADE_TANK_NAME] = { name=UPGRADE_TANK_NAME, price=PRICES[UPGRADE_TANK_NAME], description=UNIT_DESCRIPTIONS[UPGRADE_TANK_NAME] }
ICONS[UPGRADE_TANK_NAME]="tankUpgradeIcon1"
TIME_TO_PRODUCE[UPGRADE_TANK_NAME]=1
INFLATION[UPGRADE_TANK_NAME]=1.1
NUMBER_BOUGHT[UPGRADE_TANK_NAME]=0
NUMBER_QUEUED[UPGRADE_TANK_NAME]=0

UPGRADE_SOLDIER_NAME="BETTER SOLDIER"
UNIT_DESCRIPTIONS[UPGRADE_SOLDIER_NAME]="better soldier"
PRICES[UPGRADE_SOLDIER_NAME]={carb=10,protein=10,fat=10}
HOVER_LAYOUT[UPGRADE_SOLDIER_NAME] = { name=UPGRADE_SOLDIER_NAME, price=PRICES[UPGRADE_SOLDIER_NAME], description=UNIT_DESCRIPTIONS[UPGRADE_SOLDIER_NAME] }
ICONS[UPGRADE_SOLDIER_NAME]="RBCIcon"
TIME_TO_PRODUCE[UPGRADE_SOLDIER_NAME]=1
INFLATION[UPGRADE_SOLDIER_NAME]=1.1
NUMBER_BOUGHT[UPGRADE_SOLDIER_NAME]=0
NUMBER_QUEUED[UPGRADE_SOLDIER_NAME]=0

UPGRADE_HEALTH_NAME="BETTER HEALTH"
UNIT_DESCRIPTIONS[UPGRADE_HEALTH_NAME]="better health"
PRICES[UPGRADE_HEALTH_NAME]={carb=10,protein=10,fat=10}
HOVER_LAYOUT[UPGRADE_HEALTH_NAME] = { name=UPGRADE_HEALTH_NAME, price=PRICES[UPGRADE_HEALTH_NAME], description=UNIT_DESCRIPTIONS[UPGRADE_HEALTH_NAME] }
ICONS[UPGRADE_HEALTH_NAME]="healthUpgradeIcon1"
TIME_TO_PRODUCE[UPGRADE_HEALTH_NAME]=1
INFLATION[UPGRADE_HEALTH_NAME]=1.1
NUMBER_BOUGHT[UPGRADE_HEALTH_NAME]=0
NUMBER_QUEUED[UPGRADE_HEALTH_NAME]=0



function upgradePurchase(name)
	
	print(name,NUMBER_BOUGHT[name],PRICES[name],INFLATION[name])
	
	
	NUMBER_BOUGHT[name]=NUMBER_BOUGHT[name]+1
	NUMBER_QUEUED[name]=NUMBER_QUEUED[name]-1

	
end






