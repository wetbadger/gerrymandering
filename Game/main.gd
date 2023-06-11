extends Node2D

export var show_grid = false

var settings
var usrexp_settings

#var points: Array = []
var last_point
var grid_point
var previous_grid_point

#
# District Draw Mode
#

var selected_district
var district_object
var districts = []
var district_button_names
var draw_size = 33

#
# House Place Mode
#

var selected_house

var deselect_is_on = false
var disable_draw= false
var touches = 0
var houses_unplaced = 0

var placement_mode__grid_indicators = {}

#
# Buttons and things
#

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
onready var scroll = get_node("UI/Scroll")
onready var scroll2 = get_node("UI/Scroll2")
onready var district_buttons = get_node("UI/Scroll/DistrictButtons")
onready var house_buttons = get_node("UI/Scroll2/HouseButtons")
onready var ambience = get_node("Ambience")
onready var error_label = get_tree().get_current_scene().get_node("UI/Debug/ErrorLabel")
onready var player_label = get_node("UI/PlayerMove")
onready var voter_indicator = get_node("UI/VoterIndicatorUI")
var population
var width
var n_districts
var max_size
var min_size

var can_recheck = true #can determine drawmode
enum DRAW_MODES {ADD, ERASE, PLACE, REMOVE}
var draw_mode = DRAW_MODES.ADD

var just_pressed = false

var recieve_input = true

var district_colors = []

var parties
var filled_squares = 0

onready var submit_button = get_node("UI/Submit")

var map_name
var shape

var PRESS = true
var RELEASE = false

var mobile__press_type = RELEASE
var mobile__is_waiting_for_hold = false
var mobile__hold_tween

var contiguous = true

var state_shape
var reference_rect

var players = []
var current_player = 0
var _multiplayer = false

var enable_next_if_winner_is = "You"

var firework_object = load("res://Effects/Firework.tscn")

var FIREWORK_LIMIT =25
var firework_limit = 25

