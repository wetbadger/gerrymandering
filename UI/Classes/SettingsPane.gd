extends Pane

class_name SettingsPane

var collections = []

#this node displays settings data and stores the control nodes to be harvested later
func _ready():
	rect_min_size.y = 400

func display_changeable_settings(settings, boxes, icon_grid_size=2, index = 0):
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
	var i = index
	for s in settings:
		if i < len(boxes): #TODO: find out what causes settings to have too many things
			collections.append(boxes[i])
			if typeof(s) == TYPE_STRING:
				boxes[i].add_line(s)
				rect_min_size.y += 65
			if boxes[i].is_read_only == true:
				boxes[i].set_read_only(true)
			
			
			#for ints create a label and spinbox
			#for filepaths ending in .png create a spritepicker
			#for colors create a color picker
			#for text create a lineedit
			#for arrays create and option box

			for key in settings[s]:
				
				if typeof(settings[s][key]) == TYPE_INT:
					boxes[i].add_spinbox(key, settings[s][key])
					#rect_min_size.y += 65
				elif key == "asset":
					boxes[i].add_sprite_picker(settings[s][key])
					#rect_min_size.y += 25
				elif key == "color": #TODO put asset and color on one hbox
					#var col_arr = get_node("/root/Globals").default_settings["colors"][settings[s]["color"]]
					#var color = Color(col_arr[0], col_arr[1], col_arr[2])
					boxes[i].add_color_picker(settings[s]["color"])
					#rect_min_size.y += 65
				elif typeof(settings[s][key]) == TYPE_BOOL:
					boxes[i].add_checkbox(key, settings[s][key])
					#rect_min_size.y += 65
				elif typeof(settings[s][key]) == TYPE_ARRAY:
					boxes[i].add_optmenu(key, settings[s][key])
					#rect_min_size.y += 65
				elif typeof(settings[s][key]) == TYPE_REAL:
					print("Slider")
				
		i += 1

				
	add_plus_or_minus(self.name, self)
	display_groups(collections, icon_grid_size)
	
