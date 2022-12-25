extends VBoxContainer

var checked = false
var custom_game = load("res://Menus/CustomGameMenu/CustomGameMenu.tscn")
var settings_menu = load("res://Menus/SettingsMenu/SettingsMenu.tscn")

var story = load("res://Story/Story.tscn")

onready var main_menu = get_tree().get_current_scene()

func _ready():
	if get_parent().started_in_portrait:
		for btn in get_children():
			print("Yeet")
			btn.add_font_override("font", load("res://font/sans_big.tres"))
	get_node("/root/MainMenu").connect("orientation_changed", self, "_on_orientation_changed")

func _on_Custom_button_up():
	var cg = custom_game.instance()
	get_parent().add_child(cg)
	var rect = get_viewport_rect().size
	cg.set_position(Vector2(rect.x/2-cg.get_node("TabContainer").get_size().x/2, rect.y/2-cg.get_node("TabContainer").get_size().y/1.5))
	#get_tree().change_scene("res://Menus/CustomGameMenu/CustomGameMenu.tscn")
	
		
	#rect_size = Vector2(get_viewport_rect().size.y/2, rect_size.x)
func _on_orientation_changed(portrait):

		if portrait :
			for btn in get_children():
				btn.add_font_override("font", load("res://font/sans_big.tres"))
		else:
			for btn in get_children():
				btn.add_font_override("font", load("res://font/sans_norm.tres"))


func _on_Settings_button_up():
	var sm = settings_menu.instance()
	get_parent().add_child(sm)
	var rect = get_viewport_rect().size
	sm.set_position(Vector2(rect.x/2-sm.get_node("TabContainer").get_size().x/2, rect.y/2-sm.get_node("TabContainer").get_size().y/1.5))
	


func _on_Story_button_up():
	main_menu.start_story()
