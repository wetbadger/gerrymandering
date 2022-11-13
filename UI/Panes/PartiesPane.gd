extends SettingsPane

var content
onready var district_pane
var name_gen = load("res://NameGen/NameGen.gd").new()

var colors = []
var assets = []

var district_maxboxes = []
var district_minboxes = []
var col_index
var ass_index

var boxes

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
	
	var generate_silly_name = false
	if dict:
		content = dict["parties"]
		for p in content: #convert to int because json reads as TYPE_REAL
			content[p]["voters"] = int(content[p]["voters"])
		
	else:
		content = Globals.default_settings["parties"].duplicate(true)
		generate_silly_name = true
		
	BOX = load("res://UI/Boxes/PartyBox.tscn")
	boxes = []
	if not dict:
		boxes = [BOX.instance(), BOX.instance()]
	else:
		for i in len(dict["parties"]):
			boxes.append(BOX.instance())
	
	col_index = content.size()-1
	ass_index = content.size()-1
	
	var to_erase = []
	var to_add = []
	
	for party in content:
		var silly_name
		if generate_silly_name:
			silly_name = name_gen.new_name().capitalize()
		else:
			silly_name = party
		if not {silly_name: content[party]} in to_add:
			to_add.append({silly_name: content[party]})
		else:
			while {silly_name: content[party]} in to_add:
				silly_name = name_gen.new_name().capitalize()
				if not {silly_name: content[party]} in to_add:
					to_add.append({silly_name: content[party]})
				
			to_erase.append(party)
		
	for each in to_add:
		content[each.keys()[0]] = each[each.keys()[0]]
		
	for each in to_erase:
		content.erase(each)
		
	set_name("parties")
	display_changeable_settings(content, boxes)
	
	call_deferred("deferred_ready")

func add_district_max_box(spinbox):
	district_maxboxes.append(spinbox)

func add_district_min_box(spinbox):
	district_minboxes.append(spinbox)

	
func deferred_ready():
	if not district_pane:
		district_pane = scene.get_node("TabContainer/Basic/HBoxContainer/Grid2/Scroll/districts")
	district_pane.set_party_boxes(boxes)
	
func on_change(silly_name=""):
	
	if not district_pane:
		district_pane = scene.get_node("TabContainer/Basic/HBoxContainer/Grid2/Scroll/districts")
	district_pane.set_party_boxes(boxes)
	district_pane.set_max_min_values()
	
	for g in groups:
		if g[0] == "number":
			if g[-1].label_name == silly_name:
				g[2] = g[-1].get_value()

func add():
	
	if not district_pane:
		district_pane = scene.get_node("TabContainer/Basic/HBoxContainer/Grid2/Scroll/districts")
	colors = scene.settings["colors"].keys()
	assets = scene.settings["assets"].keys()

	ass_index += 1
	col_index += 1
	if ass_index > len(assets) - 1:
		ass_index = 0
	if col_index > len(colors) - 1:
		col_index = 0
	var silly_name = name_gen.new_name().capitalize()
	var props =  {"voters": 1, "asset": assets[ass_index], "color" : colors[col_index]}
	boxes.append(BOX.instance())
	var index = len(boxes) - 1
	display_changeable_settings( { silly_name : props }, boxes,  index)
	content[silly_name] = props
	
	district_pane.set_party_boxes(boxes)
	district_pane.set_max_min_values()
	
	on_change()
	
func set_max_min_values():
	district_pane.set_max_min_values()
