extends SettingsPane

onready var main_menu = get_tree().get_current_scene()
var boxes = []

func _ready():
	isAddable = false
	
	var file = File.new()
	file.open("user://settings.json", File.READ)
	var usrex_settings = parse_json(file.get_as_text())
	file.close()
	
	BOX = load("res://UI/Boxes/UsrexpSettingsBox.tscn")

	boxes = [BOX.instance(), BOX.instance()]
	for b in boxes:
		b.set_read_only(true)

	display_changeable_settings(usrex_settings, boxes)

	file.close()
