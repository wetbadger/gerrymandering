extends Node2D


var settings

var points: Array = []
var last_point
var grid_point
var selected_district = "A"
var _district = load("Objects/District.tscn")
var draw_size = 33

export var show_last_point = false
var texture_missing = load("res://pics/target.png")

onready var matrix = get_node("State").get_node("Matrix")
onready var mode_label = get_node("UI/Labels/ModeLabel")

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



func _ready():

	settings = load_settings()
	print(settings, "\t")
	width = settings["width"]
	parties = settings["parties"]
	
	population = matrix.generate_houses(width, parties)
	
	max_size = settings["max_size"]
	min_size = settings["min_size"]
	n_districts = settings["n_districts"]
	district_colors = generate_colors(n_districts)
	
	get_node("UI/DistrictButtons").load_buttons(n_districts, district_colors, max_size)

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
	var file = File.new()
	if not file.file_exists("user://settings.json"):
			create_default_settings()
			return
	file.open("user://settings.json", File.READ)
	var data = parse_json(file.get_as_text())
	return data

func create_default_settings():
	var file = File.new()
	file.open("user://settings.json", File.WRITE)
	file.store_line(to_json({
		"contiguous" : true,
		"diagonals" : false,
		"n_districts" : 5,
		"max_size" : 5,
		"min_size" : 5,
		"width" : 5,
		"parties" : {
			"Red Party" : {"voters": 10, "asset": "red_house.png"},
			"Blue Party" : {"voters": 15, "asset": "blue_house.png"}
		},
		"empty_tiles" : false,
		"empty_tiles_fillable" : false,
		"auto_size": false,
		"size_based_on" : "largest_factor",
		"even_sizes": true,
		"colors" : {
			"blue" : [0.1,0.6,0.7],
			"red" : [0.8,0.1,0.1],
			"orange" : [0.8,0.4,0.1],
			"green" : [0.2,0.8,0.1],
			"purple" : [0.5,0.2,0.8],
			"yellow" : [0.8,0.8,0.0],
			"brown" : [0.2,0.2,0.3],
			"white" : [1,1,1],
			"gray" : [0.5,0.5,0.5],
			"teal" : [0.1,0.8,0.8],
			"pink" : [0.8,0.1,0.7]
		},
		"none_selected_start_erasing" : false
	}))
	file.close()

func stop_input(t):
	recieve_input = false
	yield(get_tree().create_timer(t), "timeout")
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

	if draw_mode == 0:
		mode_label.set_text('+')
	else:
		mode_label.set_text('-')
		
	if not can_recheck:
		can_recheck = true
	
func set_mouse_members(event):
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

func _draw_district_flood(coords, exclude=null) -> void:
	var district = get_district_selected(exclude)
	if not district:
		return
	district.highlight(coords, exclude)

func draw_district_flood(coords, exclude=null):
	var temp1 = selected_district
	#var temp2 = grid_point
	selected_district = "Flood"
	grid_point = coords
	_draw_district_flood(coords, exclude)
	selected_district = temp1
	#grid_point = temp2
	

func determine_draw_mode():
	var house_in_district = house_in_district()
	if house_in_district:
		set_draw_mode(DRAW_MODES.ERASE)
		
	if settings.none_selected_start_erasing:
		if matrix.vertices.has(str(grid_point)) and not matrix.vertices[str(grid_point)].has("district"):
			var district = get_node(selected_district)
			if district and len(district.squares) > 0:
				set_draw_mode(DRAW_MODES.ERASE)
		
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

func get_district_selected(exclude=null):

	if not has_node(selected_district):
		
		var district = _district.instance()
		district.starting_vertex = grid_point
		district.max_size = max_size
		district.min_size = min_size
		district.set_global_position(grid_point * matrix.GRID_SIZE)
		district.set_name(selected_district)
		var color
		if selected_district == "Flood":
			color = Color(1, 0, 0)
			#district.squares_in_region.append(exclude)
		else:
			color = get_tree().get_current_scene().get_node("UI/DistrictButtons").get_node(selected_district).color_val
		district.get_node("TileMap").modulate = color
		add_child(district)
		district.highlight(grid_point, exclude)
		return false
	else:
		var district = get_node(selected_district)
		return district
		
func measure_width_and_height():
	#TODO: for non perfectly square shapes measure the tile height and width at the longest bones on the state polygon
	pass
	
func get_width():
	return width
