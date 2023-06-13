extends Node2D


onready var window = get_node("Window")
onready var text = get_node("Window/ScrollContainer/Label")

func _ready():
	window.set_title("About Gerrymandering")
	window.set_width(1000)
	window.set_min_height(800)
