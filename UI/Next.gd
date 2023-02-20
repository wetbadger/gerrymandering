extends Button


onready var scene = get_tree().get_current_scene()
#onready var music = scene.get_node("MapTheme")
var settings
var pointer
var hardcoded = false #is the level hardcoded or in a file?
var button_up = false
var next_maps

func _ready():
	set_process(false)
	
func init(_hardcoded=false):
	self.hardcoded = _hardcoded
	settings = scene.settings
	pointer = settings["pointer"]
	if pointer == null:
		text = "End Game"
		return
	if len(pointer) == 1:
		if hardcoded:
			#unlock these maps
			next_maps = settings["pointer"]

		else:
			print("TODO: non-hardcoded pointers")
	#TODO: multiple pointers
	#return to map and have user decide


func _on_NewPuzzle_button_up():
	#TODO: cool animation
	button_up = true
	set_process(true)

func _process(_delta):
	
	if button_up:
		if text == "End Game":
			#TODO: create special victory screen
			var error = get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn")
			if error:
				print("Could not load main menu")
		else:
			for node in settings["pointer"]:
				Globals.map_progress["Tutoria"][node] = true
			var error = get_tree().change_scene("res://Map/TutorialMap.tscn")
			if error:
				print("Could not load map scene")
