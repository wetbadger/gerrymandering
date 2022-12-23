extends Pane

class_name SettingsPane

var collections = []

#this node displays settings data and stores the control nodes to be harvested later
func _ready():
	rect_min_size.y = 400

func display_changeable_settings(settings, boxes, index = 0):

	var i = index
	for s in settings:
		if i < len(boxes):
			collections.append(boxes[i])
			if typeof(s) == TYPE_STRING:
				boxes[i].add_line(s)
				rect_min_size.y += 65
			if boxes[i].is_read_only == true:
				boxes[i].set_read_only(true)

			for key in settings[s]:
				
				if typeof(settings[s][key]) == TYPE_INT:
					boxes[i].add_spinbox(key, settings[s][key])

				elif key == "asset":
					boxes[i].add_sprite_picker(settings[s][key])

				elif key == "color":
					boxes[i].add_color_picker(settings[s]["color"])

				elif typeof(settings[s][key]) == TYPE_BOOL:
					boxes[i].add_checkbox(key, settings[s][key])

				elif typeof(settings[s][key]) == TYPE_ARRAY:
					boxes[i].add_optmenu(key, settings[s][key])

				elif typeof(settings[s][key]) == TYPE_REAL:
					#TODO: make a slider widget
					#Will be used for sound
					boxes[i].add_slider(key, settings[s][key])
				
		i += 1

				
	add_plus_or_minus(self.name, self)
	display_groups(collections)
	
