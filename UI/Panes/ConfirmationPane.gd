extends Container

#
# Right now this is just confirmation for Loading a Custom setting. Perhaps rename.
#

var game_name

func _ready():
	pass # Replace with function body.


func set_game_name(text):
	game_name = text
	get_node("BLabel").text = "Load " + text + "?"


func _on_No_button_up():
	queue_free()


func _on_Yes_button_up():
	var file = File.new()
	file.open("user://games.json", File.READ)
	var games = parse_json(file.get_as_text())
	games.erase(game_name)
	games.push_front(game_name)
	file.close()
	file.open("user://games.json", File.WRITE)
	file.store_string(JSON.print(games))
	file.close()
	var menu = get_tree().get_current_scene().get_node("CustomGameMenu")
	menu.reload()
	get_parent().get_parent().get_parent().close_window()
