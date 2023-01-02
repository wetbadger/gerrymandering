extends Node2D

onready var window = $Window
var label = load("res://UI/Widgets/BLabel.tscn")

func _ready():
	window.set_title("    Tutorial!")
	var lbl = label.instance()
	lbl.set_text("    I'm Sally the Salamander!\n\n    I'm here to teach you\n    about redistricting!")
	window.add_element(lbl)
	
