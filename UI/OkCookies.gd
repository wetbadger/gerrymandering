extends Button

func _on_Ok_button_up():

	if get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the main menu.")
