extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var points: Array = []
var last_point = Vector2()
var selected_district = "DistrictA"
var _district = load("Objects/District.tscn")
var draw_size = 33

onready var matrix = get_node("State").get_node("Matrix")

func _ready():
	matrix.generate_houses(100)


func _input(event: InputEvent) -> void:
	if not Input.is_mouse_button_pressed(BUTTON_LEFT):
		return

	points.append(event.position)
	last_point = event.get_global_position()
	
	print(get_grid_position(last_point))
	
	
	update()
func get_grid_position(point):
	var cam = get_node("State").get_node("Camera2D")
	var grid_point = Vector2(round(point.x/matrix.GRID_SIZE), round(point.y/matrix.GRID_SIZE))
	
	print("zoom: " + str(cam.zoom))
	print("pos : " + str(cam.get_global_position()))
	return grid_point

func _draw() -> void:
	#draw_colored_polygon(points, Color.red)
	#for point in points:
		#draw_circle(point,10, Color.red)
	if not last_point:
		return
	var district = get_node(selected_district)
	if not district:
		district = _district.instance()
		district.set_global_position(last_point)
		district.set_name(selected_district)
		add_child(district)
		return

	var color = PoolColorArray( [district.color] )

