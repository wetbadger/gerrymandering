extends Button


onready var scene = get_tree().get_current_scene()

var settings
var pointer

func _ready():
	pass
	
func init():
	settings = scene.settings
	pointer = settings["pointer"]
	if pointer == null:
		text = "End Game"


func _on_NewPuzzle_button_up():
	print(pointer)
