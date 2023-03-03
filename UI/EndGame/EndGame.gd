extends Node2D

var labels = []

var blabel = load("res://UI/Widgets/BLabel.tscn")
onready var hbox = get_node("CenterContainer/HBoxContainer")
onready var seats = get_node("Seats")
var votes = {}
var dist_seats = {}

func _ready():
	for lvl in Globals.popular_vote[Globals.current_map["name"]].keys():
		for party in Globals.popular_vote[Globals.current_map["name"]][lvl].keys():
			if votes.has(party):
				votes[party] += Globals.popular_vote[Globals.current_map["name"]][lvl][party]
			else:
				votes[party] = Globals.popular_vote[Globals.current_map["name"]][lvl][party]
				var lbl = blabel.instance()
				var stat = blabel.instance()
				var dists = blabel.instance()
				hbox.add_child(lbl)
				hbox.add_child(stat)
				hbox.add_child(dists)
				lbl.text = party + ": "
				lbl.id = party
				stat.text = str(0) + " votes "
				dists.text = str(0) + " seats "
				dist_seats[party] = dists
				labels.append([lbl,stat,dists])
	print(votes)
	for party in votes.keys():
		for lbl in labels:
			if lbl[0].id == party:
				lbl[1].text = str(votes[party]) + " votes "
				