func _ready():
	
	set_process_unhandled_input (true)
	settings = load_settings()
	victory_node.apply_pointer()
	usrexp_settings = load_usrexp_settings()
	
	contiguous = settings["advanced"]["District Rules"]["contiguous"]
	show_grid = settings["advanced"]["District Rules"]["show grid"]
	_multiplayer = settings["advanced"]["District Rules"]["multiplayer"]
	
	

	state_shape = settings["shape"]
	shape = load("res://Objects/States/"+state_shape+".tscn").instance()
	reference_rect = shape.get_node("ReferenceRect")
	
	district_object = load("res://Objects/District.tscn")
	
	#if true:#settings["advanced"]["District Rules"]["fog"]:
		
		#fog.create(reference_rect.rect_size.x*10, reference_rect.rect_size.y*10)
	
	get_node("State").add_child(shape)
	shape.set_name("Shape")
	var _size = get_viewport_rect().size
	var _center = Vector2(floor(_size.x/2), floor(_size.y/2))
	shape.set_position(_center)
	shape.z_index = -999
	
	yield(get_tree(), "idle_frame")
	
	parties = settings["parties"]
	
	players = parties.keys()
	
	if _multiplayer:
		player_label.visible = true
		submit_button.set_mode_multiplayer()
		
		
	
	#override width
	population = 0
	for p in parties:
		population += parties[p]["voters"]

	width = int(sqrt(population))
	
	var expected_population = population

	if settings["advanced"]["House Placement"]["layout"] == "user placed":
		house_buttons.visible = true
		house_buttons.load_buttons(settings["parties"])
		var house = house_buttons.get_children()[0]
		house.pressed = true
		selected_house = house
		draw_mode = DRAW_MODES.PLACE
		submit_button.set_mode_placement()
		houses_unplaced = population
		if settings["advanced"]["House Placement"]["algorithm"] == "load from file":
			population = matrix.user_place_house(population, parties, 
				Globals.current_settings["name"])
			for vertex in matrix.vertices:
				if matrix.vertices[vertex]["type"] == "House":
					if not matrix.vertices[vertex].has("voters"):
						matrix.vertices[vertex]["voters"] = 1
					var idcr = matrix.set_voter_indicator(matrix.vertices[vertex]["voters"], vertex)
					if not matrix.vertices[vertex].has("voters"):
						idcr.set_num(1)
					else:
						idcr.set_num(matrix.vertices[vertex]["voters"])
					placement_mode__grid_indicators[vertex] = {"indicator": idcr}
					for btn in house_buttons.get_children():
						if btn.type != "gap":
							if btn.party_name == matrix.vertices[vertex]["allegiance"]:
								var vtrs = 1
								if matrix.vertices[vertex].has("voters"):
									vtrs = matrix.vertices[vertex]["voters"]
								btn.decrement_voters(vtrs)
								houses_unplaced-=vtrs
		if houses_unplaced > 0:
			submit_button.disabled = true
			submit_button.set_mouse_filter(2)
		else:
			submit_button.disabled = false
			
		if settings["advanced"]["House Placement"]["algorithm"] == "fill":
			#fill the state with gaps
			var should_be_zero = matrix.generate_houses(0, {}, true, "fill", Globals.current_settings["name"])
		if settings["advanced"]["House Placement"]["algorithm"] == "load from file":
			population = matrix.generate_houses(population, parties, 
				settings["advanced"]["House Placement"]["gaps"], 
				settings["advanced"]["House Placement"]["algorithm"], 
				Globals.current_settings["name"],
				false)
	else:
		
		population = matrix.generate_houses(population, parties, 
			settings["advanced"]["House Placement"]["gaps"], 
			settings["advanced"]["House Placement"]["algorithm"], 
			Globals.current_settings["name"])
		create_district_buttons(expected_population)
		
		if settings.has("camera"):
			camera.set_zoom(Vector2(settings["camera"]["zoom"],settings["camera"]["zoom"]))
			camera.set_global_position(Vector2(settings["camera"]["position"][0],settings["camera"]["position"][1]))

# # # # # # # # #
#
# DISTRICT BUTTONS
#
# # # # # # # # #
			
func create_district_buttons(expected_population):
	if population == -1:
		error_screen.set_error_name("Missing File Error")
		error_screen.set_error_message("No data exists for "+Globals.current_settings["name"])
		error_screen.visible = true
		recieve_input = false
	
	elif population != expected_population:
		error_screen.set_error_name("Population Error")
		error_screen.set_error_message(state_shape + " can fit "+str(population)+" at most. For some reason, the game is trying to add "+str(expected_population)+". "+"Please try again.")
		error_screen.visible = true
		recieve_input = false
		
	#align camera
	match settings["advanced"]["House Placement"]["algorithm"]: 
		"spiral":
			if population < 50:
				camera.set_zoom(Vector2(0.05,0.05))
			elif population > 5000:
				camera.set_zoom(Vector2(1,1))
			else:
				var z = (0.95/4950) * population + (0.05 - (0.95/4950) * 50)
				camera.set_zoom(Vector2(z, z))
		"fill":
			camera.set_zoom(Vector2(0.1,0.1))
		"hardcoded":
			camera.set_zoom(Vector2(settings["camera"]["zoom"],settings["camera"]["zoom"]))
			camera.set_global_position(Vector2(settings["camera"]["position"][0],settings["camera"]["position"][1]))
	for p in parties:
		var voters = parties[p]["voters"]*1.0
		var ratio = voters/population
		popular_vote.add_party(p, parties[p]["voters"], stepify(ratio, 0.001)*100)
		#set global popular vote at game start
		
		var lvlname = [settings["name"]][0]
		var mapname = Globals.current_map["name"]

	n_districts = settings["districts"].size()
	
	district_buttons.load_buttons(settings["districts"])
	district_button_names = get_button_names()
	selected_district = district_button_names[0]
	
	if _multiplayer:

		var i = 0
		for btn in district_buttons.get_children():
			if btn.name != selected_district:
				btn.disabled = true
			else:
				btn.disabled = false
				#first district goes first
				current_player = players.find(settings["districts"][btn.name]["party"])
				player_label.set_party(players[current_player], parties[players[current_player]])
			i+=1
	
	
	if settings["advanced"]["Other"]["debug"]:
		get_node("UI/Debug").visible = true
	else:
		get_node("UI/Debug").visible = false
		
	get_node("Ambience").set_volume(usrexp_settings["Audio"]["Sound"])
	
	var shape_rect_position = shape.get_global_position()
	var anchor = Vector2(
		round(
			shape_rect_position.x / matrix.GRID_SIZE
		),
		round(
			shape_rect_position.y / matrix.GRID_SIZE)
		)

	matrix.save_matrix(Globals.current_settings["name"], anchor)

