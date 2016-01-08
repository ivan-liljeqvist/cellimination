
LEVEL = 2

BASES_SPAWNED_LEVEL2=0
CURRENT_LEVEL_COMPLETE=false

LIGHTHOUSES={}
GAME_TIME=0


WORKER_RPM = 60

LAST_ACTIONX=0
LAST_ACTIONY=0

SCREEN_HEIGHT=1280
SCREEN_WIDTH=720
HUD_RIGHT_HEIGHT=200
HUD_RIGHT_WIDTH=500

ZOOM_LEVEL=1.4

TILE_SIZE=64
TILE_NOT_REACHABLE_CODE=0

PLAYER_TEAM=1
ENEMY_TEAM=2

PLACING_NEW_BUILDING=false

SPOT_ENEMY_RADIUS=3

CAMERA_DIRECTION_UP=4
CAMERA_DIRECTION_DOWN=3
CAMERA_DIRECTION_LEFT=1
CAMERA_DIRECTION_RIGHT=2

CAMERA_OFFSETX=0
CAMERA_OFFSETY=0

CAMERA_SPEED=10

JUST_CLICKED_MINIMAP=false

GUI_CLICKED=false --when GUI is clicked, we shouldn't deselect any selection

TILEMAP_NODES={}

TILEMAP_WIDTH=0
TILEMAP_HEIGHT=0

TILEMAP_MAXY=0
TILEMAP_MAXX=0
TILEMAP_MINY=0
TILEMAP_MINX=0

TILEMAP_INDEX_LOOKUP={}

tilemapIndex=1

BASE_FOG_RADIUS = 2
JEEP_FOG_RADIUS = 1
WORKER_FOG_RADIUS = 1

tilemapObject={}

MAX_PRODUCTION_QUEUE = 4

TIME_TO_PRODUCE={}


function numberOfPlayerUnits()
  local count = 0
  for unit,isAlive in pairs(MY_UNITS) do if isAlive then count = count + 1 end end
  return count
end

require "modules.pathfinder"

function getScreenWidth()
	return tonumber(sys.get_config("display.width"))
end

function getScreenHeight()
	return tonumber(sys.get_config("display.height"))
end

local alreadyPopulatedNodeArray=false

--populates the TILEMAP_NODES array with tiles in the tilemap
function populateNodeArray()


	if alreadyPopulatedNodeArray == false then
			alreadyPopulatedNodeArray = true 
			
			local minX, minY, w, h = tilemapObject.get_bounds("world#tilemap")
			local maxX=minX+w-1
			local maxY=minY+h-1
			
			TILEMAP_WIDTH=w
			TILEMAP_HEIGHT=h
			TILEMAP_MAXY=maxY
			TILEMAP_MAXX=maxX
			TILEMAP_MINY=minY
			TILEMAP_MINX=minX
			
			--go through each row
			for xCounter=minX, maxX, 1 do
			
				TILEMAP_INDEX_LOOKUP[xCounter]={}
				
				--go through each column
				for yCounter=minY, maxY, 1 do
				
					--insert a node for each tile
					local newNode={}
					
					newNode.x=xCounter
					newNode.y=yCounter
					newNode.type=tilemapObject.get_tile("world#tilemap", "reachable", xCounter, yCounter)
					newNode.blockedType=tilemapObject.get_tile("world#tilemap", "blocked", xCounter, yCounter)
					newNode.occupied=false
					newNode.occupiedBy=nil
					newNode.blocked=false
					newNode.tilemapIndex=tilemapIndex
					
					
					TILEMAP_INDEX_LOOKUP[xCounter][yCounter]=tilemapIndex
					
					table.insert(TILEMAP_NODES,newNode)
					
					tilemapIndex=tilemapIndex+1
					
					
				end
			end
			
	end
end

--valid function used by the A* algorithm
validator = function ( node, neighbor ) 
	
		
	local isBesides = (math.abs(node.x-neighbor.x)==1 and math.abs(node.y-neighbor.y)==1) or 
					  (math.abs(node.x-neighbor.x)==0 and math.abs(node.y-neighbor.y)==1) or 
					  (math.abs(node.x-neighbor.x)==1 and math.abs(node.y-neighbor.y)==0)
					  

	
	if 	isBesides and neighbor.type~=TILE_NOT_REACHABLE_CODE and neighbor.blocked~=true then 
		return true
	end
	
	--if we've come here - the tile is not reachable

	
	return false
end


getStartAndFinish = function(startTileX,startTileY,finishTileX,finishTileY)
	
	local start={}
	local finish={}
	
	local found=0; --should be 2 when we beak the loop, then we've found start and finish
	
	for _,value in pairs(TILEMAP_NODES) do --actualcode
    	
    	if value.type==0 then
    		print("unreachable tile: "..value.x.." "..value.y)
    	end
    	
		if value.x==startTileX and startTileY==value.y then
			start=value
			found=found+1
		elseif value.x==finishTileX and finishTileY==value.y then
			finish=value
			found=found+1
		end
		
		if found==2 then
			print(startTileX,startTileY,finishTileX,finishTileY)
			return start,finish
		end
	end
	
	print("didn't find start and finish in the tile array")
	print(startTileX,startTileY,finishTileX,finishTileY)
	return nil,nil
	
end


function concatTables(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end


function copyTable(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[copyTable(orig_key)] = copyTable(orig_value)
        end
        setmetatable(copy, copyTable(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end


