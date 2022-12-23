extends Button

var deselect = false
var last_button
onready var scene = get_tree().get_current_scene()
onready var district_buttons = get_tree().get_current_scene().get_node("UI/Scroll/DistrictButtons")
onready var house_buttons = get_tree().get_current_scene().get_node("UI/Scroll2/HouseButtons")

func _ready():
	pass

func _on_Deselect_toggled(button_pressed):
	get_tree().set_input_as_handled()
	if scene.draw_mode == scene.DRAW_MODES.ADD or scene.draw_mode == scene.DRAW_MODES.ERASE:
		toggle_buttons(district_buttons)
	else:
		toggle_buttons(house_buttons)
			
func toggle_buttons(button_container):
	if !deselect:
		scene.disable_draw = true
		for btn in button_container.get_children():
			if btn.pressed == true:
				last_button = btn
				break
	else:
		#TODO: change focus back to button
		last_button.pressed = true
		scene.disable_draw = false
	
	deselect = !deselect
	scene.deselect_is_on = deselect
	if deselect:
		for btn in button_container.get_children():
			btn.pressed = false
			btn.disabled = true
	else:
		for btn in button_container.get_children():
			btn.disabled = false



func _on_Deselect_button_down():
	toggle_mode = true