func get_button_names():
	var bn = []
	var children = district_buttons.get_children()
	for b in children:
		if b.name != "Blank":
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

# # # # # # # # # # #
#
# LOAD SETTINGS
#
# # # # # # # # # # #

func load_settings():

	map_name = ""
	if Globals.map_name:
		map_name = Globals.map_name
		
	return Globals.current_settings.duplicate(true)

func load_usrexp_settings():
	var file = File.new()
	file.open("user://settings.json", file.READ)
	var data = parse_json(file.get_as_text())
	if not data:
		data = {
			"Audio" : {
				"Music" : 0.7,
				"Sound" :0.7
			},
			"Video" : {
				"Resolution" : "?",
				"Orientation" : "sensor"
			}
		}
	
	return data

func stop_input():
	recieve_input = false

func start_input():
	recieve_input = true

func _unhandled_input(event: InputEvent) -> void:
	if recieve_input:
		if (draw_mode == DRAW_MODES.ADD or draw_mode == DRAW_MODES.ERASE):
				
			if event is InputEventScreenTouch or event is InputEventScreenDrag:
				if event is InputEventScreenTouch:
					
					if event.is_pressed():
						if touches == 0:
							just_pressed = true
						else:
							just_pressed = false
						mobile__press_type = true
						touches = 0
						for getTouch in range(event.index+1):
							touches+=1
						if touches <= 0:
							call_deferred("set_draw_mode_add")
					else:
						touches-=1
						
						mobile__press_type = false
						if touches <= 0:
							call_deferred("set_draw_mode_add")

						
				#just_pressed = !just_pressed
				set_touch_members(event)
				_draw_district(event)
				
				
				return
				
	#		if Input.is_mouse_button_pressed(BUTTON_LEFT) and not event is InputEventScreenTouch:
	#			#comment these out if debugging touch controls
	#			set_mouse_members(event)
	#			_draw_district(event)
	#
			if Input.is_mouse_button_pressed(BUTTON_RIGHT):
				set_mouse_members(event)

				_remove_district()
		elif draw_mode == DRAW_MODES.PLACE or draw_mode == DRAW_MODES.REMOVE:
			if event is InputEventScreenTouch or event is InputEventScreenDrag:
				set_touch_members(event)
				place_house(event)

###################
#
# House Placement
#
###################

func place_house(event):
	
	if deselect_is_on or disable_draw:
		return
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if event is InputEventScreenTouch and not event.is_pressed():
			draw_mode = DRAW_MODES.PLACE

		if event.is_pressed() or event is InputEventScreenDrag:
			if not event is InputEventScreenDrag: #is pressed
				mobile__press_type = true

			else:
				mobile__press_type = false #screen drag

			var square = matrix.get(grid_point)
#
			var allegiance
			if matrix.get(grid_point) != null and matrix.get(grid_point).has("allegiance"):
				allegiance = square["allegiance"]

			if selected_house.type == "gap":
