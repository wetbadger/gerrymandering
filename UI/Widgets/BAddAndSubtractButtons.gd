extends HBoxContainer

var add_box
var boxes = []

func set_add(packed_scene):
	add_box = packed_scene

func _on_BAddButton_button_up():
	#var new_box = add_box.instance()
	var pane = get_parent().get_parent()
	pane.add()

func _on_BSubtractButton_button_up():
	var pane = get_parent().get_parent()
	pane.subtract()
#	for each in subtract_set:
#		each.queue_free()
#	subtract_set = [null]
