extends Control

onready var scene = get_tree().get_current_scene()
onready var ui = scene.get_node("UI")
var alert = load("res://Menus/SavedAlert.tscn")

func _ready():
	connect_cursor_signals()

func remove_save():
	$Panel/VBoxContainer/Save.queue_free()

func _on_QuitToDesktop_button_up():
	get_tree().quit()

func _on_QuitToMainMenu_button_up():
	get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn")

func _on_Resume_button_up():
	queue_free()
	scene.in_game_menu_button.disabled = false
	scene.disable_draw = false

func _on_Save_button_up():
	
	var cam = scene.camera
	var zoom = scene.camera.zoom.x
	var pos = [scene.camera.position.x, scene.camera.position.y]
	var new_settings = scene.settings #might not need dupicate()
	var terrain = scene.terrain_file
	
	new_settings["camera"] = {}
	new_settings["camera"]["zoom"] = zoom
	new_settings["camera"]["position"] = pos
	
	#Fill in other values for house placement array
	new_settings = fix_arrays(new_settings)
	
	var dir = Directory.new()
	if not dir.dir_exists("user://"+scene.settings.name):
		dir.make_dir("user://"+scene.settings.name)
		
	var file1 = File.new()
	file1.open("user://"+scene.settings.name+"/settings.json", File.WRITE)
	file1.store_line(JSON.print(new_settings, "\t"))
	file1.close()
	var file2 = File.new()
	file2.open("user://"+scene.settings.name+"/matrix.json", File.WRITE)
	file2.store_line(JSON.print(scene.matrix.vertices,"\t"))
	file2.close()
	#TODO: save positions of districts if there are any
	print(scene.settings.name + " has been saved.")
	var a = alert.instance()
	
	var file3 = File.new()
	file3.open("user://games.json", File.READ)
	var games = parse_json(file3.get_as_text())
	if not scene.settings.name in games:
		games.append(scene.settings.name)
	file3.close()
	file3.open("user://games.json", File.WRITE)
	file3.store_string(JSON.print(games, "\t"))
	file3.close()
	
	scene.save_terrain()
	
	ui.add_child(a)
	a.set_position(Vector2(580,380))
	a.set_text(scene.settings.name + " has been saved.")

func fix_arrays(settings):
	#get arrays from global settings
	var algorithm_arr = Globals.default_settings["advanced"]["House Placement"]["algorithm"]
	var layout_arr = Globals.default_settings["advanced"]["House Placement"]["layout"]
	#get the current value of the select menu
	var algorithm_value = settings["advanced"]["House Placement"]["algorithm"]
	var layout_value = settings["advanced"]["House Placement"]["layout"]
	#put our current map's value at the front of the array an erase the duplicate
	algorithm_arr.erase(algorithm_value)
	algorithm_arr.push_front(algorithm_value)
	layout_arr.erase(layout_value)
	layout_arr.push_front(layout_value)
	#write the new arrays to the settings
	settings["advanced"]["House Placement"]["algorithm"] = algorithm_arr
	settings["advanced"]["House Placement"]["layout"] = layout_arr
	return settings

func connect_cursor_signals():
	for btn in get_node("Panel/VBoxContainer").get_children():
		if btn.disabled == true:
			continue
		#connect mouseover signals
		if btn.connect('mouse_entered', self, '_on_mouse_entered') != OK:
			print("Error: mouse enter signal not connected")
		if btn.connect('mouse_exited', self, '_on_mouse_exited') != OK:
			print("Error: mouse exit signal not connected")
			
func _on_mouse_entered():
	Input.set_custom_mouse_cursor(Globals.hand)
	
func _on_mouse_exited():
	Input.set_custom_mouse_cursor(Globals.pointer)
