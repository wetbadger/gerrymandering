extends Node2D

var labels = []

var blabel = load("res://UI/Widgets/BLabel.tscn")
onready var hbox = get_node("CenterContainer/HBoxContainer")
onready var seats = get_node("Seats")
var votes = {}
var dist_seats = {"You":null,"Opponent":null}
var districts = []
var stats = []

var scores_keys
var dist_keys
var _i = 0
var _j = 0
var popular_vote = {}
var data = Globals.chamber_of_legislation["Tutoria"]
#var data = {"parties":
#	{"Fizzlicans":{"asset":2, "color":"orange", "voters":7}, 
#	"Opponent":{"asset":1, "color":"blue", "voters":43}, 
#	"You":{"asset":0, "color":"red", "voters":24}}, 
#	"scores":{"lvl1":[
#		{"A":{"Opponent":2, "You":3}}, 
#		{"B":{"Opponent":2, "You":3}}, 
#		{"C":{"Opponent":5}}
#		], 
#		"lvl2":[
#			{"A":{"Opponent":2, "You":4}}, 
#			{"B":{"Opponent":6}}, 
#			{"C":{"Opponent":6}}, 
#			{"D":{"Opponent":2, "You":3}}, 
#			{"E":{"Opponent":2, "You":3}}
#		], 
#		"lvl3":[
#			{"A":{"Opponent":15}}, 
#			{"B":{"Opponent":15}}, 
#			{"C":{"Opponent":6, "You":9}}, 
#			{"D":{"Fizzlicans":2, "Opponent":4, "You":9}}, 
#			{"E":{"Fizzlicans":5, "Opponent":3, "You":6}}
#			]}, 
#		"seats":{"lvl1":[{"You":3}, {"You":3}, {"Opponent":5}], 
#			"lvl2":[{"You":4}, {"Opponent":6}, {"Opponent":6}, {"You":3}, {"You":3}], 
#			"lvl3":[{"Opponent":15}, {"Opponent":15}, {"You":9}, {"You":9}, {"You":6}]}}

func _ready():
	
	scores_keys = data["scores"].keys()
	
	for party in data["parties"].keys():
		if votes.has(party):
			pass
			#votes[party] += Globals.popular_vote[Globals.current_map["name"]][party]
		else:
			#votes[party] = Globals.popular_vote[Globals.current_map["name"]][party]
			var lbl = blabel.instance()
			var stat = blabel.instance()
			var dists = blabel.instance()
			lbl.set_color(data["parties"][party]["color"])
			stat.set_color(data["parties"][party]["color"])
			dists.set_color(data["parties"][party]["color"])
			hbox.add_child(lbl)
			hbox.add_child(stat)
			stat.id = party
			stats.append(stat)
			hbox.add_child(dists)
			dists.id = party
			districts.append(dists)
			lbl.text = party + ": "
			lbl.id = party
			stat.text = str(0) + " votes "
			dists.text = str(0) + " seats "
			dist_seats[party] = dists
			labels.append([lbl,stat,dists])
				
func _process(delta):
	var seats_won = seats.seats_won

	for d in districts:
		for party in seats_won.keys():
			if d.id == party:
				d.text = str(seats_won[party]) + " seats "
				
	#loop through levels
	if _i < len(scores_keys):
		#print(data["scores"][scores_keys[_i]])
		dist_keys = data["scores"][scores_keys[_i]]
		#loop through districts
		if _j < len(dist_keys):
			#print(data["scores"][scores_keys[_i]][_j])
			var key = data["scores"][scores_keys[_i]][_j].keys()[0]
			var district_score = data["scores"][scores_keys[_i]][_j][key]
			
			for s in stats:
				for d in district_score.keys():
					if d == s.id:
						if not popular_vote.has(d):
							popular_vote[d] = 0
						popular_vote[d] += district_score[d]
						s.text = str(popular_vote[d]) + " votes "
			
			_j += 1
		else:
			_i += 1
			_j = 0
		
	

		
