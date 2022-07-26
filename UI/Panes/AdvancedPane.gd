extends SettingsPane

onready var content = Globals.default_settings["advanced"]
var boxes

func _ready():
	isAddable = false
	BOX = load("res://UI/Boxes/AdvBox.tscn")
	boxes = [BOX.instance(), BOX.instance(), BOX.instance()]
	for each in boxes:
		each.set_read_only(true)
	
	set_name("advanced")
	display_changeable_settings(content, boxes)

func on_change():
	pass
