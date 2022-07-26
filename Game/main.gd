extends Node2D


var settings

var points: Array = []
var last_point
var grid_point
var selected_district
var _district = load("Objects/District.tscn")
var districts = []
var district_button_names
var draw_size = 33

export var show_last_point = false
var texture_missing = load("res://pics/target.png")

onready var matrix = get_node("State").get_node("Matrix")
onready var mode_label = get_node("UI/Debug/HBox/ModeLabel")
onready var squares_filled_label = get_node("UI/Debug/HBox/SquaresFilledLabel")
onready var debug_party_tally = get_node("UI/Debug/HBox/PartyTally")
onready var popular_vote = get_node("UI/Victory/HBoxContainer/Totals")
onready var district_tally = get_node("UI/Victory/HBoxContainer/Districts")
onready var winner_label = get_node("UI/Victory/Winner")
onready var progress_label = get_node("UI/Progress")
onready var victory_node = get_node("UI/Victory")
onready var error_screen = get_node("UI/ErrorScreen")
onready var camera = get_node("State/Camera2D")
onready var district_buttons = get_node("UI/Scroll/DistrictButtons")
var population
var width
var n_districts
var max_size
var min_size

var can_recheck = true #can determine drawmode
enum DRAW_MODES {ADD, ERASE}
var draw_mode = DRAW_MODES.ADD

var just_pressed = false
var recieve_input = true

var district_colors = []

var parties
var filled_squares = 0

var submit_button

var map_name
var shape

func _ready():
	settings = load_settings()

	var state_shape = settings["shape"]
	shape = load("res://Objects/States/"+state_shape+".tscn").instance()
	get_node("State").add_child(shape)
	shape.set_name("Shape")
	var _size = get_viewport_rect().size
	var _center = Vector2(floor(_size.x/2), floor(_size.y/2))
	shape.set_position(_center)
	shape.z_index = -999
	
	yield(get_tree(), "idle_frame")
	
	#width = settings["width"]
	parties = settings["parties"]
	
	#override width
	population = 0
	for p in parties:
		population += parties[p]["voters"]

	width = int(sqrt(population))
	
	var expected_population = population

	population = matrix.generate_houses(population, parties, settings["advanced"]["gaps"], settings["advanced"]["algorithm"])
	
	if population != expected_population:
		error_screen.set_error_name("Population Error")
		error_screen.set_error_message(state_shape + " can fit "+str(population)+" at most. For some reason, the game is trying to add "+str(expected_population)+". "+"Please try again.")
		error_screen.visible = true
		recieve_input = false
		
	match settings["advanced"]["algorithm"]: 
		"spiral":
			if population < 50:
				camera.set_zoom(Vector2(0.05,0.05))
			elif population > 5000:
				camera.set_zoom(Vector2(1,1))
			else:
				var z = (0.95/4950) * population + (0.05 - (0.95/4950) * 50)
				camera.set_zoom(Vector2(z, z))
		"fill":
			camera.set_zoom(Vector2(0.5,0.5))
	
	for p in parties:
		popular_vote.add_party(p, parties[p]["voters"], stepify(parties[p]["voters"]/population, 0.001)*100)

	#max_size = settings["max_size"]
	#min_size = settings["min_size"]
	#n_districts = settings["n_districts"]
	
	n_districts = settings["districts"].size()
	#district_colors = generate_colors(n_districts)
	
	district_buttons.load_buttons(settings["districts"])
	district_button_names = get_button_names()
	selected_district = district_button_names[0]
	submit_button = get_node("UI/Submit")
	
	if settings["advanced"]["debug"]:
		get_node("UI/Debug").visible = true
	else:
		get_node("UI/Debug").visible = false
		

func get_button_names():
	var bn = []
	var children = district_buttons.get_children()
	for b in children:
		bn.append(b.name)
	return bn
	
func reset_buttons(names):
	var buttons = district_buttons.get_children()
	for button in buttons:
		if button.name in names:
			button.reset()

func generate_colors(n):
	var colors = []
	var i = 0
	for c in settings["colors"]:
		if i == n:
			break
		colors.append({c: settings["colors"][c]})
		i+=1
	return colors

