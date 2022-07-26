extends Button

onready var scene = get_tree().get_current_scene()
var game_settings

func _on_Start_button_up():
	game_settings = scene.settings
	var options = get_options()

	game_settings["shape"] = scene.state_name
	game_settings["name"]=scene.game_name.text
	game_settings["parties"]=options["parties"]
	game_settings["districts"]=options["districts"]
	game_settings["advanced"]=options["advanced"]
	

	var globals = get_node("/root/Globals")
	globals.map_name = scene.game_name.text
	
	new_game_folder(game_settings)
	var error = get_tree().change_scene("res://Game/main.tscn")
	if error:
		print("Could not load main scene")

func new_game_folder(settings):
	var game_name = settings["name"]
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
	
func get_options():
	var result = {}
	var panes = get_tree().get_current_scene().panes
	for pane in panes:
		result[pane.name] = {}
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
						result[pane.name][group[1]] = group[-1].is_pressed()
					"list":
						result[pane.name][group[1]] = group[-1].get_item_text(group[-1].get_selected())
					"color":
						result[pane.name][group_name]["color"] = group[-1]._get_color()
					"asset":
						result[pane.name][group_name]["asset"] = group[-1].sprite_index

	return result
		

#func get_party_options():
#	var result = {}
#	var parties = get_tree().get_current_scene().get_node("CenterContainer/TabContainer/Game/Grid/Parties")
#	var i = 0
#	while i < parties.party_count:
#		var p_name = parties.get_textbox_name(i)
#		result[p_name] = {}
#		result[p_name]["voters"] = parties.get_spinbox_voters(i)
#		result[p_name]["color"] = parties.get_picker_color(i)
#		result[p_name]["asset"] = parties.get_asset(i)
#		i+=1
#	return result
	
func prompt_user_to_overwrite():
	print("TODO: promt user to overwrite")
