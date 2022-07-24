extends Node2D

#A pure mathematical obejct
var vertices = {}

export var GRID_SIZE = 6
var size
var house_count = 0
var _house = load("Objects/House.tscn")
onready var sprite_tiles = get_tree().get_current_scene().get_node("State/SpriteTiles")
onready var rect = get_viewport_rect()
onready var flood_fill_2 = load("res://Algorithms/flood2.gd")
enum {RIGHT, DOWN, LEFT, UP}
var point

var house_chance = 1

export var show_traversal = false
var tracker = null
var circle = load("res://Misc/Tracker.tscn")

var rng = RandomNumberGenerator.new()
var party_stacks = {}
var party_names = []
var parties = {}
var population # (approximate)

var gaps = true

var top_left_corner = Vector2(999,999)
var bottom_right_corner = Vector2(0,0)

func _ready():
	
	rng.randomize()
	
	var dimensions = rect.size

	size = dimensions / GRID_SIZE
	size.x = floor(size.x)
	size.y = floor(size.y)
	
	
func generate_houses(n, _parties=null, _gaps=false, algo="fill"):
	gaps = _gaps
	population = n
	if _parties:
		self.parties = _parties
		for p in _parties:
			party_stacks[p] = [] #counts the number of allegiences given to said party
			party_names.append(p)

	match algo:
		"spiral": #TODO: settings["algorithm"]["spiral"]
			var starting_point = Vector2(floor(size.x/2), floor(size.y/2))
			return place_houses__spiral(n, starting_point)
		"fill":
			gaps = false #if _gaps, go back and remove squares
			var pos_and_size = get_tree().get_current_scene().get_node("State/Shape").measure_width_and_height()
			var starting_point = Vector2(floor(pos_and_size[0].x / GRID_SIZE), floor(pos_and_size[0].y / GRID_SIZE))
			var size = Vector2(floor(pos_and_size[1].x / GRID_SIZE), floor(pos_and_size[1].y / GRID_SIZE))
			print(starting_point, size)
			var area = pos_and_size[1].x * pos_and_size[1].y
			house_chance = 0 #make all gaps
			var population = place_houses__fill_space(area, starting_point, size)
			return population
		

func place_houses__fill_space(n, starting_point, size):
	#fill shape with houses, and then delete houses until n is reached
	#if n is higher than available space, throw an error, give exact number of houses that can fit

	var last_point = place_house(RIGHT, starting_point, size.x)
	var rows = 1
	while last_point.y < starting_point.y + size.y:

		last_point = place_house(DOWN, last_point, 1)
		last_point = place_house(LEFT, last_point, size.x)
		last_point = place_house(DOWN, last_point, 1)
		last_point = place_house(RIGHT, last_point, size.x)
		rows+=1
		
	var total_houses = 0
	for p in party_stacks:
		total_houses += party_stacks[p].size()
	
	print(total_houses)
	
	var voter_count = 0
	for p in parties:
		voter_count += parties[p]["voters"]
		
	print(voter_count)

	var new_voters = reduce_voters_to(voter_count)
	
	house_chance = 1
	for coord in new_voters:
		place_house(null, str2var("Vector2"+coord), 1)

	return house_count
	
func place_houses__spiral(n, starting_point):
	
	place_house(null, starting_point, 1)

	point = starting_point
	var switch = true

	var i = 1
	while house_count < n:
		if switch:
			place_house(RIGHT, point, i)
			place_house(DOWN, point, i)
			
		if not switch:
			place_house(LEFT, point, i)
			place_house(UP, point, i)
		
		switch = !switch
		i += 1
		
	if int(n) % 2:
		place_house(RIGHT, point, n-1)
	else:
		place_house(LEFT, point, n-1)
		
	return house_count
		
func place_house(direction, from_point, n):
	
	if n <= 0:
		return from_point
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
	
	if gaps:
		house_chance = rng.randf()
	#TODO: add gaps here rather than in highlight()??
	
	if not intersection:
		pass
		#print("No make house")
	elif house_chance < 0.5:
		vertices[str(point)] = {"type":"Gap", "coords":Vector2(point.x,point.y), "visited": false}
	else:
		var allegiance = get_random_allegiance()
		#var new_house = _house.instance()

		if allegiance:
			if point.x < top_left_corner.x:
				top_left_corner.x = point.x
			if point.y < top_left_corner.y:
				top_left_corner.y = point.y
			if point.x > bottom_right_corner.x:
				bottom_right_corner.x = point.x
			if point.y > bottom_right_corner.y:
				bottom_right_corner.y = point.y
			
			vertices[str(point)] = {"type":"House", "coords":Vector2(point.x,point.y), "visited": false, "allegiance" : allegiance["party"]}
			set(allegiance["asset"], point)
		#add_child(new_house)
		#new_house.set_asset()
		#new_house.scale = Vector2(0.25, 0.25)

	
	place_house(direction, point, n-1)
	return point
	
func get_random_allegiance():
	#get party a percentage
	#get party b percentage
	
	#get chance of party 1
	var probabilities = []
	for party in party_names:
		var chance = parties[party]["voters"] / population
		probabilities.append(chance)
	var percent = rng.randf()
	
	#get smallest probablity but preserve index
	var probability = 0

	var sum = 0
	var index
	for i in range(0, len(party_stacks)):
		if percent < probabilities.min() + sum:
			index = i
			break
		else:
			sum += probabilities.min()
			probabilities.erase(probabilities.min())

	#var i = rng.randi_range(0, len(party_stacks)-1)

	var i
	if not index:
		i = 0
	else:
		i = index

	if len(party_names) == 0:
		return
		
	party_stacks[party_names[i]].append(1)
	var voters = parties[party_names[i]]["voters"]
	var asset = parties[party_names[i]]["asset"]
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
		
func set(index, position):
	house_count += 1
	#object.set_global_position(position * GRID_SIZE)
	
	sprite_tiles.set_cell(position.x, position.y, index)

#
#	Deletion
#

func reduce_voters_to(n):

	var vert_copy = vertices.duplicate().keys()
	var p = len(vert_copy)
	while p > n:
		var choice = rng.randi() % vert_copy.size()
		vert_copy.pop_at(choice)
		p-=1
	return vert_copy
	#everything else should be gaps
	

func remove_house(): #turn to gap
	pass