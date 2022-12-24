extends Button

var color_val
var can_right_click = false #right click to remove the district
var camera

onready var scene = get_tree().get_current_scene()

var mouse_in

var turn_ended = false

func _ready():
	camera = scene.get_node("State/Camera2D")
	set_focus_mode(1)


func _on_Button_button_up():
	get_tree().set_input_as_handled()
	var buttons = get_tree().get_nodes_in_group("district_buttons")
	for b in buttons:
		if b != self:
			b.pressed = false
			unselect_district(b.name)
			
	scene.selected_district = self.name

func _input(event):
	if event is InputEventScreenTouch and disabled and mouse_in and event.is_pressed():
		var deselect_button = scene.get_node("UI/Deselect")
		deselect_button.pressed = false

func unselect_district(district_name):
	var state = scene.get_node("State")
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
			
func _on_Button_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
#	        BUTTON_LEFT:
#	            # left button clicked
			BUTTON_RIGHT:
				var n = scene.remove_district(name)
				text = str(n)

#
# While disabled click to undisable
#

func _on_Button_mouse_entered():
	mouse_in = true


func _on_Button_mouse_exited():
	mouse_in = false