#				voter_indicator.visible = true
#				#remove house sprite if there is one
				matrix.set(-1, grid_point)

				if matrix.vertices.has(str(grid_point)):
					if matrix.get(grid_point) != null and matrix.get(grid_point)["type"] != "House":
						determine_placement_mode(event)
#
				if draw_mode == DRAW_MODES.REMOVE:
					matrix.fog.add_fog(grid_point)
					
					if matrix.vertices.has(str(grid_point)) and matrix.vertices.has("allegiance"):
						if matrix.vertices[str(grid_point)].has("voters"):
							house_buttons.get_party(allegiance).increment_voters(matrix.vertices[grid_point]["voters"])
							houses_unplaced+=matrix.vertices[grid_point]["voters"]
						else:
							house_buttons.get_party(allegiance).increment_voters()
							houses_unplaced+=1
					matrix.vertices.erase(str(grid_point))
					if houses_unplaced > 0:
						submit_button.disabled = true
						submit_button.set_mouse_filter(2)
					else:
						submit_button.disabled = false
				else:
					#set matrix fog to clear this square
					matrix.fog.clear_fog(grid_point)
#
					if square != null and square.has("allegiance"):
						if matrix.vertices[str(grid_point)].has("voters"):
							house_buttons.get_party(allegiance).increment_voters(matrix.vertices[str(grid_point)]["voters"])
							houses_unplaced+=matrix.vertices[str(grid_point)]["voters"]
						else:
							house_buttons.get_party(allegiance).increment_voters()
							houses_unplaced+=1
							
						placement_mode__grid_indicators[str(grid_point)]["indicator"].queue_free()
						placement_mode__grid_indicators.erase(str(grid_point))
						if houses_unplaced > 0:
							submit_button.disabled = true
							submit_button.set_mouse_filter(2)
						else:
							submit_button.disabled = false
					matrix.vertices[str(grid_point)] = {
						"type":"Gap", 
						"coords":grid_point, 
						"visited": false,
					}
#
#
#
			elif selected_house.type == "house" and selected_house.voters > 0 and allegiance != selected_house.party_name:
				matrix.set(selected_house.sprite_index, grid_point)
				matrix.vertices[str(grid_point)] = {
					"type":"House", 
					"coords":grid_point, 
					"visited": false,
					"allegiance": selected_house.party_name
				}
				#replace house with new house
				if square != null and square.has("allegiance") and allegiance != selected_house.party_name:
					if square.has("voters"):
						house_buttons.get_party(allegiance).increment_voters(square["voters"])
						houses_unplaced+=square["voters"]
					else:
						house_buttons.get_party(allegiance).increment_voters()
						houses_unplaced+=1
					placement_mode__grid_indicators[str(grid_point)]["indicator"].queue_free()
					placement_mode__grid_indicators.erase(str(grid_point))
					if houses_unplaced > 0:
						submit_button.disabled = true
						submit_button.set_mouse_filter(2)
					else:
						submit_button.disabled = false
				selected_house.decrement_voters()
				houses_unplaced-=1
				matrix.voter_indicators.visible = true
				if houses_unplaced > 0:
					submit_button.disabled = true
					submit_button.set_mouse_filter(2)
				else:
					submit_button.disabled = false
				
				if not placement_mode__grid_indicators.has(str(grid_point)):
					#create a voter indicator
					var i = matrix.set_voter_indicator(1, str(grid_point))
					placement_mode__grid_indicators[str(grid_point)] = {"indicator": i}
				

			elif selected_house.type == "house" and selected_house.voters > 0 and allegiance == selected_house.party_name and not event is InputEventScreenDrag:
				if matrix.vertices[str(grid_point)].has(str("voters")):
					matrix.vertices[str(grid_point)]["voters"] += 1
				else:
					matrix.vertices[str(grid_point)]["voters"] = 2

				selected_house.decrement_voters()
				houses_unplaced-=1
				voter_indicator.set_num(matrix.vertices[str(grid_point)]["voters"])
				placement_mode__grid_indicators[str(grid_point)]["indicator"].increment()
				if houses_unplaced > 0:
					submit_button.disabled = true
					submit_button.set_mouse_filter(2)
				else:
					submit_button.disabled = false
					
				if matrix.vertices[str(grid_point)]["voters"] > 2 and matrix.vertices[str(grid_point)]["voters"] < 5:
					matrix.set(selected_house.sprite_index, grid_point)
				elif matrix.vertices[str(grid_point)]["voters"] > 4:
					matrix.set(selected_house.sprite_index, grid_point)
				
			$UI/VoterIndicatorUI.visible = true

		if houses_unplaced <= 0:
			submit_button.disabled = false
			submit_button.set_mouse_filter(0)

