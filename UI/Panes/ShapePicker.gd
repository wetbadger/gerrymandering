extends Control

var shapes = []
var current_index = 0

var button

func _ready():
	dir_contents("res://Objects/States")
	set_shape(current_index)
	
func set_button(btn):
	self.button = btn
	
func dir_contents(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
			else:
				if file_name.ends_with("tscn"):
					shapes.append(load(path+"/"+file_name).instance())
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func set_shape(index):
	var rect = get_node("Grid/ColorRect")
	var vbox = rect.get_node("VBoxContainer")
	if len(vbox.get_children()) == 2:
		vbox.remove_child(vbox.get_children()[-1])
	vbox.add_child(shapes[index])
	var size = shapes[index].get_node("ReferenceRect").rect_size
	var scale
	var x_is_bigger = true
	if size.x > size.y:
		scale = size.x
	else:
		scale = size.y
		x_is_bigger = false
	
	if scale > 400:

		shapes[index].scale = Vector2(400/scale, 400/scale)

		
	get_node("Grid/ColorRect/VBoxContainer/BLabel").text = shapes[index].name
	shapes[index].set_position(rect.rect_size / 2)
	current_index = index

func _on_BLeftArrow_button_up():
	if current_index >= 1:
		set_shape(current_index - 1)
	else:
		set_shape(len(shapes)-1)


func _on_BRightArrow_button_up():
	if current_index + 1 < len(shapes):
		set_shape(current_index + 1)
	else:
		set_shape(0)


func _on_Button_button_up():
	pass # Replace with function body.


func _on_Select_button_up():
	get_tree().get_current_scene().set_state_shape(shapes[current_index])
	get_parent().get_parent().close_window()
