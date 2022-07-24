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
const Queue = preload("res://DataStructures/queue.gd")

var squares = []
var district_sizes = []
var squares_in_region = []
var regions = []
var houses_in_region = [] #of squares in region, which ones are houses?
var house_collections = [] #collection of houses_in_region

var size_count = 1
var is_selected = true
var overflowed = false

var party_tallies = {}
var party_tally #the graphic that shows the tally

var district_buttons


func _ready():

	var scene = get_tree().get_current_scene()
	district_buttons = scene.get_node("UI/Scroll/DistrictButtons")
	for party in scene.parties:
		party_tallies[party] = 0

	if "Flood" in name or "Error" in name:
		pass
	else:
		button = district_buttons.get_node(name)
		party_tally = button.get_node("PartyTally")

func _process(_delta):
	if is_selected:
		#print(str(max_size)+" - "+str(house_count))
		tiles_left_label.set_text("Tiles Left: "+str(max_size-house_count)+"    ")
		if button:
			if typeof(house_count) == TYPE_INT:
				button.text = str(max_size-house_count)
			else:
				button.text = str(max_size)
	for p in party_tallies:	
		if party_tally:
			party_tally.set_votes(p, party_tallies[p])

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

	if len(squares) > 650: #prevent stack overflow
		overflowed = true
		if "Flood" in name or "Error" in name:
			return
	else:
		overflowed = false
	var scene = get_tree().get_current_scene()
	var house_id = str(grid_point)
	var matrix = scene.matrix
	var m_vert_house_id
	if matrix.vertices.has(house_id):
		m_vert_house_id = matrix.vertices[house_id]
	else:
		error_label.set_text("NO CAN CLICK SQUARE")
	if name == "Flood": #TODO: make Flood a class that extends District, so programemrs don't make fun of you
		if len(squares_in_region) == 0:
			squares_in_region.append(house_id)
		
		if not m_vert_house_id.has("district") and house_id != exclude:
			if len(squares) > 0:
				var neighboring_squares = get_neighbors(m_vert_house_id)

				if len(neighboring_squares) == 0:
					#if m_vert_house_id["type"] == "House":
					district_sizes.append(size_count)
					size_count = 1
					regions.append(squares_in_region)
					house_collections.append(houses_in_region)
					squares_in_region = []
					squares_in_region.append(house_id)
					houses_in_region = []
					if m_vert_house_id["type"] == "House":
						houses_in_region.append(house_id)

				else:
					#if m_vert_house_id["type"] == "House":
					size_count += 1
					squares_in_region.append(house_id)
					if m_vert_house_id["type"] == "House":
						houses_in_region.append(house_id)
				
			#var cell = (grid_point-starting_vertex)
			#var tm = get_node("TileMap")
			#tm.set_cell(cell.x-1, cell.y-1, 0, false, false, false) #, Vector2(1,1))
			#tm.update_bitmask_area(Vector2(cell.x-1, cell.y-1))
			m_vert_house_id["visited_empty"] = true
			m_vert_house_id["district"] = "Flood"
			squares.append(house_id)
			var neighbors = get_neighbors(m_vert_house_id, squares, 2)
			for neighbor in neighbors:
				get_tree().get_current_scene().draw_district_flood(matrix.vertices[neighbor]["coords"], exclude)
		return
		
	if max_size > house_count or force==true:
		if not matrix.vertices.has(house_id):
			error_label.set_text("NO HOUSE THERE")
			var id_vect = str2var("Vector2"+house_id)
			var intersection = get_world_2d().direct_space_state.intersect_point (id_vect*matrix.GRID_SIZE, 32, [ ], 2147483647, true, true )
			if not intersection:
				error_label.set_text("OUT OF STATE BORDER")
				return
			#elif id_vect.x >= matrix.top_left_corner.x and id_vect.x <= matrix.bottom_right_corner.x and id_vect.y >= matrix.top_left_corner.y and id_vect.y <= matrix.bottom_right_corner.y:
				#m_vert_house_id = {"type" : "Gap", "visited":false, "coords": str2var("Vector2"+house_id)}
				#pass
			else:
				error_label.set_text("OUT OF BOUNDS")
				return
		if not m_vert_house_id.has("district"):
			if settings["advanced"]["contiguous"] and force != true:
				if house_count != 0:
					var neighbors = get_neighbors(m_vert_house_id)
					if len(neighbors) == 0:
						return

				var neighbors = get_neighbors(m_vert_house_id, squares, 2)
				var found_neighbors = false
				for neighbor in neighbors:
					found_neighbors = true
					scene.draw_district_flood(matrix.vertices[neighbor]["coords"], house_id)
				if found_neighbors:
					var flood = scene.get_node("Flood")
					flood.district_sizes.append(flood.size_count)
					flood.regions.append(flood.squares_in_region)
					flood.house_collections.append(flood.houses_in_region)
					var ds = flood.district_sizes

					var f_regions = flood.regions
					var f_house_collections = flood.house_collections
