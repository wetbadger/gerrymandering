extends SpinBox

func _ready():
	var line_edit = get_line_edit()
	line_edit.add_color_override("font_color", Color(0,0,0,1))