func load_settings():
	var globals = get_node("/root/Globals")
	map_name = ""
	if globals.map_name:
		map_name = globals.map_name
		
	var file = File.new()
	if not file.file_exists("user://"+map_name+"/settings.json"):
			file.open("user://settings.json", File.READ)
			var data = parse_json(file.get_as_text())
			return data
	file.open("user://"+map_name+"/settings.json", File.READ)
	var data = parse_json(file.get_as_text())
	map_name = data["name"]
	return data

func stop_input():
	recieve_input = false

func start_input():
	recieve_input = true

func _input(event: InputEvent) -> void:
	if recieve_input:
		if Input.is_action_just_released("click"):
			set_draw_mode(DRAW_MODES.ADD)
			
		if Input.is_action_just_pressed("click"):
			just_pressed = true
		else:
			just_pressed = false
			
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			set_mouse_members(event)

			_draw_district()
			
		if Input.is_mouse_button_pressed(BUTTON_RIGHT):
			set_mouse_members(event)
			
			_remove_district()

func _process(_delta):

	var count = 0
	for d in districts:
		count += d.house_count
		if d.name == selected_district:
			debug_party_tally.text = str(d.party_tallies)
		
	filled_squares = count

	if draw_mode == 0:
		mode_label.set_text('Mode: +    ')
	else:
		mode_label.set_text('Mode: -    ')
		
	squares_filled_label.set_text("Squares: "+str(filled_squares)+"    ")
	progress_label.set_text(str(filled_squares)+"/"+str(population))
		
	if not can_recheck:
		can_recheck = true
		
	if is_instance_valid(submit_button):
		if filled_squares >= population: #because sometimes the computer can't count :)
			submit_button.disabled = false
		else:
			submit_button.disabled = true
			
	
	
func set_mouse_members(event):
	if event is InputEventKey:
		return
	#sets the variables realted to the mouse positions from a click
	if not last_point:
		last_point = Node2D.new()
		matrix.add_child(last_point)
		last_point.set_name("LastPoint")
		
		if show_last_point:
			var sprite = Sprite.new()
			last_point.add_child(sprite)
			sprite.texture = texture_missing
			
	points.append(event.global_position)
	last_point.set_global_position(get_global_mouse_position())
	var point = matrix.get_node("LastPoint")
	grid_point = get_grid_position(point.position)
	
func get_grid_position(point):
	var cam = get_node("State").get_node("Camera2D")
	var result = Vector2(round(point.x/matrix.GRID_SIZE), round(point.y/matrix.GRID_SIZE))
	return result

func _draw_district() -> void:
	if just_pressed and can_recheck:
		can_recheck = false
		determine_draw_mode()
	#draw_colored_polygon(points, Color.red)
	#for point in points:
		#draw_circle(point,10, Color.red)
	if not last_point:
		return
	var district = get_district_selected()
	if not district:
		return

	if draw_mode == DRAW_MODES.ERASE:
		district.erase(grid_point)
	else:
		district.highlight(grid_point)
		
	var color = PoolColorArray( [district.color] )

func _draw_district_flood(coords, exclude=null, temp=null) -> void:
	var district = get_district_selected(exclude, temp)
	if not district:
		return
	district.highlight(coords, exclude)

func draw_district_flood(coords, exclude=null):
	
	var temp1 = selected_district
	#var temp2 = grid_point
	selected_district = "Flood"
	grid_point = coords
	_draw_district_flood(coords, exclude, temp1)
	selected_district = temp1
	#grid_point = temp2
	

func determine_draw_mode():
	var house_in_district = house_in_district()
	if house_in_district:
		set_draw_mode(DRAW_MODES.ERASE)
		
#	if settings["advanced"]["none_selected_start_erasing"]:
#		if matrix.vertices.has(str(grid_point)) and not matrix.vertices[str(grid_point)].has("district"):
#			var district = get_node(selected_district)
#			if district and len(district.squares) > 0:
#				set_draw_mode(DRAW_MODES.ERASE)
		
	just_pressed = false
		