#						for r in regions:
#							print(len(r))
#						print(ds)
#						print(regions)
					free_flood()
				
					var houses_left = max_size-house_count
					var regions_to_fill = []
					if len(f_regions) != len(f_house_collections):
						error_label.set_text("SOMETHING WENT HORRIBLY WRONG")
						get_tree().paused = true
					else:
						
						var fill_regions = []
						
						for i in range(len(f_regions)):
							var f_houses_in_region = []
							var can_fill = false
							if len(f_regions[i]) > 64:
								if houses_left > 64:
									can_fill = true
							else:
								print("if "+str(len(f_house_collections[i])) + " < " + str(min_size-1) + ": ")
								if len(f_house_collections[i]) < min_size-1:
									houses_left -= len(f_house_collections[i])
									f_houses_in_region += f_house_collections[i]
									fill_regions += f_regions[i]
									can_fill = true

							print("if "+str(max_size - house_count) +  ">=" + str(len(f_houses_in_region)) + " and " + str(houses_left) + " > " + str(0) + " or " + str(len(f_houses_in_region)) + " == 0:")
							if can_fill and max_size - house_count >= len(f_houses_in_region) and houses_left > 0 or len(f_houses_in_region) == 0:
								regions_to_fill.append(fill_regions)
								
							else:
								regions_to_fill = []
								error_flash(matrix.vertices, scene, fill_regions)
								error_label.set_text("NO BLOCK REGION")
								return
								
							for r in regions_to_fill:		
								for house in r:
									highlight(matrix.vertices[house]["coords"], null, true)
					
			m_vert_house_id["district"] = self.name
			var cell = (grid_point-starting_vertex)
			var tm = get_node("TileMap")

			
			if m_vert_house_id["type"] == "House":
				house_count += 1
				party_tallies[m_vert_house_id["allegiance"]] += 1
				
#					if not ["Error", "Flood"].has(name):
#						scene.filled_squares += 1

			tm.set_cell(cell.x-1, cell.y-1, 0, false, false, false) #, Vector2(1,1))
			tm.update_bitmask_area(Vector2(cell.x-1, cell.y-1))
			
			squares.append(house_id)
			
			if house_count == max_size:
				
				if not ["Flood", "Error"].has(name):
					get_next_district()
				
		else:
			error_label.set_text("ALREADY HOUSE")
			
	else:
		error_label.set_text("TOO MANY HOUSE")
		get_next_district()
		
func get_next_district():
	var next = null
	#check if the button exists
	var scene = get_tree().get_current_scene()
	scene.stop_input()
	
	var button_name
	if scene.district_button_names.find(name) + 1 >= len(scene.district_button_names):
		button_name = scene.district_button_names[0]
	else:
		button_name = scene.district_button_names[scene.district_button_names.find(name) + 1]
	#var button_name = char(ord(name[0]) + 1)
	if scene.district_button_names.has(button_name):
		next = district_buttons.get_node(button_name)
		if next:
			for d in scene.districts:
				#check if the district alraedy used all its houses
				if d.name == button_name:
					#if it did use all its houses pick a different district
					if d.house_count == max_size:
						for each in scene.districts:
							if each.house_count < max_size:
								button_name = each.name
								
	else:
		for each in scene.districts:
			if each.house_count < max_size:
				button_name = each.name

	next = district_buttons.get_node(button_name)
	if next:
		next.pressed = true
		next._on_Button_button_up()
		
	scene.start_input()
	
func error_flash(matrix, scene, region):
	scene.stop_input()
	
	var error_shape = district_node.instance()
	error_shape.starting_vertex = Vector2(-1,-1)
	error_shape.get_node("TileMap").modulate = Color(1, 0, 0, 0.9)
	error_shape.set_name("Error")
	scene.add_child(error_shape)
	error_shape.global_position.x += 3.5
	for r in region:
		error_shape.highlight(matrix[r]["coords"], [], true)
	
	yield(get_tree().create_timer(0.15), "timeout")
	error_shape.visible = false
	yield(get_tree().create_timer(0.05), "timeout")
	error_shape.visible = true
	yield(get_tree().create_timer(0.05), "timeout")
	for s in error_shape.squares:
		matrix[s].erase("district")
	error_shape.queue_free()
	scene.start_input()
					
