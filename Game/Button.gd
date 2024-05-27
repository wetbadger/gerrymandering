extends Button

var menu = load("res://Menus/InGameMenu/InGameMenu.tscn")
onready var scene = get_tree().get_current_scene()



func _on_InGameMenu_button_up():
	var m = menu.instance()
	scene.add_child(m)
