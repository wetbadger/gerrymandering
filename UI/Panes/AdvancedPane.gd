extends AdvSettingsPane

onready var content = get_node("/root/Globals").default_settings["advanced"]

func _ready():
	set_name("advanced")
	display_changeable_settings(content)

func on_change():
	pass
