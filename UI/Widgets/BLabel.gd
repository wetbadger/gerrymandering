extends Label

export var id = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_color(color):
	set("custom_colors/font_color", Globals.word2color(color))
