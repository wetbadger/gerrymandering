extends Button


func _on_TryAgain_button_up():
	var scene = get_tree().get_current_scene()
	for district in scene.district_button_names:
		scene.remove_district(district)
	scene.get_node("Darkening").lighten()
	scene.get_node("UI/Deselect").visible = true
	scene.recieve_input = true
	scene.submit_button.visible = true
	get_parent().get_parent().visible = false
	if scene.settings["advanced"]["District Rules"]["multiplayer"]:
		scene.submit_button.set_mode_multiplayer()
	scene.firework_limit = scene.FIREWORK_LIMIT
	if scene.settings.has("tutorial"):
		var nxt_btn = scene.victory_node.next
		if nxt_btn.disabled == true:
			scene.initiate_tutorial(scene.settings["tutorial"])
			scene.t1.get_node("Tutorial1Dialog").dialog_array[1] = """Hmm, we lost. Try thinking of it this way:
3 of us and 2 of them, 4 of us and 1 of them, 
none of us 5 of them.
"""
			scene.t1.get_node("Tutorial1Dialog").next()
