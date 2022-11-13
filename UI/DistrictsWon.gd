extends Control

onready var scroll = get_node("VBoxContainer/CenterContainer/Scroll")
onready var container = get_node("VBoxContainer/CenterContainer/Scroll/CenterContainer")
onready var grid = get_node("VBoxContainer/CenterContainer/Scroll/CenterContainer/GridContainer")
var district_label_scn = load("res://UI/DistrictLabel.tscn")
onready var scene = get_tree().get_current_scene()
onready var settings = scene.settings

var labels = []
	
func add_district(party, votes):
	if not settings:
		settings = get_tree().get_current_scene().settings
	if party == null:
		party = "Tie"
	var party_label = district_label_scn.instance()
	party_label.set_text(party+": ")
	if party != "Tie":
		party_label.add_color_override("font_color", Globals.word2color(settings["parties"][party]["color"]))
	var votes_label = district_label_scn.instance()
	votes_label.set_text(str(votes))
	
	labels.append([party_label, votes_label])
	grid.add_child(party_label)
	grid.add_child(votes_label)
	#container.rect_min_size.y += 65
	
func reset():
	for label in labels:
		for part in label:
			part.queue_free()
	labels = []

func do():
	print("Signals are connected")
