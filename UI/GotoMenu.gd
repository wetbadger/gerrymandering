extends Button




func _on_GotoMenu_button_up():
	Input.set_custom_mouse_cursor(Globals.pointer)
	get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn")


func _on_GotoMenu_mouse_entered():
	Input.set_custom_mouse_cursor(Globals.hand)


func _on_GotoMenu_mouse_exited():
	Input.set_custom_mouse_cursor(Globals.pointer)
