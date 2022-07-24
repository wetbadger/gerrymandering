extends Control

var window = load("res://UI/Classes/Window.tscn")
var bShapePicker = load("res://UI/Panes/ShapePicker.tscn")
var state_name

func _on_Button_button_up():

	var w = window.instance()
	
	w.set_title("State Picker")
	
	var sp = bShapePicker.instance()
	sp.set_button(self)
	w.add_element(sp)
	
	position_window(w)

	get_tree().get_current_scene().add_child(w)
	
func set_state(state):
	var t = state.get_node("Area2D/Sprite").get_texture()
	var spr = get_node("Sprite")
	spr.texture = t
	spr.centered = false
	self.state_name = state.name
	
func _get_state():
	return state_name
	
func position_window(w):
	var viewport = get_viewport()
	var mouse_pos = get_global_mouse_position()

	var new_pos
	if mouse_pos.x >= viewport.size.x / 2:
		new_pos = Vector2(mouse_pos.x - w.get_node("PanelContainer").rect_size.x - 50, mouse_pos.y)
	elif mouse_pos.x < viewport.size.x / 2:
		new_pos = Vector2(mouse_pos.x + 50, mouse_pos.y)
		
	if mouse_pos.y >= viewport.size.y / 2 + 100:
		new_pos.y -= w.get_node("PanelContainer").rect_size.y - 50
	elif mouse_pos.y < viewport.size.y / 2:
		new_pos.y += 50
		
	w.set_global_position(new_pos)
