extends Control

class_name Window

func add_element(elem):
	get_node("PanelContainer").add_child(elem)
	
func set_title(text):
	get_node("TitleBar").get_node("HBoxContainer/Bar/Label").set_text(text)
	
func position_window(viewport):
	var mouse_pos = get_global_mouse_position()

	var new_pos
	if mouse_pos.x >= viewport.size.x / 2:
		new_pos = Vector2(mouse_pos.x - 50, mouse_pos.y)
	elif mouse_pos.x < viewport.size.x / 2:
		new_pos = Vector2(mouse_pos.x + 50, mouse_pos.y)
		
	if mouse_pos.y >= viewport.size.y / 2:
		new_pos.y -= 50
	elif mouse_pos.y < viewport.size.y / 2:
		new_pos.y += 50
		
	set_global_position(new_pos)

