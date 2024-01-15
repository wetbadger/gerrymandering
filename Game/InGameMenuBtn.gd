extends Button

var menu = load("res://Menus/InGameMenu/InGameMenu.tscn")

onready var scene = get_tree().get_current_scene()
onready var ui = scene.get_node("UI")

func _on_InGameMenuBtn_button_up():
	var m = menu.instance()
	ui.add_child(m)
	m.set_position(Vector2(650,300))
	disabled = true
	scene.disable_draw = true
