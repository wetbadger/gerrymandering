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

export var show_traversal = false
var tracker = null
var circle = load("res://Misc/Tracker.tscn")

var rng = RandomNumberGenerator.new()
var party_stacks = {}
var party_names = []
var parties = {}

func _ready():
	
	rng.randomize()
	
	var dimensions = rect.size

	size = dimensions / GRID_SIZE
	size.x = floor(size.x)
	size.y = floor(size.y)

	
func generate_houses(n, _parties=null):
	
	if _parties:
		self.parties = _parties
		for p in _parties:
			party_stacks[p] = []
			party_names.append(p)

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
	if int(n) % 2:
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
		var allegiance = get_random_allegiance()
		var new_house = _house.instance()
		vertices[str(point)] = {"type":"House", "coords":Vector2(point.x,point.y), "visited": false, "allegiance" : allegiance["party"]}
		set(new_house, point)
		add_child(new_house)
		new_house.set_asset(allegiance["asset"])
	
	place_house(direction, point, n-1)
	
func get_random_allegiance():
	var i = rng.randi_range(0, len(party_stacks)-1)
	var asset_path = parties[party_names[i]]["asset"]
	var asset = load(asset_path)
	party_stacks[party_names[i]].append(1)
	var voters = parties[party_names[i]]["voters"]
	var stack = party_stacks[party_names[i]]
	var stack_len = len(stack)
	
	var allegiance = {
		"party" : party_names[i],
		"asset" : asset
	}
	
	if stack_len >= voters:
		party_stacks.erase(party_names[i])
		party_names.erase(party_names[i])
		
	return allegiance
		
func set(object, position):
	house_count += 1
	object.set_global_position(position * GRID_SIZE)
