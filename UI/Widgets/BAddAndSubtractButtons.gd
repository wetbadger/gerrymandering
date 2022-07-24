extends HBoxContainer

var add_scene
var subtract_scene

func set_add(packed_scene):
	add_scene = packed_scene

func set_subtract(scene_instance):
	subtract_scene = scene_instance

func _on_BAddButton_button_up():
	add_scene.add()


func _on_BSubtractButton_button_up():
	subtract_scene.subtract()
