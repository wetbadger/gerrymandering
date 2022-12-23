extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var scene = get_tree().get_current_scene()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_options():
	var result = {}
	var menu = scene.get_node("SettingsMenu")
	var panes = menu.panes
	var group_name
	for pane in panes:
		result[pane.name] = scene.settings
		for box in pane.boxes:
			for group in box.groups:
			
				match group[0]:
					"line":
						group_name = group[-1].get_text()
					"number":
						if not result[pane.name].has(group_name):
							result[pane.name][group_name] = {}
						result[pane.name][group_name][group[1]] = group[-1].get_node("SpinBox").get_value()
					"bool":
						result[pane.name][group_name][group[1]] = group[-1].is_pressed()
					"list":
						result[pane.name][group_name][group[1]] = group[-1].get_item_text(group[-1].get_selected())
					"color":
						result[pane.name][group_name]["color"] = group[-1]._get_color()
					"asset":
						result[pane.name][group_name]["asset"] = group[-1].sprite_index
					"slider":
						result[pane.name][group_name][group[1]] = group[-1].get_value()
					_:
						print("ERROR: menu widget not recognized!")
 
	return result


func _on_Apply_button_up():
	var settings = scene.settings
	var options = get_options()
	var new_dict = settings.duplicate()
	var file = File.new()
	var settings_to_save = new_dict.duplicate(true)
	#return arrays to array format TODO:clean this mess
	var orientation = ["sensor","portrait","landscape"]
	orientation.erase(settings_to_save["Video"]["Orientation"])
	orientation.push_front(settings_to_save["Video"]["Orientation"])
	var resolution = ["1920x1080"]
	resolution.erase(settings_to_save["Video"]["Resolution"])
	resolution.push_front(settings_to_save["Video"]["Resolution"])
	settings_to_save["Video"]["Orientation"] = orientation
	settings_to_save["Video"]["Resolution"] = resolution
	file.open("user://settings.json", File.WRITE)
	file.store_string(JSON.print(settings_to_save, "\t"))
	file.close()
