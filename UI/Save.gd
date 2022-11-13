extends Button

onready var scene = get_tree().get_current_scene()
var game_settings
var music

func _ready():

	scene = scene.get_children()[-1]


func new_game_folder(settings, text_box):
	var game_name
	if typeof(text_box) == TYPE_STRING:
		game_name = text_box
	else:
		game_name = text_box.text #settings["name"]
	var dir = Directory.new()
	dir.open("user://")
	var err = dir.make_dir(game_name)
	if err:
		print("Could not make directory")
		if err == 32:
			prompt_user_to_overwrite()
	
	var file = File.new()
	file.open("user://"+game_name+"/settings.json", File.WRITE)
	file.store_string(JSON.print(settings, "\t"))
	file.close()
	
	file.open("user://games.json", File.READ)
	var games = parse_json(file.get_as_text())
	if not game_name in games:
		games.push_front(game_name)
	else:
		games.erase(game_name)
		games.push_front(game_name)
	file.close()
	
	file.open("user://games.json", File.WRITE)
	file.store_string(JSON.print(games, "\t"))
	file.close()
	
	#TODO: display a success message
	
func get_options():
	var result = {}
	var panes = scene.panes
	for pane in panes:
		result[pane.name] = scene.settings[pane.name]
		if pane.name == "parties":
			result[pane.name] = {}
		else:
			result[pane.name] = scene.settings[pane.name]
		var group_name
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
					_:
						print("ERROR: menu widget not recognized!")

	return result
	
func prompt_user_to_overwrite():
	print("TODO: promt user to overwrite")


func _on_Save_button_up():
	game_settings = scene.settings
	var options = get_options()

	game_settings["shape"] = scene.state_name
	if typeof(scene.game_name) == TYPE_STRING:
		game_settings["name"]=scene.game_name #.text
	else:
		game_settings["name"]=scene.game_name.text
	game_settings["parties"]=options["parties"]
	game_settings["districts"]=options["districts"]
	game_settings["advanced"]=options["advanced"]
	
	#Globals.map_name = scene.game_name #.text
	
	var new_dict = game_settings.duplicate()
	new_dict["advanced"]["House Placement"] = scene.settings["advanced"]["House Placement"]
		
	new_game_folder(game_settings, scene.game_name)
	new_dict["advanced"]["House Placement"] = Globals.default_settings["advanced"]["House Placement"]
	var file = File.new()
	file.open("user://"+game_settings["name"]+"/settings.json", File.WRITE)
	file.store_string(JSON.print(new_dict, "  "))
	file.close()
	
