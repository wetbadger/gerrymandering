extends Control

var extension = 0

func _ready():
	var parent_size = get_parent().get_node("PanelContainer").rect_size
	focus_mode = 0
	rect_size = Vector2(50, 50)
	rect_min_size = Vector2(50, 50)
	get_node("HBoxContainer/Bar").rect_min_size.x = parent_size.x - get_node("HBoxContainer/Close").rect_size.x + extension



func _on_Close_button_up():
	get_parent().close_window()
