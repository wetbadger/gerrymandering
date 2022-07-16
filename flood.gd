extends Node2D


#
#
#	Flood Fill Algorithm
#
#
	
const queue = preload("res://queue.gd")
var _district = load("Objects/District.tscn") #red error shape :)
	
var visited = []

func dfs(grid, size, coords, old_color, new_color, condition, value, type, node, exclude=[], visited_type="visited"):

	var n = size.y
	var m = size.x
	
	if condition == null:
		if str(coords) == node or not grid.has(str(coords)) or coords.x < 0 or coords.x >= n or coords.y < 0 or coords.y >=m or grid[str(coords)][visited_type] != old_color:
			return visited
	elif str(coords) == node or not grid.has(str(coords)) or not grid[str(coords)]["type"] == type or not grid[str(coords)].has(condition) or not grid[str(coords)][condition] == value or coords.x < 0 or coords.x >= n or coords.y < 0 or coords.y >=m or grid[str(coords)][visited_type] != old_color:
		return visited

	grid[str(coords)][visited_type] = new_color
	if not exclude.has(str(coords)):
		if (grid[str(coords)].has(condition) or condition == null) and grid[str(coords)][visited_type] == new_color:
			visited.append(grid[str(coords)])

	dfs(grid, size, Vector2(grid[str(coords)]["coords"].x+1, grid[str(coords)]["coords"].y), old_color, new_color, condition, value, type, node, exclude, visited_type)
	dfs(grid, size, Vector2(grid[str(coords)]["coords"].x-1, grid[str(coords)]["coords"].y), old_color, new_color, condition, value, type, node, exclude, visited_type)
	dfs(grid, size, Vector2(grid[str(coords)]["coords"].x, grid[str(coords)]["coords"].y+1), old_color, new_color, condition, value, type, node, exclude, visited_type)
	dfs(grid, size, Vector2(grid[str(coords)]["coords"].x, grid[str(coords)]["coords"].y-1), old_color, new_color, condition, value, type, node, exclude, visited_type)
		
func flood_fill(grid, size, coords, new_color, condition, value, type, node, exclude=[], visited_type="visited"):
	var old_color = grid[str(coords)][visited_type]
	if old_color == new_color:
		return visited

	dfs(grid, size, coords, old_color, new_color, condition, value, type, node, exclude, visited_type)
	return visited
	
func bfs(grid, size, coords, new_color, node, starting_vertex, current_scene, exclude=[]):
	var n = size.y
	var m = size.x
	var old_color = grid[str(coords)]["visited_empty"]
	if old_color == new_color:
		return visited
		
	var q = queue.new()
	q.enqueue(coords)
	while not q.empty():
		var new_coords = q.dequeue()
		if str(new_coords) == node:
			continue
		for e in exclude:
			if e.has(str(coords)):
				continue
		var i = new_coords.x
		var j = new_coords.y
		if i < 0 or i > n or j < 0 or j > m or not grid.has(str(new_coords)) or grid[str(new_coords)]["visited_empty"] != old_color:
			continue
		else:
			grid[str(new_coords)]["visited_empty"] = new_color
			visited.append(grid[str(new_coords)])
			
			q.enqueue(Vector2(i+1, j))
			q.enqueue(Vector2(i-1, j))
			q.enqueue(Vector2(i, j+1))
			q.enqueue(Vector2(i, j-1))
	
		
func flood_fill_empty(grid, size, coords, new_color, node, starting_vertex, current_scene, exclude=[]): #fills an empty area
	var old_color = grid[str(coords)]["visited_empty"]
	if old_color == new_color or grid[str(coords)].has("district"):
		return visited
		
	bfs(grid, size, coords, new_color, node, starting_vertex, current_scene, exclude)
	return visited

func clear():
	visited = []
