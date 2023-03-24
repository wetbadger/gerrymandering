extends VBoxContainer

var button = load("res://UI/HouseButton.tscn")
var gp_button = load("res://UI/GapButton.tscn")
var gap_button
#var label = load("res://UI/Widgets/BLabel.tscn")


func load_buttons(party_info):
	var selected_district = get_tree().get_current_scene().selected_district
	#number of districts
	#todo change with settings
	#var n_districts = get_tree().get_current_scene().get_width()
	var pressed_first_button = false
	gap_button = gp_button.instance()
	add_child(gap_button)
	
	for party_name in party_info:
		var btn = button.instance()
		btn.set_sprite(party_info[party_name]["asset"], $"../../../State/SpriteTiles3")
		add_child(btn)
		var lbl = btn.get_node("Label") #label.instance()
		lbl.set_text(party_name + "\n" + str(party_info[party_name]["voters"]))
		#btn.add_child(lbl)
		btn.party_name = party_name
		btn.label = lbl
		btn.voters = int(party_info[party_name]["voters"])
		btn.add_to_group("house_buttons")
	


func get_party(allegiance):
	var buttons = get_tree().get_nodes_in_group("house_buttons")
	for btn in buttons:
		if btn.party_name == allegiance:
			return btn

func clear():
	var buttons = get_tree().get_nodes_in_group("house_buttons")
	for btn in buttons:
		btn.remove_from_group("house_buttons")
		btn.queue_free()
	gap_button.queue_free()
