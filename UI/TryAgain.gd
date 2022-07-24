extends Button


func _on_TryAgain_button_up():
	var scene = get_tree().get_current_scene()
	for district in scene.district_button_names:
		scene.remove_district(district)
	scene.get_node("Darkening").lighten()
	scene.recieve_input = true
	scene.submit_button.visible = true
	get_parent().get_parent().visible = false
