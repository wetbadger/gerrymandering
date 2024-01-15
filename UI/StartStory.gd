extends Button




func _on_Start_button_up():
	var error = get_tree().change_scene("res://Map/TutorialMap.tscn")
	if error:
		print("There was an error in StartStory.gd")
