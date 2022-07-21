extends SettingsPane

onready var content = get_node("/root/Globals").default_settings["districts"]

func _ready():
	set_name("districts")
	display_changeable_settings(content, 1)

func on_change():
	pass