######################
#
#	PROCESS
#
######################


func _process(_delta):

	var count = 0
	for d in districts:
		count += d.house_count
		if d.name == selected_district:
			debug_party_tally.text = str(d.party_tallies)
		
	filled_squares = count

	match draw_mode:
		0:
			mode_label.set_text('Mode: +    ' + selected_district + "    ")
		1:
			mode_label.set_text('Mode: -    ' + selected_district + "    ")
		_:
			pass
		
	squares_filled_label.set_text("Squares: "+str(filled_squares)+"    ")
	progress_label.set_text(str(filled_squares)+"/"+str(population))
		
	if not can_recheck:
		can_recheck = true
		
	if not _multiplayer and is_instance_valid(submit_button) and draw_mode != DRAW_MODES.PLACE:
		if filled_squares >= population: #because sometimes the computer can't count :)
			for d in districts:
				if d.house_count < d.min_size:
					submit_button.set_reason("District "+d.name+" is too small!")
					return
				if contiguous and not d.contiguous:
					submit_button.set_reason("District "+d.name+" is not contiguous!")
					return
			
			submit_button.disabled = false
			submit_button.set_mouse_filter(0)
		else:
			
			submit_button.disabled = true
			submit_button.set_reason("Not all houses are in a district.")
			submit_button.set_mouse_filter(2)
			
	if ambience.volume <= usrexp_settings["Audio"]["Sound"]:
		ambience.volume += 0.001

########################
#
# Setters
#
#########################

# Creates a point that will henceforth be known as the "last point"

func set_last_point():
	last_point = Node2D.new()
	matrix.add_child(last_point)
	last_point.set_name("LastPoint")
	if show_last_point:
		var sprite = Sprite.new()
		last_point.add_child(sprite)
		sprite.texture = texture_missing
	
# mouse and touch member variables are set based on positions of the event

func set_mouse_members(event):
	if event is InputEventKey:
		return
	#sets the variables realted to the mouse positions from a click
	if not last_point:
		set_last_point()
	
	last_point.set_global_position(get_global_mouse_position())
	var point = matrix.get_node("LastPoint")
	previous_grid_point = grid_point
	grid_point = get_grid_position(point.position)
	
func set_touch_members(event):
	if not last_point:
		set_last_point()
	
	last_point.set_global_position(get_canvas_transform().affine_inverse().xform(event.position))
	var point = matrix.get_node("LastPoint")
	previous_grid_point = grid_point
	grid_point = get_grid_position(point.position)
	
########################
#
# Getters
#
########################	

func get_grid_position(point):
	#var cam = get_node("State").get_node("Camera2D")
	var result = Vector2(round(point.x/matrix.GRID_SIZE), round(point.y/matrix.GRID_SIZE))
	return result
	

func get_district_selected(exclude=null, temp=null):

	if not has_node(selected_district):
		
		var district = district_object.instance()
		district.starting_vertex = grid_point
		
		if selected_district == "Flood":
			district.max_size = settings["districts"][temp]["max"]
			district.min_size = settings["districts"][temp]["min"]
		else:
			district.max_size = settings["districts"][selected_district]["max"]
			district.min_size = settings["districts"][selected_district]["min"]
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

		if settings["advanced"]["District Rules"]["diagonals"]:
			#color.a = 1.0
			district.get_node("TileMap255").modulate = color
		else:
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

