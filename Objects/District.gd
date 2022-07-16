extends Node2D

var color = Color(1, 1, 1, .5)
var highlight = load("res://Objects/Highlight.tscn")
var circle = load("res://Misc/Tracker.tscn")
var tracker = null
export var show_traversal = false
var starting_vertex
var max_size = 0
var house_count = 0

var visited = []
onready var settings = get_tree().get_current_scene().settings
onready var tiles_left_label = get_tree().get_current_scene().get_node("UI/Labels/TilesLeftLabel")
onready var error_label = get_tree().get_current_scene().get_node("UI/Labels/ErrorLabel")

const flood_fill = preload("res://flood.gd")

var squares = []
var is_selected = true

func _ready():
	pass # Replace with function body.

func _process(_delta):
	if is_selected:
		#print(str(max_size)+" - "+str(house_count))
		tiles_left_label.set_text(str(max_size-house_count))

func set_starting_vertex(vertex):
	starting_vertex = vertex

func highlight(grid_point):
	
	var house_id = str(grid_point)
	var matrix = get_tree().get_current_scene().matrix.vertices
	if max_size > house_count:
		if matrix.has(house_id):
			if not matrix[house_id].has("district"):
				if settings["contiguous"]:
					if house_count != 0:
						if not has_neighbors(matrix[house_id]):
							return
				matrix[house_id]["district"] = self.name
				var cell = (grid_point-starting_vertex)
				var tm = get_node("TileMap")
				var id = tm.get_cell(cell.x, cell.y)
				
				if matrix[house_id]["type"] == "House":
					house_count+=1
				
				tm.set_cell(cell.x-1, cell.y-1, 0, false, false, false) #, Vector2(1,1))
				tm.update_bitmask_area(Vector2(cell.x-1, cell.y-1))
				
				squares.append(house_id)
			else:
				error_label.set_text("ALREADY HOUSE")
		else:
			error_label.set_text("NO HOUSE THERE")
	else:
		error_label.set_text("TOO MANY HOUSE")
				
					
func erase(grid_point):
	var house_id = str(grid_point)
	var matrix = get_tree().get_current_scene().matrix.vertices
	if matrix.has(house_id):
		if matrix[house_id].has("district"):
			if settings["contiguous"] and house_count > 2:
				var neighbor = get_any_neighbor(matrix[house_id])
				if neighbor:
					var ff = flood_fill.new()
					var size = get_viewport().size
					var true_or_false = !matrix[neighbor]["visited"]
					matrix[house_id]["visited"] = !matrix[house_id]["visited"]
					var x = ff.flood_fill(matrix, size, matrix[neighbor]["coords"], true_or_false, "district", matrix[house_id]["district"], "House", house_id)
					ff.queue_free()
					if len(x) < house_count - 1:
						error_label.set_text("NO SPLITTING DISTRICTS")
						return
				#print("TODO: need check for splitting of shape")
				#TODO:
#				var neighbor = get_any_neighbor(matrix[house_id])
#				visited = [house_id, neighbor]
#				var size_from_self = get_size_from(matrix[neighbor], matrix, visited)
#				if size_from_self < house_count:
#					visited = []
#					error_label.set_text("NO CAN SPLIT DISTRICT")
#					return
#				visited = []
			if matrix[house_id]["district"] == self.name:
				matrix[house_id].erase("district")
				#TODO: unhighlight grid
				var cell = (grid_point-starting_vertex)
				var tm = get_node("TileMap")
				var id = tm.get_cell(cell.x, cell.y)
				tm.set_cell(cell.x-1, cell.y-1, -1, false, false, false) #, Vector2(1,1))
				tm.update_bitmask_area(Vector2(cell.x-1, cell.y-1))
				house_count-=1
				squares.erase(house_id)
			else:
				error_label.set_text("WRONG DISTRICT")
		else:
			error_label.set_text("NO HOUSE DISTRICT")
	else:
		error_label.set_text("NO HOUSE TO REMOVE")

func is_house(id):
		
	var matrix = get_tree().get_current_scene().matrix.vertices
	
	if show_traversal:
		if not tracker:
			tracker = circle.instance()
			add_child(tracker)
		if matrix.has("id"):
			var coords = matrix[id]["coords"]
			tracker.set_global_position(Vector2(6,6)*coords)
		
	if matrix.has(id):
		if matrix[id].has("district"):
			if matrix[id]["district"] == self.name:
				return true
		else:
			error_label.set_text("NO NEIGHBORS")
	return false

