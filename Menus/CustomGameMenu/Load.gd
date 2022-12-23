extends Button


var window = load("res://UI/Classes/Window.tscn")
var bGamePicker = load("res://UI/Panes/GamePicker.tscn")
var bGameSelectButton = load("res://UI/Widgets/BGameSelectButton.tscn")
var games_list

onready var scene = get_tree().get_current_scene()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Load_button_up():
	var file = File.new()
	var games
	if not file.file_exists("user://games.json"):
		games = ["My State"]
		file.open("user://games.json", File.WRITE)
		file.store_string(JSON.print(games, "  "))
		file.close()
	file.open("user://games.json", File.READ)
	games = parse_json(file.get_as_text())
	print(games)
	var w = window.instance()
	var gp = bGamePicker.instance()
	for g in games:
		var btn = bGameSelectButton.instance()
		btn.set_text(g)
		gp.insert(btn)
	w.add_element(gp)
	scene.add_child(w)
	w.set_title("Load Settings")
	w.position_window()
