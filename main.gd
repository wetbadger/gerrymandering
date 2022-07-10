extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var points: Array = []
var last_point = Vector2()
var selected_district = "DistrictA"
var _district = load("Objects/District.tscn")
var draw_size = 33
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if not Input.is_mouse_button_pressed(BUTTON_LEFT):
		return
		
	#points.append(event.position)
	last_point = event.get_global_position()
	update()
	

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
		
	var shape = district.get_node("Area2D").get_node("CollisionPolygon2D")
	var local_last_point = glob_to_loc(district, last_point)
	print(local_last_point)
	print(shape.polygon)
	expand_district(shape, local_last_point)
	#district.get_node("Area2D").get_node("CollisionPolygon2D").polygon.push_back(last_point)
	print()
	
func expand_district(shape, from_point):
	var newPoly = PoolVector2Array() + shape.polygon
	var i = 0
	for point in newPoly:
		if point.x - from_point.x < draw_size:
			newPoly[i] = Vector2(from_point.x-draw_size,point.y)
		i += 1
	shape.polygon = newPoly

func glob_to_loc(node, global_pos):
	var local_pos = global_pos - node.get_global_position()
	return local_pos