####################
#
# District drawing
#
####################

func _draw_district(event) -> void:
	if deselect_is_on or disable_draw:
		return
	if just_pressed and can_recheck:
		can_recheck = false
		determine_draw_mode(event)
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



func _remove_district() -> void:
	if not last_point:
		return
	var district = get_district_selected()
	if not district:
		return
		
	district.erase(grid_point)
	if _multiplayer:
		if district.house_count < district.min_size:
			submit_button.disabled = true

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
	
#
# Mode setters
#

func set_draw_mode_erase():
	draw_mode = DRAW_MODES.ERASE
	if (is_instance_valid(mobile__hold_tween)):
		mobile__hold_tween.queue_free()
		mobile__is_waiting_for_hold = false
		
func set_draw_mode_remove():
	draw_mode = DRAW_MODES.REMOVE
	if (is_instance_valid(mobile__hold_tween)):
		mobile__hold_tween.queue_free()
		mobile__is_waiting_for_hold = false
		
func set_draw_mode_add():
	draw_mode = DRAW_MODES.ADD

func set_draw_mode(mode):
	draw_mode = mode

#figure out if we add or erase
func determine_draw_mode(event):
	var already_district = already_district()
	if already_district and not event is InputEventScreenTouch and not event is InputEventScreenDrag:
		set_draw_mode(DRAW_MODES.ERASE)
	elif event is InputEventScreenTouch:
		if already_district and not mobile__is_waiting_for_hold and mobile__press_type == true:
			get_district_selected()
			mobile__hold_tween = Tween.new()
			self.add_child(mobile__hold_tween)
			mobile__is_waiting_for_hold = true
			mobile__hold_tween.interpolate_callback(self, 1, "set_draw_mode_erase")
			mobile__hold_tween.start()
		if mobile__is_waiting_for_hold and mobile__press_type == false:
			if (is_instance_valid(mobile__hold_tween)):
				mobile__hold_tween.stop(self)
				mobile__hold_tween.queue_free()
				mobile__is_waiting_for_hold = false
				draw_mode = DRAW_MODES.ADD
		
	just_pressed = false
	
#figure out if add or delete but in house placing mode
func determine_placement_mode(event):

	if event is InputEventScreenTouch:
		if not mobile__is_waiting_for_hold and mobile__press_type == true:
			mobile__hold_tween = Tween.new()
			self.add_child(mobile__hold_tween)
			mobile__is_waiting_for_hold = true
			mobile__hold_tween.interpolate_callback(self, 1, "set_draw_mode_remove")
			mobile__hold_tween.start()
		if mobile__is_waiting_for_hold and mobile__press_type == false:
			if (is_instance_valid(mobile__hold_tween)):
				mobile__hold_tween.stop(self)
				mobile__hold_tween.queue_free()
				mobile__is_waiting_for_hold = false
				draw_mode = DRAW_MODES.PLACE	
	just_pressed = false
	
# bool checkers	
func house_in_district():
	return matrix.vertices.has(str(grid_point)) and matrix.vertices[str(grid_point)]["type"] == "House" and matrix.vertices[str(grid_point)].has("district")

func already_district():
	return matrix.vertices.has(str(grid_point)) and matrix.vertices[str(grid_point)].has("district")
	
##################
#
#	Submit Functions
#
##################


func submit_current_layout():
	#remove the house buttons
	house_buttons.clear()
	#save the vertices
	matrix.save_matrix(settings["name"])
	#generate district buttons
	create_district_buttons(population)
	#enter draw_mode: ADD
	draw_mode = DRAW_MODES.ADD

