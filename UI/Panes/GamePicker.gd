extends Picker

func _ready():
	pass # Replace with function body.


func insert(elem):
	get_node("Scroll/VBoxContainer").add_child(elem)
