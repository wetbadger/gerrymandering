extends Node2D

class_name Window

var menu

onready var scene = get_tree().get_current_scene()

func _ready():
	if scene.has_node("CustomeGameMenu"):
		menu = scene.get_node("CustomGameMenu")
		if is_instance_valid(menu):
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
	if is_instance_valid(menu):
		menu.windows_open.erase(self)
	queue_free()
	
func position_window():
	var viewport = get_viewport()
	var mouse_pos = get_global_mouse_position()

	var new_pos
	if mouse_pos.x >= viewport.size.x / 2:
		new_pos = Vector2(mouse_pos.x - self.get_node("PanelContainer").rect_size.x - 50, mouse_pos.y)
	elif mouse_pos.x < viewport.size.x / 2:
		new_pos = Vector2(mouse_pos.x + 50, mouse_pos.y)
		
	if mouse_pos.y >= viewport.size.y / 2 + 100:
		new_pos.y -= self.get_node("PanelContainer").rect_size.y - 50
	elif mouse_pos.y < viewport.size.y / 2:
		new_pos.y += 50
		
	self.set_global_position(new_pos)
	
func set_min_height(h):
	get_node("PanelContainer").rect_min_size.y = h
