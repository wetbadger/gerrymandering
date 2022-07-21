extends VBoxContainer

var checked = false

func _ready():
	var pos = get_global_position()

func _on_Custom_button_up():
	get_tree().change_scene("res://Menus/CustomGameMenu/CustomGameMenu.tscn")

func _process(_delta):
	if get_viewport_rect().size.y > 2000 and not checked:
		for btn in get_children():
			btn.add_font_override("font", load("res://font/sans_big.tres"))

		checked = true
	elif get_viewport_rect().size.y <= 2000 and checked:
		for btn in get_children():
			btn.add_font_override("font", load("res://font/sans_norm.tres"))


		checked = false
		
	#rect_size = Vector2(get_viewport_rect().size.y/2, rect_size.x)
