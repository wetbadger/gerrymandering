extends Pane

class_name SettingsPane

#this node displays settings data and stores the control nodes to be harvested later



func display_changeable_settings(settings):
	print(settings)
	#get a dictionary of changeable settings such as 
#	{
#		"Red Party" : {"voters": 10, "asset": "res://pics/sprites/red_house.png", "color": "red"},
#		"Blue Party" : {"voters": 15, "asset": "res://pics/sprites/blue_house.png", "color": "blue"}
#	}
#	or
#	{
#		"District A" : {"min_size": 5, "max_size": 5, color: "red"}
#	}
	
	#create a label from key
	for s in settings:
		add_line(s)
		for key in settings[s]:
			if typeof(settings[s][key]) == TYPE_INT:
				add_spinbox(key, settings[s][key])
			elif key == "asset":
				add_sprite_picker(settings[s][key])
			elif key == "color":
				var col_arr = get_node("/root/Globals").default_settings["colors"][settings[s]["color"]]
				var color = Color(col_arr[0], col_arr[1], col_arr[2])
				add_color_picker(color)
	#for ints create a label and spinbox
	#for filepaths ending in .png create a spritepicker
	#for colors create a color picker
	#for text create a lineedit
	#for arrays create and option box
	display_groups()
	pass
