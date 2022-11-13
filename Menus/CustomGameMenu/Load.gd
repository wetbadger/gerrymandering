extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
