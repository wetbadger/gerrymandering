extends Button

#var party_name
var type = "gap"
#var voters
var label
onready var scene = get_tree().get_current_scene()

func unselect_house(house_name):
	var state = get_tree().get_current_scene().get_node("State")
	if state.has_node(house_name):
		state.get_node(house_name).is_selected = false

func _on_GapButton_button_up():
	get_tree().set_input_as_handled()
	var buttons = get_tree().get_nodes_in_group("house_buttons")
	for b in buttons:
		if b != self:
			b.pressed = false
			unselect_house(b.name)
			
	scene.selected_house = self
