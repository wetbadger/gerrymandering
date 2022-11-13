extends Button



func _on_Nevermind_button_up():
	Globals.save_progress = false
	if get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the main menu.")
