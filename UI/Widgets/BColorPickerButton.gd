extends Control

var window = load("res://UI/Classes/Window.tscn")
var bColorPicker = load("res://UI/Panes/ColorPicker.tscn")

func _on_Button_button_up():
	var w = window.instance()
	
	w.set_title("Color Picker")
	
	var bc = bColorPicker.instance()
	bc.set_button(self)
	w.add_element(bc)
	
	w.position_window(get_viewport())
	get_tree().get_current_scene().add_child(w)
	
func set_color(color):
	get_node("ColorRect").color = color
