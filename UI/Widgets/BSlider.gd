extends HBoxContainer

var normal_theme
var mouseover_theme

var can_click = false
var label_name
var label

onready var scene = get_tree().get_current_scene()

func _ready():
	get_node("Label").add_color_override("font_color", Color(1,1,1,1))

func set_text(text):
	get_node("Label").set_text(text)
	label = text

func set_label_name(text):
	label_name = text

func get_text():
	return get_node("Label").text
	
func set_value(value):
	get_node("HSlider").set_value(value)
	
func get_value():
	return get_node("HSlider").value


func _on_HSlider_value_changed(value):
	scene.change_value(self)
