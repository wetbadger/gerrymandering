extends Node2D

#A pure mathematical obejct
var vertices = {}

export var GRID_SIZE = 6
var size
var house_count = 0
var _house = load("Objects/House.tscn")
onready var rect = get_viewport_rect()
enum {RIGHT, DOWN, LEFT, UP}
var point
func _ready():
	
	print(rect)
	var dimensions = rect.size
	print(dimensions)
	size = dimensions / GRID_SIZE
	size.x = floor(size.x)
	size.y = floor(size.y)
	print(size)
	
func generate_houses(n):
	var starting_point = Vector2(floor(size.x/2), floor(size.y/2))
	place_house(null, starting_point, 1)
#	var new_house = _house.instance()
#	set(new_house, starting_point)
#	add_child(new_house)
	point = starting_point
	var switch = true
	for i in range(1, n):
		if switch:
			place_house(RIGHT, point, i)
			place_house(DOWN, point, i)
			
		if not switch:
			place_house(LEFT, point, i)
			place_house(UP, point, i)
		
		switch = !switch
	if n % 2:
		place_house(RIGHT, point, n-1)
	else:
		place_house(LEFT, point, n-1)
		
	return house_count
		
func place_house(direction, from_point, n):
	if n <= 0:
		return
	match(direction):
		RIGHT:
			point = Vector2(from_point.x+1, from_point.y)
		DOWN:
			point = Vector2(from_point.x, from_point.y+1)
		LEFT:
			point = Vector2(from_point.x-1, from_point.y)
		UP:
			point = Vector2(from_point.x, from_point.y-1)
		_:
			point = from_point
		
	var intersection = get_world_2d().direct_space_state.intersect_point (point*GRID_SIZE, 32, [ ], 2147483647, true, true )
	if not intersection:
		pass
		#print("No make house")
	else:
		var new_house = _house.instance()
		vertices[str(point.x*point.y)] = {"type":"House"}
		set(new_house, point)
		add_child(new_house)
	
	place_house(direction, point, n-1)
	
			
		
func set(object, position):
	house_count += 1
	object.set_global_position(position * GRID_SIZE)
