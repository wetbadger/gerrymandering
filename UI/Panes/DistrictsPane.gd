extends SettingsPane

onready var content = get_node("/root/Globals").default_settings["districts"].duplicate(true)

#onready var scene = get_tree().get_current_scene()
var voters_spin_boxes = []
var colors = []
var index
var party_boxes

var boxes = []

func _ready():
	var file = File.new()
	file.open("user://games.json", File.READ)
	var games = parse_json(file.get_as_text())
	var game_name
	if games:
		game_name = games[0]
	else:
		game_name = "My State"
	file.close()
	file.open("user://" + game_name + "/settings.json", File.READ)
	var dict = parse_json(file.get_as_text())
	file.close()
	
	if dict:
		content = dict["districts"]
		for p in content: #convert to int because json reads as TYPE_REAL
			content[p]["max_size"] = int(content[p]["max_size"])
			content[p]["min_size"] = int(content[p]["min_size"])
	
	BOX = load("res://UI/Boxes/DistrictBox.tscn")
	for _i in range(content.size()):
		boxes.append(BOX.instance())
	
	set_name("districts")
	display_changeable_settings(content, boxes)
	index = content.size()-1

func on_change(text=""):
	#Don't delete this function
	pass

func add_voter_spinbox(spinbox):
	voters_spin_boxes.append(spinbox)
	
func set_party_boxes(b):
	party_boxes = b

func add():
	var c = 65
	for d in content:
		c += 1
	
	colors = scene.settings["colors"].keys()

	index += 1
	if index > len(colors) - 1:
		index = 0

	var props =  {"max_size": 1, "min_size": 1, "color" : colors[index]}
	boxes.append(BOX.instance())
	var index2 = len(boxes) - 1
	display_changeable_settings( {char(c) : props }, boxes, index2)
	content[char(c)] = props
	
	set_max_min_values()
		

func get_voter_boxes_again():
	voters_spin_boxes = []
	for p in scene.panes:
		if p.name == "parties":
			var children = p.get_children()
			print(children)
			for ch in children:
				#var spinbox = ch.get_node("BSpinBox")
				var grand_children = ch.get_children()
				for gc in grand_children:
					if "BSpinBox" in gc.name:
						add_voter_spinbox(gc)		

func set_max_min_values():
	var voter_count = 0
	for b in party_boxes:
		for g in b.groups:
			if g[0] == "number" and g[1] == "voters":
				voter_count += g[-1].get_value()
						
	var total_num_of_districts = content.size()
	var max_size = ceil(voter_count / total_num_of_districts)
	var min_size = floor(voter_count / total_num_of_districts)
	
	for b in boxes:
		for g in b.groups:
			if g[0] == "number":
				if g[1] == "max_size":
					g[-1].set_value (max_size)
				if g[1] == "min_size":
					g[-1].set_value(min_size)
