extends Button

var color
var color_val

func _ready():
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


func set_color(color_arr):
	for one_key in color_arr:
		color = one_key
	
	color_val = Color(color_arr[color][0],color_arr[color][1],color_arr[color][2])
	var new_stylebox_normal = get_stylebox("normal").duplicate()
	new_stylebox_normal.bg_color = color_val
	add_stylebox_override("normal", new_stylebox_normal)
	
	var new_stylebox_hover = get_stylebox("hover").duplicate()
	new_stylebox_hover.bg_color = color_val
	add_stylebox_override("hover", new_stylebox_hover)
	
	var new_stylebox_pressed= get_stylebox("pressed").duplicate()
	new_stylebox_pressed.bg_color = Color(color_arr[color][0]-.2,color_arr[color][1]-.2,color_arr[color][2]-.2)
	add_stylebox_override("pressed", new_stylebox_pressed)
