extends ColorRect

var button #the buttoned that opened the picker window
var original_color = Color(0,0,0,1)

var can_click = false
var is_disable_color_change = false

var color_name

func set_color_name(color_name):
	self.color_name = color_name

func set_button(btn):
	self.button = btn
	
func set_button_color():
	original_color = button.get_node("ColorRect").color
	#button.get_node("ColorRect").color = color
	button.set_color(color, color_name)
	#set button to own color


func _on_ColorSquare_mouse_entered():
	if not is_disable_color_change:
		set_button_color()
		can_click = true


func _on_ColorSquare_mouse_exited():
	if not is_disable_color_change:
		button.get_node("ColorRect").color = original_color
		can_click = false

func _input(_event):
	if can_click and Input.is_action_just_released('click'):
		#is_disable_color_change = true
		get_parent().get_parent().get_parent().get_parent().close_window()
