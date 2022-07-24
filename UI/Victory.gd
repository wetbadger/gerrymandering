extends Control

onready var scene = get_tree().get_current_scene()

func _ready():
	pass # Replace with function body.


func _on_Winner_mouse_entered():
	pass # Replace with function body.


func _on_ColorRect_mouse_entered():
	print("mouse_entered")
	scene.get_node("State/Camera2D").set_can_zoom(false)


func _on_ColorRect_mouse_exited():
	scene.get_node("State/Camera2D").set_can_zoom(true)
