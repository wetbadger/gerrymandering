extends Control

var BLabel = load("res://UI/Widgets/BLabel.tscn") 

func _ready():
	if OS.get_name() == "HTML5":
		var w = get_node("Window")
		w.set_title("Terms of Use")
		#set to beam because wierdness with html5 cursor
		Input.set_custom_mouse_cursor(Globals.beam)
		Input.set_custom_mouse_cursor(Globals.pointer)
	else:
		assert(get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn") == OK)

	get_node("Window").set_min_height(536)