func submit():
	#print("Submitted")
	
	get_node("Darkening").darken()
	#print(matrix.vertices)
	get_node("UI/Deselect").visible = false
	var scores = []
	for d in districts:
		var score = {d.name:{}}
		for id in d.squares:
			if matrix.vertices[id].has("allegiance"):
				var voters = 1
				if matrix.vertices[id].has("voters"):
					voters = matrix.vertices[id]["voters"]
				if score[d.name].has(matrix.vertices[id]["allegiance"]):
					score[d.name][matrix.vertices[id]["allegiance"]] += voters
				else:
					score[d.name][matrix.vertices[id]["allegiance"]] = voters
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

	
	if not Globals.chamber_of_legislation.has(Globals.current_map["name"]):
		Globals.chamber_of_legislation[Globals.current_map["name"]] = {"seats":{},"parties":{}}

	Globals.chamber_of_legislation[Globals.current_map["name"]]["seats"][settings["name"]] = results
	Globals.chamber_of_legislation[Globals.current_map["name"]]["parties"] = settings["parties"]
	if not Globals.chamber_of_legislation[Globals.current_map["name"]].has("scores"):
		Globals.chamber_of_legislation[Globals.current_map["name"]]["scores"] = {}
	Globals.chamber_of_legislation[Globals.current_map["name"]]["scores"][settings["name"]] = scores

	var winner = get_winner(results)
	#print(winner)
	
		
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
	
	if winner.keys()[0] == enable_next_if_winner_is:
		if settings["pointer"]:
			for node in settings["pointer"]:
				Globals.map_progress[Globals.current_map["name"]][node] = true
		victory_node.next.disabled = false
		
	#shoot off up to LIMIT fireworks
	var grid_list = matrix.vertices.keys()
	grid_list = shuffleList(grid_list)
	for square in grid_list:
		if matrix.vertices[square].has("allegiance") and matrix.vertices[square]["allegiance"] == winner.keys()[0]:
			shoot_firework(matrix.vertices[square]["coords"])
			if firework_limit <= 0:
				break

func shuffleList(list):
	var shuffledList = [] 
	var indexList = range(list.size())
	for i in range(list.size()):
		var x = randi()%indexList.size()
		shuffledList.append(list[indexList[x]])
		indexList.remove(x)
	return shuffledList

func shoot_firework(coords):
	coords.y = coords.y - 0.5
	if firework_limit > 0:
		firework_limit-=1
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var t = Timer.new()
		t.set_wait_time(rng.randf()*4)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		var firework = firework_object.instance()
		firework.get_node("Sound1").volume_db = 5*log(usrexp_settings["Audio"]["Sound"])
		firework.get_node("Sound2").volume_db = 5*log(usrexp_settings["Audio"]["Sound"])
		firework.get_node("Sound3").volume_db = 5*log(usrexp_settings["Audio"]["Sound"])
		firework.set_global_position(coords * matrix.GRID_SIZE)
		add_child(firework)
		t.queue_free()

func end_turn_enable():
	submit_button.disabled = false
	

	
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
			
			

func _on_Deselect_focus_entered():
	disable_draw = true


func _on_Deselect_focus_exited():
	disable_draw = false


# # # # # # # # #
#
#
# MULTIPLAYER
#
# # # # # # # # #

func increment_player():
	current_player += 1
	if current_player >= len(players):
		current_player = 0
	player_label.set_party(players[current_player], parties[players[current_player]])
	

	var district_btn = get_node(selected_district).get_next_district()
	
	for btn in district_buttons.get_children():
		if btn != district_btn:
			btn.disabled = true
		else:
			btn.disabled = false
			
func enable_selected_district():
	for btn in district_buttons.get_children():
		if btn.name == selected_district:
			btn.disabled = false

##################
#
# State Shape
#
##################

func readjust_state(anchor):
	var coords = anchor.coords
	shape.set_global_position(Vector2(coords.x * matrix.GRID_SIZE,
									 coords.y * matrix.GRID_SIZE))
