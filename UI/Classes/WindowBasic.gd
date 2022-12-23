extends Node2D

func _ready():
	self.set_min_height(536)

func add_element(elem, _scale=1):
	get_node("PanelContainer").add_child(elem)
	
func set_title(text):
	get_node("TitleBar").get_node("HBoxContainer/Bar/Label").set_text(text)
	
func close_window():
	queue_free()
