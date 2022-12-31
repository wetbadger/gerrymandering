extends Button


onready var scene = get_tree().get_current_scene()
onready var music = scene.get_node("MapTheme")
var settings
var pointer
var hardcoded = false #is the level hardcoded or in a file?
var button_up = false
var next_map
var next_settings 

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
			next_map = Levels.matrices[settings["pointer"][0]]
			next_settings = Levels.settings[settings["pointer"][0]]
			scene.map_name = pointer[0]
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

		var error = get_tree().change_scene("res://Game/main.tscn")
		if error:
			print("Could not load main scene")
