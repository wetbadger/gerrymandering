extends Pane

class_name AdvSettingsPane


#this node displays settings data and stores the control nodes to be harvested later
func _ready():
	
	rect_min_size.y = 400


func display_changeable_settings(settings, boxes):
	for key in settings:
		if typeof(settings[key]) == TYPE_BOOL:
			add_checkbox(key, settings[key])
		elif typeof(settings[key]) == TYPE_ARRAY:
			add_optmenu(key, settings[key])
		elif typeof(settings[key]) == TYPE_REAL:
			print("Slider")
			
	display_groups(settings)
