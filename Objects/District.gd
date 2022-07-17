extends Node2D

var color = Color(1, 1, 1, .5)
var highlight = load("res://Objects/Highlight.tscn")
var circle = load("res://Misc/Tracker.tscn")

var district_node = load("res://Objects/District.tscn")

var tracker = null
export var show_traversal = false
var starting_vertex
var max_size = 0
var min_size = 0
var house_count = 0

var visited = []
var button
onready var settings = get_tree().get_current_scene().settings
onready var tiles_left_label = get_tree().get_current_scene().get_node("UI/Debug/HBox/TilesLeftLabel")
onready var error_label = get_tree().get_current_scene().get_node("UI/Debug/ErrorLabel")


const flood_fill = preload("res://Algorithms/flood.gd")

var squares = []
var district_sizes = []
var squares_in_region = []
var regions = []
var size_count = 1
var is_selected = true

func _ready():
	if not ["Flood", "Error"].has(name):
		button = get_tree().get_current_scene().get_node("UI/DistrictButtons/" + name)

func _process(_delta):
	if is_selected:
		#print(str(max_size)+" - "+str(house_count))
		tiles_left_label.set_text("Tiles Left: "+str(max_size-house_count)+"    ")
		if button:
			button.text = str(max_size-house_count)

func set_starting_vertex(vertex):
	starting_vertex = vertex

func free_flood():
	var scene = get_tree().get_current_scene()
	var flood = scene.get_node("Flood")
	var matrix = scene.matrix.vertices
	var childs = scene.get_children()
	for s in flood.squares:
		matrix[s].erase("district")
	flood.queue_free()
	
func highlight(grid_point, exclude=null, force=false):
	var scene = get_tree().get_current_scene()
	var house_id = str(grid_point)
	var matrix = scene.matrix.vertices
	if name == "Flood":
		if len(squares_in_region) == 0:
			squares_in_region.append(house_id)
		if not matrix[house_id].has("district") and house_id != exclude:
			if len(squares) > 0:
				var neighboring_squares = get_neighbors(matrix[house_id])

				if len(neighboring_squares) == 0:
					district_sizes.append(size_count)
					size_count = 1
					regions.append(squares_in_region)
					squares_in_region = []
					squares_in_region.append(house_id)
				else:
					size_count += 1
					squares_in_region.append(house_id)
					
				
			var cell = (grid_point-starting_vertex)
			var tm = get_node("TileMap")
			tm.set_cell(cell.x-1, cell.y-1, 0, false, false, false) #, Vector2(1,1))
			tm.update_bitmask_area(Vector2(cell.x-1, cell.y-1))
			matrix[house_id]["visited_empty"] = true
			matrix[house_id]["district"] = "Flood"
			squares.append(house_id)
			var neighbors = get_neighbors(matrix[house_id], squares, 2)
			for neighbor in neighbors:
				get_tree().get_current_scene().draw_district_flood(matrix[neighbor]["coords"], exclude)
		return
		
	if max_size > house_count or force==true:
		if matrix.has(house_id):
			if not matrix[house_id].has("district"):
				if settings["contiguous"] and force != true:
					if house_count != 0:
						var neighbors = get_neighbors(matrix[house_id])
						if len(neighbors) == 0:
							return

					var neighbors = get_neighbors(matrix[house_id], squares, 2)
					var found_neighbors = false
					for neighbor in neighbors:
						found_neighbors = true
						scene.draw_district_flood(matrix[neighbor]["coords"], house_id)
					if found_neighbors:
						scene.get_node("Flood").district_sizes.append(scene.get_node("Flood").size_count)
						scene.get_node("Flood").regions.append(scene.get_node("Flood").squares_in_region)
						var ds = scene.get_node("Flood").district_sizes
						var regions = scene.get_node("Flood").regions
#						for r in regions:
#							print(len(r))
#						print(ds)
#						print(regions)
						free_flood()
					
						var houses_left = max_size-house_count
						var regions_to_fill = []
						for r in regions:
							if len(r) < min_size:
								houses_left -= len(r)
								if max_size-house_count > len(r) and houses_left > 0:
									regions_to_fill.append(r)
									
								else:
									regions_to_fill = []
									error_flash(matrix, scene, r)
									error_label.set_text("NO BLOCK REGION")
									return
							
						for r in regions_to_fill:		
							for house in r:
								highlight(matrix[house]["coords"], null, true)
						
				matrix[house_id]["district"] = self.name
				var cell = (grid_point-starting_vertex)
				var tm = get_node("TileMap")

				
				if matrix[house_id]["type"] == "House":
					house_count += 1
