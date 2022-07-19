extends HBoxContainer

var normal_theme = load("res://UI/Widgets/BThemeSpinBox.tres")
var mouseover_theme = load("res://UI/Widgets/BThemeSpinBoxHover.tres")

var can_click = false

func set_text(text):
	get_node("Label").set_text(text)

func get_text():
	return get_node("Label").text
	
func set_value(value):
	get_node("SpinBox").set_value(value)
	
func get_value():
	return get_node("SpinBox").value

func set_hover_theme():
	set_theme(mouseover_theme)
	can_click = true
	get_node("Label").add_color_override("font_color", Color(1,1,1,1))

func set_normal_theme():
	set_theme(normal_theme)
	can_click = false
	get_node("Label").add_color_override("font_color", Color(1,1,1,1))

func _on_Control_mouse_entered():
	set_hover_theme()


func _on_Control_mouse_exited():
	set_normal_theme()


func _on_SpinBox_mouse_entered():
	set_hover_theme()


func _on_SpinBox_mouse_exited():
	set_normal_theme()
	
func _input(_event):
	if Input.is_action_just_released("click"):
		if can_click:
			get_node("SpinBox").get_line_edit().select_all()
			get_node("SpinBox").get_line_edit().grab_focus()
