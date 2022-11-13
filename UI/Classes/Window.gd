extends Node2D

class_name Window

var menu

func _ready():
	menu = get_tree().get_current_scene().get_node("CustomGameMenu")
	var windows_open = menu.windows_open
	if len(windows_open) >= menu.max_windows_open:
		queue_free()
	else:
		windows_open.append(self)

func add_element(elem, _scale=1):
	get_node("PanelContainer").add_child(elem)
	
func set_title(text):
	get_node("TitleBar").get_node("HBoxContainer/Bar/Label").set_text(text)
	
func close_window():
	menu.windows_open.erase(self)
	queue_free()
