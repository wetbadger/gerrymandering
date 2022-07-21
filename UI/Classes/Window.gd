extends Node2D

class_name Window

func _ready():
	var windows_open = get_tree().get_current_scene().windows_open
	if len(windows_open) >= get_tree().get_current_scene().max_windows_open:
		queue_free()
	else:
		windows_open.append(self)

func add_element(elem, scale=1):
	get_node("PanelContainer").add_child(elem)
	
func set_title(text):
	get_node("TitleBar").get_node("HBoxContainer/Bar/Label").set_text(text)
	
func close_window():
	get_tree().get_current_scene().windows_open.erase(self)
	queue_free()
