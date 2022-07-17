extends Label

func _ready():
	pass


func set_border_color(color):
	get_font("font").outline_color = color
