extends Control

var settings
onready var layout_button = get_node("CenterContainer/TabContainer/Game/Grid/Layouts")

onready var game_name = get_node("CenterContainer/TabContainer/Game/Grid/NameText")
onready var parties = get_node("CenterContainer/TabContainer/Game/Grid/Parties")
onready var layout = get_node("CenterContainer/TabContainer/Game/Grid/Layouts")
onready var sprite_picker

var party_options

func _ready():
	
	settings = load_settings()
	game_name.set_text(settings["name"])
	for l in settings["layout"]:
		layout_button.add_item(l)

func load_settings():
	var file = File.new()
	if not file.file_exists("user://settings.json"):
			create_default_settings()
			return get_node("/root/Globals").default_settings.duplicate(true)
	file.open("user://settings.json", File.READ)
	var data = parse_json(file.get_as_text())
	return data
	
func create_default_settings():
	var file = File.new()
	file.open("user://settings.json", File.WRITE)
	var defaults = get_node("/root/Globals").default_settings.duplicate(true)
	file.store_line(JSON.print(defaults, "\t"))
	file.close()
