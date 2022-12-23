extends AudioStreamPlayer

var volume = 0.0

func _ready():
	pass # Replace with function body.



func set_volume(_volume):
	volume_db = 5*log(_volume)
	volume = volume
