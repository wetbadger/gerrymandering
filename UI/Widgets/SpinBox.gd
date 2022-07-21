extends SpinBox

func _ready():
	var line_edit = get_line_edit()
	line_edit.add_color_override("font_color", Color(0,0,0,1))

func _process(_delta):
	if get_node("../Timer").is_stopped():
		editable = true

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP or event.button_index == BUTTON_WHEEL_DOWN:
			editable = false
			get_node("../Timer").start()
