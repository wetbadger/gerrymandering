extends Node2D

#this is just a sprite
#for house properties see ...

var houses = [load("res://pics/sprites/house1.png"), load("res://pics/sprites/house2.png"), load("res://pics/sprites/house3.png")]
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var house = houses[rng.randi_range(0, 2)]
	get_node("Sprite").texture = house
	
func set_asset(asset):
	if typeof(asset) == TYPE_INT:
		pass
	else:
		get_node("Sprite").texture = asset