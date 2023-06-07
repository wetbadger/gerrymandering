extends VBoxContainer

#this is a comment

var button = load("res://UI/PalletteButton.tscn")

func load_buttons(districts):
	var selected_district = get_tree().get_current_scene().selected_district
	#number of districts
	#todo change with settings
	#var n_districts = get_tree().get_current_scene().get_width()
	var pressed_first_button = false
	for b in districts:
		
		var new_button = button.instance()
		new_button.text = str(districts[b]["max"])
		add_child(new_button)
		new_button.set_name(b)
		new_button.set_color(districts[b]["color"])
		if not pressed_first_button:
			pressed_first_button = true
			new_button.pressed = true
		if b == selected_district: #possibly redundant
			new_button.pressed = true
		new_button.add_to_group("district_buttons")
		
