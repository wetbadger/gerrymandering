extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var houses = [load("res://pics/house1.png"), load("res://pics/house2.png"), load("res://pics/house3.png")]
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var house = houses[rng.randi_range(0, 2)]
	get_node("Sprite").texture = house
	print("House Created")

func input_event(event):
	print(event)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
