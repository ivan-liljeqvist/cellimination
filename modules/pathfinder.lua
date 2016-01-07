
module ( "pathfinder", package.seeall )

 

CLOSED_SET_LOOKUP={}

OPEN_SET_LOOKUP={}
OPEN_SET_SIZE=1

CLOSED_SET_LOOKUP={}
CLOSED_SET_SIZE=0


----------------------------------------------------------------
-- local variables
----------------------------------------------------------------

local INF = 1/0

local cachedPaths=nil
----------------------------------------------------------------
-- local functions
----------------------------------------------------------------

function dist ( x1, y1, x2, y2 )
	
	return math.sqrt ( math.pow ( x2 - x1, 2 ) + math.pow ( y2 - y1, 2 ) )
end

function dist_between ( nodeA, nodeB )

	return dist ( nodeA.x, nodeA.y, nodeB.x, nodeB.y )
end

function heuristic_cost_estimate ( nodeA, nodeB )

	return dist ( nodeA.x, nodeA.y, nodeB.x, nodeB.y )
end

function is_valid_node ( node, neighbor )

	return true
end




function neighbor_nodes(node,ignore)
	
	local radius = 1

	local minY = node.y-radius
	local maxY = node.y+radius
	local minX = node.x-radius
	local maxX = node.x+radius
	
	local toReturn={}
	
	for x = minX, maxX, 1 do
		
		for y = minY, maxY, 1 do 
		
			if isTileLegit(x,y) and 
			   TILEMAP_NODES[TILEMAP_INDEX_LOOKUP[x][y]].type~=TILE_NOT_REACHABLE_CODE and
			   TILEMAP_NODES[TILEMAP_INDEX_LOOKUP[x][y]].blocked~=true then
				
				local neighborIndex = TILEMAP_INDEX_LOOKUP[x][y]
				local neighborNode = TILEMAP_NODES[neighborIndex]
				
				
				if neighborNode ~= node then
					table.insert(toReturn,neighborNode)
				end
			end
		end
		
	end
	
	return toReturn
end


function unwind_path ( flat_path, map, current_node )

	if map [ current_node ] then
		table.insert ( flat_path, 1, map [ current_node ] ) 
		return unwind_path ( flat_path, map, map [ current_node ] )
	else
		return flat_path
	end
end


function lowest_f_score ( set, f_score )

	local lowest, bestNode = INF, nil
	for node, _ in pairs ( set ) do
		local score = f_score [ node ]
		if score < lowest then
			lowest, bestNode = score, node
		end
	end
	
	return bestNode
end

----------------------------------------------------------------
-- pathfinding functions
----------------------------------------------------------------

function a_star ( start, goal, nodes, valid_node_func )

	
	OPEN_SET_LOOKUP[start]=true
	
	local came_from = {}
	
	

	if valid_node_func then 
		is_valid_node = valid_node_func 
	end

	local g_score, f_score = {}, {}
	g_score [ start ] = 0
	f_score [ start ] = g_score [ start ] + heuristic_cost_estimate ( start, goal )


	while OPEN_SET_SIZE > 0 do
	
		
		
	
		local current = lowest_f_score ( OPEN_SET_LOOKUP, f_score )
		
		if current == goal then
			local path = unwind_path ( {}, came_from, goal )
			table.insert ( path, goal )
			return path
		end

	
		OPEN_SET_LOOKUP[current]=nil
		OPEN_SET_SIZE=OPEN_SET_SIZE-1
			
		CLOSED_SET_LOOKUP[current]=true

		
		local neighbors = neighbor_nodes ( current, nodes )
		local counter=0
		for _, neighbor in ipairs ( neighbors ) do 
			if not CLOSED_SET_LOOKUP[neighbor] then
			
				local tentative_g_score = g_score [ current ] + dist_between ( current, neighbor )
				 
				if not OPEN_SET_LOOKUP[neighbor] or tentative_g_score < g_score [ neighbor ] then 
					came_from 	[ neighbor ] = current
					g_score 	[ neighbor ] = tentative_g_score
					f_score 	[ neighbor ] = g_score [ neighbor ] + heuristic_cost_estimate ( neighbor, goal )
					if not OPEN_SET_LOOKUP[neighbor] then
						
							
							OPEN_SET_LOOKUP[neighbor]=true
							OPEN_SET_SIZE=OPEN_SET_SIZE+1
							
					
					end
				end
			end
			
			counter=counter+1
		end
	end
	return nil -- no valid path
end

----------------------------------------------------------------
-- exposed functions
----------------------------------------------------------------

function clear_cached_paths ()

	cachedPaths = nil
end

function distance ( x1, y1, x2, y2 )
	
	return dist ( x1, y1, x2, y2 )
end

function path ( start, goal, nodes, ignore_cache, valid_node_func )

	CLOSED_SET_LOOKUP={}
	OPEN_SET_LOOKUP={}
	OPEN_SET_SIZE=1
	
	CLOSED_SET_LOOKUP={}
	CLOSED_SET_SIZE=0
	
	if not cachedPaths then cachedPaths = {} end
	if not cachedPaths [ start ] then
		cachedPaths [ start ] = {}
	elseif cachedPaths [ start ] [ goal ] then
		return cachedPaths [ start ] [ goal ]
	end
	
	cachedPaths [ start ] [ goal ] = a_star ( start, goal, nodes, valid_node_func )

	
	return cachedPaths [ start ] [ goal ]
end

