extends Control

class_name Dialog

var dialog_array = []
var dialog_index = 0

onready var map = get_tree().get_current_scene()

var state = 0

var nodes = []
var mouse_down = true

export var event_based = false

func _ready():
	pass

func set_text(text):
	$DialogBox.set_text(text)
	
func read_text_array(i):
	set_text(dialog_array[i])
	if (i == len(dialog_array) - 1):
		for node in nodes:
			node.enable()
			var line = node.get_node("Line2D")
			if line:
				line._draw_line()
		state+=1
		
func _input(event):
	if not event_based: #no event has to happen, just click to update text
		if (event is InputEventKey or event is InputEventScreenTouch) and (dialog_index+1 < len(dialog_array)):
			
			if event.pressed:
				dialog_index+=1
				read_text_array(dialog_index)
					
			if mouse_down:
				mouse_down = false
			else:
				mouse_down = true

func add_node(node):
	nodes.append(node)
