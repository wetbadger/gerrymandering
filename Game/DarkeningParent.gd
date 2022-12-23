extends Control


onready var rect = get_node("ColorRect")

func _ready():
	pass # Replace with function body.


func darken():
	rect_size = get_viewport_rect().size
	rect.darken()
	
func lighten():
	rect_size = get_viewport_rect().size
	rect.lighten()
