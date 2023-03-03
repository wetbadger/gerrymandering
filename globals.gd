extends Node

var map_name

var save_progress = false #TODO: delete this

#TODO: make sure these values are taken from the JSON, 
#(the variable here should only be used to CREATE the JSON)
const default_settings = {
		"name": "My State",
		"pointer" : null,
		"parties" : {
			"Reds" : {"voters": 10, "asset": "Red House", "color": "red"},
			"Blues" : {"voters": 15, "asset": "Blue House", "color": "blue"}
		},
		"districts" : {
			"A" : {
				"max" : 5,
				"min" : 5,
				"color" : "blue",
				"party" : ["Reds", "Blues"]
				},
			"B" : {
				"max" : 5,
				"min" : 5,
				"color" : "red",
				"party" : ["Blues", "Reds"]
				},
			"C" : {
				"max" : 5,
				"min" : 5,
				"color" : "orange",
				"party" : ["Reds", "Blues"]
				},
			"D" : {
				"max" : 5,
				"min" : 5,
				"color" : "purple",
				"party" : ["Blues", "Reds"]
				},
			"E" : {
				"max" : 5,
				"min" : 5,
				"color" : "green",
				"party" : ["Reds", "Blues"]
				}
		},
		"advanced" : {
			"District Rules" : {
				"contiguous" : true,
				"runtime contiguity enforcement" : false,
				"diagonals" : false,
				"show grid": false,
				"multiplayer" : false
			},
			"House Placement" : {
				"gaps": true,
				"randomize positions" : false,
				"layout": ["random", "user placed"],
				"algorithm" : ["spiral", "fill", "load from file"]
			},
			"Other" : {
				"debug" : false
			}

		},
		"shape": "Rectagonia",
		"colors" : {
			"blue" : [0.25,0.25,1],
			"red" : [0.8,0.1,0.1],
			"orange" : [0.8,0.4,0.1],
			"purple" : [0.5,0.2,0.8],
			"yellow" : [0.8,0.8,0.0],
			"brown" : [0.3,0.2,0.0],
			"green" : [0.2,0.8,0.1],
			"white" : [1,1,1],
			"gray" : [0.5,0.5,0.5],
			"teal" : [0.1,0.8,0.8],
			"pink" : [0.8,0.1,0.7],
			"black" : [0,0,0]
		},
		"assets" : {
			"Red House" : 0,
			"Blue House" : 1,
			"Orange House" : 2,
			"Purple House" : 3,
			"Yellow House" : 4,
			"Green House" : 5,
			"Weird House" : 6,
			"Red House Medium" : 7,
			"Blue House Medium" : 8,
			"Orange House Medium" : 9,
			"Purple House Medium" : 10,
			"Yellow House Medium" : 11,
			"Green House Medium" : 12,
			"Weird House Medium" : 13,
			"Red House Apartments" : 14,
			"Blue House Apartments" : 15,
			"Orange House Apartments" : 16,
			"Purple House Apartments" : 17,
			"Yellow House Apartments" : 18,
			"Green House Apartments" : 19,
			"Weird House Apartments" : 20
		}
}
var house_placement_layout = 0
var house_placement_algorithm = 0

#these are not taken from a json
var default_names = {
	"prefixes": [
		"blip",
		"bloop",
		"blob",
		"glip",
		"gloop",
		"glob",
		"bob",
		"lol",
		"lib",
		"con",
		"wang",
		"flip",
		"floop",
		"flop",
		"flim",
		"flam",
		"fash",
		"bip",
		"boop",
		"bop",
		"cat",
		"dog",
		"zoop",
		"zip",
		"nerp",
		"nom",
		"flimb",
		"beat",
		"mod",
		"nic",
		"pub",
		"bubl",
		"blubl",
		"blub",
		"nub",
		"nubl",
		"fluffl",
		"fluff",
		"puff",
		"puffl",
		"huff",
		"huffl",
		"fizzl",
		"publ",
		"republ",
		"dem",
		"commun",
		"anarch",
		"conserv",
		"preserv",
		"reserv",
		"lib",
		"nation",
		"contrar",
		"ludd",
		"ilum",
		"fed",
		"soc"
		
	],
	"suffixes": [
		"icans",
		"ocrats",
		"ists",
		"atives",
		"erals",
		"eralists",
		"itarians",
		"ialists",
		"alists",
		"ians",
		"inati",
		"ites",
		"als",
		"ards",
		"s"
	],
	"affixes": [
		"anarcho",
		"paleo",
		"neo",
		"proto",
		"crypto"
	]
}

var current_settings = {}

func word2color(word):
	if word:
		return arr2color(default_settings["colors"][word])

func arr2color(arr):
	return Color(arr[0],arr[1],arr[2])


var user_experience_settings = {
	"Audio": {
		"Music": 0.7,
		"Sound": 0.7
	},
	"Video": {
		"Orientation": [
			"sensor",
			"portrait",
			"landscape"
		],
		"Resolution": [
			"1920x1080"
		]
	}
}

var map_progress = {
	"Tutoria": {
		"lvl1" : false,
		"lvl2" : false,
		"lvl3" : false,
		"completed" : false
	}
}

var popular_vote = {
}

var chamber_of_legislation = {
	"Tutoria":{
		"parties":{
			"Opponent":{
				"asset":1, 
				"color":"blue", 
				"voters":9
			}, 
			"You":{
				"asset":0, 
				"color":"red", 
				"voters":6
			}
		}, 
		"seats": {
			"lvl1": [
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5}
			],
			"lvl2": [
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"Opponent":3}, 
				{"Opponent":5}
			],
			"lvl3": [
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"Opponent":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"Opponent":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"Opponent":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"Opponent":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"Opponent":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"Opponent":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"Opponent":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"Opponent":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"Opponent":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"Opponent":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"Opponent":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"You":3}, 
				{"Opponent":5},
				{"You":3}, 
				{"Opponent":3}, 
				{"Opponent":5}
			]
		}
	}
}

var current_map = {
	"name" : "",
	"scene": ""
}
