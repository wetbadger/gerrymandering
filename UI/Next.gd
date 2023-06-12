extends Button


onready var scene = get_tree().get_current_scene()
#onready var music = scene.get_node("MapTheme")
var settings
var pointer
var hardcoded = false #is the level hardcoded or in a file?
var button_up = false

var map_name
var map_scene

func _ready():
	set_process(false)
	
func init(_hardcoded=false):
	self.hardcoded = _hardcoded
	settings = scene.settings
	pointer = settings["pointer"]
	if pointer == null:
		text = "End Game"
		return


func _on_NewPuzzle_button_up():
	#TODO: cool animation
	button_up = true
	set_process(true)

func _process(_delta):
	
	if button_up:
		if text == "End Game":
			if Globals.map_progress.has(Globals.current_map["name"]):
				Globals.map_progress[Globals.current_map["name"]]["completed"] = true
			var error = get_tree().change_scene("res://UI/EndGame/EndGame.tscn")
			
			if error:
				print("Could not load main menu")
		else:
			var error = get_tree().change_scene(Globals.current_map["scene"])
			if error:
				print("Could not load map scene")
