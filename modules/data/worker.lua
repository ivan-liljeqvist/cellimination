
--worker
WORKER_NAME="RED BLOOD CELL (WORKER)"
UNIT_DESCRIPTIONS[WORKER_NAME]="Can build structures. Knows nothing about combat."

PRICES[WORKER_NAME]={carb=10,protein=10,fat=10}
HOVER_LAYOUT[WORKER_NAME] = {name=WORKER_NAME, price=PRICES[WORKER_NAME], description=UNIT_DESCRIPTIONS[WORKER_NAME] }
ICONS[WORKER_NAME]="RBCIcon"

MAX_HEALTH[WORKER_NAME]=100
FOG_RADIUS[WORKER_NAME]=1
MOVE_SPEED[WORKER_NAME]=10

INFLATION[WORKER_NAME]=1.1
NUMBER_BOUGHT[WORKER_NAME]=0
NUMBER_QUEUED[WORKER_NAME]=0