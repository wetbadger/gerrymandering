extends VBoxContainer

var button = load("res://UI/PalletteButton.tscn")

func load_buttons(n_districts, colors, n_houses):
	var selected_district = get_tree().get_current_scene().selected_district
	#number of districts
	#todo change with settings
	#var n_districts = get_tree().get_current_scene().get_width()
	var c = 65
	for b in range(n_districts):
		var new_button = button.instance()
		new_button.text = str(n_houses)
		add_child(new_button)
		new_button.set_name(char(c))
		new_button.set_color(colors[b])
		if char(c) == selected_district:
			new_button.pressed = true
		new_button.add_to_group("district_buttons")
		c+=1
		


		
