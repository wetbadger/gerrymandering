extends Label

export var id = ""
export var custom_text = "This is a BLabel!"

func _ready():
	pass

func set_color(color):
	set("custom_colors/font_color", Globals.word2color(color))

