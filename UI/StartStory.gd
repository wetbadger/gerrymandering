extends Button




func _on_Start_button_up():
	Input.set_custom_mouse_cursor(Globals.pointer)
	var error = get_tree().change_scene("res://Map/TutorialMap.tscn")
	if error:
		print("There was an error in StartStory.gd")
