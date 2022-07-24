extends SettingsPane

onready var content = get_node("/root/Globals").default_settings["parties"]
onready var district_pane
var name_gen = load("res://NameGen/NameGen.gd").new()

var colors = []
var assets = []

var district_maxboxes = []
var district_minboxes = []
var col_index
var ass_index

func _ready():
	col_index = content.size()-1
	ass_index = content.size()-1
	
	var to_erase = []
	var to_add = []
	
	#TODO: add this to each panel
	for party in content:
		var silly_name = name_gen.new_name().capitalize()
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
	display_changeable_settings(content)
	
	call_deferred("deferred_ready")

func add_district_max_box(spinbox):
	district_maxboxes.append(spinbox)
	
func add_district_min_box(spinbox):
	district_minboxes.append(spinbox)
	
func deferred_ready():
	if not district_pane:
		district_pane = scene.get_node("TabContainer/Basic/HBoxContainer/Grid2/Scroll/districts")
	district_pane.set_party_groups(groups)
	
func on_change(silly_name=""):
	
	if not district_pane:
		district_pane = scene.get_node("TabContainer/Basic/HBoxContainer/Grid2/Scroll/districts")
	district_pane.set_party_groups(groups)
	district_pane.set_max_min_values()
	
	for g in groups:
		if g[0] == "number":
			if g[-1].label_name == silly_name:
				g[2] = g[-1].get_value()
			
#	var sum = 0
#	for g in groups:
#		if g[1] == "voters":
#			sum += g[-1].get_value()
#	#TODO: set min size to floor() or something
#	var n_districts = len(district_maxboxes)
#	for box in district_maxboxes:
#		box.set_value(ceil(sum/n_districts))
#	for box in district_minboxes:
#		box.set_value(floor(sum/n_districts))

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
	display_changeable_settings( { silly_name : props } )
	content[silly_name] = props
	
	for g in groups:
		if g[0] == "add":
			g[-1].queue_free()
			groups.erase(g)
			break
	district_pane.set_party_groups(groups)
	district_pane.get_voter_boxes_again()
	
	on_change()
