extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var points: Array = []
var last_point
var grid_point
var selected_district = "A"
var _district = load("Objects/District.tscn")
var draw_size = 33

export var show_last_point = false
var texture_missing = load("res://pics/target.png")

onready var matrix = get_node("State").get_node("Matrix")

var population

func _ready():
	population = matrix.generate_houses(5)
	print(population)


func _input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		set_mouse_members(event)

		_draw_district()
		
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		set_mouse_members(event)
		
		_remove_district()

	
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
	var grid_point = Vector2(round(point.x/matrix.GRID_SIZE), round(point.y/matrix.GRID_SIZE))
	return grid_point

func _draw_district() -> void:
	#draw_colored_polygon(points, Color.red)
	#for point in points:
		#draw_circle(point,10, Color.red)
	if not last_point:
		return
	var district = get_district_selected()
	if not district:
		return
		
	district.highlight(grid_point)

	var color = PoolColorArray( [district.color] )

func _remove_district() -> void:
	if not last_point:
		return
	var district = get_district_selected()
	if not district:
		return
		
	district.erase(grid_point)

func get_district_selected():
	var district = get_node(selected_district)
	if not district:
		district = _district.instance()
		district.starting_vertex = grid_point
		district.max_size = ceil(sqrt(population))
		district.set_global_position(grid_point * matrix.GRID_SIZE)
		district.set_name(selected_district)
		add_child(district)
		district.highlight(grid_point)
		return false
	else:
		return district
