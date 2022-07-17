extends Control

var color_picker = load("res://UI/MyColorPicker.tscn")
var sprite
var color

func _ready():
	pass
	
func set_color(color_name):
	self.color = color_name
	var col_arr = get_node("/root/Globals").default_settings["colors"][color_name]
	var c = Color(col_arr[0],col_arr[1],col_arr[2])
	get_node("ColorRect").color = c


func _on_Button_button_up():
	print("pick a color")
