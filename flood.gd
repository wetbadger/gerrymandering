extends Node


#
#
#	Flood Fill Algorithm
#
#
	
var visited = []

func dfs(grid, size, coords, old_color, new_color, condition, value, type, node):

	var n = size.y
	var m = size.x
	if str(coords) == node or not grid.has(str(coords)) or not grid[str(coords)]["type"] == type or not grid[str(coords)].has(condition) or not grid[str(coords)][condition] == value or coords.x < 0 or coords.x >= n or coords.y < 0 or coords.y >=m or grid[str(coords)]["visited"] != old_color:
		return visited
	else:
		grid[str(coords)]["visited"] = new_color
		if grid[str(coords)].has(condition)  and grid[str(coords)]["visited"] == new_color:
			visited.append(grid[str(coords)])

		dfs(grid, size, Vector2(grid[str(coords)]["coords"].x+1, grid[str(coords)]["coords"].y), old_color, new_color, condition, value, type, node)
		dfs(grid, size, Vector2(grid[str(coords)]["coords"].x-1, grid[str(coords)]["coords"].y), old_color, new_color, condition, value, type, node)
		dfs(grid, size, Vector2(grid[str(coords)]["coords"].x, grid[str(coords)]["coords"].y+1), old_color, new_color, condition, value, type, node)
		dfs(grid, size, Vector2(grid[str(coords)]["coords"].x, grid[str(coords)]["coords"].y-1), old_color, new_color, condition, value, type, node)
		
func flood_fill(grid, size, coords, new_color, condition, value, type, node):
	var old_color = grid[str(coords)]["visited"]
	if old_color == new_color:
		return visited

	dfs(grid, size, coords, old_color, new_color, condition, value, type, node)
	return visited
