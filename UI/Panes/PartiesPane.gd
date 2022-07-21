extends SettingsPane

onready var content = get_node("/root/Globals").default_settings["parties"]

var district_maxboxes = []
var district_minboxes = []

func _ready():
	set_name("parties")
	display_changeable_settings(content)

func add_district_max_box(spinbox):
	district_maxboxes.append(spinbox)
	
func add_district_min_box(spinbox):
	district_minboxes.append(spinbox)
	
func on_change():
	var sum = 0
	for g in groups:
		if g[1] == "voters":
			sum += g[-1].get_value()
	#TODO: set min size to floor() or something
	var n_districts = len(district_maxboxes)
	for box in district_maxboxes:
		box.set_value(ceil(sum/n_districts))
	for box in district_minboxes:
		box.set_value(floor(sum/n_districts))
