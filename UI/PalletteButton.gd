extends Button

var color_val
var can_right_click = false #right click to remove the district
var camera

func _ready():
	camera = get_tree().get_current_scene().get_node("State/Camera2D")
	set_focus_mode(1)


func _on_Button_button_up():
	var buttons = get_tree().get_nodes_in_group("district_buttons")
	for b in buttons:
		if b != self:
			b.pressed = false
			unselect_district(b.name)
			
	get_tree().get_current_scene().selected_district = self.name
	
func unselect_district(district_name):
	var state = get_tree().get_current_scene().get_node("State")
	if state.has_node(district_name):
		state.get_node(district_name).is_selected = false

func set_color(color):
	
	var color_from_str = Globals.word2color(color)

	var new_stylebox_normal = get_stylebox("normal").duplicate()
	new_stylebox_normal.bg_color = color_from_str
	add_stylebox_override("normal", new_stylebox_normal)
	
	var new_stylebox_hover = get_stylebox("hover").duplicate()
	new_stylebox_hover.bg_color = color_from_str
	add_stylebox_override("hover", new_stylebox_hover)
	
	var new_stylebox_pressed= get_stylebox("pressed").duplicate()
	
	new_stylebox_pressed.bg_color = color_from_str #- Color(.2,.2,.2)
	add_stylebox_override("pressed", new_stylebox_pressed)


func _on_Button_mouse_entered():
	can_right_click = true
	camera.set_can_zoom(false)


func _on_Button_mouse_exited():
	can_right_click = false
	camera.set_can_zoom(true)
	
func _input(event):
	if can_right_click:
		if Input.is_mouse_button_pressed(BUTTON_RIGHT):
			var n = get_tree().get_current_scene().remove_district(name)
			text = str(n)
