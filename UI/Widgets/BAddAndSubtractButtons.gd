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
	var box = pane.boxes[-1]
	pane.boxes.erase(box)
	pane.collections.erase(box)
	var settings = pane.content
	settings.erase(box.groups[0][1])
	pane.set_max_min_values()
	box.queue_free()
#	for each in subtract_set:
#		each.queue_free()
#	subtract_set = [null]