func get_size_from(house, matrix, exclude=[]):
	if show_traversal:
		if not tracker:
			tracker = circle.instance()
			add_child(tracker)
		var coords = house["coords"]
		tracker.set_global_position(Vector2(6,6)*coords)
		
	if not house :
		return len(visited)
	var neighbor = get_any_neighbor(house, visited)
	if not neighbor:
		return len(visited)
	for n in get_neighbors(house, visited):
		visited.append(n)
	return get_size_from(matrix[neighbor], matrix, visited)
		
func get_any_neighbor(house, exclude=[], dir=null):
	#if dir == north:
		#try east
		#try north
		#try west
	var coords = house["coords"]
	var north = Vector2(coords.x, coords.y-1)
	var id = str(north)
	if is_house(id) and not exclude.has(id):
		return id
	var east = Vector2(coords.x+1, coords.y)
	id = str(east)
	if is_house(id) and not exclude.has(id):
		return id
	var south = Vector2(coords.x, coords.y+1)
	id = str(south)
	if is_house(id) and not exclude.has(id):
		return id
	var west = Vector2(coords.x-1, coords.y)
	id = str(west)
	if is_house(id) and not exclude.has(id):
		return id
	if settings["diagonals"]:
		var ne = Vector2(coords.x+1, coords.y-1)
		id = str(ne)
		if is_house(id) and not exclude.has(id):
			return id
		var se = Vector2(coords.x+1, coords.y+1)
		id = str(se)
		if is_house(id) and not exclude.has(id):
			return id
		var sw = Vector2(coords.x-1, coords.y+1)
		id = str(sw)
		if is_house(id) and not exclude.has(id):
			return id
		var nw = Vector2(coords.x-1, coords.y-1)
		id = str(nw)
		if is_house(id) and not exclude.has(id):
			return id
	return

func get_neighbors(house, exclude=[]):
	var neighbors = []
	var coords = house["coords"]
	var north = Vector2(coords.x, coords.y-1)
	var id = str(north)
	if is_house(id) and not exclude.has(id):
		neighbors.append(id)
	var east = Vector2(coords.x+1, coords.y)
	id = str(east)
	if is_house(id) and not exclude.has(id):
		neighbors.append(id)
	var south = Vector2(coords.x, coords.y+1)
	id = str(south)
	if is_house(id) and not exclude.has(id):
		neighbors.append(id)
	var west = Vector2(coords.x-1, coords.y)
	id = str(west)
	if is_house(id) and not exclude.has(id):
		neighbors.append(id)
	if settings["diagonals"]:
		var ne = Vector2(coords.x+1, coords.y-1)
		id = str(ne)
		if is_house(id) and not exclude.has(id):
			neighbors.append(id)
		var se = Vector2(coords.x+1, coords.y+1)
		id = str(se)
		if is_house(id) and not exclude.has(id):
			neighbors.append(id)
		var sw = Vector2(coords.x-1, coords.y+1)
		id = str(sw)
		if is_house(id) and not exclude.has(id):
			neighbors.append(id)
		var nw = Vector2(coords.x-1, coords.y-1)
		id = str(nw)
		if is_house(id) and not exclude.has(id):
			neighbors.append(id)
	return neighbors
		
func has_neighbors(house, exclude=[]):
	var coords = house["coords"]
	var north = Vector2(coords.x, coords.y-1)
	var id = str(north)
	if is_house(id) and not exclude.has(id):
		return true
	var east = Vector2(coords.x+1, coords.y)
	id = str(east)
	if is_house(id) and not exclude.has(id):
		return true
	var south = Vector2(coords.x, coords.y+1)
	id = str(south)
	if is_house(id) and not exclude.has(id):
		return true
	var west = Vector2(coords.x-1, coords.y)
	id = str(west)
	if is_house(id) and not exclude.has(id):
		return true
	if settings["diagonals"]:
		var ne = Vector2(coords.x+1, coords.y-1)
		id = str(ne)
		if is_house(id) and not exclude.has(id):
			return true
		var se = Vector2(coords.x+1, coords.y+1)
		id = str(se)
		if is_house(id) and not exclude.has(id):
			return true
		var sw = Vector2(coords.x-1, coords.y+1)
		id = str(sw)
		if is_house(id) and not exclude.has(id):
			return true
		var nw = Vector2(coords.x-1, coords.y-1)
		id = str(nw)
		if is_house(id) and not exclude.has(id):
			return true
	return false

func to_string():
	print(squares)
	print(len(squares))
