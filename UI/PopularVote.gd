extends Control

onready var grid = get_node("VBoxContainer/CenterContainer/GridContainer")
var percent_scn = load("res://UI/Percent.tscn")

func _ready():
	pass
	
func add_party(party, votes, percent=0):
	var percent_label = percent_scn.instance()
	percent_label.set_text(str(percent))
	var percent_symbol = percent_scn.instance()
	percent_symbol.set_text('%')
	grid.add_child(percent_label)
	grid.add_child(percent_symbol)
	
	var party_label = Label.new()
	party_label.set_text(party+": ")
	var votes_label = Label.new()
	votes_label.set_text(str(votes))
	grid.add_child(party_label)
	grid.add_child(votes_label)

