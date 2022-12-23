extends AudioStreamPlayer

#onready var volume = get_tree().get_current_scene().settings["Audio"]["Music"]

func _ready():
	pass
	
func set_volume(volume):
	volume_db = 5*log(volume)
