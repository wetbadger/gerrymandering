extends Pane

class_name SettingsPane

#this node displays settings data and stores the control nodes to be harvested later
func _ready():
	rect_min_size.y = 400


func display_changeable_settings(settings, icon_grid_size=2):
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
		rect_min_size.y += 25
		
		#for ints create a label and spinbox
		#for filepaths ending in .png create a spritepicker
		#for colors create a color picker
		#for text create a lineedit
		#for arrays create and option box

		for key in settings[s]:

			if typeof(settings[s][key]) == TYPE_INT:
				add_spinbox(key, settings[s][key])

			elif key == "asset":
				add_sprite_picker(settings[s][key])

			elif key == "color": #TODO put asset and color on one hbox
				#var col_arr = get_node("/root/Globals").default_settings["colors"][settings[s]["color"]]
				#var color = Color(col_arr[0], col_arr[1], col_arr[2])
				add_color_picker(settings[s]["color"])
			rect_min_size.y += 60
	
	display_groups(settings, icon_grid_size)
	
