extends SettingsPane

onready var content = Globals.default_settings["advanced"].duplicate(true)
var boxes

func _ready():
	isAddable = false
	BOX = load("res://UI/Boxes/AdvBox.tscn")
	boxes = [BOX.instance(), BOX.instance(), BOX.instance()]
	for each in boxes:
		each.set_read_only(true)
	
	set_name("advanced")

	var file = File.new()
	file.open("user://games.json", File.READ)
	var game_names = parse_json(file.get_as_text())
	var game_name = game_names[0]
	file.close()
	file.open("user://" + game_name + "/settings.json", File.READ)
	var dict = parse_json(file.get_as_text())
	if dict:
		dict.erase("name")
		display_changeable_settings(dict["advanced"], boxes)
	else:
		dict = Globals.default_settings
		dict.erase("name")
		display_changeable_settings(dict["advanced"], boxes)
	file.close()

		#display_changeable_settings(content, boxes)

func on_change():
	pass