#					if not ["Error", "Flood"].has(name):
#						scene.filled_squares += 1

				tm.set_cell(cell.x-1, cell.y-1, 0, false, false, false) #, Vector2(1,1))
				tm.update_bitmask_area(Vector2(cell.x-1, cell.y-1))
				
				squares.append(house_id)
				
				if house_count == max_size:
					var next = null
					if not ["Flood", "Error"].has(name):
						#check if the button exists
						var button_name = char(ord(name[0]) + 1)
						if scene.district_button_names.has(button_name):
							next = scene.get_node("UI/DistrictButtons").get_node(button_name)
							if next:
								for d in scene.districts:
									#check if the district alraedy used all its houses
									if d.name == char(ord(name[0]) + 1):
										#if it did use all its houses pick a different district
										if d.house_count == max_size:
											for each in scene.districts:
												if each.house_count < max_size:
													button_name = char(ord(each.name[0]))
													
						else:
							for each in scene.districts:
								if each.house_count < max_size:
									button_name = char(ord(each.name[0]))

						next = scene.get_node("UI/DistrictButtons").get_node(button_name)
						if next:
							next.pressed = true
							next._on_Button_button_up()
					
			else:
				error_label.set_text("ALREADY HOUSE")
		else:
			error_label.set_text("NO HOUSE THERE")
	else:
		error_label.set_text("TOO MANY HOUSE")
	
func error_flash(matrix, scene, region):
	var error_shape = district_node.instance()
	error_shape.starting_vertex = Vector2(-1,-1)
	error_shape.get_node("TileMap").modulate = Color(1, 0, 0, 0.9)
	error_shape.set_name("Error")
	scene.add_child(error_shape)
	error_shape.global_position.x += 3.5
	for r in region:
		error_shape.highlight(matrix[r]["coords"], [], true)
	scene.stop_input()

	yield(get_tree().create_timer(0.15), "timeout")
	error_shape.visible = false
	yield(get_tree().create_timer(0.05), "timeout")
	error_shape.visible = true
	yield(get_tree().create_timer(0.05), "timeout")
	for s in error_shape.squares:
		matrix[s].erase("district")
	error_shape.queue_free()
	scene.start_input()
					
func erase(grid_point):
	var house_id = str(grid_point)
	var scene = get_tree().get_current_scene()
	var matrix = scene.matrix.vertices
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
						error_label.set_text("NO SPLITTING DISTRICT "+str(matrix[house_id]["district"]))
						if matrix[house_id]["district"] != self.name:
							var button_name = matrix[house_id]["district"]
							var next = scene.get_node("UI/DistrictButtons").get_node(button_name)
							if next:
								next.pressed = true
								next._on_Button_button_up()
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

				tm.set_cell(cell.x-1, cell.y-1, -1, false, false, false) #, Vector2(1,1))
				tm.update_bitmask_area(Vector2(cell.x-1, cell.y-1))
				
				squares.erase(house_id)
				house_count-=1
				#scene.filled_squares-=1
				
					
			else:
				error_label.set_text("WRONG DISTRICT")

				if not ["Flood", "Error"].has(name):
					var next = scene.get_node("UI/DistrictButtons").get_node(char(ord(matrix[house_id]["district"][0])))
					if next:
						next.pressed = true
						next._on_Button_button_up()
		else:
			error_label.set_text("NO HOUSE DISTRICT")
	else:
		error_label.set_text("NO HOUSE TO REMOVE")

func is_house(id, has_district=1):
		
	var matrix = get_tree().get_current_scene().matrix.vertices
	
	if show_traversal:
		if not tracker:
			tracker = circle.instance()
			add_child(tracker)
		if matrix.has("id"):
			var coords = matrix[id]["coords"]
			tracker.set_global_position(Vector2(6,6)*coords)
		
	if matrix.has(id):
		if has_district == 2:
			if matrix[id].has("district"):
				return false
			else:
				return true
		if has_district == 1:
			if matrix[id].has("district"):
				if matrix[id]["district"] == self.name:
					return true
			else:
				error_label.set_text("NO NEIGHBORS")
		else:
			return true
	return false

func get_size_from(house, matrix, _exclude=[]):
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
		
func get_any_neighbor(house, exclude=[]):
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

func get_neighbors(house, exclude=[], has_district=1):
	var neighbors = []
	var coords = house["coords"]
	var north = Vector2(coords.x, coords.y-1)
	var id = str(north)
	if is_house(id, has_district) and not exclude.has(id):
		neighbors.append(id)
	var east = Vector2(coords.x+1, coords.y)
	id = str(east)
	if is_house(id, has_district) and not exclude.has(id):
		neighbors.append(id)
	var south = Vector2(coords.x, coords.y+1)
	id = str(south)
	if is_house(id, has_district) and not exclude.has(id):
		neighbors.append(id)
	var west = Vector2(coords.x-1, coords.y)
	id = str(west)
	if is_house(id, has_district) and not exclude.has(id):
		neighbors.append(id)
	if settings["diagonals"]:
		var ne = Vector2(coords.x+1, coords.y-1)
		id = str(ne)
		if is_house(id, has_district) and not exclude.has(id):
			neighbors.append(id)
		var se = Vector2(coords.x+1, coords.y+1)
		id = str(se)
		if is_house(id,has_district) and not exclude.has(id):
			neighbors.append(id)
		var sw = Vector2(coords.x-1, coords.y+1)
		id = str(sw)
		if is_house(id, has_district) and not exclude.has(id):
			neighbors.append(id)
		var nw = Vector2(coords.x-1, coords.y-1)
		id = str(nw)
		if is_house(id, has_district) and not exclude.has(id):
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
