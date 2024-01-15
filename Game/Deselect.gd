extends Button

var deselect = false
var last_button
onready var scene = get_tree().get_current_scene()
onready var district_buttons = get_tree().get_current_scene().get_node("UI/Scroll/DistrictButtons")
onready var house_buttons = get_tree().get_current_scene().get_node("UI/TabContainer/Houses/HouseButtons")

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
		Input.set_custom_mouse_cursor(Globals.openhand)
		scene.disable_draw = true
		for btn in button_container.get_children():
			if btn.pressed == true:
				last_button = btn
				break
		scene.matrix.voter_indicators.visible = true
	else:
		if last_button == null:
			last_button = house_buttons.get_children()[0]
		last_button.pressed = true
		Input.set_custom_mouse_cursor(Globals.pointer)
		scene.disable_draw = false
		if scene.draw_mode != scene.DRAW_MODES.PLACE and scene.draw_mode != scene.DRAW_MODES.REMOVE:
			scene.matrix.voter_indicators.visible = false
	
	deselect = !deselect
	scene.deselect_is_on = deselect
	if deselect:
		for btn in button_container.get_children():
			if btn.name != "Blank":
				btn.pressed = false
				btn.disabled = true
	else:
		if scene._multiplayer:
			scene.enable_selected_district()
		else:
			for btn in button_container.get_children():
				if btn.name != "Blank":
					btn.disabled = false



func _on_Deselect_button_down():
	toggle_mode = true


func _on_Deselect_mouse_entered():
	Input.set_custom_mouse_cursor(Globals.hand)


func _on_Deselect_mouse_exited():
	if scene.disable_draw:
		Input.set_custom_mouse_cursor(Globals.openhand)
	else:
		Input.set_custom_mouse_cursor(Globals.pointer)
