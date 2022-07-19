extends SettingsPane

onready var content = get_node("/root/Globals").default_settings["parties"]

func _ready():
	display_changeable_settings(content)

