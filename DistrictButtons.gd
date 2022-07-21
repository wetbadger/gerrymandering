extends VBoxContainer

var button = load("res://UI/PalletteButton.tscn")

func load_buttons(districts):
	var selected_district = get_tree().get_current_scene().selected_district
	#number of districts
	#todo change with settings
	#var n_districts = get_tree().get_current_scene().get_width()

	for b in districts:
		var new_button = button.instance()
		new_button.text = str(districts[b]["max_size"])
		add_child(new_button)
		new_button.set_name(b)
		new_button.set_color(districts[b]["color"])
		if b == selected_district:
			new_button.pressed = true
		new_button.add_to_group("district_buttons")
		


		