func erase(grid_point, force=false):
	var house_id = str(grid_point)
	var scene = get_tree().get_current_scene()
	var matrix = scene.matrix.vertices
	if matrix.has(house_id):
		var m_vert_house_id = matrix[house_id]
		if m_vert_house_id.has("district"):
			#check if there are 3 or more neighbors. if so, just erase the thing
			if check_all_spaces_around(m_vert_house_id) == true: #check for 5 or more consecutive neighbors
				pass
			elif settings["advanced"]["contiguous"] and (house_count > 2 or settings["advanced"]["gaps"]) and not overflowed:
				var neighbor = get_any_neighbor(m_vert_house_id)
				if neighbor:
					scene.recieve_input = false
					var ff = flood_fill.new()
					var size = get_viewport().size
					var true_or_false = !matrix[neighbor]["visited"]
					m_vert_house_id["visited"] = !m_vert_house_id["visited"]
					var x = ff.flood_fill(matrix, size, matrix[neighbor]["coords"], true_or_false, "district", m_vert_house_id["district"], house_id)
					ff.queue_free()
					scene.recieve_input = true
					if len(x) < len(squares) - 1 and not force:
						error_label.set_text("NO SPLITTING DISTRICT "+str(m_vert_house_id["district"]))
						if m_vert_house_id["district"] != self.name:
							var button_name = m_vert_house_id["district"]
							var next = district_buttons.get_node(button_name)
							if next:
								next.pressed = true
								next._on_Button_button_up()
						return

			if m_vert_house_id["district"] == self.name:
				m_vert_house_id.erase("district")
				#TODO: unhighlight grid
				var cell = (grid_point-starting_vertex)
				var tm = get_node("TileMap")

				tm.set_cell(cell.x-1, cell.y-1, -1, false, false, false) #, Vector2(1,1))
				tm.update_bitmask_area(Vector2(cell.x-1, cell.y-1))
				
				squares.erase(house_id)
				if m_vert_house_id["type"] == "House":
					house_count-=1
					party_tallies[m_vert_house_id["allegiance"]] -= 1

			else:
				error_label.set_text("WRONG DISTRICT")
				if not ["Flood", "Error"].has(name):
					var next = district_buttons.get_node(m_vert_house_id["district"])
					if next:
						next.pressed = true
						next._on_Button_button_up()
		else:
			error_label.set_text("NO HOUSE DISTRICT")
	else:
		error_label.set_text("NO HOUSE TO REMOVE")

func is_house(id, has_district=1): #TODO: make this an enum before showin ppl your code
		
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
		
func check_all_spaces_around(house, exclude = []): #TODO: streamline these functions somehow
	var spaces_around = [0, 0, 0, 0, 0, 0, 0, 0] #matching district as per is_house() default
	var coords = house["coords"]
	var north = Vector2(coords.x, coords.y-1)
	var id = str(north)
	if is_house(id) and not exclude.has(id):
		spaces_around[0] = 1
	var ne = Vector2(coords.x+1, coords.y-1)
	id = str(ne)
	if is_house(id) and not exclude.has(id):
		spaces_around[1] = 1
	var east = Vector2(coords.x+1, coords.y)
	id = str(east)
	if is_house(id) and not exclude.has(id):
		spaces_around[2] = 1
	var se = Vector2(coords.x+1, coords.y+1)
	id = str(se)
	if is_house(id) and not exclude.has(id):
		spaces_around[3] = 1
	var south = Vector2(coords.x, coords.y+1)
	id = str(south)
	if is_house(id) and not exclude.has(id):
		spaces_around[4] = 1
	var sw = Vector2(coords.x-1, coords.y+1)
	id = str(sw)
	if is_house(id) and not exclude.has(id):
		spaces_around[5] = 1
	var west = Vector2(coords.x-1, coords.y)
	id = str(west)
	if is_house(id) and not exclude.has(id):
		spaces_around[6] = 1
	var nw = Vector2(coords.x-1, coords.y-1)
	id = str(nw)
	if is_house(id) and not exclude.has(id):
		spaces_around[7] = 1
	
	var a = spaces_around
	
	var counter = 0
	for i in range(0, len(a)*2 - 1):
		if a[i % len(a)] == 1:
			if counter+1 >= 5:
				return true
			else:
				counter+=1
		elif i >= len(a):
			return false
		else:
			counter = 0
	
	return false
		
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
	if settings["advanced"]["diagonals"]:
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
	if settings["advanced"]["diagonals"]:
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
