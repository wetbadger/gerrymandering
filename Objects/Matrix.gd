extends Node2D

#A pure mathematical obejct

export var GRID_SIZE = 6
var size
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
	var new_house = _house.instance()
	set(new_house, starting_point)
	add_child(new_house)
	point = starting_point
	var switch = true
	for i in range(1, n):
		if switch:
			place_houses(RIGHT, point, i)
			place_houses(DOWN, point, i)
			
		if not switch:
			place_houses(LEFT, point, i)
			place_houses(UP, point, i)
		
		switch = !switch
	if n % 2:
		place_houses(RIGHT, point, n-1)
	else:
		place_houses(LEFT, point, n-1)
		
func place_houses(direction, from_point, n):
	if n <= 0:
		return
	if direction == RIGHT:
		point = Vector2(from_point.x+1, from_point.y)
	if direction == DOWN:
		point = Vector2(from_point.x, from_point.y+1)
	if direction == LEFT:
		point = Vector2(from_point.x-1, from_point.y)
	if direction == UP:
		point = Vector2(from_point.x, from_point.y-1)
		
	var intersection = get_world_2d().direct_space_state.intersect_point (point*GRID_SIZE, 32, [ ], 2147483647, true, true )
	if not intersection:
		print("No make house")
	else:
		var new_house = _house.instance()
		set(new_house, point)
		add_child(new_house)
	
	place_houses(direction, point, n-1)
	
			
		
func set(object, position):
	object.set_global_position(position * GRID_SIZE)
