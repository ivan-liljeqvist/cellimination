
--Red blood cell
TANK1_NAME="TANK CELL"
UNIT_DESCRIPTIONS[TANK1_NAME]="Tank Cell has a lot of health, but deals little damage"
PRICES[TANK1_NAME]={carb=10,protein=10,fat=10}
HOVER_LAYOUT[TANK1_NAME] = { price=PRICES[TANK1_NAME], description=UNIT_DESCRIPTIONS[TANK1_NAME] }
ICONS[TANK1_NAME]="tank1Icon"
MAX_HEALTH[TANK1_NAME]=100
FIRE_RATE[TANK1_NAME]=0.1 --seconds before we fire again
MOVE_SPEED[TANK1_NAME]=2
TIME_TO_PRODUCE[TANK1_NAME]=3.5
--if fightUnit
FIRING_RANGE[TANK1_NAME]=2
VISION_RANGE[TANK1_NAME]=4
FOG_RADIUS[TANK1_NAME]=1