func house_in_district():
	var in_district = matrix.vertices.has(str(grid_point)) and matrix.vertices[str(grid_point)]["type"] == "House" and matrix.vertices[str(grid_point)].has("district")
	return in_district

func set_draw_mode(mode):
	draw_mode = mode

func _remove_district() -> void:
	if not last_point:
		return
	var district = get_district_selected()
	if not district:
		return
		
	district.erase(grid_point)

func get_district_selected(exclude=null, temp=null):

	if not has_node(selected_district):
		
		var district = _district.instance()
		district.starting_vertex = grid_point
		
		if selected_district == "Flood":
			district.max_size = settings["districts"][temp]["max_size"]
			district.min_size = settings["districts"][temp]["min_size"]
		else:
			district.max_size = settings["districts"][selected_district]["max_size"]
			district.min_size = settings["districts"][selected_district]["min_size"]
		district.set_global_position(grid_point * matrix.GRID_SIZE)
		district.set_name(selected_district)
		var color
		if selected_district == "Flood":
			color = Color(1, 0, 0)
			#district.squares_in_region.append(exclude)
		else:
			var color_name = settings["districts"][selected_district]["color"] #get_tree().get_current_scene().get_node("UI/DistrictButtons").get_node(selected_district).color_val
			color = get_node("/root/Globals").word2color(color_name)
			district.color = color
			color.a = 0.5

		district.get_node("TileMap").modulate = color
		add_child(district)
		district.highlight(grid_point, exclude)
		if not ["Flood","Error"].has(selected_district):
			districts.append(district)
		return false
	else:
		var district = get_node(selected_district)
		return district
	
func get_width():
	return width
	
func submit():
	print("Submitted")
	get_node("Darkening").darken()
	#print(matrix.vertices)
	var scores = []
	for d in districts:
		var score = {d.name:{}}
		for id in d.squares:
			if matrix.vertices[id].has("allegiance"):
				if score[d.name].has(matrix.vertices[id]["allegiance"]):
					score[d.name][matrix.vertices[id]["allegiance"]] += 1
				else:
					score[d.name][matrix.vertices[id]["allegiance"]] = 1
		scores.append(score)

	var results = []
	victory_node.get_node("HBoxContainer/Districts").reset()
	for district in scores:
		for d in district:
			var most_votes = {null: 0}
			for party in district[d]:
				if district[d][party] > most_votes.values()[0]:
					most_votes = {party: district[d][party]}
				elif district[d][party] == most_votes.values()[0]:
					most_votes = {null: district[d][party]} #tie
			results.append(most_votes)
			district_tally.add_district(most_votes.keys()[0], most_votes[most_votes.keys()[0]])

	var winner = get_winner(results)
	print(winner)
	var color = Color(0,0,0)
	if not winner.keys()[0]:
		winner_label.set_text("TIE!?")
	else:
		winner_label.set_text(winner.keys()[0]+" WIN!")
		var color_name = settings["parties"][winner.keys()[0]]["color"]
		if color_name != "white":
			var col_arr = settings["colors"][color_name]
			color = Color(col_arr[0],col_arr[1],col_arr[2])
	winner_label.set_border_color(color)
	victory_node.visible = true

	recieve_input = false
	submit_button.visible = false
	
func remove_district(district_name):
	recieve_input = false
	#show a spinning hour glass here
	for d in districts:
		if d.name == district_name:
			var houses = d.squares.duplicate()
			for house in houses:
				d.erase(str2var("Vector2" + house), true)
			districts.erase(d)
			d.party_tally.reset()
			d.button.text = str(d.max_size-d.house_count)
			var n = d.max_size
			d.queue_free()
			recieve_input = true
			return n
	recieve_input = true
	
func get_winner(results):
	var arr = []
	for v in results:
		arr.append(v.keys()[0])

	var count = 0
	var winner = null
	for n in arr:
		var score = arr.count(n)
		if score > count and n != null:
			count = score
			winner = n
		elif score == count and n != null and n != winner:
			winner = null

	return {winner: arr.count(winner)}
