extends Node2D

onready var window = $Window
var label = load("res://UI/Widgets/BLabel.tscn")

func _ready():
	window.set_title("Gerrymandered!")
	var lbl = label.instance()
	lbl.set_text("""TODO: insert informative tutorial here.""")
	window.add_element(lbl)
	
