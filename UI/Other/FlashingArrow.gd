extends Node2D

onready var dialog = get_node("../../Dialog/SallyDialog")

func _process(_delta):
	if dialog.state == 1:
		visible = true
		
	if Globals.map_progress["Tutoria"]["lvl2"] == false:
		pass
	elif Globals.map_progress["Tutoria"]["lvl3"] == false:
		var node_pos = get_node("../lvl2").get_global_position()
		set_global_position(node_pos)
	else:
		var node_pos = get_node("../lvl3").get_global_position()
		set_global_position(node_pos)

