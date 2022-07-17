extends Control

onready var grid = get_node("VBoxContainer/CenterContainer/GridContainer")
var district_label_scn = load("res://UI/DistrictLabel.tscn")

func _ready():
	pass

func add_district(party, votes):
	if party == null:
		party = "Tie"
	var party_label = district_label_scn.instance()
	party_label.set_text(party+": ")
	var votes_label = district_label_scn.instance()
	votes_label.set_text(str(votes))
	grid.add_child(party_label)
	grid.add_child(votes_label)
