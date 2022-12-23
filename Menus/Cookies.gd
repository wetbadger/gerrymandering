extends Control

var BLabel = load("res://UI/Widgets/BLabel.tscn") 

func _ready():
	if OS.get_name() == "HTML5":
		var w = get_node("Window")
		w.set_title("Accept Cookies?")
		var b = BLabel.instance()
		b.set_text("""\tCookies can be used to 
					track your activity online.
					This game will only use 
					them to save your progress.""")

		w.add_element(b)
	else:
		assert(get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn") == OK)

	get_node("Window").set_min_height(536)
